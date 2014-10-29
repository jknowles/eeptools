leading_zero <- function(x, digits = 2){
  formatter <- paste0('%0', digits, 'd')
  return(sprintf(formatter, x))
}
