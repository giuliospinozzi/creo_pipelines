# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="results_tiacci";

# Pool name.
POOL_NAME="RNA-Seq_Tasselli_230522";

# Sample names (',' sep).
SAMPLE_NAMES="1-E-D3-A,8-E-D3-B,15-E-D3-C,2-WT-D3-A,9-WT-D3-B,16-WT-D3-C,3-417-D3-A,10-417-D3-B,17-417-D3-C,4-G-D3-A,11-G-D3-B,18-G-D3-C,5-DMG-D3-A,12-DMG-D3-B,19-DMG-D3-C,6-N-D3-A,13-N-D3-B,20-N-D3-C,7-DMN-D3-A,14-DMN-D3-B,21-DMN-D3-C";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/1-E-D3-A/1-E-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/8-E-D3-B/8-E-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/15-E-D3-C/15-E-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/2-WT-D3-A/2-WT-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/9-WT-D3-B/9-WT-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/16-WT-D3-C/16-WT-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/3-417-D3-A/3-417-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/10-417-D3-B/10-417-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/17-417-D3-C/17-417-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/4-G-D3-A/4-G-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/11-G-D3-B/11-G-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/18-G-D3-C/18-G-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/5-DMG-D3-A/5-DMG-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/12-DMG-D3-B/12-DMG-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/19-DMG-D3-C/19-DMG-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/6-N-D3-A/6-N-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/13-N-D3-B/13-N-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/20-N-D3-C/20-N-D3-C_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/7-DMN-D3-A/7-DMN-D3-A_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/14-DMN-D3-B/14-DMN-D3-B_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/21-DMN-D3-C/21-DMN-D3-C_1.fq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/1-E-D3-A/1-E-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/8-E-D3-B/8-E-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/15-E-D3-C/15-E-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/2-WT-D3-A/2-WT-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/9-WT-D3-B/9-WT-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/16-WT-D3-C/16-WT-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/3-417-D3-A/3-417-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/10-417-D3-B/10-417-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/17-417-D3-C/17-417-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/4-G-D3-A/4-G-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/11-G-D3-B/11-G-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/18-G-D3-C/18-G-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/5-DMG-D3-A/5-DMG-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/12-DMG-D3-B/12-DMG-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/19-DMG-D3-C/19-DMG-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/6-N-D3-A/6-N-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/13-N-D3-B/13-N-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/20-N-D3-C/20-N-D3-C_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/7-DMN-D3-A/7-DMN-D3-A_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/14-DMN-D3-B/14-DMN-D3-B_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F23A430000360_HOMcnktO/soapnuke/clean/21-DMN-D3-C/21-DMN-D3-C_2.fq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="E-D3,E-D3,E-D3,WT-D3,WT-D3,WT-D3,417-D3,417-D3,417-D3,G-D3,G-D3,G-D3,DMG-D3,DMG-D3,DMG-D3,N-D3,N-D3,N-D3,DMN-D3,DMN-D3,DMN-D3";

# Output directory.
OUTPUT_DIR="/opt/ngs";

# Reference genome file path for bowtie.
BOWTIE_DNA="/opt/genome/human/hg19/index/bowtie2/hg19.filtered";

# Reference genome file path for hisat2.
HISAT_DNA="/opt/genome/human/hg19/index/hisat2/hg19.filtered";

# Reference genome annotation file path.
BED_FILE="/opt/genome/human/hg19/annotation/hg19.refseq.bed12";

# Phix genome file path.
PHIX_DNA="/opt/genome/control/phix174/bwa/phiX174.fa";

# Ribosomal genome 1 (5S) file path.
RIBOSOMAL_DNA_1="/opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa";

# Ribosomal genome 2 file path.
RIBOSOMAL_DNA_2="/opt/genome/human/hg19/contam/bwa/humRibosomal.fa";

# Max thread number.
THREADS="12";

# GTF file path.
GFT_FILE="/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf";

# Alignment method. Options: hisat, tophat.
ALIGNMENT="hisat";

# Library type. Options: fr-firststrand, fr-secondstrand.
LIBRARY="fr-firststrand";

# Quantification method. Options: featureCounts, Cufflinks.
QUANTIFICATION="featureCounts";

# Reference genome file path.
REFERENCE_DNA="/opt/genome/human/hg19/index/hg19.filtered.fa";

# Differential Expression Analysis method. Options: edgeR, DESeq2, cummeRbund.
DEA="edgeR";

# Script directory.
#SCRIPT_DIR="/opt/applications/src/ARPIR";
SCRIPT_DIR="/opt/applications/src/creo_pipelines/pipelines";

# Analysis with or without final meta-analysis. Options: full, quant.
META_ANALYSIS="full";

# Max number of categories showed in R plots for meta-analysis.
CATEGORY_NUMBER="5";

# LOG file.
#LOG="/opt/ngs/logs/simulation.log";
LOG="/opt/ngs/logs/230522_rna_seq_tiacci.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="417-D3_VS_WT-D3,G-D3_VS_WT-D3,DMG-D3_VS_WT-D3,N-D3_VS_WT-D3,DMN-D3_VS_WT-D3,417-D3_VS_E-D3,G-D3_VS_E-D3,DMG-D3_VS_E-D3,N-D3_VS_E-D3,DMN-D3_VS_E-D3,WT-D3_VS_E-D3";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &