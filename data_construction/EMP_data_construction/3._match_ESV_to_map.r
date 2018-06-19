#Based on mapping file subsetting, match the esv table to the mapping file.
#Needs to be run on SCC with more RAM.
#Colin has this working, but this script requires jumping between here and the command line on scc1.
#Colin started writing a qsub script for this to avoid jumping back and forth from the command line, but doesn't work yet.
#clear environment, load packges.
rm(list=ls())
source('paths.r')
library(biomformat)
library(data.table)

#load cleaned up mapping file.
map <- readRDS(emp_map_clean.path)

#get names of samples in mapping file that are the columns to keep in the ESV table.
keepers <- map[,1]
keep <- as.data.frame(keepers)
keep <- keep[,1]
keep <- as.character(keep)
write(keep,sep="\n", file = emp_soil.csv_path)

#filter .biom file using the emp_soil_IDs.csv file.
####WARNING: this stopped working. either way. not sure why.
#do on scc
#module load python/2.7.7
#module load qiime/1.9.0
#
#cd /projectnb/talbot-lab-data/caverill/NEFI_16S_data/
#filter_samples_from_otu_table.py -i emp_deblur_150bp.release1.biom -o emp_soils_ESV.biom --sample_id_fp emp_soil_IDs.csv

#Run qiime biom filtering command from R script.
cmd <- paste0('filter_samples_from_otu_table.py -i ',emp_esv.path,' -o ',emp_soil_biom.path,' --sample_id_fp ',emp_soil.csv_path)
system(cmd)

#load up the esv table.
esv.raw <- read_biom(emp_soil_biom.path)
#convert to non-sparse matrix
esv <- as.data.frame(as.matrix(biom_data(esv.raw)))

#remove OTUs that have zero observations in this subset.
esv <- esv[!(rowSums(esv) == 0),]

#go ahead and remove from mapping file things that aren't actually in ESV table.
map <- as.data.frame(map)
map <- map[map[,1] %in% colnames(esv),]

#save output.
saveRDS(esv, emp_esv_clean.path)
saveRDS(map, emp_map_clean.path)