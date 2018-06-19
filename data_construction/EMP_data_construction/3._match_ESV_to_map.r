#Based on mapping file subsetting, match the esv table to the mapping file.
#Colin has this working, but this script won't reproduce it at the moment.
#The files you need for downstream analysis are all in scc1:/projectnb/talbot-lab-data/caverill/NEFI_16S_data
#Needs to be run on SCC with more RAM.
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
write(keep,sep="\n", file = paste0(data.dir,'emp_soil_IDs.csv'))

#filter .biom file using the emp_soil_IDs.csv file.
#do on scc
#module load python/2.7.7
#module load qiime/1.9.0
#cd /projectnb/talbot-lab-data/caverill/NEFI_16S_data/
#filter_samples_from_otu_table.py -i emp_deblur_150bp.release1.biom -o emp_soils_ESV.biom --sample_id_fp emp_soil_IDs.csv 


#load up the esv table.
esv.raw <- read_biom('/fs/data3/caverill/NEFI_16S_data/emp_soils_ESV.biom')
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