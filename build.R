# Package build

stulevel<-read.csv('data/smalldata.csv')
source('dropbox_source.R')
source('statamode.R')
source('cutandthresh.R')

#package.skeleton(name='eeptools')
library(devtools)
setwd('C:/Users/Jared/Projects')
build(pkg=paste(getwd(),"/eeptools",sep=""),binary=TRUE)