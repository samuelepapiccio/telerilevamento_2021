#R_code_knitr.r

setwd("/Users/samuelepapiccio/lab/")
library(knitr)

#
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
