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
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
a character string of the vector input
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
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
a<-as.factor(LETTERS)
summary(a)
b<-defac(a)
class(b)

## The function is currently defined as
function (x) 
{
    x <- as.character(x)
    x
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
