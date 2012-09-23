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
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{myurl}{
A character string for the full URL of the Dropbox share
}
}
\details{
Must be the full URL
}
\value{
None. The script is sourced.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Jared Knowles
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{source}}
}
\examples{

\dontrun{
 dropbox_source("https://dropbox.com/public/somekey/cooldata.csv")
}
}
\keyword{ ~utilities}
