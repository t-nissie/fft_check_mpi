#!/bin/csh
# Usage: submit AEB general -n 4 -jobtype parallel -exec fft_check_mpi.flatMPI.IMR_APP.csh -J fft_check_mpi.flatMPI.IMR_APP
##
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20  960  960  960 in
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20  960  960  960 out
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1024 1024 1024 in
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1024 1024 1024 out
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1440 1440 1440 in
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 20 1440 1440 1440 out
app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 10 2048 2048 2048 in
# app_mpi_launcher_mpich2.1.5_gnu ./fft_check_mpi 10 2048 2048 2048 out
