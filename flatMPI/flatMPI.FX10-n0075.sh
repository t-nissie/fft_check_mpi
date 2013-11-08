#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=4:00:00"
#PJM -L    "node=75"
#PJM --mpi "proc=1200"
#PJM -o flatMPI.FX10-n0075.out
#PJM -e flatMPI.FX10-n0075.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 1200 1200 1200 in
mpiexec ./fft_check_mpi  40 1200 1200 1200 in
mpiexec ./fft_check_mpi 100 1200 1200 1200 in
mpiexec ./fft_check_mpi 200 1200 1200 1200 in
mpiexec ./fft_check_mpi  20 1200 1200 1200 out
mpiexec ./fft_check_mpi  40 1200 1200 1200 out
mpiexec ./fft_check_mpi 100 1200 1200 1200 out
mpiexec ./fft_check_mpi 200 1200 1200 1200 out

mpiexec ./fft_check_mpi  20 2400 2400 2400 in
mpiexec ./fft_check_mpi  40 2400 2400 2400 in
mpiexec ./fft_check_mpi 100 2400 2400 2400 in
mpiexec ./fft_check_mpi 200 2400 2400 2400 in
mpiexec ./fft_check_mpi  20 2400 2400 2400 out
mpiexec ./fft_check_mpi  40 2400 2400 2400 out
mpiexec ./fft_check_mpi 100 2400 2400 2400 out
mpiexec ./fft_check_mpi 200 2400 2400 2400 out

mpiexec ./fft_check_mpi  10 3600 3600 3600 in
mpiexec ./fft_check_mpi  20 3600 3600 3600 in
mpiexec ./fft_check_mpi  10 3600 3600 3600 out
mpiexec ./fft_check_mpi  20 3600 3600 3600 out
