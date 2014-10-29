remove_char <- function(x, char){
  char <- paste0("\\", char)
  x <- gsub(char, NA, x)
}



