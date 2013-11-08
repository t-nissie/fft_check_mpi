#!/usr/bin/env gnuplot
# Time-stamp: <2013-11-08 12:17:39 takeshi>
# Author: Takeshi NISHIMATSU
##
set terminal postscript portrait enhanced dashed color 'Times-Roman' 12
set output 'flatMPI.out-of-place.eps'
set title "3-dimensional real{/Symbol \253}complex out-of-place FFT\ndouble precision, flat MPI, with FFTW\\_MEASURE,\
\nwithout final transposition, without padding\n\n"

#set key outside
#set bmargin 8
set key at 2.6, 4.8 spacing 1.2
set size 0.7,0.63
set size square

set xrange [0:5]

set xlabel "\nFujitsu FX10:  (MPI process) / (node)"
set xtics ("128\n8"   0,\
           "256\n16"  1,\
           "512\n32"  2,\
          "1024\n64"  3,\
          "2048\n128" 4,\
          "4096\n256" 5)

set x2label "Hitachi SR16000 (SMT off):  (node) / (MPI process)\n"
set x2tics ("2\n64"   0,\
            "4\n128"  1,\
            "8\n256"  2,\
           "16\n512"  3,\
           "32\n1024" 4,\
           "64\n2048" 5)

set ylabel 'GFLOPS'
set yrange [0:5]
set ytics ("100" 0,\
           "200" 1,\
           "400" 2,\
           "800" 3,\
          "1600" 4,\
          "3200" 5)

plot x t '' lt 1 lc 6,\
     'flatMPI.SR16000.1024x1024x1024.dat'\
     using (log($1/2)/log(2)):(log($14/100.00)/log(2)) t 'SR16000: 1024^3' w lp pt 4 lw 2 lt 4 lc 4,\
     'flatMPI.SR16000.2048x2048x2048.dat'\
     using (log($1/2)/log(2)):(log($14/100.00)/log(2)) t 'SR16000: 2048^3' w lp pt 6 lw 2 lt 3 lc 3,\
     'flatMPI.SR16000.4096x4096x4096.dat'\
     using (log($1/2)/log(2)):(log($14/100.00)/log(2)) t 'SR16000: 4096^3' w lp pt 8 lw 2 lt 2 lc 2,\
     'flatMPI.FX10.1024x1024x1024.dat'\
     using (log($1/8)/log(2)):(log($14/100.00)/log(2)) t    'FX10: 1024^3' w lp pt 5 lw 2 lt 8 lc 8,\
     'flatMPI.FX10.2048x2048x2048.dat'\
     using (log($1/8)/log(2)):(log($14/100.00)/log(2)) t    'FX10: 2048^3' w lp pt 7 lw 2 lt 5 lc 5,\
     'flatMPI.FX10.4096x4096x4096.dat'\
     using (log($1/8)/log(2)):(log($14/100.00)/log(2)) t    'FX10: 4096^3' w lp pt 9 lw 2 lt 7 lc 7

!epstopdf.pl flatMPI.out-of-place.eps
#Local variables:
#  compile-command: "gnuplot flatMPI.out-of-place.gp"
#End:
