\name{ggmapmerge}
\alias{ggmapmerge}
\title{Fortify a SpatialPolygonsDataFrame}
\usage{
  ggmapmerge(mapobj, xid)
}
\arguments{
  \item{mapobj}{Name of an S4 SpatialPolygonsDataFrame}

  \item{xid}{Name of ID variable in the
  SpatialPolygonsDataFrame}
}
\value{
  An S3 dataframe suitable for using in a gggplot2 map
}
\description{
  Convenience function for fortifying
  SpatialPolygonsDataFrames for ggplot2 plotting.
}
\examples{
xx <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1],
IDvar="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
plotobj<-ggmapmerge(xx,"FIPS")
}

