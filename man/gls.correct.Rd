\name{gls.correct}
\alias{gls.correct}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
gls.correct(lm)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{lm}{
%%     ~~Describe \code{lm} here~~
}
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
    require(sandwich)
    rob <- t(sapply(c("const", "HC0", "HC1", "HC2", "HC3", "HC4", 
        "HC5"), function(x) sqrt(diag(vcovHC(lm, type = x)))))
    a <- c(NA, (rob[2, 1] - rob[1, 1])/rob[1, 1], (rob[3, 1] - 
        rob[1, 1])/rob[1, 1], (rob[4, 1] - rob[1, 1])/rob[1, 
        1], (rob[5, 1] - rob[1, 1])/rob[1, 1], (rob[6, 1] - rob[1, 
        1])/rob[1, 1], (rob[7, 1] - rob[1, 1])/rob[1, 1])
    rob <- cbind(rob, round(a * 100, 2))
    a <- c(NA, (rob[2, 2] - rob[1, 2])/rob[1, 2], (rob[3, 2] - 
        rob[1, 2])/rob[1, 2], (rob[4, 2] - rob[1, 2])/rob[1, 
        2], (rob[5, 2] - rob[1, 2])/rob[1, 2], (rob[6, 2] - rob[1, 
        2])/rob[1, 2], (rob[7, 2] - rob[1, 2])/rob[1, 2])
    rob <- cbind(rob, round(a * 100, 2))
    rob <- as.data.frame(rob)
    names(rob) <- c("alpha", "beta", "alpha.pchange", "beta.pchange")
    rob$id2 <- rownames(rob)
    rob
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
