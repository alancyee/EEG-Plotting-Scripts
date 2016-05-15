#!/bin/sh

set terminal svg size 1100,1100
set output 'eeg_plot.svg'
set yrange [44000:56000]
plot "gnuplot_data.dat" using 1:2 title 'C3' with lines, 'gnuplot_data.dat' using 1:3 title 'C4' with lines,\
"gnuplot_data.dat" using 1:4 title 'FC3' with lines, 'gnuplot_data.dat' using 1:5 title 'FC4' with lines,\
"gnuplot_data.dat" using 1:6 title 'C5' with lines, 'gnuplot_data.dat' using 1:7 title 'C1' with lines,\
"gnuplot_data.dat" using 1:8 title 'C2' with lines, 'gnuplot_data.dat' using 1:9 title 'C6' with lines,\
"gnuplot_data.dat" using 1:10 title 'CP3' with lines, 'gnuplot_data.dat' using 1:11 title 'CP4' with lines

