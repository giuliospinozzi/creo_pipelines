#!/bin/bash
source /etc/environment
source /etc/profile


#1stBatch
mkdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A1-A2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A1-1/A1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -f BAMPE -n A1-A2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A1-A3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A1-1/A1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A3-1/A3-27422_R1_001.sorted.filtered.bam -f BAMPE -n A1-A3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A1-A4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A1-1/A1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A4-1/A4-27422_R1_001.sorted.filtered.bam -f BAMPE -n A1-A4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A2-A3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A3-1/A3-27422_R1_001.sorted.filtered.bam -f BAMPE -n A2-A3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A2-A4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A4-1/A4-27422_R1_001.sorted.filtered.bam -f BAMPE -n A2-A4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A2-B4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/B4-1/B4-27422_R1_001.sorted.filtered.bam -f BAMPE -n A2-B4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#B2-B4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/B2-1/B2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/B4-1/B4-27422_R1_001.sorted.filtered.bam -f BAMPE -n B2-B4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#C1-C3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/C1-1/C1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/C3-1/C3-27422_R1_001.sorted.filtered.bam -f BAMPE -n C1-C3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#C1-C4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/C1-1/C1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/C4-1/C4-27422_R1_001.sorted.filtered.bam -f BAMPE -n C1-C4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#D3-D4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D3-1/D3-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D4-1/D4-27422_R1_001.sorted.filtered.bam -f BAMPE -n D3-C4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A1-D2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A1-1/A1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D2-1/D2-27422_R1_001.sorted.filtered.bam -f BAMPE -n A1-D2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A2-D2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D2-1/D2-27422_R1_001.sorted.filtered.bam -f BAMPE -n A2-D2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#D3-D2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D3-1/D3-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D2-1/D2-27422_R1_001.sorted.filtered.bam -f BAMPE -n D3-D2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#D4-D2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D4-1/D4-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D2-1/D2-27422_R1_001.sorted.filtered.bam -f BAMPE -n D4-D2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A2-B2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A2-1/A2-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/B2-1/B2-27422_R1_001.sorted.filtered.bam -f BAMPE -n A2-B2 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A1-C1
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A1-1/A1-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/C1-1/C1-27422_R1_001.sorted.filtered.bam -f BAMPE -n A1-C1 -outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A3-D3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A3-1/A3-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D3-1/D3-27422_R1_001.sorted.filtered.bam -f BAMPE -n A3-D3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

#A4-D4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/A4-1/A4-27422_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/bam/D4-1/D4-27422_R1_001.sorted.filtered.bam -f BAMPE -n A4-D4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations


cd /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/combinations

closest-features --closest A1-A2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-A2_summits.annotated.bed

closest-features --closest A1-A3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-A3_summits.annotated.bed

closest-features --closest A1-A4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-A4_summits.annotated.bed

closest-features --closest A2-A3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A2-A3_summits.annotated.bed

closest-features --closest A2-A4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A2-A4_summits.annotated.bed

closest-features --closest A2-B4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A2-B4_summits.annotated.bed

closest-features --closest B2-B4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > B2-B4_summits.annotated.bed

closest-features --closest C1-C3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C1-C3_summits.annotated.bed

closest-features --closest C1-C4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C1-C4_summits.annotated.bed

closest-features --closest D3-D4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D3-D4_summits.annotated.bed

closest-features --closest A1-D2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-D2_summits.annotated.bed

closest-features --closest A2-D2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A2-D2_summits.annotated.bed

closest-features --closest D3-D2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D3-D2_summits.annotated.bed

closest-features --closest D4-D2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D4-D2_summits.annotated.bed

closest-features --closest A2-B2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A2-B2_summits.annotated.bed

closest-features --closest A1-C1_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-C1_summits.annotated.bed

closest-features --closest A3-D3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A3-D3_summits.annotated.bed

closest-features --closest A4-D4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A4-D4_summits.annotated.bed