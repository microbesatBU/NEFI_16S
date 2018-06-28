# clear environment and set working directory
rm(list=ls())
setwd("~/Desktop/NEFI_16S_data/") #change to path to taxonomic data

#load the taxonomic assignments
tax <- readRDS("emp_tax.rds")
esv <- readRDS("emp_esv_clean.rds")
map <- readRDS("emp_map_clean.rds")

#remove the unwanted string characters
for(i in 1:ncol(tax)){
  tax[,i] <- substring(tax[,i],4) # removes first three characters (e.g. "p__" in front of phylum assignment)
}
for(i in 1:ncol(tax)){
  tax[,i] <- gsub("\\[|\\]","",tax[,i]) # removes square brackets around assignments
}

#make taxonomy vectors
phylum <- tax$Phylum[match(rownames(esv),rownames(tax))]
class <- tax$Class[match(rownames(esv),rownames(tax))]
order <- tax$Order[match(rownames(esv),rownames(tax))]
family <- tax$Family[match(rownames(esv),rownames(tax))]
genus <- tax$Genus[match(rownames(esv),rownames(tax))]

#aggregate esv file by taxonomy
phylum_esv <- aggregate(esv,by=list(phylum),FUN=sum)
class_esv <- aggregate(esv,by=list(class),FUN=sum)
order_esv <- aggregate(esv,by=list(order),FUN=sum)
family_esv <- aggregate(esv,by=list(family),FUN=sum)
genus_esv <- aggregate(esv,by=list(genus),FUN=sum)

#make taxonomy the rownames of new esv file
rownames(phylum_esv) <- phylum_esv$Group.1; phylum_esv$Group.1 <- NULL
rownames(class_esv) <- class_esv$Group.1; class_esv$Group.1 <- NULL
rownames(order_esv) <- order_esv$Group.1; order_esv$Group.1 <- NULL
rownames(family_esv) <- family_esv$Group.1; family_esv$Group.1 <- NULL
rownames(genus_esv) <- genus_esv$Group.1; genus_esv$Group.1 <- NULL

#save esv files
saveRDS(phylum_esv,"phylum_esv.rds")
saveRDS(class_esv,"class_esv.rds")
saveRDS(order_esv,"order_esv.rds")
saveRDS(family_esv,"family_esv.rds")
saveRDS(genus_esv,"genus_esv.rds")
