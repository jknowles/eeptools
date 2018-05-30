# ISID

##' A function to check if a set of variables form a unique ID in a dataframe.
##' @description When passed a set of variable names and a dataframe, this function 
##' returns a check TRUE/FALSE whether or not the variables together uniquely 
##' identify a row in the dataframe. 
##' @param data A dataframe.
##' @param vars A character vector specifying the column names in the dataframe 
##' to check as unique. 
##' @param verbose A logical, default FALSE. If TRUE, isid will tell you how many 
##' rows you need and how many your variables uniquely identify
##' @return TRUE or FALSE. TRUE indicates the variables uniquely identify the rows. 
##' FALSE indicates they do not. 
##' @author Jared E. Knowles
##' @export
##' @examples
##' data(stuatt)
##' isid(stuatt, vars = c("sid"))
##' isid(stuatt, vars = c("sid", "school_year"))
##' isid(stuatt, vars = c("sid", "school_year"), verbose = TRUE)
##' 
isid <- function(data, vars, verbose = FALSE){
  unique <- nrow(data[!duplicated(data[, vars]),])
  total <- nrow(data)
  if(verbose == FALSE){
    unique == total
  } else{
    cat("Are variables a unique ID?\n")
    print(unique == total)
    cat("Variables define this many unique rows:\n")
    print(unique)
    cat("There are this many total rows in the data:\n")
    print(total)
  }
}
