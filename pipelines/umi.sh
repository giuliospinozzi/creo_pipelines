#!/bin/bash
source /etc/environment
source /etc/profile

PIPEVERSION="0.1"
STARTTIME=`date +'%y-%m-%d %H:%M:%S'`

echo "
  +--------------------------------------------------------+
  |                                                        |
  |         HaloPlex Pipeline 1 - Agilent Panels           |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Giulio Spinozzi                             |
  |  Date:     December                                    |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |  Version:  0.1 - PE                                    |
  +--------------------------------------------------------+

  REQUIRED VARS and relative ORDER POSITION -> REMEMBER NO SPACES!!!!!!!!!
	1. Project ID [HALO]
	2. POOL ID [CellLines1]
	3. local server working path [/opt/ngs/results]
	4. R1 list (comma separated)
	5. R2 list (comma separated)
  	6. Index list (comma separated)
"

echo "<`date +'%Y-%m-%d %H:%M:%S'`> [UniPG] Preprocessing input variables (delimiters:<>)"
## print input variables (check for log utils)
INPUTVARNUM=0
for INPUTVAR in "$@"; do
	let INPUTVARNUM++; 
	printf -v INPUTNUM '%02d' $INPUTVARNUM;
    echo "  => Input Variable: Order number = <${INPUTNUM}> ; Var Content = <${INPUTVAR}>";
done


##### ================ start SETTINGS ====================== #####
PROJECT=${1};
POOL=${2};
NGSWORKINGPATH="${3}"; # WITHOUT LAST SLASH
R1_FASTQ=$(echo "${4}" | tr "," "\n");
R2_FASTQ=$(echo "${5}" | tr "," "\n");
INDEX=$(echo "${6}" | tr "," "\n");
R1_FASTQ1=($R1_FASTQ)
R2_FASTQ1=($R2_FASTQ)
INDEX1=($INDEX)
SCRIPT_DIR="`dirname "$0"`"

for file in $R1_FASTQ
do
	if [ ! -r "$file" ]; then
		echo "Error: can't open input file for R1."
		exit 1
	fi
done

for file in $R2_FASTQ
do
	if [ ! -r "$file" ]; then
		echo "Error: can't open input file for R2."
		exit 1
	fi
done

for file in $INDEX
do
	if [ ! -r "$file" ]; then
		echo "Error: can't open input file for INDEX."
		exit 1
	fi
done

mkdir ${NGSWORKINGPATH}
mkdir ${NGSWORKINGPATH}/${PROJECT}
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Quality
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output

##### ================ end SETTINGS ======================== #####

for file1 in `seq 1 "${#R1_FASTQ1[@]}"`
do
	BNAME=`basename ${R1_FASTQ1[$(($file1-1))]} | sed 's/.gz//g' | cut -d'_' -f1`;


##### ================ RAW DATA QUALITY ======================== #####

	fastqc --nogroup --extract -o ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Quality -t 10 -f fastq ${R1_FASTQ1[$(($file1-1))]} ${R2_FASTQ1[$(($file1-1))]};


##### ================ EXTRACT THE UMIs ======================== #####

	python ${SCRIPT_DIR}/umi.py -r1 ${R1_FASTQ1[$(($file1-1))]} -r2 ${R2_FASTQ1[$(($file1-1))]} -i ${INDEX1[$(($file1-1))]} -o1 ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ/${BNAME}_R1_umi.fastq.gz -o2 ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ/${BNAME}_R2_umi.fastq.gz;


##### ===================== ALIGNMENT =========================== #####

	bwa mem -k 16 -r 1 -M -T 15 -t 10 -v 1 /opt/genome/human/hg19/index/bwa/hg19.fa <(zcat ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ/${BNAME}_R1_umi.fastq.gz ) <(zcat ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ/${BNAME}_R2_umi.fastq.gz ) > ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam;
	samtools view -F 2308 -q 25 -f 35 -uS -@ 5 ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam > ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.filtered.bam;

	samtools sort ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.filtered.bam > ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sorted.bam;
	samtools index ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sorted.bam;

	rm ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.filtered.bam;


##### ===================== DEDUPLICATION =========================== #####

	umi_tools dedup -I ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sorted.bam --paired -S ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.deduplicated.bam;


##### ===================== ANNOTATION =========================== #####

	bcftools mpileup -f /opt/genome/human/hg19/index/hg19.fa --annotate DP,AD -Oz ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.deduplicated.bam | bcftools call -mv -Oz -o ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.vcf.gz;
	bcftools filter -Oz ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.vcf.gz -o ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.filtered.vcf.gz;

done
