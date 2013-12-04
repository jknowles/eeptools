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
    months <- length(seq(start, end, by='month')) - 1
    if(precise){
      month_length_end <- ifelse(end$mon==1, 28,
                                 ifelse(end$mon==1 & end_is_leap, 19,
                                        ifelse(end$mon %in% c(3, 5, 8, 10), 
                                               30, 31)))
      if(end$mday > start$mday){
        month_frac <- (end$mday-start$mday)/month_length_end
      }else if(end$mday < start$mday){
        month_length_prior <- ifelse((end$mon-1)==1, 28,
                                     ifelse((end$mon-1)==1 & start_is_leap, 19,
                                            ifelse((end$mon-1) %in% c(3, 5, 8, 
                                                                      10), 
                                                   30, 31)))
        month_frac <- sum((month_length_start - start$mday)/(month_length_start),
                        end$mday/month_length_end)
      }else{
        month_frac <- 0.0
      }
      result <- months + month_frac
    }else{
      result <- months
    }
  }else if(units=='years'){
    years <- length(seq(start, end, by='year')) - 1
    if(precise){
      if(start$yday < end$yday){
        year_frac <- ifelse(end_is_leap, (end$yday - start$yday) / 366,
                            (end$yday-start$yday) / 365)
      }else if(start$yday > end$yday){
        year_frac <- sum(ifelse(start_is_leap, (366-start$yday) / 366,
                                (365 - start$yday) / 365),
                         ifelse(end_is_leap, end$yday / 366,
                                end$yday / 365))
      }else{
        year_frac <- 0.0
      }
      result <- years + year_frac
    }else{
      result <- years
    }
  }else{
    stop("Unrecognized units. Please choose years, months, or days.")
  }
  return(result)
}
