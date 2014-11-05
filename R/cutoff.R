##' A function to calculate thresholds in a vector.
##' @description This function tells us how far we have to
##' go before reaching a cutoff in a variable
##' by sorting the vector, then finding how far 
##' to go. Note that the cutoff is expressed in 
##' percentage terms (fixed cumulative sum)
##' @param x a numeric vector, missing values are allowed
##' @param cutoff a user defined numeric value to stop the cutoff specified as 
##' a proportion 0 to 1
##' @details Calculates the distance through a numeric vector before a certain 
##' proportion is reached by sorting the vector and calculating the cumulative proportion of each element
##' @return An integer for the minimum number of elements necessary to reach cutoff
##' @author Jared E. Knowles
##' @export
##' @examples
##' # for vector
##' a <- rnorm(100, mean=6, sd=1)
##' cutoff(a, .7) #return minimum number of elements to account 70 percent of total
##' 
cutoff <- function(x,cutoff){
  x <- x[order(-x)]
  xb <- cumsum(x)
  xc <- xb/sum(x, na.rm=T)
  length(xc[xc < cutoff])
}
