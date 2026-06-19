##' Function to add leading zeroes to maintain fixed width.
##' @description  This function ensures that fixed width data is the right 
##' length by padding zeroes to the front of values. This is a common problem 
##' with fixed width data after importing into R as non-character type.
##' @param x a vector of numeric data that should be fixed width but is 
##' missing leading zeroes.
##' @param digits an integer representing the desired width of \code{x}
##' @return A character vector of length \code{digits}
##' @details If \code{x} contains negative values, \code{digits} is widened by 1 for
##' the entire vector so that all values share a uniform total width, with the negative
##' sign occupying one character position. For example,
##' \code{leading_zero(c(-5, 42), digits = 2)} returns \code{c("-05", "042")} — both
##' width 3. Mixed-sign vectors are supported but produce width \code{digits + 1}
##' for all elements.
##' @author Jason P. Becker
##' @author Jared E. Knowles
##' @export
##' @examples
##' a <- seq(1,10)
##' a <- leading_zero(a, digits = 3)
##' a
leading_zero <- function(x, digits = 2){
  stopifnot(any(c("numeric", "integer") %in% class(x)))
  if(any(x < 0)){
    digits <- digits + 1
  }
  if(digits < 0){
    warning("Digits < 0 does not make sense, defaulting to 0")
    digits <- 0
  }
  return(formatC(x, digits = digits-1, format = "d", flag = "0"))
}
