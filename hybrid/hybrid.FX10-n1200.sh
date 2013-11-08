#!/bin/sh
#PJM -L "rscgrp=regular"
#PJM -L "elapse=5:00:00"
#PJM -L    "node=1200"
#PJM --mpi "proc=1200"
#PJM -o hybrid.FX10-n1200.out
#PJM -e hybrid.FX10-n1200.err
export PJM_JOBNAME=hybrid.FX10-n1200
export FLIB_FASTOMP=TRUE
export OMP_NUM_THREADS=16
export PARALLEL=16
echo '#  it.    Lx     Ly     Lz        N      place  th. proc.     t_plan   t_prep   t_dmmy   t_calc  GFLOPS'
mpiexec ./fft_check_mpi 1000 1200 1200 1200 in
mpiexec ./fft_check_mpi 2000 1200 1200 1200 in
mpiexec ./fft_check_mpi 1000 1200 1200 1200 out
mpiexec ./fft_check_mpi 2000 1200 1200 1200 out
