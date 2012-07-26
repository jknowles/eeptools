\name{theme_dpi}
\alias{theme_dpi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
a ggplot2 theme developed for PDF and PNG
}
\description{
This is a custom ggplot2 theme developed for the Wisconsin Department of Public Instruction
}
\usage{
theme_dpi(base_size = 16, base_family = "")
}

\arguments{
  \item{base_size}{
specify the font size as a numeric value, this value is optional
}
  \item{base_family}{
specify the font family, this value is optional
}
}
\details{
All values are optional
}
\value{
A theme object which is a list of attributes applied to a ggplot2 object.
}
\references{
For more information see https://github.com/hadley/ggplot2/wiki/Themes
}
\author{
Jared E. Knowles
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
This uses \code{\link{unit}} from the gridExtra package extensively. See also \code{\link{theme_bw}} or \code{\link{theme_minimal}} from the ggplot2 package.
}
\examples{
qplot(mpg, wt, data=mtcars) # standard
qplot(mpg, wt, data=mtcars) + theme_dpi()

## The function is currently defined as
function (base_size = 16, base_family = "") 
{
    require(gridExtra)
    structure(list(axis.line = theme_blank(), axis.text.x = theme_text(family = base_family, 
        size = base_size * 1.05, lineheight = 0.9, vjust = 1), 
        axis.text.y = theme_text(family = base_family, size = base_size * 
            1.05, lineheight = 0.9, hjust = 1), axis.ticks = theme_segment(colour = "black", 
            size = 0.2), axis.title.x = theme_text(family = base_family, 
            size = base_size * 1.2, face = "bold", vjust = 0.25), 
        axis.title.y = theme_text(family = base_family, size = base_size * 
            1.2, face = "bold", angle = 90, vjust = 0.5), axis.ticks.length = unit(0.06, 
            "cm"), axis.ticks.margin = unit(0.06, "cm"), legend.background = theme_rect(colour = NA), 
        legend.margin = unit(0.2, "cm"), legend.key = theme_rect(colour = "grey80"), 
        legend.key.size = unit(1.2, "lines"), legend.key.height = NULL, 
        legend.key.width = NULL, legend.text = theme_text(family = base_family, 
            size = base_size * 0.8), legend.text.align = NULL, 
        legend.title = theme_text(family = base_family, size = base_size * 
            0.9, face = "bold", hjust = 0), legend.title.align = NULL, 
        legend.position = "right", legend.direction = NULL, legend.justification = "center", 
        legend.box = NULL, panel.background = theme_rect(fill = "white", 
            colour = NA), panel.border = theme_rect(fill = NA, 
            colour = "grey50"), panel.grid.major = theme_line(colour = "grey90", 
            size = 0.2), panel.grid.minor = theme_line(colour = "grey98", 
            size = 0.5), panel.margin = unit(0.25, "lines"), 
        strip.background = theme_rect(fill = "grey80", colour = "grey50"), 
        strip.text.x = theme_text(family = base_family, size = base_size * 
            0.8), strip.text.y = theme_text(family = base_family, 
            size = base_size * 0.8, angle = -90), plot.background = theme_rect(colour = NA), 
        plot.title = theme_text(family = base_family, size = base_size * 
            1.4), face = "bold", plot.margin = unit(c(1, 1, 0.5, 
            0.5), "lines")), class = "options")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~aplot }
\keyword{ ~misc }% __ONLY ONE__ keyword per line
