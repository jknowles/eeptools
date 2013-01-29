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
a character vector of length 1; either "stata", "sample", or "last"
}

\details{
Specifying method="Stata" will result in ties for the mode being replaced with a "." character. Specifying "sample" will result in the function randomly sampling among the tied values and picking a single value. Finally, specifying "last" will result in the function picking the value that appears last in the dataset. 
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

