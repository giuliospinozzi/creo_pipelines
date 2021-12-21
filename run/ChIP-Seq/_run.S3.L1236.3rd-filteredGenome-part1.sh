#!/bin/bash
source /etc/environment
source /etc/profile

#L1236 - Replicate 3
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-NT-INPUT /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/1-R3-NT-INPUT/1-R3-NT-INPUT_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/1-R3-NT-INPUT/1-R3-NT-INPUT_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-NT-STAT6 /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/2-R3-NT-STAT6/2-R3-NT-STAT6_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/2-R3-NT-STAT6/2-R3-NT-STAT6_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-NT-pSTAT6 /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/3-R3-NT-pSTAT6/3-R3-NT-pSTAT6_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/3-R3-NT-pSTAT6/3-R3-NT-pSTAT6_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-KO-INPUT /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/4-R3-KO-INPUT/4-R3-KO-INPUT_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/4-R3-KO-INPUT/4-R3-KO-INPUT_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-KO-STAT6 /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/5-R3-KO-STAT6/5-R3-KO-STAT6_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/5-R3-KO-STAT6/5-R3-KO-STAT6_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-Rep3-KO-pSTAT6 /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/6-R3-KO-pSTAT6/6-R3-KO-pSTAT6_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/6-R3-KO-pSTAT6/6-R3-KO-pSTAT6_L1_2.fq.gz

cd /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks
closest-features --closest 1-R3-NT-INPUT_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 1-R3-NT-INPUT_L1_1_summits.annotated.bed
closest-features --closest 2-R3-NT-STAT6_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 2-R3-NT-STAT6_L1_1_summits.annotated.bed
closest-features --closest 3-R3-NT-pSTAT6_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 3-R3-NT-pSTAT6_L1_1_summits.annotated.bed
closest-features --closest 4-R3-KO-INPUT_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 4-R3-KO-INPUT_L1_1_summits.annotated.bed
closest-features --closest 5-R3-KO-STAT6_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 5-R3-KO-STAT6_L1_1_summits.annotated.bed
closest-features --closest 6-R3-KO-pSTAT6_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > 6-R3-KO-pSTAT6_L1_1_summits.annotated.bed

