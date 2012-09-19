max_mis<-function(x){
  suppressWarnings(x<-max(x,na.rm=TRUE))
  ifelse(is.finite(x),x,NA)
}
