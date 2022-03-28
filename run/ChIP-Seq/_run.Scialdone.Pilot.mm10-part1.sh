#!/bin/bash
source /etc/environment
source /etc/profile

#Pilot-1
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-A1 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/A1_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/A1_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-A3 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/A3_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/A3_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-C2 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/C2_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/C2_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-C3 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/C3_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/C3_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-D1 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D1_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D1_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-D2 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D2_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D2_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-D3 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D3_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D3_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-D4 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D4_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D4_R2_001.fastq.gz
ChIP-Seq_pipeline.PE Scialdone ChIP-Pilot-1 Pilot-1-D5 /opt/ngs/results_falini 12 /opt/genome/mouse/mm10/index/bowtie2/mm10.filtered /opt/genome/control/phix174/bwa/phiX174.fa /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D5_R1_001.fastq.gz /mnt/Martelli_Collaborations/Scialdone/90-590241625/00_fastq/D5_R2_001.fastq.gz




cd /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks
closest-features --closest A1_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1_R1_001_summits.annotated.bed
closest-features --closest A3_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A3_R1_001_summits.annotated.bed
closest-features --closest C2_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C2_R1_001_summits.annotated.bed
closest-features --closest C3_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C3_R1_001_summits.annotated.bed
closest-features --closest D1_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D1_R1_001_summits.annotated.bed
closest-features --closest D2_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D2_R1_001_summits.annotated.bed
closest-features --closest D3_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D3_R1_001_summits.annotated.bed
closest-features --closest D4_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D4_R1_001_summits.annotated.bed
closest-features --closest D5_R1_001_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D5_R1_001_summits.annotated.bed
