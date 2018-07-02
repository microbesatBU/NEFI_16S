#Assign spatial products.
#Climate from worldclim2. N-dep from NADP.
#These are based on functions written by Colin. 
#This script will only run on pecan2 as this is where these spatial products are actually stored (they are big).
rm(list = ls())
source('paths.r')
source('project_functions/extract_ndep.r')
source('project_functions/worldclim2_grab.r')
source('project_functions/arid_extract.r')

#load 16S meta data file with lat/long
d <- readRDS(emp_map_clean.path)

#make sure things you are going to extract aren't already in dataframe. If they are, remove them so we dont double name things.
to_remove <- c('mat','map','mat_sd','map_sd','mat_CV','map_CV','mdr','aridity','n.dep','dry.dep','wet.dep')
d <- d[,!(colnames(d) %in% to_remove)]

#extract worldclim.
clim <- worldclim2_grab(d$latitude_deg,d$longitude_deg,d$elevation_m)
clim$aridity <- arid_extract(d$latitude_deg,d$longitude_deg)

#extract N deposition. Half of these are NA because our Ndep product only covers the United States.
#ignore the warnings.
ndep <- extract_ndep(d$longitude_deg,d$latitude_deg)

#put together all spatial products
spatial <- cbind(ndep,clim)

#remove any columns from previous spatial extractions, update with new extraction.
d <- as.data.frame(d)
d <- cbind(d,spatial)

#save
saveRDS(d,emp_map_clean.path)