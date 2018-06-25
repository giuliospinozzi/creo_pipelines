#!/bin/bash
source /etc/environment
source /etc/profile

PIPEVERSION="1.0 - creo_RNAseq"
STARTTIME=`date +'%y-%m-%d %H:%M:%S'`
DBHOSTIP="localhost"
STATSDBNAME='stats_summary_RNAseq'
RUN_ID=`date +"%Y%m%d%H%M%S"`

RED='\033[0;31m' 
NC='\033[0m' # No Color
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

echo "
  +--------------------------------------------------------+
  |                                                        |
  |            Illumina Pipeline: CREO RNAseq              |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Giulio Spinozzi, PhD                        |
  |  Date:     September 2017                              |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |  Version:  1.0 - CREO - RNAseq                         |
  |                  No SAM, HiSeq optimized, Paired-End   |
  |                  TopHat2/HISAT2 - Bowtie2              |
  |                  Cufflinks/featureCounts               |
  +--------------------------------------------------------+

  REQUIRED VARS and relative ORDER POSITION -> REMEMBER NO SPACES!!!!!!!!!
	1. PROJECT_NAME [PILOT_STUDY]
	2. POOL_NAME [21092017]
	3. LIBRARY_NAME [library290817A1]
	4. RESULTS_DIR [/opt/ngs/results]
	5. READ1 [R1.fastq.gz]
	6. READ2 [R2.fastq.gz]
	7. MAXTHREADS [12]
	8. REFERENCE_GENOME_BOWTIE [/opt/genome/human/hg19/index/bowtie2/hg19]
	9. REFERENCE_GENOME_HISAT2 [/opt/genome/human/hg19/index/hisat2/hg19]
	10. REFERENCE_GENOME_BWA [/opt/genome/human/hg19/index/bwa/hg19.fa]
	11. PHIX_GENOME [/opt/genome/control/phix174/bwa/phiX174.fa]
	12. RIBOSOMAL_GENOME_hum5SrDNA [/opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa]
	13. RIBOSOMAL_GENOME_humRibosomal [/opt/genome/human/hg19/contam/bwa/humRibosomal.fa]
	14. ANALYSIS_PROTOCOL [tophat,hisat]
	15. QUANTIFICATION_METHOD [cufflinks,featureCounts,stringTie]
	16. GTF_FILE [/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf]

"
printf "${GREEN}[CREO] RNAseq Pipeline ${NC}\n"
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}[CREO] Preprocessing input variables (delimiters:<>)${NC}\n"
## print input variables (check for log utils)
INPUTVARNUM=0
for INPUTVAR in "$@"; do
	let INPUTVARNUM++; 
	printf -v INPUTNUM '%02d' $INPUTVARNUM;
    echo "  => Input Variable: Order number = <${INPUTNUM}> ; Var Content = <${INPUTVAR}>";
done

printf "${GREEN}@@@@ Variable Adjustments ${NC}\n"

PROJECT_NAME="${1}";
POOL_NAME="${2}";
LIBRARY_NAME="${3}";
#RAW_DATA_DIR="/opt/ngs/raw_data";
RESULTS_DIR="${4}";
R1_FASTQ="${5}";
R2_FASTQ="${6}";
MAXTHREADS="${7}";
REFERENCE_GENOME_BOWTIE="${8}";
REFERENCE_GENOME_HISAT2="${9}";
REFERENCE_GENOME_BWA="${10}";
PHIX_GENOME="${11}";
RIBOSOMAL_GENOME_hum5SrDNA="${12}";
RIBOSOMAL_GENOME_humRibosomal="${13}";
ANALYSIS_PROTOCOL="${14}";
QUANTIFICATION_METHOD="${15}";
GTF_FILE="${16}";
DBSCHEMA="creo";

printf "${GREEN}@@@@ Folder creation --> ${RESULTS_DIR}${NC}\n"

mkdir ${RESULTS_DIR}/${PROJECT_NAME}/FastQ
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/HISAT2
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/PhiX
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/Quality
mkdir ${RESULTS_DIR}/${PROJECT_NAME}/TopHat2

RUN_NAME="${PROJECT_NAME}|${POOL_NAME}|${LIBRARY_NAME}"

printf "${GREEN}@@@@ Create stats_summary_RNAseq table into DB (if not exists) --> http://141.250.134.204/phpmyadmin${NC}\n"
mysql -u giulio --password=speedy -e "create database if not exists ${DBSCHEMA} ; " ;

mysql -u giulio --password=speedy -e "
	CREATE TABLE IF NOT EXISTS ${STATSDBNAME} (
		RUN_ID varchar(255) default null,
		RUN_NAME varchar(1000) default null,
		PROJECT_NAME varchar(255) default null,
		POOL_NAME varchar(255) default null,
		LIBRARY_NAME varchar(255) default null,
		NUMBER_RAW_READS int(30) DEFAULT NULL,
		NUMBER_PHIX_READS int(30) DEFAULT NULL,
		NUMBER_RIBOSOMAL_READS int(30) DEFAULT NULL
	) ENGINE=MyISAM DEFAULT CHARSET=latin1;
	" ${DBSCHEMA} ;

NUMBER_RAW_READS=$((`zcat ${R1_FASTQ} | wc -l`/4)) ;
printf "${GREEN}@@@@ Starting Number of Raw Reads --> ${NUMBER_RAW_READS}${NC}\n"

# printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}##### Converting BCL in FASTQ files (compressed) #####${NC}\n"
# bcl2fastq --runfolder-dir ${RAW_DATA_DIR}/${PROJECT_NAME}/170913_D00793_0018_Ahv7khbcxy -p 12 --output-dir /opt/ngs/raw_data/${PROJECT_NAME}/170913_D00793_0018_Ahv7khbcxy/FASTQ

printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}####### FastQC Report #######${NC}\n"
fastqc --nogroup -o ${RESULTS_DIR}/${PROJECT_NAME}/quality/${LIBRARY_NAME} -t 4 -f fastq ${R1_FASTQ} ${R2_FASTQ}

printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}####### PhiX Alignment #######${NC}\n"
bwa mem -k 16 -r 1 -M -T 15 -t ${MAXTHREADS} -v 1 ${PHIX_GENOME} <(zcat ${R1_FASTQ} ) <(zcat ${R2_FASTQ} ) | samtools view -F 2308 -q 25 -f 35 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.PE.bam;
samtools view ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.PE.bam | cut -f 1 > ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.list
sort --parallel=5 ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.list > ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.sorted.list;
rm ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.list;
BNAME_R1=`basename ${R1_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
BNAME_R2=`basename ${R2_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
zcat ${R1_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R1}_R1_nophix.fastq.gz &
zcat ${R2_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R2}_R2_nophix.fastq.gz &
wait
NUMBER_PHIX_READS=`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.sorted.list | cut -d' ' -f1 `;
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${RED}##### PhiX READS: ${NUMBER_PHIX_READS} #####${NC}\n"
pigz -f -c  ${RESULTS_DIR}/${PROJECT_NAME}/PhiX/${LIBRARY_NAME}/PhiX.header.sorted.list;
R1_FASTQ="${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R1}_R1_nophix.fastq.gz";
R2_FASTQ="${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R2}_R2_nophix.fastq.gz";


printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}##### Ribosomal DNA Alignment #####${NC}\n"
bwa mem -k 16 -r 1 -M -T 15 -t ${MAXTHREADS} -v 1 ${RIBOSOMAL_GENOME_hum5SrDNA} <(zcat ${R1_FASTQ} ) <(zcat ${R2_FASTQ} ) | samtools view -F 2308 -q 25 -f 35 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.PE.bam &
bwa mem -k 16 -r 1 -M -T 15 -t ${MAXTHREADS} -v 1 ${RIBOSOMAL_GENOME_humRibosomal} <(zcat ${R1_FASTQ} ) <(zcat ${R2_FASTQ} ) | samtools view -F 2308 -q 25 -f 35 -uS - > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.PE.bam &
wait
samtools view ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.PE.bam | cut -f 1 > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.list &
samtools view ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.PE.bam | cut -f 1 > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.list &
wait
cat ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.list ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.list > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.list
rm ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.list ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.list;
sort --parallel=5 -u ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.list > ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.sorted.list
rm ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/hum5SrDNA.list ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/humRibosomal.list ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.list;
BNAME_R1=`basename ${R1_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
BNAME_R2=`basename ${R2_FASTQ} | sed 's/.gz//g' | cut -d'.' -f1`;
zcat ${R1_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R1}_noRibosomal.fastq.gz &
zcat ${R2_FASTQ} | fqreverseextract.pureheader ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.sorted.list | pigz --best -f -c > ${RESULTS_DIR}/${PROJECT_NAME}/FastQ/${LIBRARY_NAME}/${BNAME_R2}_noRibosomal.fastq.gz &
wait
R1_FASTQ="${TMPDIR}/${BNAME_R1}_noRibosomal.fastq.gz";
R2_FASTQ="${TMPDIR}/${BNAME_R2}_noRibosomal.fastq.gz";
NUMBER_RIBOSOMAL_READS=`wc -l ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.all.sorted.list | cut -d' ' -f1 `;
printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${RED}##### Ribosomal READS: ${NUMBER_RIBOSOMAL_READS} #####${NC}\n"
pigz -f -c ${RESULTS_DIR}/${PROJECT_NAME}/RibosomalRNA/${LIBRARY_NAME}/Ribosomal.header.sorted.list;



if [ ${ANALYSIS_PROTOCOL} = "tophat" ]; then
	printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}##### Mapping Reads to the Genome #####${NC}\n"
	printf "${GREEN}@@@@ Splicing read mapping --> TopHat2${NC}\n"
	tophat2 -p 8 --library-type fr-firststrand -G /opt/genome/human/hg19/annotation/hg19.refgene.chrM.sorted.gtf --mate-inner-dist 0 --mate-std-dev 80 --no-coverage-search -o library290817D1 /opt/genome/human/hg19/index/bowtie2/hg19 ../FastQ/library290817D1/R1_nophix.fastq.gz ../FastQ/library290817D1/R2_nophix.fastq.gz
	samtools index library290817D1/accepted_hits.bam
else
	echo "HISAT2";
fi


if [ ${QUANTIFICATION_METHOD} = "cufflinks" ]; then
	printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}##### Transcriptome Assembling #####${NC}\n"
	cufflinks --label Cntr1 --no-update-check --library-type fr-firststrand --verbose --GTF /opt/genome/human/hg19/annotation/hg19.refgene.chrM.gtf -p 10 -o /opt/ngs/results/PILOT_STUDY/TopHat2/library290817A1/cufflinks /opt/ngs/results/PILOT_STUDY/TopHat2/library290817A1/accepted_hits.bam

	ls -1 *Rep*_ERCC*/transcripts.gtf > assembly_GTF_list.txt

	cuffmerge -g /opt/genome/human/hg19/annotation/hg19.refgene.chrM.gtf -s /opt/genome/human/hg19/index/hg19.fa -p 8 cufflinks.transcripts.allsamples.txt
	cuffquant -p 8 --library-type fr-firststrand --no-update-check -o library290817A1/cuffquant merged_asm/merged.gtf library290817A1/accepted_hits.bam
	cuffdiff -p 12 -L Cntl,Actd -o cuffdiff --library-type fr-firststrand --no-update-check merged_asm/merged.gtf library290817A1/cuffquant/abundances.cxb,library290817B1/cuffquant/abundances.cxb,library290817C1/cuffquant/abundances.cxb library290817D1/cuffquant/abundances.cxb,library290817E1/cuffquant/abundances.cxb,library290817F1/cuffquant/abundances.cxb
else
	echo "HISAT2";
	stringtie -p 8 -G /opt/genome/human/hg19/annotation/hg19.refgene.chrM.gtf -e -B -o library290817A1/transcripts.gtf -A library290817A1/gene_abundances.tsv library290817A1/library290817A1.sorted.bam
	stringtie_expression_matrix --expression_metric=TPM --result_dirs='library290817A1,library290817B1,library290817C1,library290817D1,library290817E1,library290817F1' --transcript_matrix_file=transcript_tpm_all_samples.tsv --gene_matrix_file=gene_tpm_all_samples.tsv
	featureCounts -T 16 -p -a /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf -o featureCounts_counts.txt library290817A1/library290817A1.sorted.bam library290817B1/library290817B1.sorted.bam library290817C1/library290817C1.sorted.bam library290817D1/library290817D1.sorted.bam library290817E1/library290817E1.sorted.bam library290817F1/library290817F1.sorted.bam
fi


bam_stat.py  -i Sp_ds.bam > FILE.TXT
geneBody_coverage.py -r hg19.refseq.bed12  -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o output
inner_distance.py -i Sp_ds.bam -o output -r /opt/genome/human/hg19/annotation/hg19.refseq.bed12
junction_annotation.py -i Sp_ds.bam -o output -r /opt/genome/human/hg19/annotation/hg19.refseq.bed12
junction_saturation.py -i Sp_ds.bam -r /opt/genome/human/hg19/annotation/hg19.refseq.bed12 -o output
read_duplication.py -i Sp_ds.bam -o output
read_quality.py -i Sp_ds.bam -o output
featureCounts -T 16 -p -a /opt/genome/human/hg19/annotation/hg19.refgene.chrM.gtf -o featureCounts_counts.txt library290817A1/accepted_hits.bam library290817B1/accepted_hits.bam library290817C1/accepted_hits.bam library290817D1/accepted_hits.bam library290817E1/accepted_hits.bam library290817F1/accepted_hits.bam
cut -f 1,7-15 featureCounts_counts.txt > featureCounts_counts_clean.txt

echo "
::VARIABLE SUMMARY:: dlimiters<>
	RUN_ID=<${RUN_ID}>
	RUN_NAME=<${RUN_NAME}>
	PROJECT_NAME=<${PROJECT_NAME}>
	POOL_NAME=<${POOL_NAME}>
	LIBRARY_NAME=<${LIBRARY_NAME}>
	NUMBER_RAW_READS=<${NUMBER_RAW_READS}>
	NUMBER_PHIX_READS=<${NUMBER_PHIX_READS}>
	NUMBER_RIBOSOMAL_READS=<${NUMBER_RIBOSOMAL_READS}>
" ;

printf "<`date +'%Y-%m-%d %H:%M:%S'`> ${YELLOW}[CREO] Import STATS into SUMMARY table${NC}\n"
mysql -u giulio --password=speedy -e "INSERT INTO ${DBSCHEMA}.${STATSDBNAME} 
(RUN_ID, RUN_NAME, PROJECT_NAME, POOL_NAME, LIBRARY_NAME, NUMBER_RAW_READS, NUMBER_PHIX_READS, NUMBER_RIBOSOMAL_READS)
VALUES
('${RUN_ID}', '${RUN_NAME}', '${PROJECT_NAME}', '${POOL_NAME}', '${LIBRARY_NAME}', '${NUMBER_RAW_READS}', '${NUMBER_PHIX_READS}', '${NUMBER_RIBOSOMAL_READS}')
" ${DBSCHEMA} ;