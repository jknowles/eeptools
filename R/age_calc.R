age_calc <- function(dob, enddate=Sys.time(), units='months'){
  # dob is expected to be a vector, likely a column in a data.frame
  # enddate is expected to be a set point in time and is an atomic vector.
  # This could be refactored to allow for vector enddates if the interested is
  # in calculating age at the time of a measurement which is different for each
  # observation.
  if (!inherits(dob, "Date") | !inherits(enddate, "Date"))
    stop("Both dob and enddate must be Date class objects")
  start <- as.POSIXlt(dob)
  end <- as.POSIXlt(enddate)
  
  years <- end$year - start$year
  if(units=='years'){
    result <- ifelse((end$mon < start$mon) | 
                      ((end$mon == start$mon) & (end$mday < start$mday)),
                      years - 1, years)    
  }else if(units=='months'){
    months <- (years-1) * 12
    result <- months + start$mon
  }else if(units=='days'){
    result <- difftime(end, start, units='days')
  }else{
    stop("Unrecognized units. Please choose years, months, or days.")
  }
  return(result)
}
