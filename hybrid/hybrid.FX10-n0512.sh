#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=0:15:00"
#PJM -L    "node=512"
#PJM --mpi "proc=512"
#PJM -o hybrid.FX10-n0512.out
#PJM -e hybrid.FX10-n0512.err
export PJM_JOBNAME=hybrid.FX10-n0512
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=16
export PARALLEL=16
mpiexec ./fft_check_mpi 1000 512 512 512 in
mpiexec ./fft_check_mpi 2000 512 512 512 in
mpiexec ./fft_check_mpi 1000 512 512 512 out
mpiexec ./fft_check_mpi 2000 512 512 512 out
