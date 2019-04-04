#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import gzip, argparse
from Bio import SeqIO
import multiprocessing as mp

description = ""

usage_example = """

"""

parser = argparse.ArgumentParser(usage = usage_example, epilog = "", description = description)
parser.add_argument('-r1', '--read1', dest="read1", help="", action="store", required=True)
parser.add_argument('-r2', '--read2', dest="read2", help="", action="store", required=True)
parser.add_argument('-i', '--index', dest="index", help="", action="store", required=True)
parser.add_argument('-o1', '--output1', dest="output1", help="", action="store", required=True)
parser.add_argument('-o2', '--output2', dest="output2", help="", action="store", required=True)

args = parser.parse_args()

########################################################################
####### FUNCTIONS
########################################################################

def read1(read1,index,output1):
    with gzip.open(read1, "r") as handle:
        record_dict = SeqIO.to_dict(SeqIO.parse(handle, "fastq"))
    with gzip.open(index, "r") as handle1:
        record_dict1 = SeqIO.to_dict(SeqIO.parse(handle1, "fastq"))
            
    for item in record_dict.keys(  ):
        if record_dict1.has_key(item):
            record_dict[item].id=record_dict[item].id+"_"+str(record_dict1[item].seq)+" "+record_dict[item].description.split(' ')[1].strip()
            record_dict[item].description=""
    
    with gzip.open(output1, 'w') as handle:
        SeqIO.write(record_dict.values(), handle, 'fastq')


def read2(read2,index,output2):
    with gzip.open(read2, "r") as handle0:
        record_dict0 = SeqIO.to_dict(SeqIO.parse(handle0, "fastq"))
    with gzip.open(index, "r") as handle1:
        record_dict1 = SeqIO.to_dict(SeqIO.parse(handle1, "fastq"))
    
    for item in record_dict0.keys(  ):
        if record_dict1.has_key(item):
            record_dict0[item].id=record_dict0[item].id+"_"+str(record_dict1[item].seq)+" "+record_dict0[item].description.split(' ')[1].strip()
            record_dict0[item].description=""
    
    with gzip.open(output2, 'w') as handle3:
        SeqIO.write(record_dict0.values(), handle3, 'fastq')

#########################################################################################
### MAIN
#########################################################################################

##def main():
##    """
##    Main part of the program.
##    """
#    read1(args.read1,args.index,args.output1)
#    read2(args.read2,args.index,args.output2)
    
# sentinel
if __name__ == "__main__":
    p1 = mp.Process(name='p1', target=read1,args=(args.read1,args.index,args.output1))
    p = mp.Process(name='p', target=read2,args=(args.read2,args.index,args.output2))
    p1.start()
    p.start()
