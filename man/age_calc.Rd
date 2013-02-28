\name{age_calc}
\alias{age_calc}

\title{
Function to calculate age from date of birth.
}
\description{
This function calculates age in days, months, or years from a date of birth to another arbitrary date. This returns a numeric vector in the specified units.
}
\usage{age_calc(dob, enddate, units)}
\arguments{
  \item{dob}{
a vector of class Date representing the date of birth/start date
}
  \item{enddate}{
a vector of class Date representing the when the observation's age is of interest, defaults to current date.
}
  \item{units}{
a string that indicates units of age  
}
}
\details{
%% ~~ Additional details to be added as needed ~~
}
\value{
a vector of class numeric
}
\source{
This function was developed in part from this response on the R-Help mailing list.
https://stat.ethz.ch/pipermail/r-help/2009-November/217649.html
}
\author{
Jason P. Becker
}
\seealso{
See also \code{\link{difftime}} which this function uses and mimics some functionality but at higher unit levels.
}

\examples{

a <- as.Date(seq(as.POSIXct('1987-05-29 018:07:00'), len=26, by="21 day"))
b <- as.Date(seq(as.POSIXct('2002-05-29 018:07:00'), len=26, by="21 day"))
a
age <- age_calc(a, units='years')
age
age <- age_calc(a, units='months')
age
age <- age_calc(a, as.Date('2005-09-01'))
age

}