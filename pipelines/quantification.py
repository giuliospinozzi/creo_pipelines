#!/home/gspinozzi/arpir/bin/python2
# -*- coding: utf-8 -*-

import os, argparse, sys
import pandas as pd


header = """
  +--------------------------------------------------------+
  |                                                        |
  |            Illumina Pipeline: CREO RNAseq              |
  |                                                        |
  +--------------------------------------------------------+
  |  Author:   Giulio Spinozzi, PhD                        |
  |            Valentina Tini                              |
  |  Date:     June 2018                                   |
  |  Contact:  giulio.spinozzi@unipg.it                    |
  |            valy.tini@hotmail.it                        |
  |  Version:  2.0 - CREO - RNAseq quantification and      |
  |                         DEA analysis                   |
  |                         Cufflinks/featureCounts        |
  |                         edgeR/DESeq2/cummeRbund        |
  +--------------------------------------------------------+

  optional arguments (NO SPACES!!):
  
  -t, --threads [12]
  -i, --input
  -g, --gtf [/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf]
  -q, --quantification-method [featureCounts,Cufflinks]
  -o, --output-dir
  -l, --library-type [fr-firststrand,fr-secondstrand]
  -r, --reference-genome [/opt/genome/human/hg19/index/hg19.fa]
  -dea, --dea-method [edgeR,DESeq2,cummeRbund]
  -r_path, --r_path [/opt/applications/src/creo_pipelines/pipelines]
  -comp, --comparisons
  
""" 


description = "This application makes transcript quantification and differential expression analysis on BAM files"

usage_example = """
Examples of usage:
 (1) Quantification and DEA analysis: 
    <appname> -i <input.csv> -o <working_directory>

"""

print header, description, usage_example

parser = argparse.ArgumentParser(usage = usage_example, epilog = "[ Transcript quantification and DEA analysis on BAM files ] \n", description = description)
parser.add_argument('-t', '--threads', dest="Threads", help="Max thread number. \n Default: 12. \n", action="store", required=False, default=12)
parser.add_argument('-i', '--input', dest="input_path", help="Input path dataframe. \n No default option. \n", action="store", required=True)
parser.add_argument('-g', '--gtf', dest="GTF", help="GTF file path. \n Defaul: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf")
parser.add_argument('-q', '--quantification-method', dest="q_method", help="Quantification method. \n Defaul: featureCounts; alternative: Cufflinks. \n", action="store", required=False, default="featureCounts")
parser.add_argument('-o', '--output-dir', dest="output_dir", help="Output directory. \n No default option. \n", action="store", required=True)
parser.add_argument('-l', '--library-type', dest="library_type", help="Library type (only for Cufflinks). \n Defaul: fr-firststrand; alternative: fr-secondstrand. \n", action="store", required=False, default="fr-firststrand")
parser.add_argument('-r', '--reference-genome', dest="ref_gen", help="Reference genome file path (only for Cufflinks). \n Defaul: human hg19. \n", action="store", required=False, default="/opt/genome/human/hg19/index/hg19.filtered.fa")
parser.add_argument('-dea', '--dea-method', dest="dea_method", help="Differential Expression Analysis method. \n Default: edgeR; alternatives: DESeq2, cummeRbund. \n", action="store", required=False, default="edgeR")
parser.add_argument('-r_path', '--r_path', dest="R_path", help="R script directory. \n Default: creo_pipelines. \n", action="store", required=False, default="/opt/applications/src/creo_pipelines/pipelines")
parser.add_argument('-comp', '--comparisons', dest="comp", help="Comparisons (treat1_VS_cntrl). \n No default option. \n", action="store", required=True)

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
    print "Max_threads =", args.Threads
    print "Input path dataframe =", args.input_path
    print "GTF_path =", args.GTF
    print "quantification_method =", args.q_method
    print "output_directory =", args.output_dir
    print "library_type =", args.library_type
    print "reference_genome =", args.ref_gen
    print "DEA method =", args.dea_method
    print "R script path =", args.R_path
    print "Comparisons =", args.comp
    if not os.path.isfile(args.input_path):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for input file.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isfile(args.GTF):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for GTF file.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isdir(args.output_dir):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for output directory.\n\tExit\n" + '\033[0m')
        sys.exit()
    if not os.path.isfile(args.ref_gen):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no valid path for reference genome.\n\tExit\n" + '\033[0m')
        sys.exit()
    R_path1=args.R_path+"/runedgeR.R"
    R_path2=args.R_path+"/runDESeq2.R"
    R_path3=args.R_path+"/runcummeRbund.R"
    if not os.path.isfile(R_path1) or not os.path.isfile(R_path2) or not os.path.isfile(R_path3):
        print ('\033[0;31m' + "\n[AP]\tError while reading files: no R scripts.\n\tExit\n" + '\033[0m')
        sys.exit()


##def checkFile(input_path):
##    """
##    Check case/control
##    """
##    data=pd.DataFrame.from_csv(input_path,sep=',',index_col=None)
##    if len(data.loc[data['Type']=='cntrl'])==0 or len(data.loc[data['Type']!='cntrl'])==0:
##        print ('\033[0;31m' + "\n[AP]\tError while reading files: there must be at least one case and one control.\n\tExit\n" + '\033[0m')
##        sys.exit()
        

def checkOptions(q_method,dea_method):
    """
    Check quantification and DEA method options
    """
    if q_method == 'Cufflinks' and dea_method == 'edgeR':
        print ('\033[0;31m' + "\n[AP]\tError: quantification method Cufflinks requires DEA method cummeRbund\n\tExit\n" + '\033[0m')
        sys.exit()
    if q_method == 'Cufflinks' and dea_method == 'DESeq2':
        print ('\033[0;31m' + "\n[AP]\tError: quantification method Cufflinks requires DEA method cummeRbund\n\tExit\n" + '\033[0m')
        sys.exit()
    if q_method == 'featureCounts' and dea_method == 'cummeRbund':
        print ('\033[0;31m' + "\n[AP]\tError: quantification method featureCounts requires DEA method edgeR or DESeq2\n\tExit\n" + '\033[0m')
        sys.exit()


def runfeatureCounts(Threads,input_path,GTF,output_dir):
    """
    Run featureCounts as desired
    """
    print ('\033[1;33m' + "\n^^^^^^^^^featureCounts running^^^^^^^^^\n" + '\033[0m')
    data=pd.DataFrame.from_csv(input_path,sep=',',index_col=None)
    BAM=" ".join((data['BAM_path']))
    cmd="featureCounts -T "+str(Threads)+" -p -a "+GTF+" -o "+output_dir+"/featureCounts_counts.txt "+BAM
    os.system(cmd)
    featurecounts_path=output_dir+"/featureCounts_counts.txt"
    totals_path=output_dir+"/featureCounts_gene_total_counts.tsv"
    if os.path.isfile(featurecounts_path):
        createFeatureCountsGeneTotals(featurecounts_path,totals_path)
    else:
        print ('\033[0;31m' + "\n[AP]\tError: featureCounts output file not found, skipping totals generation.\n" + '\033[0m')


def createFeatureCountsGeneTotals(featurecounts_path,output_path):
    """
    Create a simple TSV with gene and total_count from featureCounts output.
    """
    print ('\033[1;33m' + "\n^^^^^^^^^featureCounts totals generation^^^^^^^^^\n" + '\033[0m')
    with open(featurecounts_path, 'r') as fin, open(output_path, 'w') as fout:
        header_fields = None
        for line in fin:
            if not line.strip():
                continue
            if line.startswith("#"):
                continue
            header_fields = line.rstrip("\n").split("\t")
            break

        if header_fields is None:
            print ('\033[0;31m' + "\n[AP]\tError: invalid featureCounts file, missing header.\n\tExit\n" + '\033[0m')
            sys.exit()

        if "Length" not in header_fields:
            print ('\033[0;31m' + "\n[AP]\tError: column Length not found in featureCounts header.\n\tExit\n" + '\033[0m')
            sys.exit()

        length_idx = header_fields.index("Length")
        fout.write("gene\ttotal_count\n")

        for line in fin:
            if not line.strip() or line.startswith("#"):
                continue
            fields = line.rstrip("\n").split("\t")
            if len(fields) <= length_idx:
                continue
            gene = fields[0]
            total = 0
            for value in fields[length_idx+1:]:
                if value == "":
                    continue
                total += int(float(value))
            fout.write(gene + "\t" + str(total) + "\n")

    print ('\033[0;32m' + "\n[AP]\tfeatureCounts gene totals written to: " + output_path + "\n" + '\033[0m')


def runCufflinks(Threads,input_path,GTF,output_dir,library_type,ref_gen,comp):
    """
    Run Cufflinks as desired
    """
    print ('\033[1;33m' + "\n^^^^^^^^^Cufflinks running^^^^^^^^^\n" + '\033[0m')
    data=pd.DataFrame.from_csv(input_path,sep=',',index_col=None)

    print ('\033[0;32m' + "\n############## Cufflinks ###################\n" + '\033[0m')
    with open(output_dir+"/cufflinks.transcripts.allsamples.txt","w+") as f:
        for k in range(1, (len(data)+1)):
            f.write(output_dir+"/"+data['sample_name'][k-1]+"/cufflinks/transcripts.gtf\n")
            cmd1="cufflinks --label "+data['sample_name'][k-1]+" --no-update-check --library-type "+library_type+" --verbose --GTF "+GTF+" -p "+str(Threads)+" -o "+output_dir+"/"+data['sample_name'][k-1]+"/cufflinks "+data['BAM_path'][k-1]
            os.system(cmd1)
    f.close()
    
    print ('\033[0;32m' + "\n############## Cuffmerge ###################\n" + '\033[0m')
    cmd2="cuffmerge -g "+GTF+" -s "+ref_gen+" -p "+str(Threads)+" -o "+output_dir+" "+output_dir+"/cufflinks.transcripts.allsamples.txt"
    os.system(cmd2)

    print ('\033[0;32m' + "\n############## Cuffquant ###################\n" + '\033[0m')
    for j in range(1, (len(data)+1)):
        cmd3="cuffquant -p "+str(Threads)+" --library-type "+library_type+" --no-update-check -o "+output_dir+"/"+data['sample_name'][j-1]+"/cuffquant "+output_dir+"/merged.gtf "+data['BAM_path'][j-1]
        os.system(cmd3)

    treat=data.loc[data['Type']==comp.split("_VS_")[0]]
    cntrl=data.loc[data['Type']==comp.split("_VS_")[1]]
    treat = treat.reset_index(drop=True)
    cntrl = cntrl.reset_index(drop=True)
    a=[]
    for t in range(1, (len(cntrl)+1)):
        c=output_dir+"/"+cntrl['sample_name'][t-1]+"/cuffquant/abundances.cxb"
        a.append(c)
    cntrl_list=",".join(a)
    a=[]
    for t in range(1, (len(treat)+1)):
        c=output_dir+"/"+treat['sample_name'][t-1]+"/cuffquant/abundances.cxb"
        a.append(c)
    treat_list=",".join(a)
    
    lab=",".join((cntrl['Type'][0],treat['Type'][0]))

    print ('\033[0;32m' + "\n############## Cuffdiff ###################\n" + '\033[0m')
    cmd4="cuffdiff -p "+str(Threads)+" -L "+lab+" -o "+output_dir+"/cuffdiff --library-type "+library_type+" --no-update-check "+output_dir+"/merged.gtf "+cntrl_list+" "+treat_list
    os.system(cmd4)


def runedgeR(input_path,output_dir,R_path,comp):
    """
    Run edgeR as desired
    """
    print ('\033[1;33m' + "\n^^^^^^^^^edgeR running^^^^^^^^^\n" + '\033[0m')
    cmd5="Rscript --vanilla --verbose "+R_path+"/runedgeR.R "+output_dir+"/featureCounts_counts.txt "+input_path+" "+output_dir+" "+comp
    os.system(cmd5)


def runDESeq2(input_path,output_dir,R_path,comp):
    """
    Run DESeq2 as desired
    """
    print ('\033[1;33m' + "\n^^^^^^^^^DESeq2 running^^^^^^^^^\n" + '\033[0m')
    cmd6="Rscript --vanilla --verbose "+R_path+"/runDESeq2.R "+output_dir+"/featureCounts_counts.txt "+input_path+" "+output_dir+" "+comp
    os.system(cmd6)


def runcummeRbund(input_path,output_dir,R_path):
    """
    Run cummeRbund as desired
    """
    print ('\033[1;33m' + "\n^^^^^^^^^cummeRbund running^^^^^^^^^\n" + '\033[0m')
    cmd7="Rscript --vanilla --verbose "+R_path+"/runcummeRbund.R "+output_dir+"/cuffdiff "+input_path+" "+output_dir
    os.system(cmd7)


#########################################################################################
### MAIN
#########################################################################################

def main():
    """
    Main part of the program.
    """
    # first check args and file paths
    checkArgs(args)
#    checkFile(args.input_path)
    checkOptions(args.q_method,args.dea_method)

    # if quantification method is featureCounts
    if args.q_method == 'featureCounts':
        runfeatureCounts(args.Threads,args.input_path,args.GTF,args.output_dir)

    # if quantification method is Cufflinks
    if args.q_method == 'Cufflinks':
        runCufflinks(args.Threads,args.input_path,args.GTF,args.output_dir,args.library_type,args.ref_gen,args.comp)
    
    # if DEA method is edgeR
    if args.dea_method == 'edgeR':
        runedgeR(args.input_path,args.output_dir,args.R_path,args.comp)
        
    # if DEA method is DESeq2
    if args.dea_method == 'DESeq2':
        runDESeq2(args.input_path,args.output_dir,args.R_path,args.comp)

    # if DEA method is cummeRbund
    if args.dea_method == 'cummeRbund':
        runcummeRbund(args.input_path,args.output_dir,args.R_path)


# sentinel
if __name__ == "__main__":
    main()

