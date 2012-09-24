\name{cutoff}
\alias{cutoff}

\title{
function to calculate thresholds in a vector
}
\description{
This function tells us how far we have to
go before reaching a cutoff in a variable
by sorting the vector, then finding how far 
to go. Note that the cutoff is expressed in 
percentage terms (Fixed cumulative sum)
}
\usage{
cutoff(x, cutoff)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
 a numeric vector, missing values are allowed
}
  \item{cutoff}{
cutoff a user defined numeric value to stop the cutoff specified as a proportion 0 to 1
}
}
\details{
Calculates the distance through a numeric vector before a certain proportion is reached by sorting the vector and calculating the cumulative proportion of each element
}
\value{
An integer for the minimum number of elements necessary to reach cutoff
}


\author{
Jared E. Knowles
}

\seealso{
\code{\link{cumsum}} which this function uses
}
\examples{
# for vector
a<-rnorm(100,mean=6,sd=1)
cutoff(a,.7) #return minimum number of elements to account 70 percent of total

## The function is currently defined as
function (x, cutoff) 
{
    x <- x[order(-x)]
    xb <- cumsum(x)
    xc <- xb/sum(x, na.rm = T)
    length(xc[xc < cutoff])
  }
}

\keyword{ ~manip}

