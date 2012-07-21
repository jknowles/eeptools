# Package build

stulevel<-read.csv('data/smalldata.csv')
source('dropbox_source.R')
source('statamode.R')
source('cutandthresh.R')

#package.skeleton(name='eeptools')
build(pkg=paste(getwd(),"/eeptools",sep=""),binary=TRUE)