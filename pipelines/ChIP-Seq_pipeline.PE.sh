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
  |  Date:     December 2020                               |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |  Version:  1.0 - PE                                    |
  +--------------------------------------------------------+

  REQUIRED VARS and relative ORDER POSITION -> REMEMBER NO SPACES!!!!!!!!!
	1. PROJECT_NAME [Brunetti]
	2. POOL_NAME [ChIP-Seq]
	3. LIBRARY_NAME [library290817A1]
	4. RESULTS_DIR [/opt/ngs/results]
	5. MAXTHREADS [12]
	6. REFERENCE_GENOME [/opt/genome/human/hg19/index/bwa/hg19.fa, /opt/genome/human/hg19/index/bowtie2/hg19]
	7. PHIX_GENOME [/opt/genome/control/phix174/bwa/phiX174.fa, /opt/genome/control/phix174/bowtie2/phiX174.fa]
	8. READ1 [R1.fastq.gz]
  9. READ1 [R2.fastq.gz]
	
  NOTES:
  	- Input are Paired End Reads. 
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
R2_FASTQ="${9}";

printf "Folder creation --> ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}\n"
mkdir ${RESULTS_DIR}/${PROJECT_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/stats


RUN_NAME="${PROJECT_NAME}|${POOL_NAME}|${LIBRARY_NAME}"
NUMBER_RAW_READS=$((`zcat ${R1_FASTQ} | wc -l`/2)) ;
##### ==================== End SETTINGS ======================== #####

cp -rf ${R1_FASTQ} ${R2_FASTQ} ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}
# identify base names
BNAME_R1="`basename ${R1_FASTQ}`";
BNAME_R2="`basename ${R2_FASTQ}`";
R1_FASTQ=${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R1};
R2_FASTQ=${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R2};


##### ================== RAW DATA QUALITY ====================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### FastQC Report #######\n"
fastqc --nogroup --extract -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME} -t ${MAXTHREADS} -f fastq ${R1_FASTQ} ${R2_FASTQ}

printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### FastQ Screen Report #######\n"
fastq_screen --threads ${MAXTHREADS} ${R1_FASTQ} ${R2_FASTQ} --outdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/quality/${LIBRARY_NAME} --subset 0
BNAME_R1=`basename ${R1_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
BNAME_R2=`basename ${R2_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
##### ========================================================== #####


#### ==================== PhiX Alignment ====================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### PhiX Alignment #######\n"
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}
bwa mem -k 16 -r 1 -M -T 15 -t ${MAXTHREADS} -v 1 ${PHIX_GENOME} <(zcat ${R1_FASTQ} ) <(zcat ${R2_FASTQ} ) | samtools view -F 2308 -q 25 -f 35 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.bam;
samtools view ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.bam | cut -f 1 > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list
sort --parallel=5 ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list;
rm ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.list;
zcat ${R1_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R1}_nophix.fastq.gz &
zcat ${R2_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R2}_nophix.fastq.gz &
wait
NUMBER_PHIX_READS=$((`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list | cut -d' ' -f1 `*2)) ;
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ##### PhiX READS: ${NUMBER_PHIX_READS} #####\n"
pigz -f ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/phix/${LIBRARY_NAME}/${BNAME_R1}.PhiX.header.sorted.list;
rm ${R1_FASTQ} ${R2_FASTQ}
R1_FASTQ="${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R1}_nophix.fastq.gz";
R2_FASTQ="${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/fastq/${LIBRARY_NAME}/${BNAME_R2}_nophix.fastq.gz";
#### ========================================================== #####


##### ================= Ref Genome Alignment =================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### Reference Genome Alignment #######\n"
bowtie2 -p ${MAXTHREADS} -x ${REFERENCE_GENOME} -1 <(zcat ${R1_FASTQ} ) -2 <(zcat ${R2_FASTQ} ) --no-unal | samtools view -bS - > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.bam;
samtools sort -@ ${MAXTHREADS} ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.bam -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam
samtools index ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam
rm ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.bam;
READS_MAPPED=$((`samtools view -F 0x04 -c ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam`)) ;
picard-tools MarkDuplicates I=${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam O=${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam M=${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}_duplicates.txt REMOVE_DUPLICATES=true
samtools index ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam;
READS_MAPPED_NODUPLICATES=$((`samtools view -F 0x04 -c ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam`)) ;
# bedtools bamtobed -cigar -i ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.bed
# printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### After Alignment: Coverage Analysis #######\n"
# bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam --outFileFormat bigwig -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.bw &
# bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam --outFileFormat bedgraph -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.bedgraph &
# wait
rm ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.bam*
##### ========================================================== #####



##### ================== Alignment Filtering =================== #####
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### Filtering #######\n"
bamtools filter -in ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam -isMapped true -isPrimaryAlignment true -mapQuality ">=25" -out ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam
samtools index ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam
#bedtools bamtobed -cigar -i ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam | grep '/1' > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bed
bedtools bamtobed -cigar -i ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bed
READS_AFTER_FILTERS=`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bed | cut -d' ' -f1 ` ;
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ####### After Filtering: Coverage Analysis #######\n"
# --effectiveGenomeSize is for hg19!!!!!
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2864785220 --outFileFormat bigwig -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bw &
bamCoverage -p ${MAXTHREADS} -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2864785220 --outFileFormat bedgraph -o ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bed/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bedgraph &
wait
rm ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.noDuplicates.bam*
bamPEFragmentSize -b ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.sorted.filtered.bam -hist ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/bam/${LIBRARY_NAME}/${BNAME_R1}.histLengths.png -p ${MAXTHREADS} -T ${BNAME_R1} -bs 1000 --samplesLabel ${BNAME_R1}
##### ========================================================== #####



##### ========================= Stats ========================== #####
if [ ! -r "${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/stats/sample_report.csv" ]; then
		echo -e "RUN_NAME\tNUMBER_RAW_READS\tNUMBER_PHIX_READS\tMAPPED_READS\tREADS_MAPPED_NODUPLICATES\tREADS_AFTER_FILTERS" > ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/stats/sample_report.csv
	fi
echo -e "${RUN_NAME}\t${NUMBER_RAW_READS}\t${NUMBER_PHIX_READS}\t${READS_MAPPED}\t${READS_MAPPED_NODUPLICATE}S\t${READS_AFTER_FILTERS}" >> ${RESULTS_DIR}/${PROJECT_NAME}/${POOL_NAME}/stats/sample_report.csv
##### ========================================================== #####



