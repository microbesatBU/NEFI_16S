# script to format the extra metadata
rm(list = ls())
library(dplyr)
source('paths.r')

#load mapping file; this tells us which samples we want to look at
map <- readRDS(emp_map_clean.path)

#load the metadata files we need 
study_632  <- read.csv(emp_study632_metadata.path)
study_722  <- read.csv(emp_study722_metadata.path)
study_808  <- read.csv(emp_study808_metadata.path)
study_864  <- read.csv(emp_study864_metadata.path)
study_895  <- read.csv(emp_study895_metadata.path)
study_990  <- read.csv(emp_study990_metadata.path)
study_1031 <- read.csv(emp_study1031_metadata.path)
study_1037 <- read.csv(emp_study1037_metadata.path)
study_1043 <- read.csv(emp_study1043_metadata.path)
study_1521 <- read.csv(emp_study1521_metadata.path)
study_1579 <- read.csv(emp_study632_metadata.path)
study_1674 <- read.csv(emp_study1674_metadata.path)
study_1702 <- read.csv(emp_study1702_metadata.path)
study_1716 <- read.csv(emp_study1716_metadata.path)
study_1747 <- read.csv(emp_study1747_metadata.path)

#make a list of the metadata files
data.list <- list(study_632,  study_722,  study_808,  study_864,  study_895,  study_990,  
                  study_1031, study_1037, study_1043, study_1521, study_1579, study_1674, 
                  study_1702, study_1716, study_1747)

#isolate the samples we want to look at
samples <- map$`#SampleID`

for(i in 1:length(data.list)){
  data.list[[i]] <- subset(data.list[[i]], data.list[[i]]$sample_name %in% samples)
}

#make column names consistent
for(i in 1:length(data.list)){
  colnames(data.list[[i]])[colnames(data.list[[i]]) == 'carb_nitro_ratio'] <- 'c_n_ratio'
  colnames(data.list[[i]])[colnames(data.list[[i]]) == 'perc_nitrogen'] <- 'percent_n'
  colnames(data.list[[i]])[colnames(data.list[[i]]) == 'perc_total_c'] <- 'percent_c'
  if('tot_carb' %in% colnames(data.list[[i]]) & 'tot_org_carb' %in% colnames(data.list[[i]])){
    data.list[[i]] <- data.list[[i]][-data.list[[i]]$tot_org_carb]
  }
  if('tot_carb' %in% colnames(data.list[[i]]) & 'percent_c' %in% colnames(data.list[[i]])){
    data.list[[i]] <- data.list[[i]][-data.list[[i]]$tot_carb]
  }
}

#ensure desired columns are numerics, not factors
for(i in 1:length(data.list)){
  if(colnames(data.list[[i]]) == 'c_n_ratio'){
    data.list[[i]]$c_n_ratio <- as.numeric(data.list[[i]]$c_n_ratio)
  }
  if(colnames(data.list[[i]]) == 'percent_n'){
    data.list[[i]]$percent_n <- as.numeric(data.list[[i]]$percent_n)
  }
  if(colnames(data.list[[i]]) == 'percent_c'){
    data.list[[i]]$percent_c <- as.numeric(data.list[[i]]$percent_c)
  }
  if(colnames(data.list[[i]]) == 'water_content_soil'){
    data.list[[i]]$water_content_soil <- as.numeric(data.list[[i]]$water_content_soil)
  }
  if(colnames(data.list[[i]]) == 'tot_nitro'){
    data.list[[i]]$tot_nitro <- as.numeric(data.list[[i]]$tot_nitro)
  }
  if(colnames(data.list[[i]]) == 'tot_org_carb'){
    data.list[[i]]$tot_org_carb <- as.numeric(data.list[[i]]$tot_org_carb)
  }
  if(colnames(data.list[[i]]) == 'tot_carb'){
    data.list[[i]]$tot_carb <- as.numeric(data.list[[i]]$tot_carb)
  }
}

#make units consistent and update column names
#3.   808: water content: unknown units
#11. 1579: water content: unknown units
for(i in 1:length(data.list)){
  if(colnames(data.list[[i]]) == 'tot_nitro'){
    data.list[[i]]$tot_nitro <- data.list[[i]]$tot_nitro / 1000 * 100
    colnames(data.list[[i]])[colnames(data.list[[i]]) == 'tot_nitro'] <- 'percent_n'
  }
  if(colnames(data.list[[i]]) == 'tot_org_carb'){
    data.list[[i]]$tot_org_carb <- data.list[[i]]$tot_org_carb / 1000 * 100
    colnames(data.list[[i]])[colnames(data.list[[i]]) == 'tot_org_carb'] <- 'percent_org_c'
  }
  if(colnames(data.list[[i]]) == 'tot_carb'){
    data.list[[i]]$tot_carb <- data.list[[i]]$tot_carb / 1000 * 100
    colnames(data.list[[i]])[colnames(data.list[[i]]) == 'tot_carb'] <- 'percent_c'
  }
  
}

#isolate the variables we are interested in
vars <- list('sample_name', 'water_content_soil', 'percent_n', 'percent_c', 'percent_org_c', 'c_n_ratio')

for(i in 1:length(data.list)){
  data.list[[i]] <- subset(data.list[[i]], select = colnames(data.list[[i]]) %in% vars)
}

#combine rows into one new dataframe
metadata <- dplyr::bind_rows(data.list[[1]], data.list[[2]], data.list[[3]], data.list[[4]], data.list[[5]], data.list[[6]], data.list[[7]], data.list[[8]], data.list[[9]], data.list[[10]], data.list[[11]], data.list[[12]], data.list[[13]], data.list[[14]])
metadata <- metadata[,1:6]

#save metadata 
saveRDS(metadata, emp_metadata.path)
