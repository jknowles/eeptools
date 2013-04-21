library(roxygen2)

roclet <- rd_roclet()
roc_out(roclet, "R/plotForWord.R", ".")
roc_out(roclet, "R/mapfunctions.R", ".")
roc_out(roclet, "R/cleanTex.R", ".")
