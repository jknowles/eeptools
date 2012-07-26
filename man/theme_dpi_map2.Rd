\name{theme_dpi_map2}
\alias{theme_dpi_map2}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
an alternate ggplot2 theme developed for PDF or SVG maps
}
\description{
This is a custom ggplot2 theme developed for the Wisconsin Department of Public Instruction for making PDF maps
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
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
library(reshape2) # for melt
crimesm <- melt(crimes, id = 1)
if (require(maps)) {
  states_map <- map_data("state")
  ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat)
  last_plot() + coord_map()
  ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat) + facet_wrap( ~ variable)+theme_dpi_map2()
}

## The function is currently defined as
function (base_size = 18, base_family = "") 
{
    require(gridExtra)
    structure(list(axis.line = theme_blank(), axis.text.x = theme_blank(), 
        axis.text.y = theme_blank(), axis.ticks = theme_blank(), 
        axis.title.x = theme_blank(), axis.title.y = theme_blank(), 
        axis.ticks.length = unit(0.06, "cm"), axis.ticks.margin = unit(0.06, 
            "cm"), legend.background = theme_rect(colour = "black"), 
        legend.margin = unit(0.4, "cm"), legend.key = theme_rect(colour = "grey80"), 
        legend.key.size = unit(0.7, "lines"), legend.key.height = NULL, 
        legend.key.width = NULL, legend.text = theme_text(family = base_family, 
            size = base_size * 0.5), legend.text.align = NULL, 
        legend.title = theme_text(family = base_family, size = base_size * 
            0.7, face = "bold", hjust = 0), legend.title.align = NULL, 
        legend.position = c(0.13, 0.15), legend.direction = "vertical", 
        legend.justification = "center", legend.box = NULL, panel.background = theme_rect(fill = "white", 
            colour = NA), panel.border = theme_rect(fill = NA, 
            colour = NA), panel.grid.major = theme_blank(), panel.grid.minor = theme_blank(), 
        panel.margin = unit(0.25, "lines"), strip.background = theme_rect(fill = "grey80", 
            colour = "grey50"), strip.text.x = theme_text(family = base_family, 
            size = base_size * 0.8), strip.text.y = theme_text(family = base_family, 
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
