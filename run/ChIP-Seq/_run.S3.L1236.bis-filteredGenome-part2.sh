#!/bin/bash
source /etc/environment
source /etc/profile


#L1236
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-STAT6/Clean_L1236_R1_NT_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-C-R1-NT-INP-new/C-R1-NT-INP-new_L1_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-R1-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-pSTAT6/Clean_L1236_R1_NT_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-C-R1-NT-INP-new/C-R1-NT-INP-new_L1_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-R1-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-STAT6/Clean_L1236_R1_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-D-R1-KO-INP-new/D-R1-KO-INP-new_L1_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-R1-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-pSTAT6/Clean_L1236_R1_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-D-R1-KO-INP-new/D-R1-KO-INP-new_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-R1-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-E-R2-NT-pSTAT6a/E-R2-NT-pSTAT6a_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-NT-INPUTa/Clean_L1236_R2_NT_INPUTa_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6a-INPUTa-R2-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-G-R2-KO-pSTAT6b/G-R2-KO-pSTAT6b_L1_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-F-R2-KO-INPUTb/F-R2-KO-INPUTb_L1_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6b-INPUTb-R2-INP-new --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered


cd /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/unfiltered

closest-features --closest NT-STAT6-INPUT-R1-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-R1-INP-new_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-R1-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-R1-INP-new_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-R1-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-R1-INP-new_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-R1-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-R1-INP-new_summits.annotated.bed
closest-features --closest NT-pSTAT6a-INPUTa-R2-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6a-INPUTa-R2-INP-new_summits.annotated.bed
closest-features --closest KO-pSTAT6b-INPUTb-R2-INP-new_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6b-INPUTb-R2-INP-new_summits.annotated.bed

