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
	4. R1
	5. R2
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

if [ ! -r "${R1_FASTQ}" ]; then
	echo "Error: can't open input file for R1."
	exit 1
fi
if [ ! -r "${R2_FASTQ}" ]; then
	echo "Error: can't open input file for R2."
	exit 1
fi

mkdir ${NGSWORKINGPATH}
mkdir ${NGSWORKINGPATH}/${PROJECT}
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ
mkdir ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Quality

##### ================ end SETTINGS ======================== #####




##### ================ RAW DATA QUALITY ======================== #####

fastqc --nogroup --extract -o ${NGSWORKINGPATH}/${PROJECT}/${POOL}/Quality -t 10 -f fastq ${R1_FASTQ} ${R2_FASTQ}



##### ===================== TRIMMING =========================== #####

SurecallTrimmer -fq1 ${R1_FASTQ} -fq2 ${R2_FASTQ} -halo -qualityTrimming 20 -minFractionRead 50 -out_loc ${NGSWORKINGPATH}/${PROJECT}/${POOL}/FastQ
