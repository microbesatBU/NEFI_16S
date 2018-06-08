#This is where Colin left off and where Jenny+Katie should start.
#mapping file and OTU table have been subsetted to only soils from "natural" ecosystems.
#OTU table can be loaded into R now, its sufficiently small
#column names of OTU (or ESV) table are the sample IDs, which pair with the first column of the mapping file.
#row names of OTU (or ESV) table are the actual sequences that you will need to assign taxonomy via RDP (or blast or whatever).

#clear environment, source paths.
rm(list=ls())
source('paths.r')

#load map and otu
map <- readRDS(emp_map_clean.path)
otu <- readRDS(emp_esv_clean.path)