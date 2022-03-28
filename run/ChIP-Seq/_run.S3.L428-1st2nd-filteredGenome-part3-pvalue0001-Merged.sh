#!/bin/bash
source /etc/environment
source /etc/profile

mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged

#L428
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-STAT6/Clean_L428_R1_NT_STAT6_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-STAT6/Clean_L428_R2_NT_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-INPUT/Clean_L428_R1_NT_INPUT_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-INPUT/Clean_L428_R2_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-pSTAT6/Clean_L428_R1_NT_pSTAT6_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-pSTAT6/Clean_L428_R2_NT_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-INPUT/Clean_L428_R1_NT_INPUT_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-INPUT/Clean_L428_R2_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-STAT6/Clean_L428_R1_KO_STAT6_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-STAT6/Clean_L428_R2_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-INPUT/Clean_L428_R1_KO_INPUT_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-INPUT/Clean_L428_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-pSTAT6/Clean_L428_R1_KO_pSTAT6_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-pSTAT6/Clean_L428_R2_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-INPUT/Clean_L428_R1_KO_INPUT_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-INPUT/Clean_L428_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged

cd /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/unfiltered/merged
closest-features --closest KO-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT_summits.annotated.bed

mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/irreproducible_discovery_rate/
cd /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/irreproducible_discovery_rate/
for k in $( ls /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
mv ../*.sorted.narrowPeak .
idr --samples Clean_L428_R1_KO_pSTAT6_1_peaks.sorted.narrowPeak Clean_L428_R2_KO_pSTAT6_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_pSTAT6-idr --plot --log-output-file KO_pSTAT6.idr.log
idr --samples Clean_L428_R1_KO_STAT6_1_peaks.sorted.narrowPeak Clean_L428_R2_KO_STAT6_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_STAT6-idr --plot --log-output-file KO_STAT6.idr.log
idr --samples Clean_L428_R1_KO_INPUT_1_peaks.sorted.narrowPeak Clean_L428_R2_KO_INPUT_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_INPUT-idr --plot --log-output-file KO_INPUT.idr.log
idr --samples Clean_L428_R1_NT_pSTAT6_1_peaks.sorted.narrowPeak Clean_L428_R2_NT_pSTAT6_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_pSTAT6-idr --plot --log-output-file NT_pSTAT6.idr.log
idr --samples Clean_L428_R1_NT_STAT6_1_peaks.sorted.narrowPeak Clean_L428_R2_NT_STAT6_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_STAT6-idr --plot --log-output-file NT_STAT6.idr.log
idr --samples Clean_L428_R1_NT_INPUT_1_peaks.sorted.narrowPeak Clean_L428_R2_NT_INPUT_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_INPUT-idr --plot --log-output-file NT_INPUT.idr.log