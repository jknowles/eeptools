lm_linear_test_count <-
function(lm,p){
  require(lmtest)
  order<-eval(parse(text=paste(substr(lm$call[2],3,9))))
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-delist.test(a)
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<p)))
}
