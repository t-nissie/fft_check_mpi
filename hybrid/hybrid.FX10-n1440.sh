#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=4:00:00"
#PJM -L    "node=1440"
#PJM --mpi "proc=1440"
#PJM -o hybrid.FX10-n1440.out
#PJM -e hybrid.FX10-n1440.err
export PJM_JOBNAME=hybrid.FX10-n1440
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=16
export PARALLEL=16
mpiexec ./fft_check_mpi 1000 1440 1440 1440 in
mpiexec ./fft_check_mpi 2000 1440 1440 1440 in
mpiexec ./fft_check_mpi 1000 1440 1440 1440 out
mpiexec ./fft_check_mpi 2000 1440 1440 1440 out
