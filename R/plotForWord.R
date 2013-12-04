##' Save a graphic as a Windows MetaFile
##'
##' Convenience function for producing Windows MetaFile graphics for Microsoft documents
##'
##' @param x A stored plot object to be printed
##' @param fn A string for the filename without any file extension
##' @return Nothing. Saves a .wmf with filename \code{fn} in the working directory.
##' @export
plotForWord <- function(x, fn) {
  win.metafile(filename = paste0(fn,".wmf"), width = 12, height = 9, 
               pointsize = 16,
               family=windowsFonts()$serif, restoreConsole = TRUE)
  print(x)
  dev.off()
}