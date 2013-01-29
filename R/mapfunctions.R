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
mapmerge<-function(mapobj,data,xid,yid){
  require(maptools)
  d=mapobj@data
  d<-subset(d,select=c(yid))
  eval(parse(text=paste0("d$sort<-d$",yid,"")))
  di<-merge(d,data,by.y=yid,by.x=xid,all.x=TRUE)
  di<-di[order(di$sort),]
  row.names(di)<-di$sort
  di$sort<-NULL
  spCbind(mapobj,di)
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
ggmapmerge<-function(mapobj,xid){
  require(ggplot2)
  df.points = fortify(mapobj,region=xid)
  df.points=merge(df.points,mapobj@data,by.x='id',by.y=xid)
  df.points<-df.points[order(df.points$group,df.points$piece,
                             df.points$order),]
}
