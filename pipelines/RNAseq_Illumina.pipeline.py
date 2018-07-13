#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import os, argparse, sys, csv

header = """
  +--------------------------------------------------------+
  |                                                        |
  |            Illumina Pipeline: CREO RNAseq              |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Giulio Spinozzi                             |
  |            Valentina Tini                              |
  |  Date:     June 2018                                   |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |            valy.tini@hotmail.it                        |
  |  Version:  1.0 - CREO - RNAseq                         |
  +--------------------------------------------------------+

  optional arguments (NO SPACES!!):
  
  -n, --project-name
  -pn, --pool-name
  -sn, --sample-name
  -r1, --read1
  -r2, --read2
  -type, --type [cntrl,treat]
  -rb, --reference-genome-bowtie [/opt/genome/human/hg19/index/bowtie2/hg19]
  -rh, --reference-genome-hisat2 [/opt/genome/human/hg19/index/hisat2/hg19]
  -bed, --bed-file [/opt/genome/human/hg19/annotation/hg19.refseq.bed12]
  -ph, --phix-genome [/opt/genome/control/phix174/bwa/phiX174.fa]
  -rib1, --ribosomal-genome1 [/opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa]
  -rib2, --ribosomal-genome2 [/opt/genome/human/hg19/contam/bwa/humRibosomal.fa]
  -t, --threads [12]
  -g, --gtf [/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf]
  -a, --alignment-method [hisat,tophat]
  -l, --library-type [fr-firststrand,fr-secondstrand]
  -q, --quantification-method [featureCounts,Cufflinks]
  -r, --reference-genome [/opt/genome/human/hg19/index/hg19.fa]
  -dea, --dea-method [edgeR,DESeq2,cummeRbund]
  -r_path, --r_path [/opt/applications/src/creo_pipelines/pipelines]
  -o, --output-dir
  
""" 


description = "This application makes quality control, pre-processing, alignment, transcript quantification and differential expression analysis on BAM files"

usage_example = """
Examples of usage:
 (1) RNA-Seq analysis: 
    <appname> -n <project_name> -pn <pool_name> -sn <sample_A,sample_B,sample_C,sample_D> -r1 <sample_A_read1,sample_B_read1,sample_C_read1,sample_D_read1> -r2 <sample_A_read2,sample_B_read2,sample_C_read1,sample_D_read1> -type <cntrl,cntrl,treat,treat> -o <output_directory> [options]*

"""

print header, description, usage_example

parser = argparse.ArgumentParser(usage = usage_example, epilog = "[ RNA-Seq analysis: from BAM to DEA ] \n", description = description)
parser.add_argument('-n', '--project-name', dest="project_name", help="Project name. \n No default option. \n", action="store", required=True)
parser.add_argument('-pn', '--pool-name', dest="pool_name", help="Pool name. \n No default option. \n", action="store", required=True)
parser.add_argument('-sn', '--sample-name', dest="sample_name", help="Sample names (',' sep). \n No default option. \n", action="store", required=True)
parser.add_argument('-r1', '--read1', dest="read1", help="Read 1 fastq path (',' sep). \n No default option. \n", action="store", required=True)
parser.add_argument('-r2', '--read2', dest="read2", help="Read 2 fastq path (',' sep). \n No default option. \n", action="store", required=True)
parser.add_argument('-type', '--type', dest="stype", help="Sample types (cntrl,treat). \n No default option. \n", action="store", required=True)
parser.add_argument('-rb', '--reference-genome-bowtie', dest="ref_bowtie", help="Reference genome file path for bowtie. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/index/bowtie2/hg19")
parser.add_argument('-rh', '--reference-genome-hisat2', dest="ref_hisat2", help="Reference genome file path for hisat2. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/index/hisat2/hg19")
parser.add_argument('-bed', '--bed-file', dest="bed_file", help="Reference genome annotation file path. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/annotation/hg19.refseq.bed12")
parser.add_argument('-ph', '--phix-genome', dest="phix", help="Phix genome file path. \n Default: Phix. \n", action="store", required=False, default="/opt/genome/control/phix174/bwa/phiX174.fa")
parser.add_argument('-rib1', '--ribosomal-genome1', dest="rib1", help="Ribosomal genome file path. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa")
parser.add_argument('-rib2', '--ribosomal-genome2', dest="rib2", help="Ribosomal genome file path. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/contam/bwa/humRibosomal.fa")
parser.add_argument('-t', '--threads', dest="Threads", help="Max thread number. \n Default: 12. \n", action="store", required=False, default=12)
parser.add_argument('-g', '--gtf', dest="GTF", help="GTF file path. \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf")
parser.add_argument('-a', '--alignment-method', dest="a_method", help="Alignment method. \n Default: hisat; alternative: tophat. \n", action="store", required=False, default="hisat")
parser.add_argument('-l', '--library-type', dest="library_type", help="Library type. \n Default: fr-firststrand; alternative: fr-secondstrand. \n", action="store", required=False, default="fr-firststrand")
#parser.add_argument('-i', '--input', dest="input_path", help="Input path dataframe. \n No default option. \n", action="store", required=True)
parser.add_argument('-q', '--quantification-method', dest="q_method", help="Quantification method. \n Default: featureCounts; alternative: Cufflinks. \n", action="store", required=False, default="featureCounts")
parser.add_argument('-r', '--reference-genome', dest="ref_gen", help="Reference genome file path (only for Cufflinks). \n Default: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/index/hg19.fa")
parser.add_argument('-dea', '--dea-method', dest="dea_method", help="Differential Expression Analysis method. \n Default: edgeR; alternatives: DESeq2, cummeRbund. \n", action="store", required=False, default="edgeR")
parser.add_argument('-r_path', '--r_path', dest="R_path", help="Script directory (alignment, quantification and DEA). \n Default: creo_pipelines. \n", action="store", required=False, default="/opt/applications/src/creo_pipelines/pipelines")
parser.add_argument('-o', '--output-dir', dest="output_dir", help="Output directory. \n No default option. \n", action="store", required=True)

args = parser.parse_args()


########################################################################
####### GLOBAL VARS
########################################################################

#######################################################################
####### FUNCTIONS
########################################################################

def checkArgs(args):
    """
    Check file path
    """
    print "Project name =", args.project_name, "\n"
    print "Pool names =", args.pool_name, "\n"
    print "Sample name =", args.sample_name, "\n"
    print "Read 1 fastq =", args.read1, "\n"
    print "Read 2 fastq =", args.read2, "\n"
    print "Sample types =", args.stype, "\n"
    print "Reference genome for bowtie =", args.ref_bowtie, "\n"
    print "Reference genome for hisat2 =", args.ref_hisat2, "\n"
    print "Bed file =", args.bed_file, "\n"
    print "Phix genome file =", args.phix, "\n"
    print "Ribosomal genome file 1 =", args.rib1, "\n"
    print "Ribosomal genome file 2 =", args.rib2, "\n"
    print "Max threads =", args.Threads, "\n"
    print "GTF file =", args.GTF, "\n"
    print "Alignment method =", args.a_method, "\n"
    print "Library type =", args.library_type, "\n"
    print "Quantification method =", args.q_method, "\n"
    print "Reference genome =", args.ref_gen, "\n"
    print "DEA method =", args.dea_method, "\n"
    print "Script path =", args.R_path, "\n"
    print "Output directory =", args.output_dir, "\n"
    if not os.path.isfile(args.bed_file):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for BED file.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isfile(args.phix):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for Phix genome.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isfile(args.rib1) or not os.path.isfile(args.rib2):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid paths for ribosomal genome.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isfile(args.GTF):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for GTF.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isdir(args.output_dir):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for output dir.\n\tExit\n" + '\033[0m')
        sys.exit()
    b=args.ref_bowtie+".fa"
    h=args.ref_hisat2+".fa"
    if not os.path.isfile(b) or not os.path.isfile(h):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid paths for index genome (hisat or bowtie).\n\tExit\n" + '\033[0m')
        sys.exit()
    r1=args.read1.split(",")
    r2=args.read2.split(",")
    for i in range(0, (len(r1))):
        if not os.path.isfile(r1[i]):
            print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid paths for read 1.\n\tExit\n" + '\033[0m')
            sys.exit()
    for j in range(0, (len(r2))):
        if not os.path.isfile(r2[j]):
            print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid paths for read 2.\n\tExit\n" + '\033[0m')
            sys.exit()
    R_path1=args.R_path+"/alignment.sh"
    R_path2=args.R_path+"/quantification.py"
    if not os.path.isfile(R_path1) or not os.path.isfile(R_path2):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no scripts.\n\tExit\n" + '\033[0m')
        sys.exit()


def checkOptions(a_method,q_method):
    """
    Check quantification and DEA method options
    """
    if a_method == 'HISAT2' and q_method == 'Cufflinks':
        print ('\033[0;31m' + "\n[AP]\tError: alignment method HISAT2 requires quantification method featureCounts\n\tExit\n" + '\033[0m')
        sys.exit()
    if a_method == 'Tophat' and q_method == 'featureCounts':
        print ('\033[0;31m' + "\n[AP]\tError: alignment method Tophat requires quantification method Cufflinks\n\tExit\n" + '\033[0m')
        sys.exit()


def checkFile(read1,read2,stype,sample_name):
    """
    Check read and sample type number
    """
    read1a=read1.split(",")
    read2a=read2.split(",")
    stype1=stype.split(",")
    sample_name1=sample_name.split(",")
    if len(read1a)!=len(read2a) or len(read1a)!=len(stype1) or len(read1a)!=len(sample_name1):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: read1, read2, type and sample name must be of the same length.\n\tExit\n" + '\033[0m')
        sys.exit()


def alignment(project_name,pool_name,sample_name,output_dir,read1,read2,Threads,ref_bowtie,ref_hisat2,bed_file,phix,rib1,rib2,a_method,GTF,library_type,R_path,stype):
    """
    Run alignment script as desired
    """
#    print ('\033[1;33m' + "\n^^^^^^^^^Alignment script running^^^^^^^^^\n" + '\033[0m')
    cmd1="mkdir "+output_dir+"/"+project_name
    os.system(cmd1)
    cmd2="mkdir "+output_dir+"/"+project_name+"/"+pool_name
    os.system(cmd2)
    with open(output_dir+'/'+project_name+'/'+pool_name+'/input.csv', 'wb') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',')
        filewriter.writerow(['sample_name','BAM_path','Type'])
        csvfile.close()
    read1a=read1.split(",")
    read2a=read2.split(",")
    sample_name1=sample_name.split(",")
    stype1=stype.split(",")
    for i in range(0, (len(read1a))):
        cmd="bash "+R_path+"/alignment.sh "+project_name+" "+pool_name+" "+sample_name1[i]+" "+output_dir+" "+read1a[i]+" "+read2a[i]+" "+str(Threads)+" "+ref_bowtie+" "+ref_hisat2+" "+bed_file+" "+phix+" "+rib1+" "+rib2+" "+a_method+" "+GTF+" "+library_type+" "+stype1[i]
        os.system(cmd)


def quantification(output_dir,project_name,pool_name,R_path,dea_method,q_method,Threads,GTF,library_type,ref_gen):
    """
    Run quantification script as desired
    """
#    print ('\033[1;33m' + "\n^^^^^^^^^Quantification script running^^^^^^^^^\n" + '\033[0m')
    res_dir=output_dir+"/"+project_name+"/"+pool_name
    cmd="python "+R_path+"/quantification.py -i "+output_dir+'/'+project_name+'/'+pool_name+'/input.csv'+" -o "+res_dir+"/Quantification_and_DEA"+" -r_path "+R_path+" -dea "+dea_method+" -q "+q_method+" -t "+str(Threads)+" -g "+GTF+" -l "+library_type+" -r "+ref_gen
    os.system(cmd)
    
    
def rminput(output_dir,project_name,pool_name):
    """
    Remove input file
    """
    os.system("rm "+output_dir+'/'+project_name+'/'+pool_name+'/input.csv')
        

#########################################################################################
### MAIN
#########################################################################################

def main():
    """
    Main part of the program.
    """
    # first check args and file paths
    checkArgs(args)
    checkOptions(args.a_method,args.q_method)
    checkFile(args.read1,args.read2,args.stype,args.sample_name)

    # alignment
    alignment(args.project_name,args.pool_name,args.sample_name,args.output_dir,args.read1,args.read2,args.Threads,args.ref_bowtie,args.ref_hisat2,args.bed_file,args.phix,args.rib1,args.rib2,args.a_method,args.GTF,args.library_type,args.R_path,args.stype)

    # quantification
    quantification(args.output_dir,args.project_name,args.pool_name,args.R_path,args.dea_method,args.q_method,args.Threads,args.GTF,args.library_type,args.ref_gen)
    
    # remove input file
    rminput(args.output_dir,args.project_name,args.pool_name)
    

# sentinel
if __name__ == "__main__":
    main()
