#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=0:15:00"
#PJM -L    "node=256"
#PJM --mpi "proc=256"
#PJM -o hybrid.FX10-n0256.out
#PJM -e hybrid.FX10-n0256.err
export PJM_JOBNAME=hybrid.FX10-n0256
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=16
export PARALLEL=16
mpiexec ./fft_check_mpi 10000 256 256 256 in
mpiexec ./fft_check_mpi 20000 256 256 256 in
mpiexec ./fft_check_mpi 10000 256 256 256 out
mpiexec ./fft_check_mpi 20000 256 256 256 out
