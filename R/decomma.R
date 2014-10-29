decomma <- function(x){
  x <- gsub(",", "", x)
  return(as.numeric(x))
}