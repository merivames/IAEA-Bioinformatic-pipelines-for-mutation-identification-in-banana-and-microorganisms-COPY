#!/bin/bash

#########################################################
# Assembly and mapping QC workflows
# Hands-on SRR datasets only
#########################################################

# Example:
# conda activate qc_env

# SRR11579627 = non-irradiated control
# SRR11579628 = gamma-irradiated mutant
# Reference genome = GCA_032878665.1_ASM3287866v1_genomic.fna


#########################################################
# Assembly QC with QUAST
# For example for the Reference genome that was assembled using PacBio reads
#########################################################

quast.py GCA_032878665.1_ASM3287866v1_genomic.fna

#########################################################
# Assembly QC with BUSCO
#########################################################

busco \
    -i ./GCA_032878665.1_ASM3287866v1_genomic.fna \
    -l ./busco_downloads/embryophyta_odb12/ \
    -o ./GCA_busco_output \
    -m genome \
    --offline \
    --force

#########################################################
# Alignment QC with samtools
#########################################################

# Control sample

samtools flagstat SRR11579627.sorted.bam > SRR11579627.sorted.flagstat.txt
samtools stats SRR11579627.sorted.bam > SRR11579627.sorted.stats
samtools depth -a SRR11579627.sorted.bam > SRR11579627.sorted.depth.txt
samtools stats SRR11579627.sorted.bam | grep ^MQ > SRR11579627.sorted.mq.txt
samtools depth SRR11579627.sorted.bam | \
awk '{if($3>0) c++} END {print c/NR}' \
> SRR11579627.sorted.breadth.txt


# Mutant sample

samtools flagstat SRR11579628.sorted.bam > SRR11579628.sorted.flagstat.txt
samtools stats SRR11579628.sorted.bam > SRR11579628.sorted.stats
samtools depth -a SRR11579628.sorted.bam > SRR11579628.sorted.depth.txt
samtools stats SRR11579628.sorted.bam | grep ^MQ > SRR11579628.sorted.mq.txt
samtools depth SRR11579628.sorted.bam | \
awk '{if($3>0) c++} END {print c/NR}' \
> SRR11579628.sorted.breadth.txt


#########################################################
# Variant-based QC with bcftools
#########################################################

# Control sample

bcftools mpileup \
    -Ou \
    -f GCA_032878665.1_ASM3287866v1_genomic.fna \
    SRR11579627.sorted.bam | \
bcftools call \
    -mv \
    -Ov \
    -o SRR11579627.sorted.vcf

bcftools stats SRR11579627.sorted.vcf \
    > SRR11579627.sorted.vcf.stats.txt

bcftools query \
    -f '%CHROM\t%POS\n' \
    SRR11579627.sorted.vcf \
    > SRR11579627.sorted.snp_positions.txt


# Mutant sample

bcftools mpileup \
    -Ou \
    -f GCA_032878665.1_ASM3287866v1_genomic.fna \
    SRR11579628.sorted.bam | \
bcftools call \
    -mv \
    -Ov \
    -o SRR11579628.sorted.vcf

bcftools stats SRR11579628.sorted.vcf \
    > SRR11579628.sorted.vcf.stats.txt

bcftools query \
    -f '%CHROM\t%POS\n' \
    SRR11579628.sorted.vcf \
    > SRR11579628.sorted.snp_positions.txt
