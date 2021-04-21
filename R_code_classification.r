#R Code Classification

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

