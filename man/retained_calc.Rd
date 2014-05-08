\name{retained_calc}
\alias{retained_calc}

\title{
Function to calculate whether a student has repeated a grade.
}
\description{
This function calculates whether or not a student has repeated a grade. It returns a \code{\link{data.frame}} with the student ID and a character vector with \code{Y} representing they repeated the grade and \code{N} that they had not.
}
\usage{retained_calc(df, sid, grade_val)}
\arguments{
  \item{df}{
  a data.frame containing minimally a student identifier and their grade.
}
  \item{enrollby}{
  a date that determines the earliest a student can enroll for the first time without being credited with having moved at least once.
}
  \item{sid}{
  a character that indicates the name of the student id attribute in \code{df}. The default value is \code{sid}.
}
  \item{grade_val}{
  a numeric vector that contains the value of the grade that is being checked for retention. The default value is \code{9}.
  }
}
\value{
a data.table
}
% \source{

% }
\author{
Jason P. Becker
}
% \seealso{

% }

\examples{
x <- data.frame(sid = c(101, 101, 102, 103, 103, 103, 104),
                grade = c(9, 10, 9, 9, 9, 10, 10))
retained_calc(x)
}