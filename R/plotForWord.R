##' Save a graphic as a Windows MetaFile
##'
##' Convenience function for producing Windows MetaFile graphics for Microsoft documents
##'
##' @param x A stored plot object to be printed
##' @param fn A string for the filename without any file extension
##' @return Nothing. Saves a .wmf with filename \code{fn} in the working directory.
##' @note Works with \code{\link{ggplot}} objects in the \code{\link{ggplot2}} package. Saves plots to
##' the working directory.
##' @details Uses parameters designed for import into Word and PowerPoint documents. These are a width of 12, 
##' height of 9, poitnsize of 16, and using Windows serif fonts. 
##' @export
##' @examples
##' \dontrun{
##' data(cars)
##' library(ggplot2) # works with ggplot objects
##' myplot <- qplot(speed~dist, data=cars)
##' plotForWord(myplot, "speedanddistance")
##' }
plotForWord <- function(x, fn) {
  dev.new("windows", filename = paste0(fn,".wmf"), width = 12, height = 9, 
          pointsize = 16,
          family=windowsFonts()$serif, restoreConsole = TRUE)
  print(x)
  dev.off()
}