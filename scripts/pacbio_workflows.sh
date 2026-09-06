#!/bin/bash

#########################################################
# Long-read workflows
# PacBio HiFi
#########################################################

#########################################################
# Activate environment
#########################################################

# Example:
# conda activate longread_env


#########################################################
# QC with NanoPlot
#########################################################

# PacBio HiFi reads

NanoPlot --fastq pacbio_data_hifi.fastq.gz \
    -o pacbio_output_directory \
    -t 60 \
    --loglength

#########################################################
# Filtering PacBio HiFi reads with NanoFilt
#########################################################

zcat pacbio_data_hifi.fastq.gz | \
NanoFilt -q 20 | \
gzip > pacbio_data_hifi_q20.fastq.gz


# Count retained reads

zcat pacbio_data_hifi_q20.fastq.gz | \
wc -l | \
awk '{print "Reads: "$1/4}'


#########################################################
# De novo assembly with Hifiasm
#########################################################

# Basic HiFi assembly

hifiasm \
    -o pacbio_data_q20_hifiasm.asm \
    -t 16 \
    pacbio_data_hifi_q20.fastq.gz


#########################################################
# Plot 1 assembly
#########################################################

hifiasm \
    -f0 \
    -o plot1_hifi_data.asm \
    -t 32 \
    -l0 \
    plot1_hifi_data.fq.gz


#########################################################
# Plot 2 assembly
#########################################################

hifiasm \
    -f0 \
    -o plot2_hifi_data.asm \
    -t 32 \
    plot2_hifi_data.fq.gz


# Dual-scaffold assembly

hifiasm \
    -f0 \
    -o plot2_hifi_data.asm \
    -t 32 \
    --dual-scaf \
    plot2_hifi_data.fq.gz


#########################################################
# Convert GFA to FASTA
#########################################################

awk '/^S/{print ">"$2;print $3}' \
plot1_hifi_data.asm.p_ctg.gfa \
> plot1_hifi_data.p_ctg.fa
