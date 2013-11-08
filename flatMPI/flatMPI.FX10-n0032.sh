#!/bin/sh
#PJM -L "rscgrp=short"
#PJM -L "elapse=1:00:00"
#PJM -L    "node=32"
#PJM --mpi "proc=512"
#PJM -o flatMPI.FX10-n0032.out
#PJM -e flatMPI.FX10-n0032.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 1024 1024 1024 in
mpiexec ./fft_check_mpi  40 1024 1024 1024 in
mpiexec ./fft_check_mpi 100 1024 1024 1024 in
mpiexec ./fft_check_mpi 200 1024 1024 1024 in
mpiexec ./fft_check_mpi  20 1024 1024 1024 out
mpiexec ./fft_check_mpi  40 1024 1024 1024 out
mpiexec ./fft_check_mpi 100 1024 1024 1024 out
mpiexec ./fft_check_mpi 200 1024 1024 1024 out

mpiexec ./fft_check_mpi  20 2048 2048 2048 in
mpiexec ./fft_check_mpi  40 2048 2048 2048 in
mpiexec ./fft_check_mpi  20 2048 2048 2048 out
mpiexec ./fft_check_mpi  40 2048 2048 2048 out

mpiexec ./fft_check_mpi  20 2560 2560 2560 in
mpiexec ./fft_check_mpi  40 2560 2560 2560 in
mpiexec ./fft_check_mpi  20 2560 2560 2560 out
mpiexec ./fft_check_mpi  40 2560 2560 2560 out
