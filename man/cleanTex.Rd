\name{cleanTex}
\alias{cleanTex}
\title{Remove Unwanted LaTeX files after building document}
\usage{
  cleanTex(mydoc, keepPDF = NULL, keepRnw = NULL)
}
\arguments{
  \item{fn}{a filename for your .Rnw file}

  \item{keepPDF}{Logical. Should function save PDF files
  with filename \code{fn}. Default is TRUE.}

  \item{keepRnw}{Logical. Should function save Rnw files
  with filename \code{fn}. Default is TRUE}
}
\value{
  Nothing. All files except the .tex, .pdf and .Rnw are
  removed from your directory.
}
\description{
  Convenience function for cleaning up your directory after
  running pdflatex
}

