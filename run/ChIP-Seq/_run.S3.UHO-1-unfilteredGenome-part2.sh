#!/bin/bash
source /etc/environment
source /etc/profile


#UHO-1 splitted
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-STAT6-RepA/UHO1-KO-STAT6-RepA_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepA/UHO1-KO-INPUT-RepA_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-STAT6-RepB/UHO1-KO-STAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepB/UHO1-KO-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-pSTAT6-RepA/UHO1-KO-pSTAT6-RepA_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepA/UHO1-KO-INPUT-RepA_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-pSTAT6-RepB/UHO1-KO-pSTAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepB/UHO1-KO-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered


macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-STAT6-RepA/UHO1-NT-STAT6-RepA_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepA/UHO1-NT-INPUT-RepA_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-STAT6-RepB/UHO1-NT-STAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepB/UHO1-NT-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-pSTAT6-RepA/UHO1-NT-pSTAT6-RepA_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepA/UHO1-NT-INPUT-RepA_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-pSTAT6-RepB/UHO1-NT-pSTAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepB/UHO1-NT-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered


cd /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered

closest-features --closest KO-STAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-A_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-B_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-A_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-B_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-A_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-B_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-A_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-B_summits.annotated.bed



#UHO-1 merged
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-STAT6-RepA/UHO1-KO-STAT6-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-STAT6-RepB/UHO1-KO-STAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepA/UHO1-KO-INPUT-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepB/UHO1-KO-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-pSTAT6-RepA/UHO1-KO-pSTAT6-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-pSTAT6-RepB/UHO1-KO-pSTAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepA/UHO1-KO-INPUT-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-KO-INPUT-RepB/UHO1-KO-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged


macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-STAT6-RepA/UHO1-NT-STAT6-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-STAT6-RepB/UHO1-NT-STAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepA/UHO1-NT-INPUT-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepB/UHO1-NT-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-pSTAT6-RepA/UHO1-NT-pSTAT6-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-pSTAT6-RepB/UHO1-NT-pSTAT6-RepB_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepA/UHO1-NT-INPUT-RepA_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/bam/UHO1-NT-INPUT-RepB/UHO1-NT-INPUT-RepB_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged



cd /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/combinations/unfiltered/merged
closest-features --closest KO-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT_summits.annotated.bed


mkdir /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/irreproducible_discovery_rate/
cd /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/irreproducible_discovery_rate/
for k in $( ls /opt/ngs/results_tiacci/Chip-Tasselli/UHO-1/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
mv ../*.sorted.narrowPeak .
idr --samples UHO1-KO-STAT6-RepA_L1_1_peaks.sorted.narrowPeak UHO1-KO-STAT6-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_STAT6-idr --plot --log-output-file KO_STAT6.idr.log
idr --samples UHO1-KO-pSTAT6-RepA_L1_1_peaks.sorted.narrowPeak UHO1-KO-pSTAT6-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_pSTAT6-idr --plot --log-output-file KO_pSTAT6.idr.log
idr --samples UHO1-KO-INPUT-RepA_L1_1_peaks.sorted.narrowPeak UHO1-KO-INPUT-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_INPUT-idr --plot --log-output-file KO_INPUT.idr.log
idr --samples UHO1-NT-STAT6-RepA_L1_1_peaks.sorted.narrowPeak UHO1-NT-STAT6-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_STAT6-idr --plot --log-output-file NT_STAT6.idr.log
idr --samples UHO1-NT-pSTAT6-RepA_L1_1_peaks.sorted.narrowPeak UHO1-NT-pSTAT6-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_pSTAT6-idr --plot --log-output-file NT_pSTAT6.idr.log
idr --samples UHO1-NT-INPUT-RepA_L1_1_peaks.sorted.narrowPeak UHO1-NT-INPUT-RepB_L1_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_INPUT-idr --plot --log-output-file NT_INPUT.idr.log