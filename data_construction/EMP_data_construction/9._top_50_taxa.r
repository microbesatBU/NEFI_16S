rm(list=ls())
setwd("~/Desktop/NEFI_16S_data/")

#load esv with compositional data
esv_phyla <- data.frame(readRDS("phylum_esv.rds"))
esv_class <- data.frame(readRDS("class_esv.rds"))
esv_order <- data.frame(readRDS("order_esv.rds"))
esv_family <- data.frame(readRDS("family_esv.rds"))
esv_genera <- data.frame(readRDS("genus_esv.rds"))

#load 50% subsetted data
phyla_50 <- readRDS("phyla_rel_abundance_50.RDS")
class_50 <- readRDS("class_rel_abundance_50.RDS")
order_50 <- readRDS("order_rel_abundance_50.RDS")
family_50 <- readRDS("family_rel_abundance_50.RDS")
genera_50 <- readRDS("genera_rel_abundance_50.RDS")

############ PHYLUM
#subset raw compositional data with the colnames of the 50% subsetted data
cols <- colnames(phyla_50)
esv_phyla <- esv_phyla[cols,]
#add across rows for each taxa
for(i in 1:nrow(esv_phyla)){
  esv_phyla$Sum[i] <- sum(esv_phyla[i,])
}
#sort by total abundance
most_abund <- esv_phyla[order(-esv_phyla$Sum),]
if(nrow(most_abund)>50){
  most_abund <- most_abund[1:50,]
}
#subset 50% data with the 50 most abundant
most_abund <- t(most_abund)
phyla_50 <- phyla_50[colnames(most_abund)] 

########## CLASS
#subset raw compositional data with the colnames of the 50% subsetted data
cols <- colnames(class_50)
esv_class <- esv_class[cols,]
#add across rows for each taxa
for(i in 1:nrow(esv_class)){
  esv_class$Sum[i] <- sum(esv_class[i,])
}
#sort by total abundance
most_abund <- esv_class[order(-esv_class$Sum),]
if(nrow(most_abund)>50){
  most_abund <- most_abund[1:50,]
}
#subset 50% data with the 50 most abundant
most_abund <- t(most_abund)
class_50 <- class_50[colnames(most_abund)]

########### ORDER
#subset raw compositional data with the colnames of the 50% subsetted data
cols <- colnames(order_50)
esv_order <- esv_order[cols,]
#add across rows for each taxa
for(i in 1:nrow(esv_order)){
  esv_order$Sum[i] <- sum(esv_order[i,])
}
#sort by total abundance
most_abund <- esv_order[order(-esv_order$Sum),]
if(nrow(most_abund)>50){
  most_abund <- most_abund[1:50,]
}
#subset 50% data with the 50 most abundant
most_abund <- t(most_abund)
order_50 <- order_50[colnames(most_abund)]

########### FAMILY
#subset raw compositional data with the colnames of the 50% subsetted data
cols <- colnames(family_50)
esv_family <- esv_family[cols,]
#add across rows for each taxa
for(i in 1:nrow(esv_family)){
  esv_family$Sum[i] <- sum(esv_family[i,])
}
#sort by total abundance
most_abund <- esv_family[order(-esv_family$Sum),]
if(nrow(most_abund)>50){
  most_abund <- most_abund[1:50,]
}
#subset 50% data with the 50 most abundant
most_abund <- t(most_abund)
family_50 <- family_50[colnames(most_abund)]

########### GENERA
#subset raw compositional data with the colnames of the 50% subsetted data
cols <- colnames(genera_50)
esv_genera <- esv_genera[cols,]
#add across rows for each taxa
for(i in 1:nrow(esv_genera)){
  esv_genera$Sum[i] <- sum(esv_genera[i,])
}
#sort by total abundance
most_abund <- esv_genera[order(-esv_genera$Sum),]
if(nrow(most_abund)>50){
  most_abund <- most_abund[1:50,]
}
#subset 50% data with the 50 most abundant
most_abund <- t(most_abund)
genera_50 <- genera_50[colnames(most_abund)]

#save objects as RDS
saveRDS(phyla_50, "phyla_top50.RDS")
saveRDS(class_50, "class_top50.RDS")
saveRDS(order_50, "order_top50.RDS")
saveRDS(family_50, "family_top50.RDS")
saveRDS(genera_50, "genera_top50.RDS")
