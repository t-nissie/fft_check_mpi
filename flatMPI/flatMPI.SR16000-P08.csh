#!/usr/bin/csh
# Usage: submit EP general -largememory -jobtype parallel -n 8 -B -N -u t-nissie@imr.tohoku.ac.jp -exec flatMPI.SR16000-P08.csh -J flatMPI.SR16000-P08
##
setenv MEMORY_AFFINITY MCM
setenv MALLOCMULTIHEAP true
echo "#" `hostname`
poe ./fft_check_mpi 100 1024 1024 1024 in
poe ./fft_check_mpi 200 1024 1024 1024 in
poe ./fft_check_mpi 100 1024 1024 1024 out
poe ./fft_check_mpi 200 1024 1024 1024 out

poe ./fft_check_mpi 100 1280 1280 1280 in
poe ./fft_check_mpi 200 1280 1280 1280 in
poe ./fft_check_mpi 100 1280 1280 1280 out
poe ./fft_check_mpi 200 1280 1280 1280 out

poe ./fft_check_mpi  50 2048 2048 2048 in
poe ./fft_check_mpi 100 2048 2048 2048 in
poe ./fft_check_mpi  50 2048 2048 2048 out
poe ./fft_check_mpi 100 2048 2048 2048 out

poe ./fft_check_mpi  50 2560 2560 2560 in
poe ./fft_check_mpi 100 2560 2560 2560 in
poe ./fft_check_mpi  50 2560 2560 2560 out
poe ./fft_check_mpi 100 2560 2560 2560 out

poe ./fft_check_mpi  50 3072 3072 3072 in
poe ./fft_check_mpi 100 3072 3072 3072 in
poe ./fft_check_mpi  50 3072 3072 3072 out
poe ./fft_check_mpi 100 3072 3072 3072 out

poe ./fft_check_mpi  10 4096 4096 4096 in
poe ./fft_check_mpi  20 4096 4096 4096 in
poe ./fft_check_mpi  10 4096 4096 4096 out
poe ./fft_check_mpi  20 4096 4096 4096 out

poe ./fft_check_mpi  10 5120 5120 5120 in
poe ./fft_check_mpi  20 5120 5120 5120 in
# poe ./fft_check_mpi  10 5120 5120 5120 out
# poe ./fft_check_mpi  20 5120 5120 5120 out
