#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=4:00:00"
#PJM -L    "node=90"
#PJM --mpi "proc=1440"
#PJM -o flatMPI.FX10-n0090.out
#PJM -e flatMPI.FX10-n0090.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 1440 1440 1440 in
mpiexec ./fft_check_mpi  40 1440 1440 1440 in
mpiexec ./fft_check_mpi 100 1440 1440 1440 in
mpiexec ./fft_check_mpi 200 1440 1440 1440 in
mpiexec ./fft_check_mpi  20 1440 1440 1440 out
mpiexec ./fft_check_mpi  40 1440 1440 1440 out
mpiexec ./fft_check_mpi 100 1440 1440 1440 out
mpiexec ./fft_check_mpi 200 1440 1440 1440 out

mpiexec ./fft_check_mpi  20 2880 2880 2880 in
mpiexec ./fft_check_mpi  40 2880 2880 2880 in
mpiexec ./fft_check_mpi 100 2880 2880 2880 in
mpiexec ./fft_check_mpi 200 2880 2880 2880 in
mpiexec ./fft_check_mpi  20 2880 2880 2880 out
mpiexec ./fft_check_mpi  40 2880 2880 2880 out
mpiexec ./fft_check_mpi 100 2880 2880 2880 out
mpiexec ./fft_check_mpi 200 2880 2880 2880 out

mpiexec ./fft_check_mpi  10 4320 4320 4320 in
mpiexec ./fft_check_mpi  20 4320 4320 4320 in
#mpiexec ./fft_check_mpi  10 4320 4320 4320 out
#mpiexec ./fft_check_mpi  20 4320 4320 4320 out
