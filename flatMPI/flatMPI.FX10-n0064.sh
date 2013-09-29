#!/bin/sh
#PJM -L "rscgrp=short"
#PJM -L "elapse=2:00:00"
#PJM -L    "node=64"
#PJM --mpi "proc=1024"
#PJM -o flatMPI.FX10-n0064.out
#PJM -e flatMPI.FX10-n0064.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '\#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_itr0   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 1024 1024 1024 in
mpiexec ./fft_check_mpi  40 1024 1024 1024 in
mpiexec ./fft_check_mpi  20 1024 1024 1024 out
mpiexec ./fft_check_mpi  40 1024 1024 1024 out

mpiexec ./fft_check_mpi  20 2048 2048 2048 in
mpiexec ./fft_check_mpi  40 2048 2048 2048 in
mpiexec ./fft_check_mpi 100 2048 2048 2048 in
mpiexec ./fft_check_mpi 200 2048 2048 2048 in
mpiexec ./fft_check_mpi  20 2048 2048 2048 out
mpiexec ./fft_check_mpi  40 2048 2048 2048 out
mpiexec ./fft_check_mpi 100 2048 2048 2048 out
mpiexec ./fft_check_mpi 200 2048 2048 2048 out

mpiexec ./fft_check_mpi  10 3072 3072 3072 in
mpiexec ./fft_check_mpi  20 3072 3072 3072 in
mpiexec ./fft_check_mpi  10 3072 3072 3072 out
mpiexec ./fft_check_mpi  20 3072 3072 3072 out

mpiexec ./fft_check_mpi  10 4096 4096 4096 in
mpiexec ./fft_check_mpi  20 4096 4096 4096 in
