#!/bin/bash

## salmonIndex.sh
# Create Salmon index with decoy.

## Assuming we have compressed GENCODE transcript and genome fasta files ready.
# The files can be downloaded from GENCODE site.

## Usage:
# ./salmonIndex.sh 

## Output: a direactor salmon-index with the index files.

transcript_fa="gencode.v47.transcripts.fa.gz"
genome_fa="GRCh38.primary_assembly.genome.fa.gz"

## Make a chromosome list from the genome file.
zgrep "^>" ${genome_fa} | cut -d" " -f1 | cut -d">" -f2 > decoys.txt

## Concatenate the genome fasta to the transcripts, creating a "gentrome".
cat ${transcript_fa} ${genome_fa} > gentrome.fa.gz

salmon index -t gentrome.fa.gz \
             --decoys decoys.txt \
             -i salmon-index \
             -p 12 --gencode
