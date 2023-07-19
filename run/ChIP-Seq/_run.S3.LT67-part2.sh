#!/bin/bash
source /etc/environment
source /etc/profile

mkdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

#L67
macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-Empty-ReplA/1_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-Empty-ReplB/15_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/Empty-ReplA/8_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/Empty-ReplB/22_R1.sorted.filtered.bam -f BAMPE -n INPUT-Empty --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-WT-ReplA/2_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-WT-ReplB/16_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-WT-ReplA/9_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-WT-ReplB/23_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-WT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-ReplA/3_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-ReplB/17_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-ReplA/10_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-ReplB/24_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-N417Y --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-D419G-ReplA/4_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-D419G-ReplB/18_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-D419G-ReplA/11_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-D419G-ReplB/25_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-D419G --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-D419G-ReplA/5_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-D419G-ReplB/19_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-D419G-ReplA/12_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-D419G-ReplB/26_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-N417Y-D419G --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-D419N-ReplA/6_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-D419N-ReplB/20_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-D419N-ReplA/13_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-D419N-ReplB/27_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-D419N --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

macs2 callpeak -B -g hs -c /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-D419N-ReplA/7_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/INPUT-STAT6-N417Y-D419N-ReplB/21_R1.sorted.filtered.bam -t /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-D419N-ReplA/14_R1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/LT67/bam/STAT6-N417Y-D419N-ReplB/28_R1.sorted.filtered.bam -f BAMPE -n INPUT-STAT6-N417Y-D419N --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged



cd /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/combinations/merged

closest-features --closest INPUT-Empty_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-Empty_summits.annotated.bed
closest-features --closest INPUT-STAT6-WT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-WT_summits.annotated.bed
closest-features --closest INPUT-STAT6-N417Y_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-N417Y_summits.annotated.bed
closest-features --closest INPUT-STAT6-D419G_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-D419G_summits.annotated.bed
closest-features --closest INPUT-STAT6-N417Y-D419G_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-N417Y-D419G_summits.annotated.bed
closest-features --closest INPUT-STAT6-D419N_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-D419N_summits.annotated.bed
closest-features --closest INPUT-STAT6-N417Y-D419N_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > INPUT-STAT6-N417Y-D419N_summits.annotated.bed




mkdir /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/irreproducible_discovery_rate/
cd /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/irreproducible_discovery_rate/
for k in $( ls /opt/ngs/results_tiacci/Chip-Tasselli/LT67/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
mv ../*.sorted.narrowPeak .
idr --samples 1_R1_peaks.sorted.narrowPeak 15_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-Empty-idr --plot --log-output-file INPUT-Empty.idr.log
idr --samples 2_R1_peaks.sorted.narrowPeak 16_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-WT-idr --plot --log-output-file INPUT-STAT6-WT.idr.log
idr --samples 3_R1_peaks.sorted.narrowPeak 17_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-N417Y-idr --plot --log-output-file INPUT-STAT6-N417Y.idr.log
idr --samples 4_R1_peaks.sorted.narrowPeak 18_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-D419G-idr --plot --log-output-file INPUT-STAT6-D419G.idr.log
idr --samples 5_R1_peaks.sorted.narrowPeak 19_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-N417Y-D419G-idr --plot --log-output-file INPUT-STAT6-N417Y-D419G.idr.log
idr --samples 6_R1_peaks.sorted.narrowPeak 20_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-D419N-idr --plot --log-output-file INPUT-STAT6-D419N.idr.log
idr --samples 7_R1_peaks.sorted.narrowPeak 21_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file INPUT-STAT6-N417Y-D419N-idr --plot --log-output-file INPUT-STAT6-N417Y-D419N.idr.log

idr --samples 8_R1_peaks.sorted.narrowPeak 22_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file Empty-idr --plot --log-output-file Empty.idr.log
idr --samples 9_R1_peaks.sorted.narrowPeak 23_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-WT-idr --plot --log-output-file STAT6-WT.idr.log
idr --samples 10_R1_peaks.sorted.narrowPeak 24_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-N417Y-idr --plot --log-output-file STAT6-N417Y.idr.log
idr --samples 11_R1_peaks.sorted.narrowPeak 25_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-D419G-idr --plot --log-output-file STAT6-D419G.idr.log
idr --samples 12_R1_peaks.sorted.narrowPeak 26_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-N417Y-D419G-idr --plot --log-output-file STAT6-N417Y-D419G.idr.log
idr --samples 13_R1_peaks.sorted.narrowPeak 27_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-D419N-idr --plot --log-output-file STAT6-D419N.idr.log
idr --samples 14_R1_peaks.sorted.narrowPeak 28_R1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file STAT6-N417Y-D419N-idr --plot --log-output-file STAT6-N417Y-D419N.idr.log




