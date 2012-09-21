cutoff <-
function(x,cutoff){
  x<-x[order(-x)]               #sort vector descending
  xb<-cumsum(x)                 # take cumulative sum
  xc<-xb/sum(x,na.rm=T)        #express proportionally
  length(xc[xc<cutoff])         #count number of items until 
  #threshhold is exceeded
}
