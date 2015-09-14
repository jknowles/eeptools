##' A function to calculate thresholds in a vector.
##' @description This function tells us what the cumulative percentage of a vector 
##' is at a designated cutoff value. This is the inverse of \code{cutoff}
##' @param x a numeric vector, missing values are allowed
##' @param cutoff a user defined numeric value to stop the cutoff specified as 
##' a count
##' @details Calculates the proportion of a numeric vector reached after sorting 
##' the vector in ascending order and stopping at the specified count
##' @return A numeric proportion
##' @author Jared E. Knowles
##' @export
##' @examples
##' # for vector
##' a <- rnorm(100, mean=6, sd=1)
##' thresh(a, 8) #return minimum number of elements to account 70 percent of total
thresh<-function(x, cutoff){
  #x is the column or variable
  #thresh is the number to count to 
  x<-x[order(-x)] # sort vector descending
  xb<-cumsum(x)   # take cumulative sum (order matter)
  xc<-xb/sum(x,na.rm=T) # express proportionally
  xc[cutoff]            # report cumulative percentage at given threshold
}
