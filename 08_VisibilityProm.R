#############   RADIUS PROMINENCE CALCULATION FOR RASTERS

### to apply this script, you need a digital elevation model
### and then edit the writeRaster() and png() function paths to relate to your raster

Y_elev <- raster("output_data/large/Yelev32635.tif")


prom_radius <- function(input, radius) {  #length of neighborhood is defined by desired radius in meters
  #e.g. radius in m will determine the size of passing window / neighborhood 
  
  # check for required packages
  if(!require(raster)){
    install.packages("raster")
    library(raster)
  } 
  if(!require(FSA)){
    install.packages("FSA")
    library(FSA)
  }
  
  # define the function to be run in the neighborhood
  f.prom <- function(x) perc(x,x[length(x)/2],"lt")    # perc is a function from FSA package, 
  # in this case the perc() function calculates percentage of cells lower than the central one 
  # lt, gt, leg, get are the arguments for lower, greater, lower or equal, and greater or equal 
  
  # check input raster has even sides ## WHY IS THAT NEEDED? CAN WE RELAX THIS REQUIREMENT?
  #I thought for moving window statistic a raster much have odd number of pixels to a row and that was it?
  # if(res(input)[1]*dim(input)[1]!=res(input)[2]*dim(input)[2]) {print("Raster has uneven sides")
  # } else { 
  #   print(paste(res(input)[1]*dim(input)[1],"is the length (in m) of both raster sides, all is copacetic"))
  #   
    # define size of neighborhood
    img_res <- res(input)[1]  # how many meters are represented by a raster cell
    window_side <- radius*2   # length of neighborhood side in  meters 
    cells <- as.integer(window_side/img_res)  # number of cells that make the length of neighborhood
    if ((cells %% 2) == 0) {
      print(paste(cells,"is an even number. Neighborhood size must be uneven to calculate. Revise radius"))   # toggle radius in light of image res
    } else {
      r <- raster(input)
      r_prom <- setValues(r, as.matrix(as.integer(focal(input, matrix(1,cells,cells), f.prom, pad = T, padValue = 0))))
      
      writeRaster(r_prom, filename=file.path("output_data/Elh_prom250m.tiff"), format = "GTiff",
                  datatype= "INT2S", overwrite = TRUE, NAflag = 9999)
      print("Working on the plot now")
      
      png("figures/Yamprom250.png", )
      par(mfrow=c(1,2))
      plot(input, main = "This is the original raster \n Yambol/Turkey 23-30 m DEM")
      plot(r_prom, main =  paste0("Prominence within the radius \n
                                  of ", radius, "m from any spot within the DEM")) # HOW CAN I PRINT THE INPUT RADIUS?
      dev.off()
    }
  } 
#} # this parenthesis relates to size evenness, which I removed

################################## RUN THE FUNCTION
e1 <- crop(elev, extent(415725, 500181, 4608601, 4700000)) # Elhovo
mapview(e1)

t1 <- system.time(prom_radius(e1, 250))
# the script errored out at png() due to wrong specification of path, but r-prom exists
# Timing stopped at: 232.4 4.46 455.4



################################# VALIDATION
prom <- raster("output_data/Elh_prom250m.tiff")
prom <- raster("output_data/Yam_prom250m.tiff")

library(mapview)
mapview(prom)
elev 

# https://stackoverflow.com/questions/72027179/terra-raster-values-lost-after-projection

crs(prom)
res(prom)
extent(prom) <- extent(elev)
