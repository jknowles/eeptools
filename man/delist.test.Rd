\name{delist.test}
\alias{delist.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Converting test results from a regression test to a vector
}
\description{
This function takes any of the results from a linear model test and converts it to 
a vector suitable for building a dataframe out of
}
\usage{
delist.test(test, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{test}{
results from a regression diagnostic test such as \code{\link{bptest}}
}
  \item{\dots}{
other information to pass along to the test functions
}
}
\details{
This function simply takes the results from regression diagnostic tests in the \code{\link{lmtest}} package and makes them into vector 
}
\value{
returns a vector of test results
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Jared E. Knowles
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{lmtest}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (test, ...) 
{
    vector <- c(test$method, test$p.value, paste(test$parameter, 
        collapse = " "), test$statistic, test$data.name)
    return(vector)
  }
}

