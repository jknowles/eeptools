statamode <- function(x, method = c("last", "stata", "sample")){
  x <- as.character(x)
  if (method == 'stata'){
    z <- table(as.vector(x))
    m <- names(z)[z == max(z)]
    
    if (length(m) == 1){
      return(m)
    }
    
    return(".")
  }
  else if (method == 'sample'){
    z <- table(as.vector(x))
    m<-names(z)[z == max(z)]
    if (length(m)==1){
      return(m)
    }
    else if (length(m)>1){
      return(sample(m,1))
    }
    else if (length(m)<1){
      return(NA_character_)
    }
  }
  else if (method=='last'){
    z <- table(as.vector(x))
    m <- names(z)[z == max(z)]
    if (length(m) == 1){
      return(m)
    }
    else if (length(m) > 1){
      return(tail(m,1))
    }
    else if (length(m) < 1){
      return(NA_character_)
    }
  }
}