# script to subset out only taxa that are found in 50%+ of samples
#Katie- udpate the save paths. Put them in the paths.r file, and call them by their names in that file, rather than hard coding them here.
#Finally, try rewriting this as a loop operating on each taxonomic data set stored in a list.
rm(list=ls())
source('paths.r')
#setwd("~/Desktop/NEFI_16S_data/")

#load the relative taxonomic data
  phyla <- readRDS(emp_phylum_esv.path)
classes <- readRDS( emp_class_esv.path)
  order <- readRDS( emp_order_esv.path)
 family <- readRDS(emp_family_esv.path)
 genera <- readRDS( emp_genus_esv.path)

# find number for half the samples
n_half <- nrow(phyla)/2 #same for every level of taxonomy

### PHYLA ###
#loop setup
count <- 0 
num <- 1
names <- character()
#loop through and count number of samples taxa are in
for(i in 1:ncol(phyla)){
  for(j in 1:nrow(phyla)){
    if(phyla[j,i] > 0){
      count = count + 1
    }
  }
  if(count >= n_half){
    names[num] <- colnames(phyla)[i]
    num = num + 1
  }
  count = 0
}
#subset out chosen taxa
phyla <- phyla[names]
colnames(phyla) <- gsub("[.]","-",colnames(phyla))


### CLASS ###
#loop setup
count <- 0 
num <- 1
names <- character()
#loop through and count number of samples taxa are in
for(i in 1:ncol(classes)){
  for(j in 1:nrow(classes)){
    if(classes[j,i] > 0){
      count = count + 1
    }
  }
  if(count >= n_half){
    names[num] <- colnames(classes)[i]
    num = num + 1
  }
  count = 0
}
#subset out chosen taxa
classes <- classes[names]
colnames(classes) <- gsub("[.]","-",colnames(classes))
colnames(classes)[1] <- gsub("V","",colnames(classes)[1])
colnames(classes)[2:5] <- gsub("X","",colnames(classes)[2:5])

### ORDER ###
#loop setup
count <- 0 
num <- 1
names <- character()
#loop through and count number of samples taxa are in
for(i in 1:ncol(order)){
  for(j in 1:nrow(order)){
    if(order[j,i] > 0){
      count = count + 1
    }
  }
  if(count >= n_half){
    names[num] <- colnames(order)[i]
    num = num + 1
  }
  count = 0
}
#subset out chosen taxa
order <- order[names]
colnames(order) <- gsub("[.]","-",colnames(order))
colnames(order)[1] <- gsub("V","",colnames(order)[1])
colnames(order)[2:6] <- gsub("X","",colnames(order)[2:6])

### FAMILY ###
#loop setup
count <- 0 
num <- 1
names <- character()
#loop through and count number of samples taxa are in
for(i in 1:ncol(family)){
  for(j in 1:nrow(family)){
    if(family[j,i] > 0){
      count = count + 1
    }
  }
  if(count >= n_half){
    names[num] <- colnames(family)[i]
    num = num + 1
  }
  count = 0
}
#subset out chosen taxa
family <- family[names]
colnames(family) <- gsub("[.]","-",colnames(family))
colnames(family)[1] <- gsub("V","",colnames(family)[1])
colnames(family)[2:6] <- gsub("X","",colnames(family)[2:6])

### GENERA ###
#loop setup
count <- 0 
num <- 1
names <- character()
#loop through and count number of samples taxa are in
for(i in 1:ncol(genera)){
  for(j in 1:nrow(genera)){
    if(genera[j,i] > 0){
      count = count + 1
    }
  }
  if(count >= n_half){
    names[num] <- colnames(genera)[i]
    num = num + 1
  }
  count = 0
}
#subset out chosen taxa
genera <- genera[names]
colnames(genera) <- gsub("[.]","-",colnames(genera))
colnames(genera)[1] <- gsub("V","",colnames(genera)[1])

#save as RDS
saveRDS(phyla, "phyla_rel_abundance_50.RDS")
saveRDS(classes, "class_rel_abundance_50.RDS")
saveRDS(order, "order_rel_abundance_50.RDS")
saveRDS(family, "family_rel_abundance_50.RDS")
saveRDS(genera, "genera_rel_abundance_50.RDS")
