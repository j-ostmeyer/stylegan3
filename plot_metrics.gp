set terminal postscript landscape enhanced color lw 1 font 16
set encoding iso_8859_1
set grid lt 0 lw .3
set samples 10000
set fit results
set pointsize 1
set border lw 0.5

set logscale y

set xlabel "kimag"
set ylabel "metric"

set output "metrics.eps"
set title tt
plot "metric-fid50k_full.csv" u 1:($2/100) w l t "FID/100", "metric-kid50k_full.csv" u 1:($2*100) w l t "KID*100"#, "metric-pr50k3_full.csv" u 1:($2) w l t "PR"
