#!/bin/bash

#########################################################
# Extract candidate regions for IGV visualization
#########################################################

# Inputs:
# - SRR11579627.sorted.bam  # non-irradiated control
# - SRR11579628.sorted.bam  # gamma-irradiated mutant


#########################################################
# Extract CM065024.1
#########################################################

# Mutant

samtools view -b SRR11579628.sorted.bam CM065024.1 \
    > SRR11579628.CM065024.1.bam

samtools index SRR11579628.CM065024.1.bam


# Control

samtools view -b SRR11579627.sorted.bam CM065024.1 \
    > SRR11579627.CM065024.1.bam

samtools index SRR11579627.CM065024.1.bam


#########################################################
# Extract CM065025.1
#########################################################

# Mutant

samtools view -b SRR11579628.sorted.bam CM065025.1 \
    > SRR11579628.CM065025.1.bam

samtools index SRR11579628.CM065025.1.bam


# Control

samtools view -b SRR11579627.sorted.bam CM065025.1 \
    > SRR11579627.CM065025.1.bam

samtools index SRR11579627.CM065025.1.bam


#########################################################
# Extract CM065034.1
#########################################################

# Mutant

samtools view -b SRR11579628.sorted.bam CM065034.1 \
    > SRR11579628.CM065034.1.bam

samtools index SRR11579628.CM065034.1.bam


# Control

samtools view -b SRR11579627.sorted.bam CM065034.1 \
    > SRR11579627.CM065034.1.bam

samtools index SRR11579627.CM065034.1.bam
