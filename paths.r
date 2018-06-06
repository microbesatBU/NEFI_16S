#This script stores all of the paths internal to this project (within the project directory)
#Also stores all data paths, stored in a data directory.
#The data directory will change depend on where you are running this code.
#depends on the package 'here' which defines your local path when an Rstudio project is loaded.
#Here essentially just prints your working directory, which is the project repo.
proj.dir <- paste0(here(),'/')


#data paths. Colin has set this to a directory on pecan2, but will be changed to something on SCC.
#You will need to change this if you want to work with the data associated with this project on your local machine.
#Someone smarter than colin probably has a better solution for this.
#I save data objects as ".rds" files, which is just an R data storage type.
#.rds files can be loaded with "readRDS()", and saved with "saveRDS(R_object, path/to/file.rds)
data.dir <- '/fs/data3/caverill/NEFI_16S_data/'

#raw EMP deblurred ESV table and mapping files.
emp_esv.path <- paste0(data.dir,'emp_deblur_150bp.release1.biom')
emp_map.path <- paste0(data.dir,'emp_qiime_mapping_release1.tsv')