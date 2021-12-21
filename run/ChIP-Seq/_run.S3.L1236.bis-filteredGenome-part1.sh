#!/bin/bash
source /etc/environment
source /etc/profile

#L1236 - BIS
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-A-R1-NT-INPUT /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/A-R1-NT-INPUT/A-R1-NT-INPUT_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/A-R1-NT-INPUT/A-R1-NT-INPUT_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-B-R1-KO-INPUT /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/B-R1-KO-INPUT/B-R1-KO-INPUT_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/B-R1-KO-INPUT/B-R1-KO-INPUT_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-C-R1-NT-INP-new /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/C-R1-NT-INP-new/C-R1-NT-INP-new_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/C-R1-NT-INP-new/C-R1-NT-INP-new_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-D-R1-KO-INP-new /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/D-R1-KO-INP-new/D-R1-KO-INP-new_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/D-R1-KO-INP-new/D-R1-KO-INP-new_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-E-R2-NT-pSTAT6a /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/E-R2-NT-pSTAT6a/E-R2-NT-pSTAT6a_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/E-R2-NT-pSTAT6a/E-R2-NT-pSTAT6a_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-F-R2-KO-INPUTb /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/F-R2-KO-INPUTb/F-R2-KO-INPUTb_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/F-R2-KO-INPUTb/F-R2-KO-INPUTb_L1_2.fq.gz
ChIP-Seq_pipeline.PE Chip-Tasselli L1236 L1236-G-R2-KO-pSTAT6b /opt/ngs/results_tiacci 12 /opt/genome/human/hg19/index/bowtie2/hg19.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/G-R2-KO-pSTAT6b/G-R2-KO-pSTAT6b_L1_1.fq.gz /mnt/Martelli_Collaborations/Tiacci/Chip-Tasselli-Amazon/f21ftseuht1676-humusbmr/G-R2-KO-pSTAT6b/G-R2-KO-pSTAT6b_L1_2.fq.gz



cd /opt/ngs/results_tiacci/Chip-Tasselli/L1236/peaks
closest-features --closest A-R1-NT-INPUT_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > A-R1-NT-INPUT_L1_1_summits.annotated.bed
closest-features --closest B-R1-KO-INPUT_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > B-R1-KO-INPUT_L1_1_summits.annotated.bed
closest-features --closest C-R1-NT-INP-new_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > C-R1-NT-INP-new_L1_1_summits.annotated.bed
closest-features --closest D-R1-KO-INP-new_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > D-R1-KO-INP-new_L1_1_summits.annotated.bed
closest-features --closest E-R2-NT-pSTAT6a_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > E-R2-NT-pSTAT6a_L1_1_summits.annotated.bed
closest-features --closest F-R2-KO-INPUTb_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > F-R2-KO-INPUTb_L1_1_summits.annotated.bed
closest-features --closest G-R2-KO-pSTAT6b_L1_1_summits.bed <(gtf2bed < /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf) > G-R2-KO-pSTAT6b_L1_1_summits.annotated.bed

