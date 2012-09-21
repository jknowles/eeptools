\name{theme_dpi}
\alias{theme_dpi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
a ggplot2 theme developed for PDF and PNG
}
\description{
This is a custom ggplot2 theme developed for the Wisconsin Department of Public Instruction
}
\usage{
theme_dpi(base_size = 16, base_family = "")
}

\arguments{
  \item{base_size}{
specify the font size as a numeric value, this value is optional
}
  \item{base_family}{
specify the font family, this value is optional
}
}
\details{
All values are optional
}
\value{
A theme object which is a list of attributes applied to a ggplot2 object.
}
\references{
For more information see https://github.com/hadley/ggplot2/wiki/Themes
}
\author{
Jared E. Knowles
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
This uses \code{\link{unit}} from the gridExtra package extensively. See also \code{\link{theme_bw}} from the ggplot2 package.
}
\examples{
qplot(mpg, wt, data=mtcars) # standard
qplot(mpg, wt, data=mtcars) + theme_dpi()
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~aplot }
\keyword{ ~misc }% __ONLY ONE__ keyword per line
