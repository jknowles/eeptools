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
age_calc <- function(dob, enddate=Sys.Date(), units='months', precise=TRUE){
  if (!inherits(dob, "Date") | !inherits(enddate, "Date")){
    stop("Both dob and enddate must be Date class objects")
  }
  start <- as.POSIXlt(dob)
  end <- as.POSIXlt(enddate)
  if(precise){
    start_is_leap <- ifelse(start$year %% 400 == 0, TRUE, 
                            ifelse(start$year %% 100 == 0, FALSE,
                                   ifelse(start$year %% 4 == 0, TRUE, FALSE)))
    end_is_leap <- ifelse(end$year %% 400 == 0, TRUE, 
                          ifelse(end$year %% 100 == 0, FALSE,
                                 ifelse(end$year %% 4 == 0, TRUE, FALSE)))
  }
  if(units=='days'){
    result <- difftime(end, start, units='days')
  }else if(units=='months'){
    months <- sapply(mapply(seq, as.POSIXct(start), as.POSIXct(end), 
                            by='months', SIMPLIFY=FALSE), 
                     length) - 1
    # length(seq(start, end, by='month')) - 1
    if(precise){
      month_length_end <- ifelse(end$mon==1, 28,
                                 ifelse(end$mon==1 & end_is_leap, 29,
                                        ifelse(end$mon %in% c(3, 5, 8, 10), 
                                               30, 31)))
      month_length_prior <- ifelse((end$mon-1)==1, 28,
                                   ifelse((end$mon-1)==1 & start_is_leap, 29,
                                          ifelse((end$mon-1) %in% c(3, 5, 8, 
                                                                    10), 
                                                 30, 31)))
      month_frac <- ifelse(end$mday > start$mday,
                           (end$mday-start$mday)/month_length_end,
                           ifelse(end$mday < start$mday, 
                                  (month_length_prior - start$mday) / 
                                    month_length_prior + 
                                    end$mday/month_length_end, 0.0))
      result <- months + month_frac
    }else{
      result <- months
    }
  }else if(units=='years'){
    years <- sapply(mapply(seq, as.POSIXct(start), as.POSIXct(end), 
                           by='years', SIMPLIFY=FALSE), 
                    length) - 1
    if(precise){
      start_length <- ifelse(start_is_leap, 366, 365)
      end_length <- ifelse(end_is_leap, 366, 365)
      start_day <- ifelse(start_is_leap & start$yday >= 60,
                          start$yday - 1,
                          start$yday)
      end_day <- ifelse(end_is_leap & end$yday >=60,
                        end$yday - 1,
                        end$yday)
      year_frac <- ifelse(start_day < end_day,
                          (end_day - start_day)/end_length,
                          ifelse(start_day > end_day, 
                                 (start_length-start_day) / start_length +
                                   end_day / end_length, 0.0))
      result <- years + year_frac
    }else{
      result <- years
    }
  }else{
    stop("Unrecognized units. Please choose years, months, or days.")
  }
  return(result)
}
