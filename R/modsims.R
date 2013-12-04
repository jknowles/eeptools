##' Generate prediction intervals for model functions
##'
##' Generate prediction intervals from R models following Gelman and Hill
##'
##' @param mod Name of a model object such as \code{\link{lm}}, \code{\link{glm}}, or \code{merMod}
##' @param newdata Sets of new data to generate predictions for
##' @param nsims Number of simulations per case
##' @param na.omit Logical indicating whether to remove NAs from \code{newdata}
##' @return A dataframe with newdata and prediction intervals
##' @references Modified from Gelman and Hill 2006. Data Analysis Using Regression and Multilevel/Hierarchical Models. Cambridge University Press.
##' @export
##' @examples
##' \dontrun{
##'  
##' }
gelmansim <- function(mod, newdata, nsims, na.omit=TRUE){
  sims.tmp <- sim(mod, n.sims=nsims)
  form.tmp <- mod$formula[-2]
  
  # generate factors matrix from model
  not.numeric <- function(x) ifelse(is.numeric(x), FALSE, TRUE)
  
  # Get factors
  facs <- mod$model[,sapply(mod$model, not.numeric)]
  
  if(class(facs) == "data.frame"){
    contr.tmp <- lapply(facs, unique)
    for(i in names(contr.tmp)){
      newdata[, i] <- factor(newdata[, i], levels=unlist(contr.tmp[i]))
      X.tilde <- model.matrix(form.tmp, newdata, xlev=contr.tmp, 
                              contrasts.arg = lapply(mod$model[,sapply(mod$model, 
                                                                       is.factor)],
                                                     contrasts, contrasts=FALSE))
    }
  } else {
    contr.tmp <- unique(facs)
    names.tmp <- sapply(mod$model, not.numeric)
    facname <- names(names.tmp[names.tmp==TRUE])
    newdata[, facname] <- factor(newdata[, facname], 
                                 levels=contr.tmp)
    contr.list <- list(contrasts(mod$model[, facname], 
                                 contrasts=FALSE))
    names(contr.list) <- facname
    X.tilde <- model.matrix(form.tmp, newdata, xlev=contr.tmp, 
                            contrasts.arg = contr.list)
  }
  
  if(na.omit==TRUE){
    newdata <- na.omit(newdata)
  }
  
  pred.tmp <- unlist(dimnames(sims.tmp@coef)[2])
  X.tilde <- X.tilde[, colnames(X.tilde) %in% pred.tmp]
  X.tilde <- reorder(X.tilde, dim=2, names=pred.tmp)
  
  n.tilde <- nrow(X.tilde)
  y.tilde <- array(NA, c(nsims, n.tilde))
  
  for(s in 1:nsims){
    y.tilde[s,] <- rnorm(n.tilde, X.tilde %*% sims.tmp@coef[s,], 
                         sims.tmp@sigma[s])
  }
  
  yhats <- colMeans(y.tilde)
  yhatMin <- apply(y.tilde, 2, quantile, probs=0.2)
  yhatMax <- apply(y.tilde, 2,  quantile, probs=0.8)
  
  sim.results <- cbind(newdata, yhats)
  sim.results <- cbind(sim.results, cbind(yhatMin, yhatMax))
  sim.results <- as.data.frame(sim.results)
  return(sim.results)
}