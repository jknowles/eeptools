\name{stuatt}
\alias{stuatt}
\docType{data}
\title{
Student Attributes from the Strategic Data Project Toolkit
}
\description{
A synthetic dataset of student attributes from the Strategic Data Project which includes records with errors to practice data cleaning and impelmenting business rules for consistency in data. 
}
\usage{data(stuatt)}
\format{
  A data frame with 87534 observations on the following 9 variables.
  \describe{
    \item{\code{sid}}{a numeric vector of the unique student ID}
    \item{\code{school_year}}{a numeric vector of the school year}
    \item{\code{male}}{a numeric vector indicating 1 = male}
    \item{\code{race_ethnicity}}{a factor with levels \code{A} \code{B} \code{H} \code{M/O} \code{W}}
    \item{\code{birth_date}}{a numeric vector of the student birthdate}
    \item{\code{first_9th_school_year_reported}}{a numeric vector of the first year a student is reported in 9th grade}
    \item{\code{hs_diploma}}{a numeric vector}
    \item{\code{hs_diploma_type}}{a factor with levels \code{} \code{Alternative Diploma} \code{College Prep Diploma} \code{Standard Diploma}}
    \item{\code{hs_diploma_date}}{a factor with levels \code{} \code{12/2/2008} \code{12/21/2008} \code{4/14/2008} \code{4/18/2008} \code{4/2/2009} \code{4/21/2009} \code{5/10/2009} \code{5/13/2008} \code{5/14/2008} \code{5/14/2009} \code{5/15/2007} \code{5/16/2009} \code{5/17/2009} \code{5/2/2009} \code{5/21/2009} \code{5/23/2008} \code{5/24/2009} \code{5/26/2009} \code{5/29/2008} \code{5/3/2008} \code{5/6/2009} \code{5/8/2008} \code{5/9/2006} \code{5/9/2007} \code{6/11/2009} \code{6/25/2009} \code{6/4/2009} \code{6/5/2008} \code{6/6/2009} \code{6/8/2008} \code{7/10/2009} \code{7/14/2008} \code{7/9/2007}}
  }
}
\details{
This is the non-clean version of the data to allow for implementing business rules to clean data.
}
\source{
Available from the Strategic Data Project online at \url{http://www.gse.harvard.edu/~pfpie/index.php/sdp/tools}
}
\references{
Visit the Strategic Data Project online at:  \url{http://www.gse.harvard.edu/sdp}
}
\examples{
data(stuatt)
## maybe str(stuatt) ; plot(stuatt) ...
}
\keyword{datasets}
