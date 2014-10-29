\name{cleanTex}
\alias{cleanTex}
\title{Remove Unwanted LaTeX files after building document}
\usage{
cleanTex(mydoc, keepPDF = NULL, keepRnw = NULL, keepRproj = NULL)
}
\arguments{
  \item{mydoc}{a filename for your .Rnw file}

  \item{keepPDF}{Logical. Should function preserve PDF files
  with filename \code{mydoc}. Default is TRUE.}

  \item{keepRnw}{Logical. Should function save Rnw files
  with filename \code{mydoc}. Default is TRUE}
  
  \item{keepRproj}{Logical. Should function save .Rproj files
  with filename \code{mydoc}. Default is TRUE}
}
\value{
Nothing. All files except the .tex, .pdf and .Rnw are
removed from your directory.
}
\description{
Convenience function for cleaning up your directory after
running pdflatex
}

