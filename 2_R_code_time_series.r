#Time series analisis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

#install.packages("raster")
#install.packages("rasterVis") metodi di visualizzazione per pacchetti raster

library(raster)
library(rasterVis)
setwd("/Users/samuelepapiccio/lab/greenland")

#importo i file lst con la funzione raster land surface temperature
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

#list of files, Pattern = nome in comune dei file
list.files()
rlist<-list.files(pattern="lst")

#apply a function to a list of files, lapply(x,Fun) = x = lista, Fun = funzione da applicare
import<-lapply(rlist,raster)

#Stack crea un unico file con tutti gli elem della lista, utile per il plot
TGr<-stack(import)
plot(TGr)
plotRGB(TGr,1,2,3,stretch="Lin")

#
levelplot(TGr)
levelplot(TGr$lst_2000)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
#rinomino i titoli delle singole immagini= names.att
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#inserisco il titolo= main
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#melt
#creo una lista
meltlist<-list.files(pattern="melt")
#applico la funzione raster alla lista
import_melt<-lapply(meltlist,raster)
melt<-stack(import_melt)

levelplot(melt)

#operazioni tra matrici
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
levelplot(melt_amount)
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)
