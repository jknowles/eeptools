\name{stulevel}
\alias{stulevel}
\docType{data}
\title{
A synthetic data set of K-12 student attributes.
}
\description{
A small dataset of synthetic data on K-12 students with 2700 observations. 1200 individual students are represented, nested within 4 districts and 2 schools.
}
\usage{data(stulevel)}
\format{
  A data frame with 2700 observations on the following 32 variables.
  \describe{
    \item{\code{X}}{a numeric vector}
    \item{\code{school}}{a numeric vector}
    \item{\code{stuid}}{a numeric vector}
    \item{\code{grade}}{a numeric vector}
    \item{\code{schid}}{a numeric vector}
    \item{\code{dist}}{a numeric vector}
    \item{\code{white}}{a numeric vector}
    \item{\code{black}}{a numeric vector}
    \item{\code{hisp}}{a numeric vector}
    \item{\code{indian}}{a numeric vector}
    \item{\code{asian}}{a numeric vector}
    \item{\code{econ}}{a numeric vector}
    \item{\code{female}}{a numeric vector}
    \item{\code{ell}}{a numeric vector}
    \item{\code{disab}}{a numeric vector}
    \item{\code{sch_fay}}{a numeric vector}
    \item{\code{dist_fay}}{a numeric vector}
    \item{\code{luck}}{a numeric vector}
    \item{\code{ability}}{a numeric vector}
    \item{\code{measerr}}{a numeric vector}
    \item{\code{teachq}}{a numeric vector}
    \item{\code{year}}{a numeric vector}
    \item{\code{attday}}{a numeric vector}
    \item{\code{schoolscore}}{a numeric vector}
    \item{\code{district}}{a numeric vector}
    \item{\code{schoolhigh}}{a numeric vector}
    \item{\code{schoolavg}}{a numeric vector}
    \item{\code{schoollow}}{a numeric vector}
    \item{\code{readSS}}{a numeric vector}
    \item{\code{mathSS}}{a numeric vector}
    \item{\code{proflvl}}{a factor with levels \code{advanced} \code{basic} \code{below basic} \code{proficient}}
    \item{\code{race}}{a factor with levels \code{A} \code{B} \code{H} \code{I} \code{W}}
  }
}
\details{
This data is synthetically generated to reflect student test scores and demographic attributes. 
}
\source{
The script to generate this synthetic dataset can be found and modified at \url{https://github.com/jknowles/r_tutorial_ed}
}


\examples{
data(stulevel)
}

\keyword{datasets}
