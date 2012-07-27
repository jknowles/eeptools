n <- 100; 
x = seq(n) 
y = 10 + 10 *x + 20 * rchisq(n,df=2) 
non_normal_lm = lm(y~x) 

lm_linear_test_count(non_normal_lm,p=.8)
lm_mega_test_count(non_normal_lm,p=.05)
lm_mega_test(non_normal_lm)
lm_het_test(non_normal_lm)
gls.correct(non_normal_lm)
order<-eval(parse(text=paste(substr(non_normal_lm$call[2],3,9))))

raintest(non_normal_lm,order.by=order)

substr(non_normal_lm$call[2],3,9)

#non-constant variance 
n <- 100; 
x = seq(n) 
y = 100 + 3 * x + rnorm(n,0,3) * x; 
het_var_lm = lm(y~x) 