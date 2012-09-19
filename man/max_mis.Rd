\name{max_mis}
\alias{max_mis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function to safely take the maximum of a vector that could include only NAs.
}
\description{
When computing the maximum on arbitrary subsets of data, some of which may only have missing values, it 
may be necessary to take the maximum of a vector of NAs. This replaces the behavior that returns Inf or
-Inf and replaces it with simply returning an NA. 
}
\usage{
max_mis(x)
}

\arguments{
  \item{x}{
A vector of data that a maximum can be taken of.
}
}
\details{
This function only returns valid results for vectors with a mix of NA and numeric values.
}
\value{
If any valid numeric values are in the vector it returns the maximum. If all NAs, it returns NA.
}
\references{

}
\author{
Jared E. Knowles
}
\note{

}

\seealso{
See also \code{\link{max}} which this function wraps.
}

\examples{

max(c(7,NA,3,2,0),na.rm=TRUE)
max_mis(c(7,NA,3,2,0))
max(c(NA,NA,NA,NA),na.rm=TRUE)
max_mis(c(NA,NA,NA,NA))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
