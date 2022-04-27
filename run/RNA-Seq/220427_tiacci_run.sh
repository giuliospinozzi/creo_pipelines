# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="results_tiacci";

# Pool name.
POOL_NAME="RNA-Seq_Tasselli_220427";

# Sample names (',' sep).
SAMPLE_NAMES="1-L-NT-A-D3,2-L-KO-A-D3,3-L-NT-B-D3,4-L-KO-B-D3,5-L-NT-C-D3,6-L-KO-C-D3,7-S-NT-A-D3,8-S-KO-A-D3,9-S-NT-B-D3,10-S-KO-B-D3,11-S-NT-C-D3,12-S-KO-C-D3,13-L-NT-A-D4,14-L-KO-A-D4,15-L-NT-B-D4,16-L-KO-B-D4,17-L-NT-C-D4,18-L-KO-C-D4,19-S-NT-A-D4,20-S-KO-A-D4,21-S-NT-B-D4,22-S-KO-B-D4,23-S-NT-C-D4,24-S-KO-C-D4";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/1-L-NT-A-D3/1-L-NT-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/2-L-KO-A-D3/2-L-KO-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/3-L-NT-B-D3/3-L-NT-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/4-L-KO-B-D3/4-L-KO-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/5-L-NT-C-D3/5-L-NT-C-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/6-L-KO-C-D3/6-L-KO-C-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/7-S-NT-A-D3/7-S-NT-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/8-S-KO-A-D3/8-S-KO-A-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/9-S-NT-B-D3/9-S-NT-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/10-S-KO-B-D3/10-S-KO-B-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/11-S-NT-C-D3/11-S-NT-C-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/12-S-KO-C-D3/12-S-KO-C-D3_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/13-L-NT-A-D4/13-L-NT-A-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/14-L-KO-A-D4/14-L-KO-A-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/15-L-NT-B-D4/15-L-NT-B-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/16-L-KO-B-D4/16-L-KO-B-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/17-L-NT-C-D4/17-L-NT-C-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/18-L-KO-C-D4/18-L-KO-C-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/19-S-NT-A-D4/19-S-NT-A-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/20-S-KO-A-D4/20-S-KO-A-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/21-S-NT-B-D4/21-S-NT-B-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/22-S-KO-B-D4/22-S-KO-B-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/23-S-NT-C-D4/23-S-NT-C-D4_1.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/24-S-KO-C-D4/24-S-KO-C-D4_1.fq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/1-L-NT-A-D3/1-L-NT-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/2-L-KO-A-D3/2-L-KO-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/3-L-NT-B-D3/3-L-NT-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/4-L-KO-B-D3/4-L-KO-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/5-L-NT-C-D3/5-L-NT-C-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/6-L-KO-C-D3/6-L-KO-C-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/7-S-NT-A-D3/7-S-NT-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/8-S-KO-A-D3/8-S-KO-A-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/9-S-NT-B-D3/9-S-NT-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/10-S-KO-B-D3/10-S-KO-B-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/11-S-NT-C-D3/11-S-NT-C-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/12-S-KO-C-D3/12-S-KO-C-D3_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/13-L-NT-A-D4/13-L-NT-A-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/14-L-KO-A-D4/14-L-KO-A-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/15-L-NT-B-D4/15-L-NT-B-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/16-L-KO-B-D4/16-L-KO-B-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/17-L-NT-C-D4/17-L-NT-C-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/18-L-KO-C-D4/18-L-KO-C-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/19-S-NT-A-D4/19-S-NT-A-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/20-S-KO-A-D4/20-S-KO-A-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/21-S-NT-B-D4/21-S-NT-B-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/22-S-KO-B-D4/22-S-KO-B-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/23-S-NT-C-D4/23-S-NT-C-D4_2.fq.gz,/mnt/Martelli_Collaborations/Tiacci/RNA-Seq-Tasselli/f22ftseuht0311-humngayr/24-S-KO-C-D4/24-S-KO-C-D4_2.fq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="L-NT-D3,L-KO-D3,L-NT-D3,L-KO-D3,L-NT-D3,L-KO-D3,S-NT-D3,S-KO-D3,S-NT-D3,S-KO-D3,S-NT-D3,S-KO-D3,L-NT-D4,L-KO-D4,L-NT-D4,L-KO-D4,L-NT-D4,L-KO-D4,S-NT-D4,S-KO-D4,S-NT-D4,S-KO-D4,S-NT-D4,S-KO-D4";

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
LOG="/opt/ngs/logs/220427_rna_seq_tiacci.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="L-KO-D3_VS_L-NT-D3,S-KO-D3_VS_S-NT-D3,L-KO-D4_VS_L-NT-D4,S-KO-D4_VS_S-NT-D4";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &