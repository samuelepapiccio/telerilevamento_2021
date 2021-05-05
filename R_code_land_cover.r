#R_code_land_cover.r

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(ggplot2)
library(RStoolbox)
library(gridExtra)

defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1,g=2,b=3,stretch="lin")
ggRGB(defor1, r=1,g=2,b=3,stretch="lin")

defor2<-brick("defor2.jpg")
plotRGB(defor2, r=1,g=2,b=3,stretch="lin")
ggRGB(defor2, r=1,g=2,b=3,stretch="lin")

par(mfrow=c(1,2))
ggRGB(defor1, r=1,g=2,b=3,stretch="lin")
ggRGB(defor2, r=1,g=2,b=3,stretch="lin")

#multiframe with ggplot2 and gridextra
p1<-ggRGB(defor1, r=1,g=2,b=3,stretch="lin")
p2<-ggRGB(defor2, r=1,g=2,b=3,stretch="lin")
grid.arrange(p1,p2, nrow=2)
