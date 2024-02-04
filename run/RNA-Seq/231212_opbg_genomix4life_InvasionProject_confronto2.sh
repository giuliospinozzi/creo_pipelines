# Replace the variables with paths and options of interest.
TODAY=`date +"%Y%m%d%H%M%S"`
# Project name.
PROJECT_NAME="results_opbg";

# Pool name.
POOL_NAME="InvasionProject_231120_comparison2";

# Sample names (',' sep).
SAMPLE_NAMES="INV-19,INV-20,NS-19,NS-20,INV-29,INV-30,NS-29,NS-30";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/39_S25_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/40_S50_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/37_S65_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/38_S66_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/1_S1_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/2_S2_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/3_S3_R1_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/4_S4_R1_001.fastq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/39_S25_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/40_S50_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/37_S65_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_luglio2023/1_FASTQ/38_S66_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/1_S1_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/2_S2_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/3_S3_R2_001.fastq.gz,/home/giulio/projects/OPBG/Pericoli_nov2023/1_Fastq/4_S4_R2_001.fastq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="INV,INV,NS,NS,INV,INV,NS,NS"

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
LIBRARY="fr-secondstrand";

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
LOG="/opt/ngs/logs/${TODAY}_rna_seq_opbg_${POOL_NAME}.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="INV_VS_NS";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &

rm -rf /opt/ngs/results_opbg/InvasionProject_231120_comparison2/FastQ