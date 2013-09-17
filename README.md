fft_check_mpi.F, a 3-dimensional FFT benchmark program written in Fortran with MPI
==================================================================================
fft_check_mpi.F is a benchmark program. It times in-place and
out-of-place double-precision real 3-dimensional FFT.
It is written in Fortran, using FFTW, parallelized with MPI.

Homepage and download
---------------------
Go to <https://github.com/t-nissie/fft_check_mpi>.

FFTW
----
It is very important that machines have the *de facto standard* and
*ultra fast* FFT library, FFTW <http://www.fftw.org/> .

See also:
* <http://www.fftw.org/doc/Transposed-distributions.html>
* <http://www.fftw.org/doc/Combining-MPI-and-Threads.html>

How to build fft_check_mpi
--------------------------
There are makefiles for some machines such as SR16000, FX10, etc.
Flat MPI and OpenMP+MPI hybrid parallelization versions of makefiles are provided.

    $ make -f fft_check_mpi.flatMPI.Makefile.FX10-mpifrtpx
    $ make -f fft_check_mpi.hybrid.Makefile.SR16000-xlf90_r-fftw_xlc

How to execute fft_check_mpi
----------------------------
fft_check_mpi requires five command line arguments.
They are the number of iterations, Lx, Ly, Lz and
in-place (in) or out-of-place (out). For example,

    $ mpirun -np 8 ./fft_check_mpi 100 512 512 512 out

output, timing and GFLOPS
-------------------------
fft_check_mpi writes results into standard output (stdout).
A result contains Lx, Ly, Lz, N(=LxLyLz), in-place or out-of-place,
the number of OpenMP threads, the number of MPI processes, time for plan,
time for preparation, time for one dummy loop, time for calculation,
and GFLOPS value.

Data for debug will be written into standard error output (stderr).

Giga FLOPS values are roughly estimated from 5N*log_2(N)/2 floating point operations.

Benchmark results
-----------------
![log log plot of GFLOPS](fft_check_mpi.flatMPI.out-of-place.jpg)

Flat MPI vs. OpenMP+MPI hybrid parallelization
----------------------------------------------
fft_check_mpi.F can be compiled both in flat MPI and in OpenMP+MPI
hybrid parallelization. In many cases of large scale 3-dimensional FFT,
flat MPI is faster than hybrid parallelization.

Padding
-------
If the numbers of dimensions of an array are powers of two,
for example r(2048,2048,2048), "bank conflict" may occur in FFT and
it reduces computational speed. To avoid "bank conflict",
"padding" is commonly introduced, for example r(2048,2048+3,2048).
However, introduction of "padding" make code complicated.
Therefore, "padding" is not introduced in this fft_check_mpi.F.

Initial dummy loop
------------------
On some platforms, initial MPI communication takes unpredictable time.
Therefore, fft_check_mpi.F wast one dummy loop in the beginning.

Copying and author
------------------
Copyright © 2012-2013 by Takeshi Nishimatsu

fft_check_mpi is distributed in the hope that
it will be useful, but WITHOUT ANY WARRANTY.
You can copy, modify and redistribute fft_check_mpi,
but only under the conditions described in
the GNU General Public License (the "GPL").

Takeshi Nishimatsu (t-nissie{at}imr.tohoku.ac.jp)
