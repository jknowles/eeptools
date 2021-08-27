##' Function to calculate age from date of birth.
##' @description This function calculates age in days, months, or years from a 
##' date of birth to another arbitrary date. This returns a numeric vector in 
##' the specified units.
##' @param dob a vector of class \code{Date} representing the date of birth/start date
##' @param enddate a vector of class Date representing the when the observation's 
##' age is of interest, defaults to current date.
##' @param units character, which units of age should be calculated? allowed values are 
##' days, months, and years
##' @param precise logical indicating whether or not to calculate with leap year 
##' and leap second precision
##' @return A numeric vector of ages the same length as the dob vector
##' @source This function was developed in part from this response on the R-Help mailing list.
##' @seealso See also \code{\link{difftime}} which this function uses and mimics 
##' some functionality but at higher unit levels.
##' @author Jason P. Becker
##' @export
##' @examples
##' a <- as.Date(seq(as.POSIXct('1987-05-29 018:07:00'), len=26, by="21 day"))
##' b <- as.Date(seq(as.POSIXct('2002-05-29 018:07:00'), len=26, by="21 day"))
##' 
##' age <- age_calc(a, units='years')
##' age
##' age <- age_calc(a, units='months')
##' age
##' age <- age_calc(a, as.Date('2005-09-01'))
##' age
age_calc <- function(dob, enddate=Sys.Date(), units='months', precise=TRUE){
  units = match.arg(units, 
                    c('days', 'months', 'years'))
  
  if (!is.logical(precise) & length(precise != 1)){
    stop("`precise` must be a logical of length 1.")
  }
  
  retval <- numeric(length(dob))
  
  is_dob_miss <- is.na(dob)
  
  retval[is_dob_miss] <- NA_real_
  
  
  retval[!is_dob_miss] <- 
    .age_calc_nomiss(dob[!is_dob_miss], 
                         enddate = enddate, 
                         units = units, 
                         precise = precise)
  
  retval
}

.age_calc_nomiss <- function(dob, enddate=Sys.Date(), units='months', precise=TRUE){
  if (!inherits(dob, "Date") | !inherits(enddate, "Date")) {
    stop("Both dob and enddate must be Date class objects")
  }
  
  if (any(vapply(enddate < dob, isTRUE, logical(1)))) {
    stop("End date must be a date after date of birth")
  }
  
  start <- as.POSIXlt(dob)
  end <- as.POSIXlt(enddate)
  if (precise) {
    start_is_leap <- .is_leap_year(start$year)
    end_is_leap <- .is_leap_year(end$year)
  }
  
  switch(
    units, 
    'days' = 
      {
        difftime(end, start, units = 'days')
      }, 
    'months' = 
      {
        months <- mapply(seq, as.POSIXct(start), 
                         as.POSIXct(end), 
                         MoreArgs = list(by = 'months'), 
                         SIMPLIFY = FALSE)
        months <- vapply(months, 
                         length, 
                         numeric(1)) - 1
        
        if (precise) {
          month_length_end <- .day_in_month(end$mon, 
                                            end_is_leap)
          month_length_prior <- .day_in_month(end$mon, 
                                              start_is_leap)
          
          eg <- end$mday > start$mday
          el <- end$mday < start$mday
          month_frac <- rep(0.0, length(end$mday))
          month_frac[eg] <- (end$mday[eg] - start$mday[eg]) / month_length_end[eg]
          month_frac[el] <- (month_length_prior[el] - start$mday[el]) / month_length_prior[el] + end$mday[el]/month_length_end[el]
          
          months + month_frac
        }else{
          months
        }
      }, 
    'years' = 
      {
        years <- mapply(seq, 
                        as.POSIXct(start), 
                        as.POSIXct(end), 
                        MoreArgs = list('years'), 
                        SIMPLIFY = FALSE)
        years <- vapply(years, 
                        length, 
                        numeric(1)) - 1
        if (precise) {
          start_length <- 365 + start_is_leap
          end_length <- 365 + end_is_leap 
          
          start_day <- start$yday - (start_is_leap & start$yday >= 60)
          end_day <- end$yday - (end_is_leap & end$yday >= 60)
          
          sl <- start_day < end_day
          sg <- start_day > end_day
          year_frac <- rep(0.0, start_day)
          year_frac[sl] <- (end_day[sl] - start_day[sl])/end_length[sl]
          year_frac[sg] <- (start_length[sg] - start_day[sg]) / start_length[sg] + end_day[sg] / end_length[sg]
          
          years + year_frac
        }else{
          years
        }
      }, 
    stop("Unrecognized units. Please choose years, months, or days.")
  )
}

.is_leap_year <- function(year){
  year %% 400 == 0 &
    year %% 100 != 0 &
    year %% 4 == 0
}

.day_in_month <- function(month, is_leap){
  retval <- rep(31, length(month))
  
  retval[month == 1 & is_leap] <- 29
  retval[month == 1 & !is_leap] <- 28
  retval[month %in% c(3, 5, 8, 10)] <- 30
  
  retval
}
