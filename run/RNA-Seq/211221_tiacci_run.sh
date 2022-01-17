# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="results_tiacci";

# Pool name.
POOL_NAME="RNA-Seq_Tasselli_211220";

# Sample names (',' sep).
SAMPLE_NAMES="7-L428-NT-A-D4,8-L428-KO-A-D4,9-L428-NT-B-D4,10-L428-KO-B-D4,11-L428-NT-C-D4,12-L428-KO-C-D4";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/7-L428-NT-A-D4/V350049134_WHHUMciptOAAGRAA-629_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/8-L428-KO-A-D4/V350049134_WHHUMciptOAAHRAA-631_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/9-L428-NT-B-D4/V350049134_WHHUMciptOAAIRAA-632_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/10-L428-KO-B-D4/V350049134_WHHUMciptOAAJRAA-633_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/11-L428-NT-C-D4/V350049134_WHHUMciptOAAKRAA-634_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/12-L428-KO-C-D4/V350049134_WHHUMciptOAALRAA-636_1.fq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/7-L428-NT-A-D4/V350049134_WHHUMciptOAAGRAA-629_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/8-L428-KO-A-D4/V350049134_WHHUMciptOAAHRAA-631_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/9-L428-NT-B-D4/V350049134_WHHUMciptOAAIRAA-632_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/10-L428-KO-B-D4/V350049134_WHHUMciptOAAJRAA-633_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/11-L428-NT-C-D4/V350049134_WHHUMciptOAAKRAA-634_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/F21FTSEUHT1795_HUMciptO/Raw/12-L428-KO-C-D4/V350049134_WHHUMciptOAALRAA-636_2.fq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="L428-NT-D4,L428-KO-D4,L428-NT-D4,L428-KO-D4,L428-NT-D4,L428-KO-D4";

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
SCRIPT_DIR="/opt/applications/src/creo_pipelines/pipelines";

# Analysis with or without final meta-analysis. Options: full, quant.
META_ANALYSIS="full";

# Max number of categories showed in R plots for meta-analysis.
CATEGORY_NUMBER="5";

# LOG file.
#LOG="/opt/ngs/logs/simulation.log";
LOG="/opt/ngs/logs/211221_tiacci.log";

#Comparisons (cntrl_VS_treat1,cntrl_VS_treat2).
COMPARISONS="L428-NT-D4_VS_L428-KO-D4";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &