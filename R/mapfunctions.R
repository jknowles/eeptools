##' Combine an S4 polygon object with a dataframe
##'
##' Convenience function for merging dataframes and S4 spatial polygon objects. 
##'
##' @param mapobj Name of an S4 SpatialPolygonsDataFrame
##' @param data Name of an S3 dataframe
##' @param xid Name of ID variable in the SpatialPolygonsDataFrame
##' @param yid Name of ID variable in the S3 dataframe
##' @return A SpatialPolygonsDataFrame with new variables attached from supplied dataframe
##' @export
##' @examples
##' xx <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1],
##' IDvar="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
##' yy<-as(xx,"data.frame")
##' yy$newvar<-sample(letters,nrow(yy),replace=TRUE)
##' yy<-subset(yy,select=c("FIPS","newvar"))
##' newpoly<-mapmerge(xx,yy,xid="FIPS",yid="FIPS") 
mapmerge <- function(mapobj,data,xid,yid){
  x <- grep(xid,colnames(mapobj@data))
  y <- grep(yid,colnames(data))
  o <- match(mapobj@data[,x], data[,y])
  d <- data[o, ]
  row.names(d) <- mapobj@data[, x]
  d <- spCbind(mapobj, d)
  return(d)
}

##' Fortify a SpatialPolygonsDataFrame
##'
##' Convenience function for fortifying SpatialPolygonsDataFrames for ggplot2 plotting. 
##'
##' @param mapobj Name of an S4 SpatialPolygonsDataFrame
##' @param xid Name of ID variable in the SpatialPolygonsDataFrame
##' @return An S3 dataframe suitable for using in a gggplot2 map
##' @export
##' @examples
##' xx <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1],
##' IDvar="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
##' plotobj<-ggmapmerge(xx,"FIPS")
ggmapmerge <- function(mapobj,xid){
  require(ggplot2)
  df.points = fortify(mapobj, region=xid)
  df.points = merge(df.points, mapobj@data, by.x='id', by.y=xid)
  df.points <- df.points[order(df.points$group, df.points$piece,
                             df.points$order), ]
}
