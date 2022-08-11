#!/bin/bash
source /etc/environment
source /etc/profile


#LT53 splitted
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT_Empty-1/Empty_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT_Empty-1/INPUT_Empty_1.sorted.filtered.bam -f BAMPE -n INPUT-Empty-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-WT-1/WT_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-WT-1/INPUT_WT_1.sorted.filtered.bam -f BAMPE -n INPUT-WT-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-1/N417Y_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-1/INPUT_N417Y_1.sorted.filtered.bam -f BAMPE -n INPUT-N417Y-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-D419G-1/D419G_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-D419G-1/INPUT_D419G_1.sorted.filtered.bam -f BAMPE -n INPUT-D419G-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-D419G-1/N417Y_D419G_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-D419G-1/INPUT_N417Y_D419G_1.sorted.filtered.bam -f BAMPE -n INPUT-N417Y-D419G-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-D419N-1/D419N_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-D419N-1/INPUT_D419N_1.sorted.filtered.bam -f BAMPE -n INPUT-D419N-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

macs2 callpeak -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-D419N-1/N417Y_D419N_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/LT53/bam/INPUT-N417Y-D419N-1/INPUT_N417Y_D419N_1.sorted.filtered.bam -f BAMPE -n INPUT-N417Y-D419N-1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered


cd /opt/ngs/results_tiacci/Chip-Tasselli/LT53/peaks/combinations/unfiltered

closest-features --closest INPUT-Empty-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-Empty-1_summits.annotated.bed
closest-features --closest INPUT-WT-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-WT-1_summits.annotated.bed
closest-features --closest INPUT-N417Y-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-N417Y-1_summits.annotated.bed
closest-features --closest INPUT-D419G-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-D419G-1_summits.annotated.bed
closest-features --closest INPUT-N417Y-D419G-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-N417Y-D419G-1_summits.annotated.bed
closest-features --closest INPUT-D419N-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-D419N-1_summits.annotated.bed
closest-features --closest INPUT-N417Y-D419N-1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > INPUT-N417Y-D419N-1_summits.annotated.bed

