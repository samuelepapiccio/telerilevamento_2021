# My first code in R for remote sensing!

setwd("/Users/samuelepapiccio/lab/")
library(raster)

p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#color change
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
#associo l'immagine alla banda 1 e plotto il risultato
plot(p224r63_2011$B1_sre)
#esercizio: plot band 1 with a predefined colut ramp palette
plot(p224r63_2011$B1_sre,col=cl)

#plotto accanto alla banda del blu anche la banda del verde
par(mfrow=c(1,2)) #1 row 2 columns
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

par(mfrow=c(2,1)) #2 rows 1 column
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the first four bands of landsat
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

#cambio la scala dei colori per le singole bande e le plotto in un quadrato 2x2
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
clg <- colorRampPalette(c('dark green','green','light green'))(100)
clr <- colorRampPalette(c('dark red','red','pink'))(100)
clnir <- colorRampPalette(c('red','orange','yellow'))(100)

par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre,col=clb)
plot(p224r63_2011$B2_sre,col=clg)
plot(p224r63_2011$B3_sre,col=clr)
plot(p224r63_2011$B4_sre,col=clnir)
