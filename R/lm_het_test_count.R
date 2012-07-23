lm_het_test_count <-
function(lm,p){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  white.form<-parse(text=paste("~",order[2],"+","I(",substr(order,1,4)[2],
                               "^2)"))
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #White test
  #a<-bptest(lm,eval(white.form))
  #testresults<-rbind(testresults,delist.test(a))
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.2)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<p)))
}
