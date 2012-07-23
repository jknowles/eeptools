\name{lm_linear_test_count}
\alias{lm_linear_test_count}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
lm_linear_test_count(lm,p)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{lm}{
%%     ~~Describe \code{lm} here~~
}
\item{p}{

}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (lm) 
{
    require(lmtest)
    order <- eval(parse(text = paste(substr(lm$call[2], 5, 9))))
    a <- resettest(lm, power = 2:4)
    testresults <- delist.test(a)
    a <- raintest(lm, order.by = order)
    testresults <- rbind(testresults, delist.test(a))
    a <- harvtest(lm, order.by = order)
    testresults <- rbind(testresults, delist.test(a))
    colnames(testresults) <- c("method", "p", "parameter", "test statistic", 
        "data.name")
    return(length(which(as.numeric(testresults[, 2]) < p)))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
