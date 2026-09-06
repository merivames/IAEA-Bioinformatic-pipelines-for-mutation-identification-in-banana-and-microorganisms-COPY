#!/usr/bin/env Rscript

#########################################################
# Compute log2 depth ratio between mutant and control
#########################################################

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 3) {
    stop("Usage: Rscript depth_ratio.R <control.depth.bed> <mutant.depth.bed> <output.txt>")
}

control_file <- args[1]
mutant_file <- args[2]
output_file <- args[3]


#########################################################
# Read input files
#########################################################

control <- read.table(control_file, header = FALSE)
mutant <- read.table(mutant_file, header = FALSE)


#########################################################
# Assign column names
#########################################################

colnames(control) <- c("chr", "start", "end", "depth_ctrl")
colnames(mutant) <- c("chr", "start", "end", "depth_mut")


#########################################################
# Merge genomic windows
#########################################################

df <- merge(control, mutant, by = c("chr", "start", "end"))


#########################################################
# Compute log2(mutant/control)
#########################################################

df$ratio <- log2((df$depth_mut + 1) / (df$depth_ctrl + 1))


#########################################################
# Save output
#########################################################

write.table(
    df,
    output_file,
    sep = "\t",
    row.names = FALSE,
    quote = FALSE
)
