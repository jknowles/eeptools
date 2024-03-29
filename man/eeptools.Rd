% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eeptools-package.r
\docType{package}
\name{eeptools}
\alias{eeptools}
\title{Evaluation of educational policy tools}
\description{
Make common tasks for educational evaluation easier to do!
}
\details{
This package has a number of useful shortcuts for common tasks. It includes 
some themes for ggplot2 plots, processing arbitrary text files of data, 
calculating student characteristics, and finding thresholds within vectors. 
Future development work will include methods for tuning and evaluating early 
warning system models.
}
\note{
This package is still in beta and function names may change in the next release.
}
\examples{
gender<-c("M","M","M","F","F","F")
statamode(gender)
statamode(gender[1:5])

missing_data<-c(NA,NA,NA)
max_mis(missing_data)

makenum(gender)
gender <- factor(gender)
defac(gender)
}
\author{
Jared E. Knowles
}
\keyword{"_PACKAGE"}
