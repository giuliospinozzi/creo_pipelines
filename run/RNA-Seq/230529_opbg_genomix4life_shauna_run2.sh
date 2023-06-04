# Replace the variables with paths and options of interest.

# Project name.
PROJECT_NAME="results";

# Pool name.
POOL_NAME="RNA-Seq_OPBG_Shauna_2-3";

# Sample names (',' sep).
SAMPLE_NAMES="IN-run1-8,IN-run1-1,IN-run1-7,IN-run1-9,IN-run1-10,IN-run1-11,IN-run2-13,IN-run2-14,IN-run2-15,IN-run2-22,IN-run2-23,IN-run2-24,IN-NM-run2-28,IN-NM-run2-29,IN-NM-run2-30,IN-NOGVCrun2-36,IN-NOGVCrun2-37,IN-NOGVCrun2-38";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S8_S8_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S1_S1_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S7_S7_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S9_S9_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S10_S10_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S11_S11_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/13_S13_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/14_S14_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/15_S15_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/22_S22_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/23_S23_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/24_S24_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/28_S28_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/29_S29_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/30_S30_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/36_S36_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/37_S37_R1_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/38_S38_R1_001.fastq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S8_S8_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S1_S1_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S7_S7_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S9_S9_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S10_S10_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Vinci_16112022/S11_S11_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/13_S13_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/14_S14_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/15_S15_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/22_S22_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/23_S23_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/24_S24_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/28_S28_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/29_S29_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/30_S30_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/36_S36_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/37_S37_R2_001.fastq.gz,/home/giulio/projects/OPBG/RNA-Seq_Petrilli_Maggio2023/Fastq/38_S38_R2_001.fastq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-GC,IN-NM,IN-NM,IN-NM,IN-NOGC,IN-NOGC,IN-NOGC"

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
LOG="/opt/ngs/logs/230529_rna_seq_opbg_shauna_2-3.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="IN-GC_VS_IN-NM,IN-GC_VS_IN-NOGC";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &