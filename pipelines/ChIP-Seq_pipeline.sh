#!/bin/bash
source /etc/environment
source /etc/profile


echo "
  +--------------------------------------------------------+
  |                                                        |
  |                ChIP-Seq Pipeline (CREO)                |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Giulio Spinozzi                             |
  |  Date:     September 2020                              |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |  Version:  1.0 - SE                                    |
  +--------------------------------------------------------+

  REQUIRED VARS and relative ORDER POSITION -> REMEMBER NO SPACES!!!!!!!!!
	1. PROJECT_NAME [Brunetti]
	2. POOL_NAME [ChIP-Seq]
	3. LIBRARY_NAME [library290817A1]
	4. RESULTS_DIR [/opt/ngs/results]
	5. MAXTHREADS [12]
	6. REFERENCE_GENOME [/opt/genome/human/hg19/index/bwa/hg19.fa]
	7. PHIX_GENOME [/opt/genome/control/phix174/bwa/phiX174.fa]
	8. READ1 [R1.fastq.gz]
	
  NOTES:
  	- Input are Single End Reads. 
"


echo "<`date +'%Y-%m-%d %H:%M:%S'`> [CREO-UniPG] Preprocessing input variables (delimiters:<>)"
## print input variables (check for log utils)
INPUTVARNUM=0
for INPUTVAR in "$@"; do
	let INPUTVARNUM++; 
	printf -v INPUTNUM '%02d' $INPUTVARNUM;
    echo "  => Input Variable: Order number = <${INPUTNUM}> ; Var Content = <${INPUTVAR}>";
done



##### =================== Start SETTINGS ======================= #####
PROJECT_NAME="${1}";
POOL_NAME="${2}";
LIBRARY_NAME="${3}";
RESULTS_DIR="${4}";
MAXTHREADS="${5}";
REFERENCE_GENOME="${6}";
PHIX_GENOME="${7}";
R1_FASTQ="${8}";

printf "Folder creation --> ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}\n"

mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality


RUN_NAME="${PROJECT_NAME}|${POOL_NAME}|${LIBRARY_NAME}"
NUMBER_RAW_READS=$((`zcat ${R1_FASTQ} | wc -l`/4)) ;
##### ==================== End SETTINGS ======================== #####



##### ================== RAW DATA QUALITY ====================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### FastQC Report #######\n"
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME}
fastqc --nogroup --extract -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME} -t ${MAXTHREADS} -f fastq ${R1_FASTQ}

printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### FastQ Screen Report #######\n"
fastq_screen ${R1_FASTQ} --outdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME}
##### ========================================================== #####



##### ==================== PhiX Alignment ====================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### PhiX Alignment #######\n"
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}
BNAME_R1=`basename ${R1_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
bwa mem -k 16 -r 1 -M -T 15 -t ${MAXTHREADS} -v 1 ${PHIX_GENOME} <(zcat ${R1_FASTQ} ) | samtools view -F 2308 -q 25 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.bam;
samtools view ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.bam | cut -f 1 > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list
sort --parallel=5 ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list;
rm ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list;
zcat ${R1_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/PhiX/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R1}_nophix.fastq.gz
NUMBER_PHIX_READS=`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list | cut -d' ' -f1 `;
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ##### PhiX READS: ${NUMBER_PHIX_READS} #####\n"
pigz -f ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list;
R1_FASTQ="${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R1}_nophix.fastq.gz";
##### ========================================================== #####



##### ================= Ref Genome Alignment =================== #####
bwa mem -k 16 -r 1 -M -T 15 -R "@RG\tID:$j\tSM:${b}.${k}\tCN:CREO-UniPG.${RUN_NAME}" -t ${MAXTHREADS} -v 1 ${REFERENCE_GENOME} <(zcat ${R1_FASTQ} ) | samtools view -F 2308 -q 25 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.bam;
samtools sort ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.bam -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam
samtools index ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam
BWA_RESULTS=`samtools flagstat ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam `
BWA_MAPPED_PP=$((`echo ${BWA_RESULTS} | grep ' properly paired ' | cut -d' ' -f34`/2)) ;
bedtools bamtobed -cigar -i ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam | grep '/1' > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.bed
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam --outFileFormat bigwig -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bw
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam --outFileFormat bedgraph -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bedgraph
##### ========================================================== #####



##### ================== Alignment Filtering =================== #####
bamtools filter -in ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam -isMapped true -isPrimaryAlignment true -mapQuality ">=75" -out ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam
samtools index ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam
bedtools bamtobed -cigar -i ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam | grep '/1' > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bed
READS_AFTER_FILTERS=`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bed | cut -d' ' -f1 ` ;
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam --outFileFormat bigwig -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bw
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam --outFileFormat bedgraph -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bedgraph
##### ========================================================== #####



##### ========================= Stats ========================== #####
if [ ! -r "${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/reports/sample_report.csv" ]; then
		echo -e "RUN_NAME\tNUMBER_RAW_READS\tNUMBER_PHIX_READS\tBWA_MAPPED\tREADS_AFTER_FILTERS" >> ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/reports/sample_report.csv
	fi
echo -e "${RUN_NAME}\t${NUMBER_RAW_READS}\t${NUMBER_PHIX_READS}\t${BWA_MAPPED_PP}\t${READS_AFTER_FILTERS}" >> ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/reports/sample_report.csv
##### ========================================================== #####


