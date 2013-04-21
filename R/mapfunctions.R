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
##' \dontrun{
##' xx <- maptools::readShapePoly(system.file("shapes/sids.shp", package="maptools")[1], IDvar="FIPSNO")
##' yy<-as(xx,"data.frame")
##' yy$newvar<-sample(letters,nrow(yy),replace=TRUE)
##' yy<-subset(yy,select=c("FIPS","newvar"))
##' newpoly<-mapmerge(xx,yy,xid="FIPS",yid="FIPS")
##' }
mapmerge <- function(mapobj,data,xid,yid){
  x <- match(xid,colnames(mapobj@data))
  y <- match(yid,colnames(data))
  o <- match(mapobj@data[,x], data[,y])
  d <- data[o, ]
  row.names(d) <- mapobj@data[, x]
  d <- maptools::spCbind(mapobj, d)
  return(d)
}

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
##' \dontrun{
##' xx <- maptools::readShapePoly(system.file("shapes/sids.shp", package="maptools")[1], IDvar="FIPSNO")
##' yy<-as(xx,"data.frame")
##' yy$newvar<-sample(letters,nrow(yy),replace=TRUE)
##' yy<-subset(yy,select=c("FIPS","newvar"))
##' newpoly<-mapmerge(xx,yy,xid="FIPS",yid="FIPS")
##' }
mapmerge2 <- function (mapobj, data, xid, yid) 
{
  x <- match(xid, colnames(mapobj@data))
  y <- match(yid, colnames(data))
  o <- match(mapobj@data[, x], data[, y])
  d <- data[o, ]
  row.names(d) <- row.names(mapobj@data)
  d <- maptools::spCbind(mapobj, d)
  return(d)
}

##' Fortify a SpatialPolygonsDataFrame
##'
##' Convenience function for fortifying SpatialPolygonsDataFrames for ggplot2 plotting. 
##'
##' @param mapobj Name of an S4 SpatialPolygonsDataFrame
##' @param xid Name of ID variable in the SpatialPolygonsDataFrame
##' @return An S3 dataframe suitable for using in a gggplot2 map
##' @details This function requires maptools to be loaded and \code{\link{gpclibPermit}} 
##' to be \code{TRUE}. This is because it depends on the \code{\link{fortify}} method in \code{\link{ggplot2}}. 
##' @export
##' @examples
##' \dontrun{
##' xx <- maptools::readShapePoly(system.file("shapes/sids.shp", package="maptools")[1], IDvar="FIPSNO")
##' plotobj<-ggmapmerge(xx,"FIPS")
##' }
ggmapmerge <- function(mapobj,xid){
  require(ggplot2)
  df.points = fortify(mapobj, region=xid)
  df.points = merge(df.points, mapobj@data, by.x='id', by.y=xid)
  df.points <- df.points[order(df.points$group, df.points$piece,
                             df.points$order), ]
}
