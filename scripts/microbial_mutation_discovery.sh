#!/bin/bash

#########################################################
# Discovery of mutations in gamma-irradiated microorganisms
# Microorganism sp. mutants vs wild type
# Genomes in fasta format are available for hands on in the data directory
#########################################################


#########################################################
# Filter contigs >1000 bp with SeqKit
#########################################################

seqkit seq \
    -m 1000 \
    assembly.fasta \
    > assembly_min1000.fasta


#########################################################
# Pairwise genome comparisons with MUMmer dnadiff
#########################################################

dnadiff \
    -p WT_vs_Mutant24 \
    ./WT.fasta \
    ./Mutant24.fasta


dnadiff \
    -p WT_vs_Mutant34 \
    ./WT.fasta \
    ./Mutant34.fasta


dnadiff \
    -p WT_vs_Mutant58 \
    ./WT.fasta \
    ./Mutant58.fasta


#########################################################
# Genome annotation with Prokka
#########################################################

prokka \
    --outdir WT_annot \
    --prefix WT \
    ./WT.fasta


prokka \
    --outdir Mutant24_annot \
    --prefix Mutant24 \
    ./Mutant24.fasta


prokka \
    --outdir Mutant34_annot \
    --prefix Mutant34 \
    ./Mutant34.fasta


prokka \
    --outdir Mutant58_annot \
    --prefix Mutant58 \
    ./Mutant58.fasta


#########################################################
# Candidate region extraction from annotation
#########################################################

awk '$1=="NODE_8_length_4422_cov_1163.700904" && $4<=1800 && $5>=800' \
WT.gff
