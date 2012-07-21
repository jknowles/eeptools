\name{thresh}
\alias{thresh}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
function to return the maximum percentage of the cumulative sum represented by a subset of the vector
}
\description{
Returns the proportion of the cumulative sum represented by the number of elements in the vector a user specifies. This allows the user to identify the maximum proportion of the total that only X number of elements may represent in the vector.
}
\usage{
thresh(x, cutoff)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
a numeric vector, missing values are allowed
}
  \item{cutoff}{
the number of elements to look at
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
An integer for the proportion of the vector's sum reached at cutoff
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
 \code{\link{cutoff}} which this function is related to
}
\examples{
# for vector
a<-rnorm(100,mean=6,sd=1)
thresh(a,8) #return minimum number of elements to account 70 percent of total
# for df

## The function is currently defined as
function (x, cutoff) 
{
    x <- x[order(-x)]
    xb <- cumsum(x)
    xc <- xb/sum(x, na.rm = T)
    xc[cutoff]
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~manip}
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
