#R_code_variability.r #19/05/2020

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)
library(gridExtra)
library(GGplot2)

sent<-brick("sentinel.png")
# default r=1,g=2,b=3
plotRGB(sent,stretch="lin") # = plotRGB(sent,r=1,g=2,b=3,stretch="lin")
plotRGB(sent,r=2,g=1,b=3,stretch="lin")

nir<- sent$sentinel.1
red<- sent$sentinel.2

ndvi<- (nir-red)/(nir+red)
plot(ndvi)

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) 
plot(ndvi,col=cl)

#focal analysis sd3
ndvi_sd3 <-focal(ndvi, w=matrix(1/9,nrow=3,ncol=3),fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvi_sd3,col=clsd)

#mean ndvi with focal
ndvi_mean3 <-focal(ndvi, w=matrix(1/9,nrow=3,ncol=3),fun=mean)
plot(ndvi_mean3,col=clsd)

#focal analysis sd13
ndvi_sd13 <-focal(ndvi, w=matrix(1/169,nrow=13,ncol=13),fun=sd)
plot(ndvi_sd13,col=clsd)

#focal analysis sd5
ndvi_sd5 <-focal(ndvi, w=matrix(1/25,nrow=5,ncol=5),fun=sd)
plot(ndvi_sd5,col=clsd)

#PCA
sentPCA<- rasterPCA(sent)
plot(sentPCA$map)

summary(sentPCA$map)
#the first PC contai the 69% of variability

