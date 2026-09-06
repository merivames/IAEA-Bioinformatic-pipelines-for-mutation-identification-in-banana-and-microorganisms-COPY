#!/bin/bash

#########################################################
# NLR-Annotator analysis for candidate region
#########################################################

# Required files in the working directory:
# - NLR-Annotator.jar
# - mot.txt
# - store.txt
# - CM065034.1_6_9Mb.ref.fa


#########################################################
# Create output directory
#########################################################

mkdir -p nlr_results


#########################################################
# Run NLR-Annotator
#########################################################

java -Xmx8G -jar NLR-Annotator.jar \
    -i CM065034.1_6_9Mb.ref.fa \
    -x mot.txt \
    -y store.txt \
    -t 4 \
    -o nlr_results/nlr_annotator.out.txt \
    -g nlr_results/nlr_annotator.gff \
    -b nlr_results/nlr_annotator.bed \
    -m nlr_results/nlr_motifs.bed \
    -a nlr_results/nb_arc_motifs.aln.fasta


#########################################################
# Extract NLR loci sequences
#########################################################

java -Xmx8G -jar NLR-Annotator.jar \
    -i CM065034.1_6_9Mb.ref.fa \
    -x mot.txt \
    -y store.txt \
    -t 4 \
    -f CM065034.1_6_9Mb.ref.fa nlr_results/nlr_loci.fasta 0
