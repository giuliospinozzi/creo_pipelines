# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="Scialdone";

# Pool name.
POOL_NAME="RNA_Seq_220328";

# Sample names (',' sep).
SAMPLE_NAMES="358KBFoWT,358KMZWT,360KBFoWT,360KMZWT,372WBFoKO,372WMZKO,373WBFoWT,373WMZWT,375BFoKO,375MZKO,458WBFoKO,458WMZKO";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/358KBFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/358KMZ_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/360KBFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/360KMZ_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/372WBFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/372WMZ_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/373WBFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/373WMZ_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/375BFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/375MZ_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/458WBFo_R1_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/458WMZ_R1_001.fastq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/358KBFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/358KMZ_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/360KBFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/360KMZ_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/372WBFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/372WMZ_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/373WBFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/373WMZ_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/375BFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/375MZ_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/458WBFo_R2_001.fastq.gz,/home/valentina/Annarita_RNA_Seq/90-588708625/00_fastq/458WMZ_R2_001.fastq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="BFoWT,MZWT,BFoWT,MZWT,BFoKO,MZKO,BFoWT,MZWT,BFoKO,MZKO,BFoKO,MZKO";

# Output directory.
OUTPUT_DIR="/opt/ngs/results_falini";

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
LOG="/opt/ngs/logs/220328_rnaseq_annarita.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="BFoKO_VS_BFoWT,MZKO_VS_MZWT,MZKO_VS_BFoKO,MZWT_VS_BFoWT";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &