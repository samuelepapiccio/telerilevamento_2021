#R code complete - Telerilevamento Geoecologico

#-----------------------------------------------

#Summary:

# 1. R code remote sensing first code
# 2. R code Time series Greenland
# 3. R code Copernicus
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation index
# 9. R code land cover
# 10. R code variability
# 11. R code spectral signatures

#-----------------------------------------------

# 1. remote sensing first code

# My first code in R for remote sensing!

#set working directory and load "raster" package
setwd("/Users/samuelepapiccio/lab/")
library(raster)

#create a rasterBrick object
p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011

#plot the result
plot(p224r63_2011)

#change colour ramp and plot the result
cl <- colorRampPalette(c('light blue','blue','green'))(100) 
plot(p224r63_2011, col=cl)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#clean the current graph
dev.off()
#combine the image at the first band and plot the result
plot(p224r63_2011$B1_sre)
#plot band 1 with a predefined colut ramp palette
plot(p224r63_2011$B1_sre,col=cl)

#plot the images of the first two bands of landsat in the same window
#method 1
par(mfrow=c(1,2)) #1 row 2 columns
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#method 2
par(mfrow=c(2,1)) #2 rows 1 column
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the images of the first four bands of landsat in the same window
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#a quadrat of bands
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#change the color ramp palette and plot the images in a 2x2 square
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
clg <- colorRampPalette(c('dark green','green','light green'))(100)
clr <- colorRampPalette(c('dark red','red','pink'))(100)
clnir <- colorRampPalette(c('red','orange','yellow'))(100)

par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre,col=clb)
plot(p224r63_2011$B2_sre,col=clg)
plot(p224r63_2011$B3_sre,col=clr)
plot(p224r63_2011$B4_sre,col=clnir)

#RGB, let's try various combination
plotRGB(p224r63_2011, r=1, g=2, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#mount a 2x2 multiframe
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=1, g=2, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#export the results in PDF format
pdf("my_first_R_PDF.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=1, g=2, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#stretch Histogram
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=1, g=2, b=3, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="hist")

#par natural colour, false colour and false colour with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#install and load "RStoolbox" package
install.packages("RStoolbox")
library(RStoolbox)

#Multitemporal set

p224r63_1988 <-brick("p224r63_1988_masked.grd")
p224r63_1988

plot(p224r63_1988)
plotRGB(p224r63_1988, r=1, g=2, b=3, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#create a multiframe 2x2 with the images of 1988 and 2011 with linear and histrogram stretching and export it in PDF format
pdf("multitemp_PDF.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
dev.off()

#-----------------------------------------------------------------------------------

# 2. Time series Greenland

#Time series analisis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

#install.packages("raster")
#install.packages("rasterVis")

#set working directory and load "raster" and "rasterVis" packages
library(raster)
library(rasterVis)
setwd("/Users/samuelepapiccio/lab/greenland")

#import the files "lst" with the raster function
lst_2000<-raster("lst_2000.tif")
lst_2005<-raster("lst_2005.tif")
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")

#create a multiframe 2x2 with the four images
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# create a list of files and insert on it all the file in the wd who have "lst" in the name
list.files()
rlist<-list.files(pattern="lst")

#apply raster function to a list of files
import<-lapply(rlist,raster)

TGr<-stack(import)
plot(TGr)
plotRGB(TGr,1,2,3,stretch="Lin")

levelplot(TGr)
levelplot(TGr$lst_2000)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
#rinomino i titoli delle singole immagini
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#inserisco il titolo
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#melt
#creo una lista
meltlist<-list.files(pattern="melt")
#applico la funzione raster alla lista
import_melt<-lapply(meltlist,raster)
melt<-stack(import_melt)

levelplot(melt)

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
levelplot(melt_amount)
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)

#-----------------------------------------------------------------

# 3. R code Copernicus

#R code copernicus
#visualizing copernicus data

#install.packages("ncdf4")
library(raster)
library(ncdf4)

setwd("/Users/samuelepapiccio/lab/")

#Burned Area
burnedarea<-raster("c_gls_BA300_202009200000_GLOBE_PROBAV_V1.1.1.nc")
cl<-colorRampPalette(c("black","red","pink"))(100)
plot(burnedarea,col=cl)

#aggregate files, ricampionamento bi-lineare
ba_res<-aggregate(burnedarea,fact=25)
plot(ba_res,col=cl)

#-------------------------------------------------------------

 # 4. R code knitr
 
 #R_code_knitr.r

setwd("/Users/samuelepapiccio/lab/")
library(knitr)

#
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
 
#-------------------------------------------------------------

# 5. R code multivariate analysis

#R_code_multivariate_analysis.r

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)

#
p224r63_2011<-brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

#plottiamo i valori della banda 1 contro i valori della banda 2
#pch:cambio la forma dei punti, cex:cambio la dimensione dei punti
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red",pch=19,cex=2)

#plottiamo tutte le correlazioni possibili con la funzione pairs
pairs(p224r63_2011)


#aggregate cells: resampling (ricampionamento)
p224r63_2011res<-aggregate(p224r63_2011,fact=10,fun=mean)
par(mfrow=c(2,1))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="lin")
plotRGB(p224r63_2011res,r=4,g=3,b=2,stretch="lin")

#RasterPCA: principal component analysis for rasters
p224r63_2011res_PCA<-rasterPCA(p224r63_2011res)

summary(p224r63_2011res_PCA$model)
plot(p224r63_2011res_PCA$map)
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#-------------------------------------------------------------

# 6. R code classification

#R Code Classification

#set working directory and load packages "raster" and "RStoolbox"
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

#Grand Canyon
#https://landsat.visibleearth.nasa.gov/view.php?id=80948

#setwd("/Users/samuelepapiccio/lab/")
#library(raster)
#library(RStoolbox)

#function brick: create a raster brick object
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc,1,2,3,stretch="lin")
plotRGB(gc,1,2,3,stretch="hist")

#Unsupervised Classification with 2 classes 
gcc2<-unsuperClass(gc,nClasses=2)
plot(gcc2$map)

#Unsupervised Classification with 4 classes
gcc4<-unsuperClass(gc,nClasses=4)
plot(gcc4$map)

#-------------------------------------------------------------

# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#-------------------------------------------------------------

# 8. R code vegetation index

#R_code_vegetation_index.r

setwd("/Users/samuelepapiccio/lab/")
library(raster)
library(RStoolbox)
library(rasterdiv) #for the wordlwide NDVI
library(rasterVis)

#function brick
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

#wordlwide NDVI
plot(copNDVI)

#Eliniminiamo l'acqua
copNDVI<-raster::reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
levelplot(copNDVI)

#-------------------------------------------------------------

# 9. R code land cover

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

#-------------------------------------------------------------

# 10. R code variability

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

#-------------------------------------------------------------

# 11. R code spectral signatures

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

