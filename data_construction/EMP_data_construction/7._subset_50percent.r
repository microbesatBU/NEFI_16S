# script to subset out only taxa that are found in 50%+ of samples
#Katie- udpate the save paths. Put them in the paths.r file, and call them by their names in that file, rather than hard coding them here.
#Finally, try rewriting this as a loop operating on each taxonomic data set stored in a list.
rm(list=ls())
source('paths.r')

#load the relative taxonomic data
data <- readRDS(emp_phylo.level.list_esv.path)

# find number for half the samples
n_half <- ncol(data[[1]])/2 #same for every level of taxonomy

#loop through each data set to subset out only taxa found in 50%+ of samples
for(i in 1:length(data.list)){
  count <- 0 
  num <- 1
  names <- character()
  #loop through and count number of samples taxa are in
  for(j in 1:nrow(data.list[[i]])){ #rows are taxa
    for(k in 1:ncol(data.list[[i]])){ #columns are samples
      if(data.list[[i]][j,k] > 0){
        count = count + 1
      }
    }
    if(count >= n_half){
      names[num] <- rownames(data.list[[i]])[j]
      num = num + 1
    }
    count = 0
  }
  data.list[[i]] <- data.list[[i]][names,]
}

#save as RDS
saveRDS(data.list, emp_phylo.level.list_esv.path)
