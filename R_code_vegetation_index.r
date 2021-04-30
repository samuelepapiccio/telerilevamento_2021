#R_code_vegetation_index.r

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)


#
defor1<- brick("defor1.jpg")
defor2<- brick("defor2.jpg")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#different vegetation idex
#time 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)

#new ramp palette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1,col=cl)
plot(dvi1, col=cl, main="DVI at time 1")

#time 2
dvi2 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi2)

#new ramp palette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2,col=cl)
plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#difference dvi
difdvi<-dvi1-dvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi,col=cld)

par(mfrow=c(3,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
plot(difdvi,col=cld,main="Difference DVI")

#normalized dvi
#(NIR-RED)/(NIR+RED)
#time 1
#ndvi1<-(defor1$defor1.1 - defor1$defor1.2)/(defor1$defor1.1 + defor1$defor1.2)
ndvi1<-(dvi1)/(defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1,col=cl)

#time 2
ndvi2<-(defor2$defor2.1 - defor2$defor2.2)/(defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2,col=cl)

par(mfrow=c(2,1))
plot(ndvi1, col=cl, main="NDVI at time 1")
plot(ndvi2, col=cl, main="NDVI at time 2")

#Spectral indices
#library(RStoolbox)
#time 1
vi1<- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1,col=cl)

#time 2
vi2<- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2,col=cl)

#difference ndvi
difndvi<-ndvi1-ndvi2
plot(difndvi,col=cld)


