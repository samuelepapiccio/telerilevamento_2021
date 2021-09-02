# R code no2

#set working directory EN

setwd("/Users/samuelepapiccio/lab/EN/")
library(raster)
library(RStoolbox)

# Import first image (single band)
# We will select band 1, but the raster function enables to select other single band


EN01<- raster("EN_0001.png")

# Plot the first image with the preferred Color Ramp Palette

cls<- colorRampPalette(c("red","pink","orange","yellow"))(200)
plot(EN01,col=cls)

# Import the last image and plot it with the previous color ramp palette

EN13<- raster("EN_0013.png")
cls<- colorRampPalette(c("red","pink","orange","yellow"))(200)
plot(EN13,col=cls)

# Make the difference between the two images and plot it

ENdif<- EN01-EN13
plot(ENdif,col=cls)

#plot everything altoghether

par(mfrow=c(3,1))
plot(EN01,col=cls, main="NO2 in January")
plot(EN13,col=cls, main="NO2 in March")
plot(ENdif,col=cls, main="NO2 difference (January - March)")

# Import the whole set

#list of files
rlist<- list.files(pattern="EN")
rlist

import<-lapply(rlist,raster)
import

EN<- stack(import)
plot(EN, col=cls)

# Replicate the plot of images 01 and 13 using the stack

par(mfrow=c(3,1))
plot(EN$EN_0001,col=cls,main="NO2 in January")
plot(EN$EN_0013,col=cls, main="NO2 in March")

# Compute a PCA over the 13 images

ENpca<- rasterPCA(EN)

summary(ENpca$model)

dev.off()
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# Compute the local variability (local SD) of the first PC

PC1sd<- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cls)

