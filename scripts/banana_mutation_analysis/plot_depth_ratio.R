#!/usr/bin/env Rscript

#########################################################
# Plot genome-wide log2 depth ratios
#########################################################

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
    stop("Usage: Rscript plot_depth_ratio.R <depth_ratio.txt> <output_prefix>")
}

input_file <- args[1]
prefix <- args[2]


#########################################################
# Load libraries
#########################################################

library(ggplot2)


#########################################################
# Read input data
#########################################################

df <- read.table(input_file, header = TRUE)


#########################################################
# Generate plots per chromosome/haplotype
#########################################################

for (c in unique(df$chr)) {

    sub <- df[df$chr == c, ]

    p <- ggplot(sub, aes(x = start, y = ratio)) +
        geom_line(linewidth = 0.3) +
        theme_bw() +
        ggtitle(c) +
        xlab("Position") +
        ylab("log2(mutant/control)")

    ggsave(
        paste0(prefix, "_", c, ".pdf"),
        plot = p,
        width = 10,
        height = 4
    )
}
