#!/bin/bash

#########################################################
# Banana mutation discovery
# Depth-based coverage scan
#########################################################

# Inputs:
# - GCA_032878665.1_ASM3287866v1_genomic.fna
# - SRR11579627.sorted.bam  # non-irradiated control
# - SRR11579628.sorted.bam  # gamma-irradiated mutant

# Example:
# conda activate bedtools_env


#########################################################
# Index reference genome
#########################################################

samtools faidx GCA_032878665.1_ASM3287866v1_genomic.fna


#########################################################
# Create genome size file
#########################################################

cut -f1,2 GCA_032878665.1_ASM3287866v1_genomic.fna.fai \
    > GCA_032878665.1_ASM3287866v1_genomic.txt


#########################################################
# Create 50 kb genome windows
#########################################################

bedtools makewindows \
    -g GCA_032878665.1_ASM3287866v1_genomic.txt \
    -w 50000 \
    > GCA_032878665.1_ASM3287866v1_genomic.50kb.bed


#########################################################
# Sort genome windows
#########################################################

sort -k1,1 -k2,2n \
    GCA_032878665.1_ASM3287866v1_genomic.50kb.bed \
    > GCA_032878665.1_ASM3287866v1_genomic.50kb.sorted.bed


#########################################################
# Compute coverage per sample
#########################################################

# Control sample

bedtools coverage \
    -a GCA_032878665.1_ASM3287866v1_genomic.50kb.sorted.bed \
    -b SRR11579627.sorted.bam \
    -mean \
    -sorted \
    -g GCA_032878665.1_ASM3287866v1_genomic.txt \
    > SRR11579627.depth.50k.bed


# Mutant sample

bedtools coverage \
    -a GCA_032878665.1_ASM3287866v1_genomic.50kb.sorted.bed \
    -b SRR11579628.sorted.bam \
    -mean \
    -sorted \
    -g GCA_032878665.1_ASM3287866v1_genomic.txt \
    > SRR11579628.depth.50k.bed
