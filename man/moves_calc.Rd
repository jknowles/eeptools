\name{moves_calc}
\alias{moves_calc}

\title{
Function to calculate the number of times a student has changed schools.
}
\description{
This function calculates the number of times a student has changed schools, including accounting for gaps in enrollment data. It returns a \code{\link{data.table}} with the student ID and the number of student moves.
}
\usage{moves_calc(df, enrollby, exitby, gap, sid, schid, enroll_date, exit_date)}
\arguments{
  \item{df}{
  a data.frame containing minimally a student identifier, school identifier, enrollment date, and exit date.
}
  \item{enrollby}{
  a date that determines the earliest a student can enroll for the first time without being credited with having moved at least once.
}
  \item{exitby}{
  a date that determines the latest a student can exit for the final time without being credited with having moved at least once.
}
  \item{gap}{
  a number that represents the largest gap between an exit date and the next enrollment date that can occur without indicating the student moved to a third school not contained within the data set. The default value is \code{14}.
  }
  \item{sid}{
  a character that indicates the name of the student id attribute in \code{df}. The default value is \code{sid}.
  }
   \item{schid}{
  a character that indicates the name of the school id attribute in \code{df}. The default value is \code{schid}.
  }
  \item{enroll_date}{
  a character that indicates the name of the enrollment date attribute in \code{df}. The default value is \code{enroll_date}.
  }
  \item{exit_date}{
  a character that indicates the name of the student id attribute in \code{df}. The default value is \code{exit_date}.
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
\dontrun{df <- data.frame(sid=rep(seq(1,10,1), 3), schid=c(rep(1,3), rep(2,4), rep(3,3)),
                 enroll_date=as.Date(seq(as.POSIXct('2004-08-26 000:00:00'), len=10, by="10 day")),
                 exit_date=as.Date(seq(as.POSIXct('2004-08-26 000:00:00'), len=10, by="26 day")))

moves <- moves_calc(df)
moves
moves <- moves_calc(df, enrollby='2004-10-15', gap=22)
moves
moves <- moves_calc(df, enrollby='2004-10-15', exitby='2005-05-29')
moves
}}