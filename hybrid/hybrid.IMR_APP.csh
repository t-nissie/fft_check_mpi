#!/bin/csh
# Usage: submit AEB general -n 8 -pt 12 -jobtype sparallel -exec hybrid.IMR_APP.csh -J hybrid.IMR_APP
##
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1024 1024 1024 in
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1024 1024 1024 out
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 10 2048 2048 2048 in
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 10 2048 2048 2048 out
