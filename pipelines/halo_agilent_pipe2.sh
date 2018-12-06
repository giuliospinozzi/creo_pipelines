#!/bin/bash
source /etc/environment
source /etc/profile

PIPEVERSION="0.1"
STARTTIME=`date +'%y-%m-%d %H:%M:%S'`

echo "
  +--------------------------------------------------------+
  |                                                        |
  |         HaloPlex Pipeline 2 - Agilent Panels           |
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
	4. R1 [After SurecallTrimmer]
	5. R2 [After SurecallTrimmer]
	6. INDEX I1
	7. Amplicon List (BED format)
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
R1_FASTQ="${4}";
R2_FASTQ="${5}";
INDEX="${6}";
AMPLICONS="${7}";

if [ ! -r "${R1_FASTQ}" ]; then
	echo "Error: can't open input file for R1."
	exit 1
fi
if [ ! -r "${R2_FASTQ}" ]; then
	echo "Error: can't open input file for R2."
	exit 1
fi
if [ ! -r "${INDEX}" ]; then
	echo "Error: can't open input file for INDEX."
	exit 1
fi

mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output
##### ================ end SETTINGS ======================== #####



##### ===================== ALIGNMENT =========================== #####

BNAME=`basename ${R1_FASTQ} | sed 's/.gz//g' | cut -d'_' -f1`;
bwa mem -k 16 -r 1 -M -T 15 -t 10 -v 1 /opt/genome/human/hg19/index/bwa/hg19.fa <(zcat ${R1_FASTQ} ) <(zcat ${R2_FASTQ} ) > ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam

samtools view -F 2308 -q 25 -f 35 -uS -@ 5 ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam > ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.filtered.bam



##### ===================== ANNOTATION =========================== #####

LocatIt -q 25 -m 1 -U -IS -OB -b ${AMPLICONS} -o ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.bam ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Alignments/${BNAME}.sam ${INDEX}

samtools sort ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.bam ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.sorted
samtools index ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Output/${BNAME}.sorted.bam