\name{remove_stars}
\alias{remove_stars}
\title{
Function to replace a "*" in redacted data with an NA in R
}
\description{
Redacted education data files often have a "*" character. When importing into R this is a problem, which this function solves in a simple step by replacing "*" with NA, and then converting the vector to numeric.
}
\usage{
remove_stars(x)
}
\arguments{
  \item{x}{
a vector of data that should be numeric but contains "*" characters forcing R to read it as character
}
}


\value{
Returns a vector of the same length as the input vector that is numeric without "*" characters.
}

\author{
Jared E. Knowles
}
\note{
Future versions could be modified to accomodate other indicators of redacted data.
}

\examples{
a<-c(1,5,3,6,"*",2,5,"*","*")
b<-remove_stars(a)
is.numeric(b)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~manip }
