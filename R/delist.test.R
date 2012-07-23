delist.test <-
function(test,...){
  vector<-c(test$method,test$p.value,paste(test$parameter,collapse=" "),
            test$statistic,test$data.name)
  return(vector)
}
