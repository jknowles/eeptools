\name{midsch}
\alias{midsch}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data(midsch)}
\format{
  A data frame with 19985 observations on the following 16 variables.
  \describe{
    \item{\code{district_id}}{a numeric vector}
    \item{\code{school_id}}{a numeric vector}
    \item{\code{subject}}{a factor with levels \code{math} \code{read}}
    \item{\code{grade}}{a numeric vector}
    \item{\code{n1}}{a numeric vector}
    \item{\code{ss1}}{a numeric vector}
    \item{\code{n2}}{a numeric vector}
    \item{\code{ss2}}{a numeric vector}
    \item{\code{predicted}}{a numeric vector}
    \item{\code{residuals}}{a numeric vector}
    \item{\code{resid_z}}{a numeric vector}
    \item{\code{resid_t}}{a numeric vector}
    \item{\code{cooks}}{a numeric vector}
    \item{\code{test_year}}{a numeric vector}
    \item{\code{tprob}}{a numeric vector}
    \item{\code{flagged_t95}}{a numeric vector}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(midsch)
## maybe str(midsch) ; plot(midsch) ...
}
\keyword{datasets}
