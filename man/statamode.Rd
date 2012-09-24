\name{statamode}
\alias{statamode}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
to mimic the mode function in Stata.
}
\description{
This function mimics the functionality of
the mode function in Stata. It does this by
calculating the modal category of a vector
and replacing tied categories with a "."
to represent a single mode does not exist.
}
\usage{
statamode(x)
}

\arguments{
  \item{x}{
a numeric vector, missing values are allowed
}
}

\value{
The modal value of a vector if a unique mode exists, else "."
}
\author{
Jared E. Knowles
}

\seealso{
\code{\link{table}} which this function uses
}
\examples{
# for vectors
a<-c(month.name,month.name)
statamode(a) # returns "." to show no unique mode; useful for ddply
a<-c(LETTERS,"A","A")
statamode(a)

}


\keyword{ ~manip}

