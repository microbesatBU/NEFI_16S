#clear environment, set working directory
rm(list=ls())
setwd("~/Desktop/NEFI_16S_data/") #change to path with data

#load esv with compositional data
esv_phyla <- data.frame(readRDS("phylum_esv.rds"))
esv_class <- data.frame(readRDS("class_esv.rds"))
esv_order <- data.frame(readRDS("order_esv.rds"))
esv_family <- data.frame(readRDS("family_esv.rds"))
esv_genera <- data.frame(readRDS("genus_esv.rds"))

### PHYLA ###
#find the total number of sequences in each sample
num_seqs <- numeric()
for(i in 1:ncol(esv_phyla)){
  num_seqs[i] <- sum(esv_phyla[[i]])
}
esv_phyla_relative <- data.frame()

#divide by total number of sequences to get relative abundance
for(i in 1:nrow(esv_phyla)){
  for(j in 1:ncol(esv_phyla)){
    esv_phyla_relative[i,j] <- esv_phyla[i,j]/num_seqs[j]
  }
}
rownames(esv_phyla_relative) <- rownames(esv_phyla)
colnames(esv_phyla_relative) <- colnames(esv_phyla)

### CLASS ###
#find the total number of sequences in each sample
num_seqs <- numeric()
for(i in 1:ncol(esv_class)){
  num_seqs[i] <- sum(esv_class[[i]])
}
esv_class_relative <- data.frame()

#divide by total number of sequences to get relative abundance
for(i in 1:nrow(esv_class)){
  for(j in 1:ncol(esv_class)){
    esv_class_relative[i,j] <- esv_class[i,j]/num_seqs[j]
  }
}
rownames(esv_class_relative) <- rownames(esv_class)
colnames(esv_class_relative) <- colnames(esv_class)

### ORDER ###
#find the total number of sequences in each sample
num_seqs <- numeric()
for(i in 1:ncol(esv_order)){
  num_seqs[i] <- sum(esv_order[[i]])
}
esv_order_relative <- data.frame()

#divide by total number of sequences to get relative abundance
for(i in 1:nrow(esv_order)){
  for(j in 1:ncol(esv_order)){
    esv_order_relative[i,j] <- esv_order[i,j]/num_seqs[j]
  }
}
rownames(esv_order_relative) <- rownames(esv_order)
colnames(esv_order_relative) <- colnames(esv_order)

### FAMILY ###
#find the total number of sequences in each sample
num_seqs <- numeric()
for(i in 1:ncol(esv_family)){
  num_seqs[i] <- sum(esv_family[[i]])
}
esv_family_relative <- data.frame()

#divide by total number of sequences to get relative abundance
for(i in 1:nrow(esv_family)){
  for(j in 1:ncol(esv_family)){
    esv_family_relative[i,j] <- esv_family[i,j]/num_seqs[j]
  }
}
rownames(esv_family_relative) <- rownames(esv_family)
colnames(esv_family_relative) <- colnames(esv_family)

### GENERA ###
#find the total number of sequences in each sample
num_seqs <- numeric()
for(i in 1:ncol(esv_genera)){
  num_seqs[i] <- sum(esv_genera[[i]])
}
esv_genera_relative <- data.frame()

#divide by total number of sequences to get relative abundance
for(i in 1:nrow(esv_genera)){
  for(j in 1:ncol(esv_genera)){
    esv_genera_relative[i,j] <- esv_genera[i,j]/num_seqs[j]
  }
}
rownames(esv_genera_relative) <- rownames(esv_genera)
colnames(esv_genera_relative) <- colnames(esv_genera)

#transpose the data frames
esv_phyla_relative <- data.frame(t(esv_phyla_relative))
esv_class_relative <- data.frame(t(esv_class_relative))
esv_order_relative <- data.frame(t(esv_order_relative))
esv_family_relative <- data.frame(t(esv_family_relative))
esv_genera_relative <- data.frame(t(esv_genera_relative))

#save data
saveRDS(esv_phyla_relative, "relative_abund_phyla.rds")
saveRDS(esv_class_relative, "relative_abund_class.rds")
saveRDS(esv_order_relative, "relative_abund_order.rds")
saveRDS(esv_family_relative, "relative_abund_family.rds")
saveRDS(esv_genera_relative, "relative_abund_genera.rds")
