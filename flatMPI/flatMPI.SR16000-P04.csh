#!/usr/bin/csh
# Usage: submit EB general -largememory -jobtype parallel -n 4 -B -N -u t-nissie@imr.tohoku.ac.jp -exec flatMPI.SR16000-P04.csh -J flatMPI.SR16000-P04
##
setenv MEMORY_AFFINITY MCM
setenv MALLOCMULTIHEAP true
echo "#" `hostname`
poe ./fft_check_mpi 100  640  640  640 in
poe ./fft_check_mpi 200  640  640  640 in
poe ./fft_check_mpi 100  640  640  640 out
poe ./fft_check_mpi 200  640  640  640 out

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
#poe ./fft_check_mpi  50 2560 2560 2560 out
#poe ./fft_check_mpi 100 2560 2560 2560 out