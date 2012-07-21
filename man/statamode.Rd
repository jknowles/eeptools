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
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
a numeric vector, missing values are allowed
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
The modal value of a vector if a unique mode exists, else "."
}
\references{
%% ~put references to the literature/web site here ~
}
Jared E. Knowles
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{table}} which this function uses
}
\examples{
for vector
a<-c(month.name,month.name)
statamode(a) # returns "." to show no unique mode; useful for ddply
a<-c(LETTERS,"A","A")
statamode(a)

## The function is currently defined as
function (x) 
{
    z <- table(as.vector(x))
    m <- names(z)[z == max(z)]
    if (length(m) == 1) {
        return(m)
    }
    return(".")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~manip}

