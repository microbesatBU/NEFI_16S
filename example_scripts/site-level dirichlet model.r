#demonstrating how we use the ddirch function.
#this is going to fit a multivariate beta model (dirichlet model) using JAGS, a tool for fitting Bayesian models.
#Colin has built a function that wraps a lot of the data formatting stuff, as well as makes the output of this easier to work with.
#This script shows you how to use the function.

#clear environment, load paths, packages and functions.
rm(list=ls())
library(runjags)
source('paths.r')
source('project_functions/ddirch_site.level_JAGS_no.missing.data.r')
source('project_functions/crib_fun.r')

#load mapping file.
map <- readRDS(emp_map_clean.path)

#load an OTU table. Lets analyze at the phylum level today.
otu <- readRDS(emp_phylo.level.list_esv.path)
otu <- otu$phylum

#check that the columns sum to 1.
#okay, most of these do, but one is as low as 0.63.
#This tells me some filtering has already happened. Either excluding some OTUs (not present in 50% of samples) or something else.
#For the sake of example I am moving forward
hist(colSums(otu))
min(colSums(otu))
max(colSums(otu))

#define y data frame, your species matrix.
#Colin is going to model 4 phyla of interest.
y <- otu[rownames(otu) %in% c('Verrucomicrobia','Firmicutes','Actinobacteria','Acidobacteria'),]
y <- t(y) #transpose so columns are species, rows are samples.

#subset the map to only inlucde samples in y.
rownames(map) <- map$`#SampleID` #I hate when columns start with the "#" character.
x <- map[rownames(map) %in% rownames(y),]

#Get colums of x you actually want to use to model.
x <- x[,c('map','mat','map_CV','mat_CV','aridity')]
x <- x[complete.cases(x),]

#drop any observations in y lost to complete casing x.
y <- y[rownames(y) %in% rownames(x),]

#make sure x and y are in the same order.
y <- y[order(rownames(y)),]
x <- x[order(rownames(x)),]

map <- map[rownames(map) %in% rownames(y),]
map <- map[order(rownames(map)),]

#log some stuff. X values with magnitudes in the 100s-1000s  throws things off.
x$map    <- log(x$map)
x$map_CV <- log(x$map_CV)
x$mat_CV <- log(x$mat_CV)

#add an intercept to this model. This is done automatically in betareg, you have to do it by hand here. 
#This is just a vector of 1s as the first column.
if(is.data.frame(x)){intercept <- rep(1, nrow(x))}
if(is.vector(x)){intercept <- rep(1, length(x))}
x <- cbind(intercept,x)

#just use 80 samples so testing doesn't take forever.
#tried to pick rows that varied a lot in the predictor values.
#x <- x[1:300,]
#y <- y[1:300,]

#IMPORTANT. Now you need to define an "other" column in the y matrix. 
#This is important for standardizing dirichlet coefficients.
#it needs to be the first column.
#make sure its not negative or greater than 1.
other <- 1 - rowSums(y)
for(i in 1:length(other)){ #this is just a check line.
  if(other[i] < 0 | other[i] > 1){cat('there is a problem. other is either less than 0 or greater than 1.')}
}
y <- cbind(other, y)

#try crib fun
for(i in 1:ncol(y)){y[,i] <- crib_fun(y[,i])}

#try it out!
#currently the prsf (gelman diagnostics) are too high. 
#This probably will get resolved eithe rrunning the simulation longer or using more data.
#to run the simulation longer, try increasing burnin, sample or both.
model <- site.level_dirlichet_jags(y=y,x_mu = x)
#model <- site.level_dirlichet_jags(y=y,x_mu = x,sample = 3000, burnin = 2000)

#plot it out.
par(mfrow = c(2,3)) #mod this based on number of plots
for(i in 1:ncol(model$predicted)){
  name <- colnames(model$observed)[i]
  plot(model$observed[,i] ~ model$predicted[,i], main = name)
  mod <- lm(model$observed[,i] ~ model$predicted[,i])
  rsq <- summary(mod)$r.squared
  abline(mod, col = 'purple', lwd = 2, lty = 2)
  mtext(paste0('R2 = ',round(rsq,2)), side = 3, line = -2, adj = 0.05)
}
