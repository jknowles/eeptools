\name{mapmerge}
\alias{mapmerge}
\title{Combine an S4 polygon object with a dataframe}
\usage{
  mapmerge(mapobj, data, xid, yid)
}
\arguments{
  \item{mapobj}{Name of an S4 SpatialPolygonsDataFrame}

  \item{data}{Name of an S3 dataframe}

  \item{xid}{Name of ID variable in the
  SpatialPolygonsDataFrame}

  \item{yid}{Name of ID variable in the S3 dataframe}
}
\value{
  A SpatialPolygonsDataFrame with new variables attached
  from supplied dataframe
}
\description{
  Convenience function for merging dataframes and S4
  spatial polygon objects.
}
\examples{
xx <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1],
IDvar="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
yy<-as(xx,"data.frame")
yy$newvar<-sample(letters,nrow(yy),replace=TRUE)
yy<-subset(yy,select=c("FIPS","newvar"))
newpoly<-mapmerge(xx,yy,xid="FIPS",yid="FIPS")
}

