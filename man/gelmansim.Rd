\name{gelmansim}
\alias{gelmansim}
\title{Generate prediction intervals for model functions}
\usage{
  gelmansim(mod, newdata, nsims, na.omit = TRUE)
}
\arguments{
  \item{mod}{Name of a model object such as
  \code{\link{lm}}, \code{\link{glm}}, or \code{merMod}}

  \item{newdata}{Sets of new data to generate predictions
  for}

  \item{nsims}{Number of simulations per case}

  \item{na.omit}{Logical indicating whether to remove NAs
  from \code{newdata}}
}
\value{
  A dataframe with newdata and prediction intervals
}
\description{
  Generate prediction intervals from R models following
  Gelman and Hill
}
\examples{
\dontrun{

}
}
\references{
  Modified from Gelman and Hill 2006. Data Analysis Using
  Regression and Multilevel/Hierarchical Models. Cambridge
  University Press.
}

