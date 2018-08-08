rm(list=ls())

source('paths.r')

data <- read.table(SRA_to_Sample.path, sep='\t', header=TRUE)

vars <- c('SRA_Sample', 'Sample_Name')
sample_SRA_link <- data[,vars]

saveRDS(sample_SRA_link, sra_sample_link.path)
