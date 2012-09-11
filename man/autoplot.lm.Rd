\name{autoplot.lm}
\alias{autoplot.lm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
autoplot.lm(x, ..., which = c(1:3, 5), mfrow = c(1, 1))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
  \item{which}{
%%     ~~Describe \code{which} here~~
}
  \item{mfrow}{
%%     ~~Describe \code{mfrow} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x, ..., which = c(1:3, 5), mfrow = c(1, 1)) 
{
    require(ggplot2)
    require(grid)
    df <- fortify(model)
    df <- cbind(df, rows = 1:nrow(df))
    g1 <- ggplot(df, aes(.fitted, .resid)) + geom_point() + geom_smooth(se = FALSE) + 
        geom_hline(linetype = 2, size = 0.2) + scale_x_continuous("Fitted Values") + 
        scale_y_continuous("Residual") + opts(title = "Residuals vs Fitted")
    a <- quantile(df$.stdresid, c(0.25, 0.75))
    b <- qnorm(c(0.25, 0.75))
    slope <- diff(a)/diff(b)
    int <- a[1] - slope * b[1]
    g2 <- ggplot(df, aes(sample = .resid)) + stat_qq() + geom_abline(slope = slope, 
        intercept = int) + scale_x_continuous("Theoretical Quantiles") + 
        scale_y_continuous("Standardized Residuals") + opts(title = "Normal Q-Q")
    g3 <- ggplot(df, aes(.fitted, sqrt(abs(.stdresid)))) + geom_point() + 
        geom_smooth(se = FALSE) + scale_x_continuous("Fitted Values") + 
        scale_y_continuous("Root of Standardized Residuals") + 
        opts(title = "Scale-Location")
    g4 <- ggplot(df, aes(rows, .cooksd, ymin = 0, ymax = .cooksd)) + 
        geom_point() + geom_linerange() + scale_x_continuous("Observation Number") + 
        scale_y_continuous("Cook's distance") + opts(title = "Cook's Distance")
    g5 <- ggplot(df, aes(.hat, .stdresid)) + geom_point() + geom_smooth(se = FALSE) + 
        geom_hline(linetype = 2, size = 0.2) + scale_x_continuous("Leverage") + 
        scale_y_continuous("Standardized Residuals") + opts(title = "Residuals vs Leverage")
    g6 <- ggplot(df, aes(.hat, .cooksd)) + geom_point() + geom_smooth(se = FALSE) + 
        scale_x_continuous("Leverage") + scale_y_continuous("Cook's distance") + 
        opts(title = "Cook's dist vs Leverage")
    plots <- list(g1, g2, g3, g4, g5, g6)
    grid.newpage()
    if (prod(mfrow) > 1) {
        mypos <- expand.grid(1:mfrow[1], 1:mfrow[2])
        mypos <- mypos[with(mypos, order(Var1)), ]
        pushViewport(viewport(layout = grid.layout(mfrow[1], 
            mfrow[2])))
        formatter <- function(.) {
        }
    }
    else {
        mypos <- data.frame(matrix(1, length(which), 2))
        pushViewport(viewport(layout = grid.layout(1, 1)))
        formatter <- function(.) {
            .dontcare <- readline("Hit <Return> to see next plot: ")
            grid.newpage()
        }
    }
    j <- 1
    for (i in which) {
        formatter()
        print(plots[[i]], vp = viewport(layout.pos.row = mypos[j, 
            ][1], layout.pos.col = mypos[j, ][2]))
        j <- j + 1
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
