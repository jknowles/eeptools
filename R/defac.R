##' Convert a factor to a character string safely
##' @description  This is a shortcut function to convert a factor to a character 
##' variable without having to type as.character()
##' @param x a factor to be turned into a character
##' @seealso \code{\link{factor}}, \code{\link{levels}} to understand the R 
##' implementation of factors.
##' @return A character
##' @section Deprecation:
##' Deprecated in eeptools 1.3.0; use \code{as.character()} instead. This
##' function will be removed in a future release.
##' @author Jared E. Knowles
##' @export
##' @examples
##' a <- as.factor(LETTERS)
##' summary(a)
##' b <- defac(a)
##' class(b)
##' 
defac <- function(x){
  .Deprecated(msg = paste("defac() is deprecated as of eeptools 1.3.0 and will be",
                          "removed in a future release. Use as.character() instead."))
  as.character(x)
}