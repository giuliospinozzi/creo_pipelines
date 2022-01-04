#!/bin/bash
source /etc/environment
source /etc/profile

#L1236 - Replicate 3
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-NT-STAT6/2-R3-NT-STAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-NT-INPUT/1-R3-NT-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-2-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-NT-pSTAT6/3-R3-NT-pSTAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-NT-INPUT/1-R3-NT-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-3-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-KO-STAT6/5-R3-KO-STAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-KO-INPUT/4-R3-KO-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-5-4 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-KO-pSTAT6/6-R3-KO-pSTAT6_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep3-KO-INPUT/4-R3-KO-INPUT_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-6-4 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered

cd /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered

closest-features --closest NT-STAT6-INPUT-2-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-2-1_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-3-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-3-1_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-5-4_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-5-4_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-6-4_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-6-4_summits.annotated.bed