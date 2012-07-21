###########################################
# This function tells us how far we have to
# go before reaching a cutoff in a variable
# by sorting the vector, then finding how far 
# to go. Note that the cutoff is expressed in 
# percentage terms
# (Fixed cumulative sum)
############################################

#' Calculates the distance through a numeric vector before a certain proportion is reached
#' by sorting the vector and calculating the cumulative proportion of each element
#'
#'
#' @param x a numeric vector, missing values are allowed
#' @param cutoff a user defined numeric value to stop the cutoff specified 
#'    as a proportion 0 to 1
#' @keywords cumsum
#' @keywords threshold
#' @return An integer for the minimum number of elements necessary to reach cutoff
#' @seealso
#'  \code{\link{cumsum}} which this function uses
#'
#' @export
#' @examples
#' # for vector
#' a<-rnorm(100,mean=6,sd=1)
#' cutoff(a,.7) #return minimum number of elements to account 70 percent of total
#' # for df
#  

cutoff<-function(x,cutoff){
  x<-x[order(-x)]               #sort vector descending
  xb<-cumsum(x)                 # take cumulative sum
  xc<-xb/sum(x,na.rm=T)        #express proportionally
  length(xc[xc<cutoff])         #count number of items until 
  #threshhold is exceeded
}

##########################################
# This function allows us to see what % 
# of observations are found at a given threshold
# again expressed in percentage terms.
############################################

#' Returns the number of elements necessary in a vector to reach some proportion
#' of vector's cumulative sum
#' 
#' @param x a numeric vector, missing values are allowed
#' @param cutoff a user defined numeric value to stop the calculation  
#'  
#' @keywords cumsum
#' @keywords threshold
#' @keywords cutoff
#' @return An integer for the proportion of the vector's sum reached at cutoff
#' @seealso
#'  \code{\link{cutoff}} which this function is related to
#'
#' @export
#' @examples
#' # for vector
#' a<-rnorm(100,mean=6,sd=1)
#' thresh(a,8) #return minimum number of elements to account 70 percent of total
#' # for df
#  

thresh<-function(x,cutoff){
  #x is the column or variable
  #thresh is the number to count to 
  x<-x[order(-x)] # sort vector descending
  xb<-cumsum(x)   # take cumulative sum (order matter)
  xc<-xb/sum(x,na.rm=T) # express proportionally
  xc[cutoff]            # report cumulative percentage at given threshold
}

