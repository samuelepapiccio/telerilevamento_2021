#R code copernicus
#visualizing copernicus data

#install.packages("ncdf4") pacchetto per visualizzare dati copernicus
library(raster)
library(ncdf4)

setwd("/Users/samuelepapiccio/lab/")

#Burned Area
burnedarea<-raster("c_gls_BA300_202009200000_GLOBE_PROBAV_V1.1.1.nc")
cl<-colorRampPalette(c("black","red","pink"))(100)
plot(burnedarea,col=cl)

#aggregate files, resamplig bi-linear
ba_res<-aggregate(burnedarea,fact=25)
plot(ba_res,col=cl)
