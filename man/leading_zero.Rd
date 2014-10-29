\name{leading_zero}
\alias{leading_zero}

\title{
  Function to add leading zeroes to maintain fixed width.
}
\description{
  This function ensures that fixed width data is the right length by padding zeroes to the front of values. This is a common problem with fixed width data after importing into R as non-character type.
}
\usage{leading_zero(x, digits)}
\arguments{
  \item{x}{
    a vector of numeric data that should be fixed width but is missing leading zeroes.}
  \item{digits}{
    an integer representing the desired width of \code{x}
  }
}
\details{
  %% ~~ Additional details to be added as needed ~~
}
\value{
  a character vector of length \code{digits}
}
\author{
  Jason P. Becker
}
\examples{
  a <- seq(1,10)
  a <- leading_zero(a, digits = 3)
  a
}
