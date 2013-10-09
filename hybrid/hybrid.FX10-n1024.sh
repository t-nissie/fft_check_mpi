#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=1:00:00"
#PJM -L    "node=1024"
#PJM --mpi "proc=1024"
#PJM -o hybrid.FX10-n1024.out
#PJM -e hybrid.FX10-n1024.err
export PJM_JOBNAME=hybrid.FX10-n1024
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=16
export PARALLEL=16
mpiexec ./fft_check_mpi 1000 1024 1024 1024 in
mpiexec ./fft_check_mpi 2000 1024 1024 1024 in
mpiexec ./fft_check_mpi 1000 1024 1024 1024 out
mpiexec ./fft_check_mpi 2000 1024 1024 1024 out
