# My first code in R for remote sensing!

setwd("/Users/samuelepapiccio/lab/")
library(raster)

p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)
