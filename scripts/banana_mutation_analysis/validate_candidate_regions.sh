#!/bin/bash

#########################################################
# Validate candidate regions by sequencing depth
#########################################################

# Inputs:
# - SRR11579627.sorted.bam  # non-irradiated control
# - SRR11579628.sorted.bam  # gamma-irradiated mutant


#########################################################
# CM065024.1 candidate and flank regions
#########################################################

samtools depth -aa -r CM065024.1:20000000-30000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065024.1 mutant shift", sum/n, n}'

samtools depth -aa -r CM065024.1:20000000-30000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065024.1 control shift", sum/n, n}'

samtools depth -aa -r CM065024.1:10000000-18000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065024.1 mutant flank", sum/n, n}'

samtools depth -aa -r CM065024.1:10000000-18000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065024.1 control flank", sum/n, n}'


#########################################################
# CM065025.1 candidate and flank regions
#########################################################

samtools depth -aa -r CM065025.1:4000000-12000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065025.1 mutant shift", sum/n, n}'

samtools depth -aa -r CM065025.1:4000000-12000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065025.1 control shift", sum/n, n}'

samtools depth -aa -r CM065025.1:15000000-23000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065025.1 mutant flank", sum/n, n}'

samtools depth -aa -r CM065025.1:15000000-23000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065025.1 control flank", sum/n, n}'


#########################################################
# CM065034.1 candidate and flank regions
#########################################################

samtools depth -aa -r CM065034.1:6000000-9000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065034.1 mutant shift", sum/n, n}'

samtools depth -aa -r CM065034.1:6000000-9000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065034.1 control shift", sum/n, n}'

samtools depth -aa -r CM065034.1:1000000-4000000 SRR11579628.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065034.1 mutant flank", sum/n, n}'

samtools depth -aa -r CM065034.1:1000000-4000000 SRR11579627.sorted.bam | \
awk '{sum+=$3; n++} END{print "CM065034.1 control flank", sum/n, n}'
