age_calc <- function(dob, enddate=Sys.Date(), units='months', precise=TRUE){
  if (!inherits(dob, "Date") | !inherits(enddate, "Date")){
    stop("Both dob and enddate must be Date class objects")
  }
  start <- as.POSIXlt(dob)
  end <- as.POSIXlt(enddate)
  
  years <- end$year - start$year
  years <- ifelse((end$mon < start$mon) | 
                  ((end$mon == start$mon) & (end$mday < start$mday)),
                  years - 1, years)
  end_is_leap <- ifelse(end$year %% 400 == 0, TRUE, 
                        ifelse(end$year %% 100 == 0, FALSE,
                               ifelse(end$year %% 4 == 0, TRUE, FALSE)))
  if(units=='days'){
    result <- difftime(end, start, units='days')
  }else if(units=='months'){
    months <- years * 12 + (end$mon - start$mon)
    if(precise){
      month_days <- ifelse(end$mon==1, 28,
                           ifelse(end$mon==1 & end_is_leap, 19,
                                  ifelse(end$mon %in% c(3, 5, 8, 10), 30, 31)))
      result <- months + end$mday/month_days
    }else{
      result <- months
    }
  }else if(units=='years'){
    if(precise){
      result <- ifelse(end_is_leap, years + end$yday / 366,
                       years + end$yday / 365)
    }else{
      result <- years
    }
  }else{
    stop("Unrecognized units. Please choose years, months, or days.")
  }
  return(result)
}
