max_mis<-function(x){
  suppressWarnings(x<-max(x,na.rm=T))
  ifelse(is.finite(x),x,NA)
}
