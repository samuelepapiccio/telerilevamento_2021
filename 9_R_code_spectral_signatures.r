# Rcode_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)

setwd("/Users/samuelepapiccio/lab/")


defor2<-brick("defor2.jpg")

plotRGB(defor2,r=1,g=2,b=3, stretch="lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="hist")

#spectral signatures defor2
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="magenta")

#results:
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 587.5 220.5 184857      197        8       15
#1 561.5 216.5 187699       72       91      123

#define the columns of the dataset:
band<- c(1,2,3)
forest<- c(197,8,15)
water<-c(72,91,139)

#create the dataframe

spectrals<-data.frame(band,forest,water)

#plot the spectrals signatures

ggplot(spectrals, aes(x=band))+
 geom_line(aes(y=forest), color="green")+
 geom_line(aes(y=water), color="blue")+
 labs(x="wavelength",y="reflectance")
 
 ###################### Multitemporal
 
 defor1<-brick("defor1.jpg")
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")

#spectral signatures defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="magenta")

#results defor1:
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 70.5 333.5 102887     223       14       35
#1 78.5 381.5 68623      230       24       44
#1 105.5 390.5 62224     219       26       53
#1 97.5 369.5 77210      216       13       33
#1 101.5 333.5 102918    233       17       38

#results defor2:
     x     y  cell defor2.1 defor2.2 defor2.3
#1 76.5 342.5 96872      180      166      157
#1 74.5 374.5 73926      185       90       94
#1 93.5 381.5 68926      195        7       21
#1 108.5 362.5 82564     211      106      136
#1 99.5 339.5 99046      115       80       76

 
 #define the columns of the dataset:
band<- c(1,2,3)
time1<- c(223,14,35)
time1p2<-c(230,24,44)
time2<-c(180,166,157)
time2p2<-c(185,90,94)

#create the dataframe

spectralst<-data.frame(band,time1,time2)
ggplot(spectrals, aes(x=band))+
 geom_line(aes(y=time1), color="red",linetype="dotted")+
 geom_line(aes(y=time1p2), color="red",linetype="dotted")+
 geom_line(aes(y=time2), color="blue",linetype="dotted")+
 geom_line(aes(y=time2p2), color="blue",linetype="dotted")+
 labs(x="band",y="reflectance")

#image from earth observatory

eo<-brick("eo.jpg")
plotRGB(eo,1,2,3, stretch="hist")

click(eo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="magenta")

#results:
       x      y     cell eo.1 eo.2 eo.3
#1 3601.5 2380.5 22743242    1   22   51
#1 2615.5 2934.5 19481966  176  152  124

#define the column of dataset:
band<- c(1,2,3)
water<- c(1,22,51)
land<-c(176,152,124)

#plot the spectrals signatures
spectralsg<-data.frame(band,water,land)
ggplot(spectrals, aes(x=band))+
 geom_line(aes(y=water), color="blue")+
 geom_line(aes(y=land), color="green")+
 labs(x="band",y="reflectance")
