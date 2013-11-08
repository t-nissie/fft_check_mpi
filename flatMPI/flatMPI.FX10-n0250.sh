#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=2:00:00"
#PJM -L    "node=250"
#PJM --mpi "proc=4000"
#PJM -o flatMPI.FX10-n0250.out
#PJM -e flatMPI.FX10-n0250.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi  20 4000 4000 4000 in
mpiexec ./fft_check_mpi  40 4000 4000 4000 in
mpiexec ./fft_check_mpi 100 4000 4000 4000 in
mpiexec ./fft_check_mpi 200 4000 4000 4000 in
mpiexec ./fft_check_mpi  20 4000 4000 4000 out
mpiexec ./fft_check_mpi  40 4000 4000 4000 out
mpiexec ./fft_check_mpi 100 4000 4000 4000 out
mpiexec ./fft_check_mpi 200 4000 4000 4000 out
