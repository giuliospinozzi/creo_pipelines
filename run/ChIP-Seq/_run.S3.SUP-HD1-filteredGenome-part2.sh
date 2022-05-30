#!/bin/bash
source /etc/environment
source /etc/profile


#SUP-HD1 splitted
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/5-A-S-KO-STAT6/5-A-5-KO-STAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-A-S-KO-INPUT/4-A-S-KO-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/5-B-S-KO-STAT6/5-B-S-KO-STAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-B-S-KO-INPUT/4-B-S-KO-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/6-A-S-KO-pSTAT6/6-A-S-KO-pSTAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-A-S-KO-INPUT/4-A-S-KO-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/6-B-S-KO-pSTAT6/6-B-S-KO-pSTAT_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-B-S-KO-INPUT/4-B-S-KO-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered


macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/2-A-S-NT-STAT6/2-A-S-NT-STAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-A-S-NT-INPUT/1-A-S-NT-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/2-B-S-NT-STAT6/2-B-S-NT-STAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-B-S-NT-INPUT/1-B-S-NT-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-A-S-NT-pSTAT6/3-A-S-NT-pSTAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-A-S-NT-INPUT/1-A-S-NT-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-A --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-B-S-NT-pSTAT6/3-B-S-NT-pSTAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-B-S-NT-INPUT/1-B-S-NT-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-B --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered


cd /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered

closest-features --closest KO-STAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-A_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-B_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-A_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-B_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-A_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-B_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-A_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-A_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-B_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-B_summits.annotated.bed



#SUP-HD1 merged
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/5-A-S-KO-STAT6/5-A-5-KO-STAT6_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/5-B-S-KO-STAT6/5-B-S-KO-STAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-A-S-KO-INPUT/4-A-S-KO-INPUT_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-B-S-KO-INPUT/4-B-S-KO-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-A-S-NT-pSTAT6/3-A-S-NT-pSTAT6_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-B-S-NT-pSTAT6/3-B-S-NT-pSTAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-A-S-KO-INPUT/4-A-S-KO-INPUT_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/4-B-S-KO-INPUT/4-B-S-KO-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged


macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/2-A-S-NT-STAT6/2-A-S-NT-STAT6_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/2-B-S-NT-STAT6/2-B-S-NT-STAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-A-S-NT-INPUT/1-A-S-NT-INPUT_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-B-S-NT-INPUT/1-B-S-NT-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-A-S-NT-pSTAT6/3-A-S-NT-pSTAT6_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/3-B-S-NT-pSTAT6/3-B-S-NT-pSTAT6_L2_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-A-S-NT-INPUT/1-A-S-NT-INPUT_L1_1.sorted.filtered.bam /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/bam/1-B-S-NT-INPUT/1-B-S-NT-INPUT_L2_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT --outdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged



cd /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/combinations/unfiltered/merged
closest-features --closest KO-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT_summits.annotated.bed


mkdir /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/irreproducible_discovery_rate/
cd /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/irreproducible_discovery_rate/
for k in $( ls /opt/ngs/results_tiacci/Chip-Tasselli/SUP-HD1/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
mv ../*.sorted.narrowPeak .
idr --samples 5-A-5-KO-STAT6_L1_1_peaks.sorted.narrowPeak 5-B-S-KO-STAT6_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_STAT6-idr --plot --log-output-file KO_STAT6.idr.log
idr --samples 6-A-S-KO-pSTAT6_L1_1_peaks.sorted.narrowPeak 6-B-S-KO-pSTAT_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_pSTAT6-idr --plot --log-output-file KO_pSTAT6.idr.log
idr --samples 4-A-S-KO-INPUT_L1_1_peaks.sorted.narrowPeak 4-B-S-KO-INPUT_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file KO_INPUT-idr --plot --log-output-file KO_INPUT.idr.log
idr --samples 2-A-S-NT-STAT6_L1_1_peaks.sorted.narrowPeak 2-B-S-NT-STAT6_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_STAT6-idr --plot --log-output-file NT_STAT6.idr.log
idr --samples 3-A-S-NT-pSTAT6_L1_1_peaks.sorted.narrowPeak 3-B-S-NT-pSTAT6_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_pSTAT6-idr --plot --log-output-file NT_pSTAT6.idr.log
idr --samples 1-A-S-NT-INPUT_L1_1_peaks.sorted.narrowPeak 1-B-S-NT-INPUT_L2_1_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file NT_INPUT-idr --plot --log-output-file NT_INPUT.idr.log