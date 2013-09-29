#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=2:00:00"
#PJM -L    "node=256"
#PJM --mpi "proc=4096"
#PJM -o flatMPI.FX10-n0256.out
#PJM -e flatMPI.FX10-n0256.err
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=1
export PARALLEL=1
export FLIB_CNTL_BARRIER_ERR=FALSE
mpiexec ./fft_check_mpi  20 4096 4096 4096 in
mpiexec ./fft_check_mpi  40 4096 4096 4096 in
mpiexec ./fft_check_mpi 100 4096 4096 4096 in
mpiexec ./fft_check_mpi 200 4096 4096 4096 in
mpiexec ./fft_check_mpi  20 4096 4096 4096 out
mpiexec ./fft_check_mpi  40 4096 4096 4096 out
mpiexec ./fft_check_mpi 100 4096 4096 4096 out
mpiexec ./fft_check_mpi 200 4096 4096 4096 out
