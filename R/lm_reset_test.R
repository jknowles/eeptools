lm_reset_test <-
function(lm){
  require(lmtest)
  a<-resettest(lm,power=2:4)
  a<-delist.test(a)
  return(a)
}
