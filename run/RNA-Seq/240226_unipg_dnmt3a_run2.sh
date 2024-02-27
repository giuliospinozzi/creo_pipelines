# Replace the variables with paths and options of interest.
TODAY=`date +"%Y%m%d%H%M%S"`
# Project name.
PROJECT_NAME="results";

# Pool name.
POOL_NAME="AML2-IMS-M2_DNMT3A";

# Sample names (',' sep).
SAMPLE_NAMES="OCI-AML2-VUOTO-1,OCI-AML2-VUOTO-2,OCI-AML2-VUOTO-3,OCI-AML2-dnmt3a-1,OCI-AML2-dnmt3a-2,OCI-AML2-dnmt3a-3,IMS-M2_P0-1,IMS-M2_P4-1,IMS-M2_P0-2,IMS-M2_P4-2,IMS-M2_P0-3,IMS-M2_P4-3";

# Read 1 fastq path (',' sep). Files must appear in the same order as sample names.
READ_1="/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_1/A_1_EKRN230061621-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_2/A_2_EKRN230061622-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_3/A_3_EKRN230061623-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_4/A_4_EKRN230061624-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_5/A_5_EKRN230061625-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_6/A_6_EKRN230061626-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_1/I_1_EKRN230061615-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_2/I_2_EKRN230061616-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_3/I_3_EKRN230061617-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_4/I_4_EKRN230061618-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_5/I_5_EKRN230061619-1A_22FCJVLT3_L1_1.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_6/I_6_EKRN230061620-1A_22FCJVLT3_L1_1.fq.gz";

# Read 2 fastq path (',' sep). Required only for paired-end analysis. Files must appear in the same order as sample names.
READ_2="/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_1/A_1_EKRN230061621-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_2/A_2_EKRN230061622-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_3/A_3_EKRN230061623-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_4/A_4_EKRN230061624-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_5/A_5_EKRN230061625-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/A_6/A_6_EKRN230061626-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_1/I_1_EKRN230061615-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_2/I_2_EKRN230061616-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_3/I_3_EKRN230061617-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_4/I_4_EKRN230061618-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_5/I_5_EKRN230061619-1A_22FCJVLT3_L1_2.fq.gz,/opt/ngs/raw_data/RNA-Seq-NOVOGENE/X204SC23112090-Z01-F001/01.RawData/I_6/I_6_EKRN230061620-1A_22FCJVLT3_L1_2.fq.gz";

# Sample types (',' sep). Types must appear in the same order as sample names.
TYPE="OCI-AML2-VUOTO,OCI-AML2-VUOTO,OCI-AML2-VUOTO,OCI-AML2-dnmt3a,OCI-AML2-dnmt3a,OCI-AML2-dnmt3a,IMS-M2_P0,IMS-M2_P4,IMS-M2_P0,IMS-M2_P4,IMS-M2_P0,IMS-M2_P4"

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
LOG="/opt/ngs/logs/${TODAY}_rna_seq_unipg_${POOL_NAME}.log";

#Comparisons (treat1_VS_cntrl,treat2_VS_cntrl).
COMPARISONS="OCI-AML2-dnmt3a_VS_OCI-AML2-VUOTO,IMS-M2_P4_VS_IMS-M2_P0";

nohup python ${SCRIPT_DIR}/RNAseq_pipeline.py -n ${PROJECT_NAME} -pn ${POOL_NAME} -sn ${SAMPLE_NAMES} -r1 ${READ_1} -r2 ${READ_2} -type ${TYPE} -o ${OUTPUT_DIR} -rb ${BOWTIE_DNA} -rh ${HISAT_DNA} -bed ${BED_FILE} -ph ${PHIX_DNA} -rib1 ${RIBOSOMAL_DNA_1} -rib2 ${RIBOSOMAL_DNA_2} -t ${THREADS} -g ${GFT_FILE} -a ${ALIGNMENT} -l ${LIBRARY} -q ${QUANTIFICATION} -r_path ${SCRIPT_DIR} -r ${REFERENCE_DNA} -dea ${DEA} -comp ${COMPARISONS} -meta ${META_ANALYSIS} -cat ${CATEGORY_NUMBER} 2>&1 > ${LOG} &
