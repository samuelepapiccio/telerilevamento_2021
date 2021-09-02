#R_code_land_cover.r
#MAP1 1992
#MAP2 2006

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

#unsupervised classification
#2 classes

d1c<-unsuperClass(defor1,nClasses=2 )
plot(d1c$map)

d2c<-unsuperClass(defor2,nClasses=2 )
plot(d2c$map)

#class1: agriculture
#class2:forest
 
#unsupervised classification
#3classes

d1c3<-unsuperClass(defor1,nClasses=3 )
plot(d1c3$map)

d2c3<-unsuperClass(defor2,nClasses=3 )
plot(d2c3$map) 
######################### MAP 1
#frequencies
freq(d1c$map)
#     value  count
#[1,]     1  34006
#[2,]     2 307286

#sommavalori
s1<-307286+34006

#proporzione
prop1<-freq(d1c$map)/s1
#prop foresta: 0.90036098
#prop agriculture: 0.09963902

######################## MAP2

#frequencies 
freq(d2c$map)

#     value  count
#[1,]     1 163182
#[2,]     2 179544

#sommavalori
s2<-179544+163182

#proporzione
prop2<-freq(d2c$map)/s2

#prop foresta: 0.5238704
#prop agriculture: 0.4761296

#built a dataframe
cover<-c("Forest","Agriculture")
percent_1992<-c(89.83,10.16)
percent_2006<-c(52.06,47.93)

percentages<-data.frame(cover,percent_1992,percent_2006)
percentages

#let's plot them
ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+ geom_bar(stat="identity", fill="blue")
ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+ geom_bar(stat="identity", fill="blue")

#Grid arrange
p1<-ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+ geom_bar(stat="identity", fill="blue")
p2<-ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+ geom_bar(stat="identity", fill="blue")

grid.arrange(p1,p2,nrow=1)

