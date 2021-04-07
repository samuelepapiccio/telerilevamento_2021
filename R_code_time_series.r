#Time series analisis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

library(raster)
setwd("/Users/samuelepapiccio/lab/greenland")

#importo i file lst con la funzione raster
lst_2000<-raster("lst_2000.tif")
lst_2005<-raster("lst_2005.tif")
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")

#par
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#list of files
list.files()

rlist<-list.files(pattern="lst")

import<-lapply(rlist,raster)

TGr<-stack(import)
plot(TGr)
plotRGB(TGr,1,2,3,stretch="Lin")
