##' Remove commas from numeric fields and return them as numerics
##' @description  A shortcut function to strip commas out of numeric fields imported
##' from other software and convert them into numeric vectors that can be operated 
##' on. This assumes decimal point as opposed to decimal comma notation. 
##' @param x a character vector containing numbers with commas that should 
##' be coerced into being numeric.
##' @details This function assumes decimal point notation for numbers. For more 
##' information, see \url{https://en.wikipedia.org/wiki/Decimal_mark#Countries_using_Arabic_numerals_with_decimal_point}.
##' @return A numeric
##' @section Deprecation:
##' Deprecated in eeptools 1.3.0; use \code{readr::parse_number()} instead. This
##' function will be removed in a future release.
##' @author Jared E. Knowles
##' @export
##' @examples
##' input <- c("10,243", "11,212", "7,011", "5443", "500")
##' output <- decomma(input)
##' is.numeric(output)
##' 
decomma <- function(x){
  .Deprecated(msg = paste("decomma() is deprecated as of eeptools 1.3.0 and will be",
                          "removed in a future release.",
                          "Use readr::parse_number() instead."))
  x <- gsub(",", "", x)
  return(as.numeric(x))
}