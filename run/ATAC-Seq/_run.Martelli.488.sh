#!/bin/bash
source /etc/environment
source /etc/profile


ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_A_EMPTY /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_A_EMPTY_S1_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_A_EMPTY_S1_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_A_MUT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_A_MUT_S2_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_A_MUT_S2_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_A_WT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_A_WT_S3_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_A_WT_S3_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_B_EMPTY /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_B_EMPTY_S4_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_B_EMPTY_S4_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_B_MUT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_B_MUT_S5_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_B_MUT_S5_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_B_WT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_B_WT_S6_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_B_WT_S6_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_C_EMPTY /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_C_EMPTY_S7_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_C_EMPTY_S7_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_C_MUT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_C_MUT_S8_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_C_MUT_S8_R2_001.fastq.gz

ATAC-Seq.pipeline-PE ATAC-Seq run488 IDH2_C_WT /opt/ngs/results 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /home/giulio/ATAC-OSR-run488/IDH2_C_WT_S9_R1_001.fastq.gz /home/giulio/ATAC-OSR-run488/IDH2_C_WT_S9_R2_001.fastq.gz


cd /opt/ngs/results/ATAC-Seq/run488/peaks
closest-features --closest IDH2_A_EMPTY_S1_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_EMPTY_S1_R1_001_summits.annotated.bed
closest-features --closest IDH2_A_MUT_S2_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_MUT_S2_R1_001_summits.annotated.bed
closest-features --closest IDH2_A_WT_S3_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_A_WT_S3_R1_001_summits.annotated.bed
closest-features --closest IDH2_B_EMPTY_S4_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_EMPTY_S4_R1_001_summits.annotated.bed
closest-features --closest IDH2_B_MUT_S5_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_MUT_S5_R1_001_summits.annotated.bed
closest-features --closest IDH2_B_WT_S6_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_B_WT_S6_R1_001_summits.annotated.bed
closest-features --closest IDH2_C_EMPTY_S7_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_EMPTY_S7_R1_001_summits.annotated.bed
closest-features --closest IDH2_C_MUT_S8_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_MUT_S8_R1_001_summits.annotated.bed
closest-features --closest IDH2_C_WT_S9_R1_001_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > IDH2_C_WT_S9_R1_001_summits.annotated.bed

