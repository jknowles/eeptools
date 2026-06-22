##' Remove Unwanted LaTeX files after building document
##'
##' Convenience function for cleaning up your directory after running pdflatex 
##'
##' @param fn a filename for your .Rnw file
##' @param keepPDF Logical. Should function save PDF files with filename \code{fn}. 
##' Default is TRUE.
##' @param keepRnw Logical. Should function save Rnw files with filename \code{fn}. 
##' Default is TRUE.
##' @param keepRproj Logical. Should function save .Rproj files with filename \code{fn}. 
##' Default is TRUE.
##' @return Nothing. All files except the .tex, .pdf and .Rnw are removed from your directory.
##' @section Deprecation:
##' Deprecated in eeptools 1.3.0. Modern knitr/Quarto workflows manage their own
##' build artifacts, so this Sweave-era helper is no longer needed. It will be
##' removed in a future release.
##' @export
cleanTex <- function(fn, keepPDF = TRUE, keepRnw = TRUE, keepRproj = TRUE){
  .Deprecated(msg = paste("cleanTex() is deprecated as of eeptools 1.3.0 and will be",
                          "removed in a future release. Modern knitr/Quarto",
                          "workflows manage their own build artifacts."))
  a <- list.files(pattern=fn)
  save <- a[grep(".tex",a)]
  if(keepPDF==TRUE){  
    save <- append(save,a[grep(".pdf",a)])
  }
  else if(keepPDF==FALSE){
    save <- save
  }
  if(keepRnw==TRUE){
    save <- append(save, a[grep(".Rnw",a)])
    save <- append(save, a[grep(".rnw",a)])
  }
  else if(keepRnw==FALSE){
    save <- save
  }
  if(keepRproj==TRUE){
    save <- append(save, a[grep(".Rproj",a)])
    save <- append(save, a[grep(".rproj",a)])
  }
  else if(keepRproj==FALSE){
    save <- save
  }
  rm <- setdiff(a,save)
  file.remove(rm)
}
