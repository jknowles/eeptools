##' A function to replicate the basic plot function for linear models in ggplot2
##' @description This uses ggplot2 to replicate the plot functionality for lm 
##' in ggplot2 and allow themes.
##' @param object a linear model object from \code{\link{lm}}
##' @param which which of the tests do we want to display output from
##' @param mfrow Describes the layout of the resulting function in the plot frames
##' @param parameters to pass through
##' @return A ggplot2 object that mimics the functionality of a plot of linear model.
##' @references Modified from: http://librestats.com/2012/06/11/autoplot-graphical-methods-with-ggplot2/
##' @seealso \code{\link{plot.lm}} which this function mimics
##' @export
##' @import ggplot2
##' @examples
##' # Univariate
##' a <- runif(1000)
##' b <- 7*a+rnorm(1)
##' mymod <- lm(b~a)
##' autoplot(mymod)
##' # Multivariate
##' data(mpg)
##' mymod <- lm(cty~displ + cyl + drv, data=mpg)
##' autoplot(mymod)
##' 
max_mis <- function(x){
  varclass <- class(x)
  suppressWarnings(x <- max(x, na.rm=TRUE))
  if(varclass == "integer"){
    ifelse(!is.finite(x), NA_integer_, x)
  } else if(varclass == "numeric") {
    ifelse(!is.finite(x), NA_real_, x)
  }

}
