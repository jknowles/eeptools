remove_stars<-function(x){
  if(is.character(x)){
    x[x=="*"]<-NA
    x<-as.numeric(x)
  }  else {
    x<-as.character(x)
    x[x=="*"]<-NA
    x<-as.numeric(x)
  }
}
