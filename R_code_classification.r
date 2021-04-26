#R Code Classification

#set working directory and load packages "raster" and "RStoolbox"
setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)

#function brick: create a raster brick object
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#Visualize RGB levels
plotRGB(so,1,2,3,stretch="lin")

#Unsupervised Classification
soc<-unsuperClass(so,nClasses=3)
plot(soc$map)

#Unsupervised Classification with 20 classes
soc20<-unsuperClass(so,nClasses=20)
plot(soc20$map)

#Download and image from solar orbiter
sun<-brick("sun.png")
suncl<-unsuperClass(sun,nClasses=3)
plot(suncl$map)

#Grand Canyon
#https://landsat.visibleearth.nasa.gov/view.php?id=80948

#setwd("/Users/samuelepapiccio/lab/")
#library(raster)
#library(RStoolbox)

#function brick: create a raster brick object
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc,1,2,3,stretch="lin")
plotRGB(gc,1,2,3,stretch="hist")

#Unsupervised Classification with 2 classes
gcc2<-unsuperClass(gc,nClasses=2)
plot(gcc2$map)

#Unsupervised Classification with 4 classes
gcc4<-unsuperClass(gc,nClasses=4)
plot(gcc4$map)
