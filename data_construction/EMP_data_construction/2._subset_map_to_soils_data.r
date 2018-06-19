#subset mapping file and otu table to only include soil samples from 'natural' ecosystems.
#clear environmenta, load packages.
rm(list=ls())
source('paths.r')
library(data.table)

#load map using fread is from the data.table package, loads big data frames very quickly.
#frad imports data as a data.table object. We like data.table because it can manipulate LARGE data frames very quickly.
raw.map <- fread(emp_map.path)

#Subset to soil observations.
map <- raw.map[empo_3 == 'Soil (non-saline)' & envo_biome_1 == 'terrestrial biome',]

#we probably want to make some more exclusion choices. There are agricultural sites here for instance.
#Lets exclude crops, polar desert, rangeland and "".
nope <- c('cropland biome','','polar desert biome','rangeland biome')
map <- map[!(envo_biome_3 %in% nope),]

#exclude a few studies that are sand from stream water filters and agroforestry.
nope <- c(755,1711,1714)
map <- map[!(study_id %in% nope),]

#save mapping file.
saveRDS(map, emp_map_clean.path)