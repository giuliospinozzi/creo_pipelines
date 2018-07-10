# creo_pipelines
Bioinformatics Pipelines

## Introduction
This application makes RNA-Seq analysis: quality control, pre-processing, alignment, transcript quantification and differential expression analysis on BAM files. Given input files and working directory, pipeline is completely automatized. First, quality control on fastq files is performed with FastQC e FastQ Screen. FastQC makes quality control and creates one report for sample. FastQ Screen estimates approximately the percentage of reads that can be mapped on genomes other than human, like ribosomal genome, phix genome and mouse genome. This allows to evaluate the presence of contaminating genomes. Pre-processing follows quality control: reads are aligned on phix genome and ribosomal genome to eliminate contaminations. Alignment can be performed with TopHat or HISAT2; in the first case quantification is performed with Cufflinks and DEA with cummeRbund, in the second case quantification is performed with featureCounts and DEA with DESeq2 or edgeR. A second intermediate quality control analysis is also performed on the aligned BAM files with some of the RSeQC scripts and in particular: inner_distance, junction_annotation, junction_saturation, bam_stat, read_distribution, geneBody_coverage.

## Prerequisites
### Applications
#### For Graphical User Interface and scripts running:
*	zenity 3.18.1.1
*	Python 2.7.12 (modules: os, argparse, sys, csv, pandas)
*	R 3.2.3 (packages: cummeRbund, edgeR, DESeq2, ggfortify, calibrate, genefilter, RColorBrewer, gplots)
#### For quality control on fastq files and pre-processing:
*	FastQC 0.11.5
*	FastQ Screen 0.11.3
*	bwa 0.7.12-r1039
*	samtools 0.1.19-96b5f2294a
*	mysql 14.14
#### For alignment and quality control on BAM files:
*	TopHat 2.1.1
*	RSeQC 2.6.4
*	HISAT 2.1.0
#### For quantification:
*	featureCounts 1.5.3
*	Cufflinks 2.2.1
### Input files
*	Fastq files of the samples. Since this is a differential analysis, at least one case and one control must be present, furthermore it is a paired-end analysis and therefore the files of read 1 and read 2 must be provided for each sample.
*	Reference genome for Bowtie with relative indices, necessary for alignment with TopHat. The path in which the file with its indices is searched by default is as follows: /opt/genome/human/hg19/index/bowtie2/ hg19.
*	Reference genome for Hisat2 with relative indices, necessary for alignment with HISAT2. The path in which the file with its indices is searched by default is as follows: /opt/genome/human/hg19/index/hisat2/ hg19.
*	BED file, necessary for quality control on BAM files. The path in which the file is searched by default is as follows: /opt/genome/human/hg19/annotation/hg19.refseq.bed12.
*	Phix genome with relative indices, necessary for pre-processing. The path in which the file with its indices is searched by default is as follows: /opt/genome/control/phix174/bwa/phiX174.fa.
*	Ribosomal genome 1 with relative indices, necessary for pre-processing. The path in which the file with its indices is searched by default is as follows: /opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa.
*	Ribosomal genome 2 with relative indices, necessary for pre-processing. The path in which the file with its indices is searched by default is as follows: /opt/genome/human/hg19/contam/bwa/humRibosomal.fa.
*	GTF file, necessary for alignment with TopHat and quantification with featureCounts and Cufflinks. The path in which the file is searched by default is as follows: /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf.
*	Reference genome with relative indices, necessary for quantificazione with Cufflinks. The path in which the file with its indices is searched by default is as follows: /opt/genome/human/hg19/index/hg19.fa.

## Running application
### Command line
#### Usage

```RNAseq_Illumina.pipeline -n <project_name> -pn <pool_name> -sn <sample_A,sample_B,sample_C,sample_D> -r1 <sample_A_read1,sample_B_read1,sample_C_read1,sample_D_read1> -r2 <sample_A_read2,sample_B_read2,sample_C_read1,sample_D_read1> -type <cntrl,cntrl,treat,treat> -o <output_directory> [options]*```

#### Arguments
| | |
------------ | -------------
```-n```	| Project name. No default option. <br>
```-pn```	| Pool name. No default option. <br>
```-sn```	| Sample names (',' sep). No default option. <br>
```-r1```	| Read 1 fastq path (',' sep). No default option. The files must appear in the same order as the sample names. <br>
```-r2```	| Read 2 fastq path (',' sep). No default option. The files must appear in the same order as the sample names. <br>
```-type```	| Sample types (',' sep, 'cntrl' for control). No default option. The types must appear in the same order as the sample names. <br>
```-o``` | Output directory. No default option. <br>

#### Options
| | |
------------ | -------------
```-rb```	| Reference genome file path for bowtie. Default: human hg19. [/opt/genome/human/hg19/index/bowtie2/hg19] <br>
```-rh```	| Reference genome file path for hisat2. Default: human hg19. [/opt/genome/human/hg19/index/hisat2/hg19] <br>
```-bed```	| Reference genome annotation file path. Default: human hg19. [/opt/genome/human/hg19/annotation/hg19.refseq.bed12] <br>
```-ph```	| Phix genome file path. Default: Phix. [/opt/genome/control/phix174/bwa/phiX174.fa] <br>
```-rib1```	| Ribosomal genome file path. Default: human hg19. [/opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa] <br>
```-rib2```	| Ribosomal genome file path. Default: human hg19. [/opt/genome/human/hg19/contam/bwa/humRibosomal.fa] <br>
```-t```	| Max thread number. Default: 12. <br>
```-g```	| GTF file path. Default: human hg19. [/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf] <br>
```-a```	| Alignment method. Default: hisat; alternative: tophat. <br>
```-l```	| Library type. Default: fr-firststrand; alternative: fr-secondstrand. <br>
```-q```	| Quantification method. Default: featureCounts; alternative: Cufflinks. <br>
```-r```	| Reference genome file path. Default: human hg19. [/opt/genome/human/hg19/index/hg19.fa] <br>
```-dea```	| Differential Expression Analysis method. Default: edgeR; alternatives: DESeq2, cummeRbund. <br>
```-r_path```	| Script directory (alignment, quantification and DEA). Default: /opt/applications/src/creo_pipelines/pipelines <br>

### Graphical User Interface
#### Usage
```GUI_RNAseq_pipeline``` <br>
A series of windows allow to indicate the input files and to choose between the various options.

<p align="center"><img src="/images/GUI_screenshot.png" width="55%"></p>
