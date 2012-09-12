# B = number bootstrapped smoothers
# shade: plot the shaded confidence region?
# spag: plot spaghetti lines?
# mweight: should the median smoother be visually weighted?
# show.lm: should the linear regresison line be plotted?
# show.CI: should the 95% CI limits be plotted?
vwReg <- function(formula, data, B=1000, shade=TRUE, spag=FALSE, mweight=TRUE, show.lm=FALSE, show.CI=FALSE) {
  IV <- all.vars(formula)[2]
  DV <- all.vars(formula)[1]
  data <- na.omit(data[order(data[, IV]), c(IV, DV)])
  
  print("Computing boostrapped smoothers ...")
  steps <- nrow(data)*3	# three times more prediction points on the x-axis than original data points - for smoother smoothers
  newx <- seq(min(data[, IV]), max(data[, IV]), length=steps)
  l0.boot <- matrix(NA, nrow=steps, ncol=B)
  for (i in 1:B) {
    data2 <- data[sample(nrow(data), replace=TRUE), ]
    data2 <- data2[order(data2[, IV]), ]
    l0.boot[, i] <- predict(loess(formula, data2), newdata=newx)
  }
  
  # compute median and CI limits of bootstrap
  library(plyr)
  library(reshape2)
  CI.boot <- adply(l0.boot, 1, function(x) quantile(x, prob=c(.025, .5, .975), na.rm=TRUE))[, -1]
  colnames(CI.boot)[1:3] <- c("LL", "M", "UL")
  CI.boot$x <- newx
  CI.boot$width <- CI.boot$UL - CI.boot$LL
  
  # scale the CI width to the range 0 to 1 and flip it (bigger numbers = narrower CI)
  CI.boot$w2 <- (CI.boot$width - min(CI.boot$width))
  CI.boot$w3 <- 1-(CI.boot$w2/max(CI.boot$w2))
  
  
  # convert bootstrapped spaghettis to long format
  b2 <- melt(l0.boot)
  b2$x <- newx
  colnames(b2) <- c("index", "B", "value", "x")
  
  print("ggplot prints the figure ...")
  library(ggplot2)
  library(RColorBrewer)
  
  p1 <- ggplot(data, aes_string(x=IV, y=DV)) + theme_bw()
  
  
  if (shade == TRUE) {
    print("Computing density estimates for each vertical cut ...")
    # vertical cross-sectional density estimate
    d2 <- ddply(b2[, c("x", "value")], .(x), function(df) {
      res <- data.frame(density(df$value, na.rm=TRUE, n=100)[c("x", "y")])
      colnames(res) <- c("y", "dens")
      return(res)
    }, .progress="text")
    
    maxdens <- max(d2$dens)
    mindens <- min(d2$dens)
    d2$dens.scaled <- (d2$dens - mindens)/maxdens	
    
    # alpha scaling
    #p1 <- p1 + geom_point(data=d2, aes(x=x, y=y, alpha=dens.scaled), size=0.4, color="red")
    
    # color scaling
    p1 <- p1 + geom_point(data=d2, aes(x=x, y=y, color=dens.scaled), size=1.4) + scale_color_gradientn("dens.scaled", colours=brewer.pal(9, "YlOrRd"))
  }
  
  if (spag==TRUE) {
    library(reshape2)
    p1 <- p1 + geom_path(data=b2, aes(x=x, y=value, group=B), size=0.7, alpha=15/B, color="darkblue")
  }
  
  if (mweight == TRUE) {
    p1 <- p1 + geom_point(data=CI.boot, aes(x=x, y=M, alpha=w3), size=1, linejoin="mitre", color="darkred")
  } else {
    p1 <- p1 + geom_path(data=CI.boot, aes(x=x, y=M), size = 0.3, linejoin="mitre", color="darkred")
  }
  
  # Confidence limits
  if (show.CI == TRUE) {
    p1 <- p1 + geom_path(data=CI.boot, aes(x=x, y=UL, group=B), size=1, color="red")
    p1 <- p1 + geom_path(data=CI.boot, aes(x=x, y=LL, group=B), size=1, color="red")
  }
  
  p1 <- p1 + geom_point(size=1)
  
  # plain linear regression line
  if (show.lm==TRUE) {p1 <- p1 + geom_smooth(method="lm", color="darkgreen", se=FALSE)}
  p1
}



## Test

# build a demo data set
set.seed(1)
x <- rnorm(200, 0.8, 1.2) 
e <- rnorm(200, 0, 2)*(abs(x)^1.5 + .5)
y <- 8*x - x^3 + e
df <- data.frame(x, y)

vwReg(y~x, df)
vwReg(y~x, df, shade=FALSE, spag=TRUE)
vwReg(y~x, df, shade=TRUE, spag=FALSE, mweight=TRUE, show.CI=TRUE, show.lm=TRUE)
vwReg(y~x, df, shade=FALSE, spag=TRUE, show.lm=TRUE)

#http://www.nicebread.de/visually-weighted-regression-in-r-a-la-solomon-hsiang/