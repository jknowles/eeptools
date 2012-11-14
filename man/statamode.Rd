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
statamode(x,method)
}

\arguments{
  \item{x}{
a numeric vector, missing values are allowed
}
  \item(method){
a character vector of length 1 specifying the way to break ties in cases where more than one mode exists; either "stata", "sample", or "last". "stata" provides a "." if more than one mode exists. "sample" randomly samples from among the tied values for a single mode. "last" takes the final modal category appearing in the data.
}

\value{
The modal value of a vector if a unique mode exists, else output determined by method
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
statamode(a,method="stata") # returns "." to show no unique mode; useful for ddply
statamode(a,method="sample") # randomly pick one
a<-c(LETTERS,"A","A")
statamode(a)


}


\keyword{ ~manip}

