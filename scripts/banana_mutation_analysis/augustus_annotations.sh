#!/bin/bash

#########################################################
# Downstream annotation of candidate region CM065034.1
#########################################################

# Inputs:
# - GCA_032878665.1_ASM3287866v1_genomic.fna
# - Candidate region: CM065034.1:6000000-9000000


#########################################################
# Extract candidate region from reference genome
#########################################################

samtools faidx \
    GCA_032878665.1_ASM3287866v1_genomic.fna \
    CM065034.1:6000000-9000000 \
    > CM065034.1_6_9Mb.ref.fa


#########################################################
# Predict genes with AUGUSTUS
#########################################################

augustus \
    --species=rice \
    --protein=on \
    CM065034.1_6_9Mb.ref.fa \
    > CM065034.1_6_9Mb.augustus.with_proteins.gff


#########################################################
# Count predicted genes
#########################################################

awk -F'\t' '$3=="gene"' \
    CM065034.1_6_9Mb.augustus.with_proteins.gff \
    > genes.gff

wc -l genes.gff
