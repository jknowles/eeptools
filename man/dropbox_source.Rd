\name{dropbox_source}
\alias{dropbox_source}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function to source R scripts from Dropbox public shares
}
\description{
Allows the user to source R scripts from a public Dropbox folder using the 
URL provided by the Dropbox shared URL tool. Parses the URL and then sources
the script in one easy line.
}
\usage{
dropbox_source(myurl)
}

\arguments{
  \item{myurl}{
A character string for the full URL of the Dropbox share
}
}
\details{
Must be the full URL including https://
}
\value{
None. The script is sourced.
}

\author{
Jared Knowles
}
\note{
This function works with Dropbox as of the release date. If functionality breaks, please e-mail the package maintainer to push an update. 
}

\seealso{
\code{\link{source}}
}

\examples{

\dontrun{
 dropbox_source("https://dropbox.com/public/somekey/cooldata.csv")
}
}

\keyword{ ~utilities}
