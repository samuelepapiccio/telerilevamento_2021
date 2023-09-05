#R_code_knitr.r

setwd("/Users/samuelepapiccio/lab/")
library(knitr)

#crea un report  nome codice                                                    nome pacchetto     
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
