#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=4:00:00"
#PJM -L    "node=128"
#PJM --mpi "proc=2048"
#PJM -o flatMPI.FX10-n0128.out
#PJM -e flatMPI.FX10-n0128.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 2048 2048 2048 in
mpiexec ./fft_check_mpi  40 2048 2048 2048 in
mpiexec ./fft_check_mpi 100 2048 2048 2048 in
mpiexec ./fft_check_mpi 200 2048 2048 2048 in
mpiexec ./fft_check_mpi  20 2048 2048 2048 out
mpiexec ./fft_check_mpi  40 2048 2048 2048 out
mpiexec ./fft_check_mpi 100 2048 2048 2048 out
mpiexec ./fft_check_mpi 200 2048 2048 2048 out

mpiexec ./fft_check_mpi  20 4096 4096 4096 in
mpiexec ./fft_check_mpi  40 4096 4096 4096 in
mpiexec ./fft_check_mpi 100 4096 4096 4096 in
mpiexec ./fft_check_mpi 200 4096 4096 4096 in
mpiexec ./fft_check_mpi  20 4096 4096 4096 out
mpiexec ./fft_check_mpi  40 4096 4096 4096 out
mpiexec ./fft_check_mpi 100 4096 4096 4096 out
mpiexec ./fft_check_mpi 200 4096 4096 4096 out
