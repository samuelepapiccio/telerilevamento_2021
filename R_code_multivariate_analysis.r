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
