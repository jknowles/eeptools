pkgname <- "eeptools"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('eeptools')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("autoplot.lm")
### * autoplot.lm

flush(stderr()); flush(stdout())

### Name: autoplot.lm
### Title: A function to replicate the basic plot function for linear
###   models in ggplot2
### Aliases: autoplot.lm

### ** Examples


# Univariate
a<-runif(1000)
b<-7*a+rnorm(1)
mymod<-lm(b~a)
autoplot(mymod)

# Multivariate

data(mpg)
mymod<-lm(cty~displ+cyl+drv,data=mpg)
autoplot(mymod)



cleanEx()
nameEx("cutoff")
### * cutoff

flush(stderr()); flush(stdout())

### Name: cutoff
### Title: function to calculate thresholds in a vector
### Aliases: cutoff
### Keywords: ~manip ~kwd2

### ** Examples

# for vector
a<-rnorm(100,mean=6,sd=1)
cutoff(a,.7) #return minimum number of elements to account 70 percent of total

## The function is currently defined as
function (x, cutoff) 
{
    x <- x[order(-x)]
    xb <- cumsum(x)
    xc <- xb/sum(x, na.rm = T)
    length(xc[xc < cutoff])
  }



cleanEx()
nameEx("defac")
### * defac

flush(stderr()); flush(stdout())

### Name: defac
### Title: convert a factor to a character string safely
### Aliases: defac

### ** Examples

a<-as.factor(LETTERS)
summary(a)
b<-defac(a)
class(b)

## The function is currently defined as
function (x) 
{
    x <- as.character(x)
    x
  }



cleanEx()
nameEx("destring")
### * destring

flush(stderr()); flush(stdout())

### Name: destring
### Title: a function to convert numeric factors into numeric class objects
### Aliases: destring

### ** Examples


a<-ordered(c(1,3,'09',7,5))
b<-destring(a)
class(b)
b
a

## The function is currently defined as
function (x) 
{
    x <- as.character(x)
    x <- as.numeric(x)
    x
  }



cleanEx()
nameEx("dropbox_source")
### * dropbox_source

flush(stderr()); flush(stdout())

### Name: dropbox_source
### Title: A function to source R scripts from Dropbox public shares
### Aliases: dropbox_source
### Keywords: ~utilities

### ** Examples


# Not run
# dropbox_source("https://dropbox.com/public/somekey/cooldata.csv")



cleanEx()
nameEx("eeptools-package")
### * eeptools-package

flush(stderr()); flush(stdout())

### Name: eeptools-package
### Title: Convenience functions
### Aliases: eeptools-package eeptools
### Keywords: package

### ** Examples

# Some examples later



cleanEx()
nameEx("max_mis")
### * max_mis

flush(stderr()); flush(stdout())

### Name: max_mis
### Title: A function to safely take the maximum of a vector that could
###   include only NAs.
### Aliases: max_mis
### Keywords: ~kwd1 ~kwd2

### ** Examples


max(c(7,NA,3,2,0),na.rm=TRUE)
max_mis(c(7,NA,3,2,0))
max(c(NA,NA,NA,NA),na.rm=TRUE)
max_mis(c(NA,NA,NA,NA))




cleanEx()
nameEx("midsch")
### * midsch

flush(stderr()); flush(stdout())

### Name: midsch
### Title: A dataframe of aggregate test scores for schools in a Midwest
###   state.
### Aliases: midsch
### Keywords: datasets

### ** Examples

data(midsch)




cleanEx()
nameEx("remove_stars")
### * remove_stars

flush(stderr()); flush(stdout())

### Name: remove_stars
### Title: Function to replace a "*" in redcated data with an NA in R
### Aliases: remove_stars
### Keywords: ~manip

### ** Examples

a<-c(1,5,3,6,"*",2,5,"*","*")
b<-remove_stars(a)
is.numeric(b)



cleanEx()
nameEx("statamode")
### * statamode

flush(stderr()); flush(stdout())

### Name: statamode
### Title: to mimic the mode function in Stata.
### Aliases: statamode
### Keywords: ~manip

### ** Examples

# for vectors
a<-c(month.name,month.name)
statamode(a) # returns "." to show no unique mode; useful for ddply
a<-c(LETTERS,"A","A")
statamode(a)




cleanEx()
nameEx("stuatt")
### * stuatt

flush(stderr()); flush(stdout())

### Name: stuatt
### Title: Student Attributes from the Strategic Data Project Toolkit
### Aliases: stuatt
### Keywords: datasets

### ** Examples

data(stuatt)
## maybe str(stuatt) ; plot(stuatt) ...



cleanEx()
nameEx("stulevel")
### * stulevel

flush(stderr()); flush(stdout())

### Name: stulevel
### Title: A synthetic data set of K-12 student attributes.
### Aliases: stulevel
### Keywords: datasets

### ** Examples

data(stulevel)
## maybe str(stulevel) ; plot(stulevel) ...



cleanEx()
nameEx("theme_dpi")
### * theme_dpi

flush(stderr()); flush(stdout())

### Name: theme_dpi
### Title: a ggplot2 theme developed for PDF and PNG
### Aliases: theme_dpi
### Keywords: ~aplot ~misc

### ** Examples

qplot(mpg, wt, data=mtcars) # standard
qplot(mpg, wt, data=mtcars) + theme_dpi()



cleanEx()
nameEx("theme_dpi_map")
### * theme_dpi_map

flush(stderr()); flush(stdout())

### Name: theme_dpi_map
### Title: a ggplot2 theme developed for PDF or SVG maps
### Aliases: theme_dpi_map
### Keywords: ~aplot ~misc

### ** Examples


# Data
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
require(reshape2) # for melt
crimesm <- melt(crimes, id = 1)

# No DPI theme
states_map <- map_data("state")
ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")

# Draw map
last_plot() + coord_map()
  
# DPI theme
ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat) + facet_wrap( ~ variable)+theme_dpi_map()




cleanEx()
nameEx("theme_dpi_map2")
### * theme_dpi_map2

flush(stderr()); flush(stdout())

### Name: theme_dpi_map2
### Title: an alternate ggplot2 theme developed for PDF or SVG maps
### Aliases: theme_dpi_map2
### Keywords: ~aplot ~misc

### ** Examples


# Data
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
require(reshape2) # for melt
crimesm <- melt(crimes, id = 1)

# No DPI theme
states_map <- map_data("state")
ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")

# Draw map
last_plot() + coord_map()+theme_dpi_map2()
  
# DPI theme
ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat) + facet_wrap( ~ variable)+theme_dpi_map2()




cleanEx()
nameEx("theme_dpi_mapPNG")
### * theme_dpi_mapPNG

flush(stderr()); flush(stdout())

### Name: theme_dpi_mapPNG
### Title: an alternate ggplot2 theme developed for PNG or JPG maps
### Aliases: theme_dpi_mapPNG
### Keywords: ~aplot ~misc

### ** Examples

# Data
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
require(reshape2) # for melt
crimesm <- melt(crimes, id = 1)

# No DPI theme
states_map <- map_data("state")
ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")

# Draw map
last_plot() + coord_map()+theme_dpi_mapPNG()
  
# DPI theme
ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + expand_limits(x = states_map$long, y = states_map$lat) + facet_wrap( ~ variable)+theme_dpi_mapPNG()




cleanEx()
nameEx("thresh")
### * thresh

flush(stderr()); flush(stdout())

### Name: thresh
### Title: function to return the maximum percentage of the cumulative sum
###   represented by a subset of the vector
### Aliases: thresh
### Keywords: ~manip ~kwd2

### ** Examples

# for vector
a<-rnorm(100,mean=6,sd=1)
thresh(a,8) #return minimum number of elements to account 70 percent of total
# for df

## The function is currently defined as
function (x, cutoff) 
{
    x <- x[order(-x)]
    xb <- cumsum(x)
    xc <- xb/sum(x, na.rm = T)
    xc[cutoff]
  }



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
