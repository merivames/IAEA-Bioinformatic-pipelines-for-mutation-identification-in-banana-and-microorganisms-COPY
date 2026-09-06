#!/bin/bash

#########################################################
# Microbial short-read workflows
# Taxonomic confirmation with KrakenUniq
#########################################################

krakenuniq \
    --db /path/to/krakenuniq_db \
    --threads 16 \
    --paired bacillus_1.fastq bacillus_2.fastq \
    --report-file bacillus.report.tsv \
    > bacillus.output.txt

#########################################################
# De novo assembly with SPAdes
#########################################################

# Careful mode

spades.py \
    --careful \
    -1 bacillus_1.fastq \
    -2 bacillus_2.fastq \
    -o bacillus_spades_output \
    -t 16 \
    -m 64

# Isolate mode

spades.py \
    --isolate \
    -1 bacillus_1.fastq \
    -2 bacillus_2.fastq \
    -o bacillus_spades_output \
    -t 16 \
    -m 64

#########################################################
# Assembly QC with BUSCO
#########################################################

busco \
    -i bacillus_spades_output/contigs.fasta \
    -l ./busco_downloads/bacillales_odb12/ \
    -o bacillus_busco_bacillales \
    -m genome \
    --offline \
    --force
