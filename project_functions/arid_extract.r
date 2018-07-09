#' arid_extract.r : extract global aridity index values.
#'The Global Potential Evapo-Transpiration (Global-PET) and Global Aridity Index (Global-Aridity) dataset provides high-resolution global raster climate data related to evapo-transpiration processes and rainfall deficit for potential vegetative growth.
#'From: http://www.cgiar-csi.org/data/global-aridity-and-pet-database
#'Reference: R. J. Zomer, A. Trabucco, D. A. Bossio, L. V. Verchot, Climate change mitigation: A spatial analysis of global land suitability for clean development mechanism afforestation and reforestation. Agric. Ecosyst. Environ. 126, 67–80 (2008). 
#'doi:10.1016/j.agee.2008.01.014
#'
#' @param latitude  #vector of latitude 
#' @param longitude #vector of longitude
#' @param path      #path to where raster is stored. Defaults to a location on pecan2.
#'
#' @return          #returns a vector of aridity index values.
#' @export
#'
#' @examples
arid_extract <- function(latitude, longitude, folder = '/project/talbot-lab-data/spatial_raster_data/Global_Aridity/'){
  #get hostname
  host <- system('hostname', intern=T)
  
  #Change directory if you are on pecan2
  if(host == 'pecan2'){folder <- '/fs/data3/caverill/Global_Aridity/'}
  
  #drop path.
  path <- paste0(folder,'aridity/w001001.adf')
  
  #load raster
  arid <- raster::raster(path)
  
  #extract values
  out <- raster::extract(arid, cbind(longitude,latitude))
  
  #return output
  return(out)
}