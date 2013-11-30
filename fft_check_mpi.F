! fft_check_mpi.F -*-f90-*-
! Time-stamp: <2013-11-30 18:18:12 takeshi>
! Author: Takeshi NISHIMATSU
!!
program fft_check_mpi
  use, intrinsic :: iso_c_binding
  implicit none
  include 'mpif.h'
  include 'fftw3-mpi.f03'
  integer(C_INTPTR_T)                :: Lx
  integer(C_INTPTR_T)                :: Ly
  integer(C_INTPTR_T)                :: Lz
  real*8                             :: N_inv
  type(C_PTR)                        :: plan_r2c, plan_c2r, rdata, cdata
  real(C_DOUBLE),            pointer :: r_tmp(:) !Rank remapping target must be rank 1
  real(C_DOUBLE),            pointer :: r(:,:,:)
  complex(C_DOUBLE_COMPLEX), pointer :: c_tmp(:) !Rank remapping target must be rank 1
  complex(C_DOUBLE_COMPLEX), pointer :: c(:,:,:)
  integer(C_INTPTR_T)                :: i, alloc_local, local_Lz, local_z_offset
  integer(C_INTPTR_T)                ::                 local_Ly, local_y_offset
  integer                            :: n, j, N_TIMES, i_error, my_mpi_rank, n_mpi_procs, n_threads
  character(len=100)                 :: str
  logical                            :: in_or_out

  ! For timing
  integer                 :: c_r(0:4)   ! count
  real*8                  :: t_r(1:4)   ! time
  real*8                  :: g_r        ! GFLOPS
  real*8                  :: f_r         ! The numbers of floating point operations in [G]
  integer                 :: count_rate, count_max

# if defined(_OPENMP)
  integer                            :: provided, OMP_GET_MAX_THREADS
  call MPI_INIT_THREAD(MPI_THREAD_FUNNELED, provided, i_error)
  call dfftw_init_threads(i_error)
  n_threads = OMP_GET_MAX_THREADS()
  call dfftw_plan_with_nthreads(n_threads)
  write(0,'(a,i7,a,i4)') '_OPENMP =', _OPENMP, ',    OMP_GET_MAX_THREADS =', n_threads
# else
  call MPI_INIT(i_error)
  n_threads = 1
# endif
  call MPI_COMM_RANK(MPI_COMM_WORLD, my_mpi_rank, i_error)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, n_mpi_procs, i_error)

  ! default values
  N_TIMES = 1000
  Lx =  60
  Ly =  80
  Lz = 100
  in_or_out = .true.

  n = command_argument_count()
  if (n.eq.0) then
     ! Use default values
  else if (n.eq.5) then
     call get_command_argument(1,str); read(str,*) N_TIMES
     call get_command_argument(2,str); read(str,*) Lx
     call get_command_argument(3,str); read(str,*) Ly
     call get_command_argument(4,str); read(str,*) Lz
     call get_command_argument(5,str); if (str.eq.'out') in_or_out = .false.
  else
     write(0,'(a,a,i3,a)') __FILE__, ':', __LINE__, ': Illegal number of arguments.'
     stop 1
  end if
  N_inv = 1.0d0/Lx/Ly/Lz

  !   get local data size and allocate (note dimension reversal)
  alloc_local = fftw_mpi_local_size_3d_transposed(Lz, Ly, Lx/2+1, MPI_COMM_WORLD, &
       & local_Lz, local_z_offset, &
       & local_Ly, local_y_offset)
  rdata    = fftw_alloc_real(2 * alloc_local); call c_f_pointer(rdata, r_tmp, [2*(Lx/2+1)*Ly*local_Lz])
  if (in_or_out) then
     call                                           c_f_pointer(rdata, c_tmp, [  (Lx/2+1)*Lz*local_Ly])
     cdata = c_null_ptr
  else
     cdata = fftw_alloc_complex( alloc_local); call c_f_pointer(cdata, c_tmp, [  (Lx/2+1)*Lz*local_Ly])
  end if

  !   rank remapping or array dimension changing
  r(0:2*(Lx/2+1)-1, 0:Ly-1, 0:local_Lz-1) => r_tmp
  c(0:Lx/2,         0:Lz-1, 0:local_Ly-1) => c_tmp

  !   first-touch of r(:,:,:) and c(:,:,:)
!$omp parallel do
  do i = 0, local_Lz-1
     r(:, :, i) = 0.0d0
  end do
!$omp end parallel do
!$omp parallel do
  do i = 0, local_Ly-1
     c(:, :, i) = (0.0d0, 0.0d0)
  end do
!$omp end parallel do

  call system_clock(c_r(0))

  !   create MPI plan for in-place forward DFT (note dimension reversal)
  plan_r2c = fftw_mpi_plan_dft_r2c_3d(Lz, Ly, Lx, r, c, MPI_COMM_WORLD, ior(FFTW_MEASURE,FFTW_MPI_TRANSPOSED_OUT))
  plan_c2r = fftw_mpi_plan_dft_c2r_3d(Lz, Ly, Lx, c, r, MPI_COMM_WORLD, ior(FFTW_MEASURE,FFTW_MPI_TRANSPOSED_IN))

  call system_clock(c_r(1))

  !   initialization of array r(:,:,:) with a wave
!$omp parallel do
  do i = 0, local_Lz-1
     if (mod(int(i+local_z_offset),2).eq.0) then
        r(:, :, i) = 0.1d0
     else
        r(:, :, i) = 0.0d0
     end if
  end do
!$omp end parallel do

  call system_clock(c_r(2))

  !   compute transform (j=-4..0 are dummy iterations.)
  do j = -4, n_times
     if (j.eq.1) call system_clock(c_r(3))

     call fftw_mpi_execute_dft_r2c(plan_r2c, r, c)
     ! write(6,'(a,i5,a,i4,2(a,i5),a,2e23.15)') 'my_mpi_rank/size =', my_mpi_rank, '/', n_mpi_procs, &
     !      &                               ',  local_Ly =', local_Ly, &
     !      &                               ',  local_y_offset =', local_y_offset, &
     !      &                               ',   c(1,Lz/2+1,1) =', c(1,Lz/2+1,1)
!$omp parallel do
     do i = 0, local_Ly-1
        c(:, :, i) = c(:, :, i) * N_inv
     end do
!$omp end parallel do
     call fftw_mpi_execute_dft_c2r(plan_c2r, c, r)
  end do

  call system_clock(c_r(4), count_rate, count_max)

  write(0,'(a,i5,a,i4,a,f19.15)') 'my_mpi_rank/size =', my_mpi_rank, '/', n_mpi_procs, &
       &',   r(0,0,0) =', r(0,0,0)

  !   let them free
  call fftw_destroy_plan(plan_r2c)
  call fftw_destroy_plan(plan_c2r)
  call fftw_free(rdata)
  call fftw_free(cdata)

  do j = 1, 4
     t_r(j) = dble(c_r(j)-c_r(j-1))/count_rate ; if (t_r(j)<0.0d0) t_r(j)=t_r(j)+dble(count_max)/count_rate
  end do
  f_r = log(dble(Lx)*dble(Lz)*dble(Ly)) / log(2.0d0) / 1.0d9 * N_TIMES * 5 * Lx * Ly * Lz
  g_r = f_r / t_r(4)
  if (my_mpi_rank.eq.0) then
     write(0,'(a,f10.2,a)') 'The number of floating point operations: f_r = ', f_r, ' [G]'
     write(6,'(i6,3i7,i16,L2,2i5,1(f13.3,3f9.3,f10.3))') N_TIMES, Lx, Ly, Lz, Lx*Ly*Lz, in_or_out, &
          & n_threads, n_mpi_procs, t_r(1), t_r(2), t_r(3), t_r(4), g_r
  end if

  call MPI_FINALIZE(i_error)
end program fft_check_mpi
!Local variables:
!  compile-command: "mpif90 -Wall -O3 -ffree-form -ffree-line-length-none -o fft_check_mpi fft_check_mpi.F -lfftw3 -lfftw3_mpi && mpirun -np 2 ./fft_check_mpi 100 30 40 50 out && sleep 1"
!End:
