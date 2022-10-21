#!/bin/bash
source /etc/environment
source /etc/profile


#1stBatch
mkdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

#A
macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_MUT/IDH2_A_MUT_S2_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_EMPTY/IDH2_A_EMPTY_S1_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_A_MUT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_WT/IDH2_A_WT_S3_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_EMPTY/IDH2_A_EMPTY_S1_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_A_WT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_WT/IDH2_A_WT_S3_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_A_MUT/IDH2_A_MUT_S2_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_A_WT_MUT --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations


#B
macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_MUT/IDH2_B_MUT_S5_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_EMPTY/IDH2_B_EMPTY_S4_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_B_MUT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_WT/IDH2_B_WT_S6_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_EMPTY/IDH2_B_EMPTY_S4_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_B_WT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_WT/IDH2_B_WT_S6_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_B_MUT/IDH2_B_MUT_S5_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_B_WT_MUT --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations


#C
macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_MUT/IDH2_C_MUT_S8_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_EMPTY/IDH2_C_EMPTY_S7_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_C_MUT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_WT/IDH2_C_WT_S9_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_EMPTY/IDH2_C_EMPTY_S7_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_C_WT_EMPTY --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations

macs2 callpeak -B -g hs -t /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_WT/IDH2_C_WT_S9_R1_001.sorted.filtered.bam -c /opt/ngs/results/ATAC-Seq/run488/bam/IDH2_C_MUT/IDH2_C_MUT_S8_R1_001.sorted.filtered.bam -f BAMPE -n IDH2_C_WT_MUT --outdir /opt/ngs/results/ATAC-Seq/run488/peaks/combinations


#Annotation
cd /opt/ngs/results/ATAC-Seq/run488/peaks/combinations
pigz *.bdg

closest-features --closest IDH2_A_MUT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_MUT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_A_WT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_WT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_A_WT_MUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_WT_MUT_summits.annotated.bed

closest-features --closest IDH2_B_MUT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_MUT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_B_WT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_WT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_B_WT_MUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_WT_MUT_summits.annotated.bed

closest-features --closest IDH2_C_MUT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_MUT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_C_WT_EMPTY_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_WT_EMPTY_summits.annotated.bed

closest-features --closest IDH2_C_WT_MUT_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_WT_MUT_summits.annotated.bed