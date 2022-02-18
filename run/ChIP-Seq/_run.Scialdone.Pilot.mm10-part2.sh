#!/bin/bash
source /etc/environment
source /etc/profile


#Pilot-1
mkdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#A1-A3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A1/A1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A3/A3_R1_001.sorted.filtered.bam -f BAMPE -n A1-A3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#A1-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A1/A1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n A1-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#C2-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-C2/C2_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n C2-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#D1-C3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D1/D1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-C3/C3_R1_001.sorted.filtered.bam -f BAMPE -n D1-C3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#C3-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-C3/C3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n C3-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#D2-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D2/D2_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n D2-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#D3-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D3/D3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n D3-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#D4-D5
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D4/D4_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D5/D5_R1_001.sorted.filtered.bam -f BAMPE -n D4-D5 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations


#D1-D3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D1/D1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D3/D3_R1_001.sorted.filtered.bam -f BAMPE -n D1-D3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#A1-C2
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A1/A1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-C2/C2_R1_001.sorted.filtered.bam -f BAMPE -n A1-C2--outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#A1-D3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A1/A1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D3/D3_R1_001.sorted.filtered.bam -f BAMPE -n A1-D3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

#A1-D4
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-A1/A1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D4/D4_R1_001.sorted.filtered.bam -f BAMPE -n A1-D4 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations


#C2-D3
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-C2/C2_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/bam/Pilot-1-D3/D3_R1_001.sorted.filtered.bam -f BAMPE -n C2-D3 --outdir /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations


cd /opt/ngs/results_falini/Scialdone/ChIP-Pilot-1/peaks/combinations

closest-features --closest A1-A3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-A3_summits.annotated.bed
closest-features --closest A1-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-D5_summits.annotated.bed
closest-features --closest C2-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C2-D5_summits.annotated.bed
closest-features --closest D1-C3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D1-C3_summits.annotated.bed
closest-features --closest C3-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C3-D5_summits.annotated.bed
closest-features --closest D2-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D2-D5_summits.annotated.bed
closest-features --closest D3-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D3-D5_summits.annotated.bed
closest-features --closest D4-D5_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D4-D5_summits.annotated.bed
closest-features --closest D1-D3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > D1-D3_summits.annotated.bed
closest-features --closest A1-C2_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-C2_summits.annotated.bed
closest-features --closest A1-D3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-D3_summits.annotated.bed
closest-features --closest A1-D4_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > A1-D4_summits.annotated.bed
closest-features --closest C2-D3_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > C2-D3_summits.annotated.bed




