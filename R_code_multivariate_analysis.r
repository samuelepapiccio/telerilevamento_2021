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
