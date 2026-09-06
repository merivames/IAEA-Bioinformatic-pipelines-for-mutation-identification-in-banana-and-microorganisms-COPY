#!/bin/bash

#########################################################
# Hands-on datasets
#########################################################

# SRR11579628 = gamma-irradiated mutant
# SRR11579627 = non-irradiated control
# Reference genome = Musa acuminata AAA Group
# GCA_032878665.1_ASM3287866v1_genomic.fna.gz


#########################################################
# QC with FastQC
#########################################################

fastqc SRR11579628_1.fastq SRR11579628_2.fastq
fastqc SRR11579627_1.fastq SRR11579627_2.fastq


#########################################################
# Trimming and filtering with fastp
#########################################################

# Mutant sample

fastp \
    -i SRR11579628_1.fastq \
    -I SRR11579628_2.fastq \
    -o SRR11579628_filtered_1.fastq \
    -O SRR11579628_filtered_2.fastq \
    -q 20 \
    --detect_adapter_for_pe \
    -g \
    -x \
    -t 1 \
    -h SRR11579628_fastp_report.html


# Control sample

fastp \
    -i SRR11579627_1.fastq \
    -I SRR11579627_2.fastq \
    -o SRR11579627_filtered_1.fastq \
    -O SRR11579627_filtered_2.fastq \
    -q 20 \
    --detect_adapter_for_pe \
    -g \
    -x \
    -t 1 \
    -h SRR11579627_fastp_report.html


#########################################################
# Optional: re-run FastQC after filtering
#########################################################

fastqc SRR11579628_filtered_1.fastq SRR11579628_filtered_2.fastq
fastqc SRR11579627_filtered_1.fastq SRR11579627_filtered_2.fastq


#########################################################
# Prepare reference genome
#########################################################

gunzip GCA_032878665.1_ASM3287866v1_genomic.fna.gz


#########################################################
# Index reference genome with Minimap2
#########################################################

minimap2 \
    -d GCA_032878665.1_ASM3287866v1_genomic.mmi \
    GCA_032878665.1_ASM3287866v1_genomic.fna


#########################################################
# Map Illumina reads to reference genome
#########################################################

# Control sample

minimap2 \
    -ax sr \
    --secondary=no \
    -t 32 \
    GCA_032878665.1_ASM3287866v1_genomic.mmi \
    SRR11579627_filtered_1.fastq \
    SRR11579627_filtered_2.fastq | \
samtools sort -o SRR11579627.sorted.bam

samtools index SRR11579627.sorted.bam

# Mutant sample

minimap2 \
    -ax sr \
    --secondary=no \
    -t 32 \
    GCA_032878665.1_ASM3287866v1_genomic.mmi \
    SRR11579628_filtered_1.fastq \
    SRR11579628_filtered_2.fastq | \
samtools sort -o SRR11579628.sorted.bam

samtools index SRR11579628.sorted.bam
