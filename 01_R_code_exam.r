#R code exam
#DEFORESATION IN RONDONIA(BRAZIL)

#Imposto la working directory
setwd("/Users/samuelepapiccio/lab/esame/")
#Carico su R alcuni pacchetti che mi serviranno per l'analisi
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

#Carico le immagini tramite la funzione "brick" 
#(che crea un file raster multibanda) 
ron00<-brick("rond00.jpeg")
ron06<-brick("rond06.jpeg")
#Visualizzo i risultati in una sola finestra
par(mfrow=c(2,1))
plotRGB(ron00)
plotRGB(ron06)
#-------------------------Classification-----------------------

#eseguo una "Unsupervised Classification" 
#impostando il numero di classi =2(Foresta,Agricoltura) 
#class Rondonia 2000
ron00cl<-unsuperClass(ron00,nClasses=2)
#class Rondonia 2006
ron06cl<-unsuperClass(ron06,nClasses=2)

#Visualizzo i risultati in una sola finestra
#Cambio la palette dei colori
cl <- colorRampPalette(c('brown','dark green'))(100)
par(mfrow=c(1,2))
plot(ron00cl$map,col=cl)
plot(ron06cl$map,col=cl)

#Calcolo della frequenza delle varie classi
#Anno 2000-------------------------
freq(ron00cl$map)
#   value        count
#   forest       2466666
#   agricolture  965382
sum00<-2466666+965382
#proportions00
prop00<-freq(ron00cl$map)/sum00
prop00
#                %             
#forest        71.87
#agricolture   28.13
#Anno 2006------------------------
freq(ron06cl$map) 
#   value        count
#   forest       1260489
#   agricolture  2171559
sum06<-1260489+2171559
#proportions06
prop06<-freq(ron06cl$map)/sum06
#                %             
#forest        36.73  
#agricolture   63.27  

#-------Costruzione di un data frame--------
cover<-c("Forest","Agricolture")
percent_2000<-c(71.87,28.13)
percent_2006<-c(36.73,63.27)
percentages<-data.frame(copertura,percent_2000,percent_2006)

#Visualizziamo i risultati con ggplot 
ggplot(percentages,aes(x=cover,y=percent_2000,color=cover))+ geom_bar(stat="identity", fill="red")
ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+ geom_bar(stat="identity", fill="blue")

#Visualizzo entrambi i grafici in un'unica finestra con grid arrange
#Grid arrange
p1<-ggplot(percentages,aes(x=cover,y=percent_2000,color=cover))+ geom_bar(stat="identity", fill="dark green")
p2<-ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+ geom_bar(stat="identity", fill="dark green")
grid.arrange(p1,p2,nrow=1)
