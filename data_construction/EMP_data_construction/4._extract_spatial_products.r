#Assign spatial products.
#Climate from worldclim2. N-dep from NADP.
#These are based on functions written by Colin. 
#This script will only run on scc1 or pecan2 as this is where these spatial products are actually stored (they are big).
rm(list = ls())
source('paths.r')
source('project_functions/extract_ndep.r')
source('project_functions/worldclim2_grab.r')

#load 16S meta data file with lat/long
d <- readRDS(emp_map_clean.path)

#extract worldclim.
d <- cbind(d,worldclim2_grab(d$latitude_deg,d$longitude_deg,d$elevation_m))

#extract N deposition. Half of these are NA because our Ndep product only covers the United States.
#ignore the warnings.
d <- cbind(d,extract_ndep(d$longitude_deg,d$latitude_deg))

#save
saveRDS(d,emp_map_clean.path)