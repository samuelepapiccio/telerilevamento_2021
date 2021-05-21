#R_code_variability.r #19/05/2020

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)
library(gridExtra) #for plotting ggplot togheder
library(ggplot2)# for ggplotplotting
library(viridis) #for ggplot colouring

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
sentpca<- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$map)
#the first PC contai the 67.36% of original information

############################
pc1 <- sentpca$map$PC1

pc1sd5 <-focal(pc1, w=matrix(1/25,nrow=5,ncol=5),fun=sd)
#plot(pc1sd5,col=clsd)

pc1_sd7 <-focal(pc1, w=matrix(1/49,nrow=7,ncol=7),fun=sd)
#plot(pc1_sd7,col=clsd)

#
source("source_test_lezione.r")



ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")


p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")
 
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")

grid.arrange(p1, p2, p3, nrow = 1)
