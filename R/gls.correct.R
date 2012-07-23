gls.correct <-
function(lm){
  require(sandwich)
  rob<-t(sapply(c('const','HC0','HC1','HC2','HC3','HC4','HC5'),function (x)
    sqrt(diag(vcovHC(lm,type=x)))))
  a<-c(NA,(rob[2,1]-rob[1,1])/rob[1,1],(rob[3,1]-rob[1,1])/rob[1,1],
       (rob[4,1]-rob[1,1])/rob[1,1],(rob[5,1]-rob[1,1])/rob[1,1],
       (rob[6,1]-rob[1,1])/rob[1,1],(rob[7,1]-rob[1,1])/rob[1,1])
  rob<-cbind(rob,round(a*100,2))
  a<-c(NA,(rob[2,2]-rob[1,2])/rob[1,2],(rob[3,2]-rob[1,2])/rob[1,2],
       (rob[4,2]-rob[1,2])/rob[1,2],(rob[5,2]-rob[1,2])/rob[1,2],
       (rob[6,2]-rob[1,2])/rob[1,2],(rob[7,2]-rob[1,2])/rob[1,2])
  rob<-cbind(rob,round(a*100,2))
  rob<-as.data.frame(rob)
  names(rob)<-c('alpha','beta','alpha.pchange','beta.pchange')
  rob$id2<-rownames(rob)
  rob
}
