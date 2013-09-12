moves_calc <- function(df, 
                       enrollby,
                       exitby,
                       gap=14,
                       sid='sid', 
                       schid='schid',
                       enroll_date='enroll_date',
                       exit_date='exit_date'){
  # df is a data.frame that minimally contains a student ID (default 'sasid'),
  # a school ID (default 'schno'), and two dates an enrollment date and an 
  # exit date for each sid-schid combination.

  # Load required packages
  if("data.table" %in% rownames(installed.packages()) == FALSE){
    install.packages("data.table")
  } 
  require(data.table)
  # Type checking inputs.
  if (!inherits(df[[enroll_date]], "Date") | !inherits(df[[exit_date]], "Date"))
      stop("Both enroll_date and exit_date must be Date objects")
  # Check if enrollby and exitby arguments are supplied. When they aren't,
  # assign them to default dates of -09-15 and -06-01 of the min and max year.
  # If they are assigned but are not date objects then 
  if(missing(enrollby)){
    enrollby <- as.Date(paste(year(min(df[[enroll_date]], na.rm=TRUE)),
                              '-09-15', sep=''), format='%Y-%m-%d')
  }else{
    if(is.na(as.Date(enrollby, format="%Y-%m-%d"))){
      enrollby <- as.Date(paste(year(min(df[[enroll_date]], na.rm=TRUE)),
                                '-09-15', sep=''), format='%Y-%m-%d')
      warning(paste("enrollby must be a string with format %Y-%m-%d,",
                    "defaulting to", 
                    enrollby, sep=' '))
    }else{
      enrollby <- as.Date(enrollby, format="%Y-%m-%d")
    }
  }
  if(missing(exitby)){
    exitby <- as.Date(paste(year(max(df[[exit_date]], na.rm=TRUE)),
                            '-06-01', sep=''), format='%Y-%m-%d')
  }else{
    if(is.na(as.Date(exitby, format="%Y-%m-%d"))){
      exitby <- as.Date(paste(year(max(df[[exit_date]], na.rm=TRUE)),
                                '-06-01', sep=''), format='%Y-%m-%d')
      warning(paste("exitby must be a string with format %Y-%m-%d,",
                    "defaulting to", 
                    exitby, sep=' '))
    }else{
      exitby <- as.Date(exitby, format="%Y-%m-%d")
    }
  }
  if(!is.numeric(gap)){
    gap <- 14
    warning("gap was not a number, defaulting to 14 days")
  }
  # Generate results data table
  output <- data.frame(id = as.character(unique(df[[sid]])),
                       moves = vector(mode = 'numeric', 
                                      length = length(unique(df[[sid]]))))
  # Students with missing data receive missing moves
  incomplete <- df[!complete.cases(df[, c(enroll_date, exit_date)]), ]
  output[which(output[['id']] %in% incomplete[[sid]]),][['moves']] <- NA

  output <- data.table(output, key='id')
  df <- df[complete.cases(df[, c(enroll_date, exit_date)]), ]
  dt <- data.table(df, key=sid)
  dt$sasid <- as.factor(as.character(dt$sasid))
  setnames(dt, names(dt)[which(names(dt) %in% enroll_date)], "enroll_date")
  setnames(dt, names(dt)[which(names(dt) %in% exit_date)], "exit_date")
  #names(dt)[which(names(dt) %in% enroll_date)] <- "enroll_date"
  #names(dt)[which(names(dt) %in% exit_date)] <- "exit_date"
  first <- dt[, list(enroll_date=min(enroll_date)), by=sid]
  last <- dt[, list(exit_date=max(exit_date)), by=sid]
  output[id %in% first[enroll_date>enrollby][[sid]], moves:=moves+1L]
  output[id %in% last[exit_date<exitby][[sid]], moves:=moves+1L]
  # Select all students who have more than one row. Create a recursive function
  # that checks that rows > 2, selects the min exit_date and difftimes the min # enroll_date thats > the exit_date value. If >gap, add 1 to counter. Remove 
  # observation with min exit_date, then call self with what's left. Break when
  # rows < 2 and return sid and moves counter.
  school_switch <- function(dt, x=0){
    if(dim(dt)[1]<2){
      return(x)
    }else{
      exit <- min(dt[, exit_date])
      exit_school <- dt[exit_date==exit][[schid]]
      rows <- dt[, enroll_date]>exit
      dt <- dt[rows,]
      enroll <- min(dt[, enroll_date])
      enroll_school <- dt[enroll_date==enroll][[schid]]
      if(difftime(min(dt[, enroll_date], na.rm=TRUE), exit)<gap &
         exit_school==enroll_school){
        y = x
      }else if(difftime(min(dt[, enroll_date], na.rm=TRUE), exit)<gap){
        y = x + 1L
      }else{
        y = x + 2L
      }
      school_switch(dt, y)
    }
  }
  # I can't decide how to handle NAs for this so I'm excluding them.
  # Because of gaps in enrollment when removing a record, this algorithm will
  # likely catch the move anyway.
  # print(dt[,which(names(dt) %in% enroll_date), with=FALSE])
  # print(dim(dt))
  # dt <- subset(dt, !is.na(dt[][[enroll_date]]))
  # print(dim(dt))
  # dt <- dt[is.na(dt[,which(names(dt) %in% enroll_date), with=FALSE])]
  # dt <- dt[is.na(dt[,which(names(dt) %in% exit_date), with=FALSE])]
  dt[, moves:= school_switch(.SD), by=sid]
  dt <- dt[,list(switches=unique(moves)), by=sid]
  output[dt, moves:=moves+switches]
  # Need to combine dt with output
  return(output)
}
#   for(i in 1:(length(df[[sid]])-1)){
#     # If this is the first time the student is listed (and not the very first
#     # student so that the prior student is undefined) check if enroll date is
#     # after YYYY-09-15. If so, add 1 move.
#     if(i>1 && df[sid][i,]!=df[sid][(i-1),]){
#       if(df[['enroll_date']][i]>enrollby){
#         output[as.character(df[[sid]][i]), moves:=moves+1L]
#       }
#     }else if(i==1){
#       if(df[['enroll_date']][i]>enrollby){
#       output[as.character(df[[sid]][i]), moves:=moves+1L]
#       }
#     }
#     # If we're looking at the same student
#     if(df[sid][i,]==df[sid][(i+1),]){
#       # And that student has less than gap days between their exit and next
#       # enrollment date, and it's the same school
#       if(as.numeric(difftime(df[['enroll_date']][i+1], 
#                              df[['exit_date']][i], units='days'))<gap &
#          df[schid][(i+1),]==df[schid][i,]){
#         # Break out so that there is no move counted and we start at the
#         # second stint at that school.
#         next
#       }else if(as.numeric(difftime(df[['enroll_date']][i+1], 
#                                    df[['exit_date']][i], 
#                           units='days'))<gap){
#         # When you have less than fourteen days between schools, this is
#         # a direct move and no other school was likely attended between
#         # this time. Therefore, this counts as one move.
#         output[as.character(df[[sid]][i]), moves:=moves+1L] 
#         # print(output)
#       }else{
#         # Student has same ID as one below (at least two entries), and
#         # difference between the exit and enroll dates are greater than gap,
#         # then this counts as two moves (one out of district, then back 
#         # into district)
#         output[as.character(df[[sid]][i]), moves:=moves+2L] 
#         # print(output)
#       }
#     }else{
#       # Should trigger if the next student number doesn't match meaning this is
#       # the last record for that student in the file.
#       if(is.na(df[['exit_date']][i])){
#         next
#       }
#       else if(df[['exit_date']][i]<exitby){
#         output[as.character(df[[sid]][i]), moves:=moves+1L]
#       }
#     }
#   }
#   return(output)
# }
