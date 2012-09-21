thresh <-
function(x,cutoff){
  #x is the column or variable
  #thresh is the number to count to 
  x<-x[order(-x)] # sort vector descending
  xb<-cumsum(x)   # take cumulative sum (order matter)
  xc<-xb/sum(x,na.rm=T) # express proportionally
  xc[cutoff]            # report cumulative percentage at given threshold
}
