# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="results_tiacci";

# Pool name.
POOL_NAME="RNA-Seq_Tasselli_220117";

# Sample names (',' sep).
SAMPLE_NAMES="1-UHO1-NT-A-D3,2-UHO1-KO-A-D3,3-UHO1-NT-B-D3,4-UHO1-KO-B-D3,5-UHO1-NT-C-D3,6-UHO1-KO-C-D3";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/1-UHO1-NT-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/2-UHO1-KO-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/3-UHO1-NT-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/4-UHO1-KO-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/5-UHO1-NT-C-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/6-UHO1-KO-C-D3_1.fq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/1-UHO1-NT-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/2-UHO1-KO-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/3-UHO1-NT-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/4-UHO1-KO-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/5-UHO1-NT-C-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT2052_HOMqtunO/6-UHO1-KO-C-D3_2.fq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="NT,KO,NT,KO,NT,KO";

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
LOG="/opt/ngs/logs/220117_rna_seq_tiacci.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="KO_VS_NT";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &