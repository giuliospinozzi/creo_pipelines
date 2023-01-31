#!/bin/bash
source /etc/environment
source /etc/profile


#2ndBatch
mkdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#E1-WTinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/E1-1/E1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/WTINPUT-1/WTINPUT_R1_001.sorted.filtered.bam -f BAMPE -n E1-WTINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#E2-WTinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/E2-1/E2_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/WTINPUT-1/WTINPUT_R1_001.sorted.filtered.bam -f BAMPE -n E2-WTINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#E3-WTinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/E3-1/E3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/WTINPUT-1/WTINPUT_R1_001.sorted.filtered.bam -f BAMPE -n E3-WTINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#E4-WTinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/E4-1/E4_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/WTINPUT-1/WTINPUT_R1_001.sorted.filtered.bam -f BAMPE -n E4-WTINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations



#F1-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/F1-1/F1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BCINPUT-1/BCINPUT_R1_001.sorted.filtered.bam -f BAMPE -n F1-BCINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#F3-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/F3-1/F3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BCINPUT-1/BCINPUT_R1_001.sorted.filtered.bam -f BAMPE -n F3-BCINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#F4-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/F4-1/F4_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BCINPUT-1/BCINPUT_R1_001.sorted.filtered.bam -f BAMPE -n F4-BCINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations



#G2-DNinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/G2-1/G2_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/DNINPUT-1/DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n G2-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#G3-DNinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/G3-1/G3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/DNINPUT-1/DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n G3-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#G4-DNinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/G4-1/G4_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/DNINPUT-1/DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n G4-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations



#H1-DN-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/H1-1/H1_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BC-DNINPUT-1/BC-DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n H1-BC-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#H3-DN-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/H3-1/H3_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BC-DNINPUT-1/BC-DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n H3-BC-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

#H4-DN-BCinput
macs2 callpeak -B -g hs -t /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/H4-1/H4_R1_001.sorted.filtered.bam -c /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/bam/BC-DNINPUT-1/BC-DNINPUT_R1_001.sorted.filtered.bam -f BAMPE -n H4-BC-DNINPUT --outdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations



cd /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/combinations

closest-features --closest E1-WTINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > E1-WTINPUT_summits.annotated.bed
closest-features --closest E2-WTINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > E2-WTINPUT_summits.annotated.bed
closest-features --closest E3-WTINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > E3-WTINPUT_summits.annotated.bed
closest-features --closest E4-WTINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > E4-WTINPUT_summits.annotated.bed

closest-features --closest F1-BCINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > F1-BCINPUT_summits.annotated.bed
closest-features --closest F3-BCINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > F3-BCINPUT_summits.annotated.bed
closest-features --closest F4-BCINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > F4-BCINPUT_summits.annotated.bed

closest-features --closest G2-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > G2-DNINPUT_summits.annotated.bed
closest-features --closest G3-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > G3-DNINPUT_summits.annotated.bed
closest-features --closest G4-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > G4-DNINPUT_summits.annotated.bed

closest-features --closest H1-BC-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > H1-BC-DNINPUT_summits.annotated.bed
closest-features --closest H3-BC-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > H3-BC-DNINPUT_summits.annotated.bed
closest-features --closest H4-BC-DNINPUT_summits.bed <(gtf2bed < /opt/genome/mouse/mm10/annotation/mm10.sorted.gtf) > H4-BC-DNINPUT_summits.annotated.bed


mkdir /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/irreproducible_discovery_rate/
cd /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/irreproducible_discovery_rate/
for k in $( ls /opt/ngs/results_falini/Scialdone/ChIP-2ndBatch/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
for k in $( ls /opt/ngs/results_falini/Scialdone/ChIP-1stBatch/peaks/*.narrowPeak ); do echo $k; cat $k | sort -k8,8nr | head -n 100000 > ${k:0:-10}sorted.narrowPeak; done
mv ../*.sorted.narrowPeak .
idr --samples A1-27422_R1_001_peaks.sorted.narrowPeak E1_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-BCOR-MEPwt-idr --plot --log-output-file anti-BCOR-MEPwt.idr.log
idr --samples A2-27422_R1_001_peaks.sorted.narrowPeak E2_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-DNMT3A-MEPwt-idr --plot --log-output-file anti-DNMT3A-MEPwt.idr.log
idr --samples A3-27422_R1_001_peaks.sorted.narrowPeak E3_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-HA2119Ub-MEPwt-idr --plot --log-output-file anti-HA2119Ub-MEPwt.idr.log
idr --samples A4-27422_R1_001_peaks.sorted.narrowPeak E4_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-KDM2B-MEPwt-idr --plot --log-output-file anti-KDM2B-MEPwt.idr.log

idr --samples B2-27422_R1_001_peaks.sorted.narrowPeak F1_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-DNMT3A-MEP_bcor_ko-idr --plot --log-output-file anti-DNMT3A-MEP_bcor_ko.idr.log
idr --samples B3-27422_R1_001_peaks.sorted.narrowPeak F3_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-HA2119Ub-MEP_bcor_ko-idr --plot --log-output-file anti-HA2119Ub-MEP_bcor_ko.idr.log
idr --samples B4-27422_R1_001_peaks.sorted.narrowPeak F4_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-KDM2B-MEP_bcor_ko-idr --plot --log-output-file anti-KDM2B-MEP_bcor_ko.idr.log

idr --samples C1-27422_R1_001_peaks.sorted.narrowPeak G2_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-BCOR-MEP_dn_ko-idr --plot --log-output-file anti-BCOR-MEP_dn_ko.idr.log
idr --samples C3-27422_R1_001_peaks.sorted.narrowPeak G3_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-HA2119Ub-MEP_dn_ko-idr --plot --log-output-file anti-HA2119Ub-MEP_dn_ko.idr.log
idr --samples C4-27422_R1_001_peaks.sorted.narrowPeak G4_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-KDM2B-MEP_dn_ko-idr --plot --log-output-file anti-KDM2B-MEP_dn_ko.idr.log

idr --samples D3-27422_R1_001_peaks.sorted.narrowPeak H3_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-HA2119Ub-MEP_dn_ko_bc_ko-idr --plot --log-output-file anti-HA2119Ub-MEP_dn_ko_bc_ko.idr.log
idr --samples D4-27422_R1_001_peaks.sorted.narrowPeak H4_R1_001_peaks.sorted.narrowPeak --input-file-type narrowPeak --rank p.value --output-file anti-KDM2B-MEP_dn_ko_bc_ko-idr --plot --log-output-file anti-KDM2B-MEP_dn_ko_bc_ko.idr.log