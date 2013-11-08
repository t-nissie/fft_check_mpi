#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=4:00:00"
#PJM -L    "node=100"
#PJM --mpi "proc=1600"
#PJM -o flatMPI.FX10-n0100.out
#PJM -e flatMPI.FX10-n0100.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 1600 1600 1600 in
mpiexec ./fft_check_mpi  40 1600 1600 1600 in
mpiexec ./fft_check_mpi 100 1600 1600 1600 in
mpiexec ./fft_check_mpi 200 1600 1600 1600 in
mpiexec ./fft_check_mpi  20 1600 1600 1600 out
mpiexec ./fft_check_mpi  40 1600 1600 1600 out
mpiexec ./fft_check_mpi 100 1600 1600 1600 out
mpiexec ./fft_check_mpi 200 1600 1600 1600 out

mpiexec ./fft_check_mpi  20 3200 3200 3200 in
mpiexec ./fft_check_mpi  40 3200 3200 3200 in
mpiexec ./fft_check_mpi 100 3200 3200 3200 in
mpiexec ./fft_check_mpi 200 3200 3200 3200 in
mpiexec ./fft_check_mpi  20 3200 3200 3200 out
mpiexec ./fft_check_mpi  40 3200 3200 3200 out
mpiexec ./fft_check_mpi 100 3200 3200 3200 out
mpiexec ./fft_check_mpi 200 3200 3200 3200 out

mpiexec ./fft_check_mpi  10 4800 4800 4800 in
mpiexec ./fft_check_mpi  20 4800 4800 4800 in
mpiexec ./fft_check_mpi  10 4800 4800 4800 out
mpiexec ./fft_check_mpi  20 4800 4800 4800 out
