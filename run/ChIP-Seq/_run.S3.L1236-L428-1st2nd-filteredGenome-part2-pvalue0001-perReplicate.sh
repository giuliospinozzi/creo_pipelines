#!/bin/bash
source /etc/environment
source /etc/profile

#L428
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-STAT6/Clean_L428_R1_NT_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-INPUT/Clean_L428_R1_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-pSTAT6/Clean_L428_R1_NT_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-NT-INPUT/Clean_L428_R1_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-STAT6/Clean_L428_R2_NT_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-INPUT/Clean_L428_R2_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-pSTAT6/Clean_L428_R2_NT_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-NT-INPUT/Clean_L428_R2_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-STAT6/Clean_L428_R1_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-INPUT/Clean_L428_R1_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-pSTAT6/Clean_L428_R1_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep1-KO-INPUT/Clean_L428_R1_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-STAT6/Clean_L428_R2_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-INPUT/Clean_L428_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-pSTAT6/Clean_L428_R2_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L428/bam/L428-Rep2-KO-INPUT/Clean_L428_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered

cd /opt/ngs/results_tiacci/Chip-Tasselli/L428/peaks/combinations/filtered

closest-features --closest KO-STAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-R1_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-R1_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-R2_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-R2_summits.annotated.bed

closest-features --closest NT-STAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-R1_summits.annotated.bed
closest-features --closest NT-STAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-R2_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-R1_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-R2_summits.annotated.bed

#L1236
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations
mkdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-STAT6/Clean_L1236_R1_NT_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-INPUT/Clean_L1236_R1_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-STAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-pSTAT6/Clean_L1236_R1_NT_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-NT-INPUT/Clean_L1236_R1_NT_INPUT_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-NT-STAT6a/Clean_L1236_R2_NT_STAT6a_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-NT-INPUTa/Clean_L1236_R2_NT_INPUTa_1.sorted.filtered.bam -f BAMPE -n NT-STAT6a-INPUTa-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-NT-pSTAT6b/Clean_L1236_R2_NT_pSTAT6b_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-NT-INPUTb/Clean_L1236_R2_NT_INPUTb_1.sorted.filtered.bam -f BAMPE -n NT-pSTAT6b-INPUTb-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered

macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-STAT6/Clean_L1236_R1_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-INPUT/Clean_L1236_R1_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-pSTAT6/Clean_L1236_R1_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep1-KO-INPUT/Clean_L1236_R1_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-R1 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-KO-STAT6/Clean_L1236_R2_KO_STAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-KO-INPUT/Clean_L1236_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-STAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered
macs2 callpeak --pvalue 0.0001 -B -g hs -t /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-KO-pSTAT6/Clean_L1236_R2_KO_pSTAT6_1.sorted.filtered.bam -c /opt/ngs/results_tiacci/Chip-Tasselli/L1236/bam/L1236-Rep2-KO-INPUT/Clean_L1236_R2_KO_INPUT_1.sorted.filtered.bam -f BAMPE -n KO-pSTAT6-INPUT-R2 --outdir /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered

cd /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks/combinations/filtered

closest-features --closest KO-STAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-R1_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-R1_summits.annotated.bed
closest-features --closest KO-STAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-STAT6-INPUT-R2_summits.annotated.bed
closest-features --closest KO-pSTAT6-INPUT-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > KO-pSTAT6-INPUT-R2_summits.annotated.bed

closest-features --closest NT-STAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6-INPUT-R1_summits.annotated.bed
closest-features --closest NT-STAT6a-INPUTa-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-STAT6a-INPUTa-R2_summits.annotated.bed
closest-features --closest NT-pSTAT6-INPUT-R1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6-INPUT-R1_summits.annotated.bed
closest-features --closest NT-pSTAT6b-INPUTb-R2_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > NT-pSTAT6b-INPUTb-R2_summits.annotated.bed

