#!/bin/bash

## salmonQuant.sh
# Retrieve SRA reads and excecute Salmon quantification program
# for a GEO RNA-seq sample with replicates.

## Assuming we have a list of SRR numbers, one on a line, 
# as a set of replicates for a "sample" (in GEO's terminology), 
# and we want to combine them into one quant.sf.
# Also asuume we have NCBI sra-toolkit ready.

## Usage:
# salmonQuant.sh [SRRn_list]
# Use the script in a for loop for multiple samples.

## Output: A directory names $SRRn with
# /fastq holding SRA read and fastq files (if not removed),
# /salmon-quant with salmon created files.                                     

## Path to index directory. Change as needed.
salmon_index=salmon-quant/salmon-index  

SRRn_list=$1  # e.g., DMSO_1_SRRn, all runs for one replicate set

dir=${SRRn_list%_SRRn}  # e.g., DMSO_1
mkdir $dir && cd $dir

mkdir fastq
cp ../${SRRn_list} ./

## Retrieve reads from NCBI SRA and run salmon quant.
while read sn; do

    echo -e "\nDownload and processing SRA read $sn ...\n"

    # Retrieve SRA run using sra-toolkit and run number.
    # Result: a directory $sn with $sn.sra.
    prefetch $sn -O fastq

    # Convert the run to fastq pair: $sn_1.fastq, $sn_2.fastq.
    fasterq-dump $sn -e 16 -O fastq
    
    # Compress: *_1.fastq.gz, *_2.fastq.gz
    # This can be done but is slow.
    # gzip ${sn}_[12].fastq

done < ${SRRn_list}

r1_list=$(ls fastq/*_1.fastq)
r2_list=$(ls fastq/*_2.fastq)

# Run Salmon
salmon quant -i ${salmon_index} -l A -p 16 \
             --gcBias \
             --numGibbsSamples 20 \
             -o salmon-quant \
             -1 ${r1_list} \
             -2 ${r2_list}

## Remove *.fastq files. Those files are very large (~ 5 - 7 GB).
# Comment out if kept.
rm -r fastq/*_[12].fastq

echo -e "Done with Salmon quant for ${SRRn_list}. \n"
cd ..
