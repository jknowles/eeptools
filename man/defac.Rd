\name{defac}
\alias{defac}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
convert a factor to a character string safely
}
\description{
This is a shortcut function to convert a factor to a character variable without having to type as.character()
}
\usage{
defac(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
a factor to be turned into a character
}
}
\value{
a character string of the vector input
}

\author{
Jared E. Knowles
}

\seealso{
\code{\link{factor}}, \code{\link{levels}} to understand the R implementation of factors.
}

\examples{
a<-as.factor(LETTERS)
summary(a)
b<-defac(a)
class(b)

}
