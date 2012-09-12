\name{vwReg}
\alias{vwReg}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
vwReg(formula, data, title = "", B = 1000, shade = TRUE, shade.alpha = 0.1, spag = FALSE, mweight = TRUE, show.lm = FALSE, show.median = TRUE, median.col = "white", show.CI = FALSE, method = loess, bw = FALSE, slices = 200, palette = colorRampPalette(c("#FFEDA0", "#DD0000"), bias = 2)(20), ylim = NULL, quantize = "continuous", ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{
%%     ~~Describe \code{formula} here~~
}
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{title}{
%%     ~~Describe \code{title} here~~
}
  \item{B}{
%%     ~~Describe \code{B} here~~
}
  \item{shade}{
%%     ~~Describe \code{shade} here~~
}
  \item{shade.alpha}{
%%     ~~Describe \code{shade.alpha} here~~
}
  \item{spag}{
%%     ~~Describe \code{spag} here~~
}
  \item{mweight}{
%%     ~~Describe \code{mweight} here~~
}
  \item{show.lm}{
%%     ~~Describe \code{show.lm} here~~
}
  \item{show.median}{
%%     ~~Describe \code{show.median} here~~
}
  \item{median.col}{
%%     ~~Describe \code{median.col} here~~
}
  \item{show.CI}{
%%     ~~Describe \code{show.CI} here~~
}
  \item{method}{
%%     ~~Describe \code{method} here~~
}
  \item{bw}{
%%     ~~Describe \code{bw} here~~
}
  \item{slices}{
%%     ~~Describe \code{slices} here~~
}
  \item{palette}{
%%     ~~Describe \code{palette} here~~
}
  \item{ylim}{
%%     ~~Describe \code{ylim} here~~
}
  \item{quantize}{
%%     ~~Describe \code{quantize} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
function (formula, data, title = "", B = 1000, shade = TRUE, 
    shade.alpha = 0.1, spag = FALSE, mweight = TRUE, show.lm = FALSE, 
    show.median = TRUE, median.col = "white", show.CI = FALSE, 
    method = loess, bw = FALSE, slices = 200, palette = colorRampPalette(c("#FFEDA0", 
        "#DD0000"), bias = 2)(20), ylim = NULL, quantize = "continuous", 
    ...) 
{
    IV <- all.vars(formula)[2]
    DV <- all.vars(formula)[1]
    data <- na.omit(data[order(data[, IV]), c(IV, DV)])
    if (bw == TRUE) 
        palette <- colorRampPalette(c("#EEEEEE", "#999999", "#333333"), 
            bias = 2)(20)
    print("Computing boostrapped smoothers ...")
    newx <- data.frame(seq(min(data[, IV]), max(data[, IV]), 
        length = slices))
    colnames(newx) <- IV
    l0.boot <- matrix(NA, nrow = nrow(newx), ncol = B)
    l0 <- method(formula, data)
    for (i in 1:B) {
        data2 <- data[sample(nrow(data), replace = TRUE), ]
        data2 <- data2[order(data2[, IV]), ]
        if (class(l0) == "loess") {
            m1 <- method(formula, data2, control = loess.control(surface = "i", 
                statistics = "a", trace.hat = "a"), ...)
        }
        else {
            m1 <- method(formula, data2, ...)
        }
        l0.boot[, i] <- predict(m1, newdata = newx)
    }
    library(plyr)
    library(reshape2)
    CI.boot <- adply(l0.boot, 1, function(x) quantile(x, prob = c(0.025, 
        0.5, 0.975, pnorm(c(-3, -2, -1, 0, 1, 2, 3))), na.rm = TRUE))[, 
        -1]
    colnames(CI.boot)[1:10] <- c("LL", "M", "UL", paste0("SD", 
        1:7))
    CI.boot$x <- newx[, 1]
    CI.boot$width <- CI.boot$UL - CI.boot$LL
    CI.boot$w2 <- (CI.boot$width - min(CI.boot$width))
    CI.boot$w3 <- 1 - (CI.boot$w2/max(CI.boot$w2))
    b2 <- melt(l0.boot)
    b2$x <- newx[, 1]
    colnames(b2) <- c("index", "B", "value", "x")
    library(ggplot2)
    library(RColorBrewer)
    p1 <- ggplot(data, aes_string(x = IV, y = DV)) + theme_bw()
    if (shade == TRUE) {
        quantize <- match.arg(quantize, c("continuous", "SD"))
        if (quantize == "continuous") {
            print("Computing density estimates for each vertical cut ...")
            flush.console()
            if (is.null(ylim)) {
                min_value <- min(min(l0.boot, na.rm = TRUE), 
                  min(data[, DV], na.rm = TRUE))
                max_value <- max(max(l0.boot, na.rm = TRUE), 
                  max(data[, DV], na.rm = TRUE))
                ylim <- c(min_value, max_value)
            }
            d2 <- ddply(b2[, c("x", "value")], .(x), function(df) {
                res <- data.frame(density(df$value, na.rm = TRUE, 
                  n = slices, from = ylim[1], to = ylim[2])[c("x", 
                  "y")])
                colnames(res) <- c("y", "dens")
                return(res)
            }, .progress = "text")
            maxdens <- max(d2$dens)
            mindens <- min(d2$dens)
            d2$dens.scaled <- (d2$dens - mindens)/maxdens
            d2$alpha.factor <- d2$dens.scaled^shade.alpha
            p1 <- p1 + geom_tile(data = d2, aes(x = x, y = y, 
                fill = dens.scaled, alpha = alpha.factor)) + 
                scale_fill_gradientn("dens.scaled", colours = palette) + 
                scale_alpha_continuous(range = c(0.001, 1))
        }
        if (quantize == "SD") {
            SDs <- melt(CI.boot[, c("x", paste0("SD", 1:7))], 
                id.vars = "x")
            count <- 0
            d3 <- data.frame()
            col <- c(1, 2, 3, 3, 2, 1)
            for (i in 1:6) {
                seg1 <- SDs[SDs$variable == paste0("SD", i), 
                  ]
                seg2 <- SDs[SDs$variable == paste0("SD", i + 
                  1), ]
                seg <- rbind(seg1, seg2[nrow(seg2):1, ])
                seg$group <- count
                seg$col <- col[i]
                count <- count + 1
                d3 <- rbind(d3, seg)
            }
            p1 <- p1 + geom_polygon(data = d3, aes(x = x, y = value, 
                color = NULL, fill = col, group = group)) + scale_fill_gradientn("dens.scaled", 
                colours = palette, values = seq(-1, 3, 1))
        }
    }
    print("Build ggplot figure ...")
    flush.console()
    if (spag == TRUE) {
        p1 <- p1 + geom_path(data = b2, aes(x = x, y = value, 
            group = B), size = 0.7, alpha = 10/B, color = "darkblue")
    }
    if (show.median == TRUE) {
        if (mweight == TRUE) {
            p1 <- p1 + geom_path(data = CI.boot, aes(x = x, y = M, 
                alpha = w3^3), size = 0.6, linejoin = "mitre", 
                color = median.col)
        }
        else {
            p1 <- p1 + geom_path(data = CI.boot, aes(x = x, y = M), 
                size = 0.6, linejoin = "mitre", color = median.col)
        }
    }
    if (show.CI == TRUE) {
        p1 <- p1 + geom_path(data = CI.boot, aes(x = x, y = UL, 
            group = B), size = 1, color = "red")
        p1 <- p1 + geom_path(data = CI.boot, aes(x = x, y = LL, 
            group = B), size = 1, color = "red")
    }
    if (show.lm == TRUE) {
        p1 <- p1 + geom_smooth(method = "lm", color = "darkgreen", 
            se = FALSE)
    }
    p1 <- p1 + geom_point(size = 1, shape = 21, fill = "white", 
        color = "black")
    if (title != "") {
        p1 <- p1 + opts(title = title)
    }
    p1 + opts(legend.position = "none")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
