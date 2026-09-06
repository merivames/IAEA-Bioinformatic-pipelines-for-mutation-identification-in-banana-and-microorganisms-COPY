#!/bin/bash

#########################################################
# Oxford Nanopore (ONT) workflows
#########################################################

# Example:
# conda activate ont_env


#########################################################
# QC with NanoPlot
#########################################################

NanoPlot --fastq ont_reads.fastq.gz \
    -o ont_output_directory \
    -t 60 \
    --loglength \
    --N50


#########################################################
# Filtering ONT reads with Filtlong
#########################################################

filtlong \
    --min_length 1000 \
    --min_mean_q 8 \
    ONT_reads.fastq.gz \
    > ONT_filtered.fastq

#########################################################
# De novo assembly of ONT reads with Hifiasm
#########################################################

# Basic ONT assembly

hifiasm \
    -o ont_assembly.asm \
    -t 32 \
    --ont \
    ONT_filtered.fastq


#########################################################
# Convert GFA to FASTA
#########################################################

awk '/^S/{print ">"$2;print $3}' \
ont_assembly.asm.bp.p_ctg.gfa \
> ont_assembly.p_ctg.fa
