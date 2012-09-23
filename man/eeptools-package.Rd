\name{eeptools-package}
\alias{eeptools-package}
\alias{eeptools}
\docType{package}
\title{
Evaluation of educational policy tools
}
\description{
Make common tasks for educational evaluation easier to do!
}
\details{
\tabular{ll}{
Package: \tab eeptools\cr
Type: \tab Package\cr
Version: \tab 0.1 \cr
Date: \tab 2012-07-21\cr
License: \tab GPL-3 \cr
}
This package has a number of useful shortcuts for common tasks. It includes some themes for ggplot2 plots, processing arbitrary text files of data, calculating student characteristics, and finding thresholds within vectors. Future development work will include methods for tuning and evaluating early warning system models.
}
\author{
Jared E Knowles

Jared E. Knowles <jknowles@gmail.com>
}
\references{
This package is developed to support the work at state and local education agencies for evaluating education policies.
}

\keyword{ package }
\seealso{

}
\examples{
gender<-c("M","M","M","F","F","F")
statamode(gender)
statamode(gender[1:5])

missing_data<-c(NA,NA,NA)
max_mis(missing_data,na.rm=T)

destring(gender)
gender<-factor(gender)
defac(gender)

}
