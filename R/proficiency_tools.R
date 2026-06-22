#' Draw a visual crosstab (mosaic plot) with shading for correlations 
#' and labels in each cell.
#'
#' Improves labeling of mosaic plots over \code{mosaic} from the vcd package
#'
#' @param data a data object, matrix or dataframe, that contains the categorical 
#'    variables to compose the crosstab
#' @param rowvar a character value for the column in data that will be displayed on the rows
#'    of the crosstab
#' @param colvar a character value for the column in data that will be displayed in columns of the 
#'    crosstab
#' @param varnames a character vector of length two with the labels for rowvar and colvar
#'    respectively
#' @param title a character vector of length one that contains the main title for the plot
#' @param subtitle a character vector of length one that contains the subtitle displayed 
#'    beneath the plot
#' @param label logical, if TRUE cells will be labeled, else they will not
#' @param shade logical, if TRUE cells will be shaded with Pearson residuals
#' @param ... additional arguments to \code{\link{crosstabs}} e.g. digits
#' @keywords mosaic
#' @keywords crosstabs
#' @keywords vcd
#' @return A mosaic plot
#' @seealso
#'  \code{\link[vcd]{mosaic}} which this function wraps
#'  \code{\link{crosstabs}} which does the data manipulation for the crosstab
#'
#' @section Deprecation:
#' Deprecated in eeptools 1.3.0; use \code{vcd::mosaic()} or the \code{ggmosaic}
#' package instead. This function will be removed in a future release, at which
#' point the \code{vcd} dependency will be dropped.
#' @import vcd
#' @export
#' @examples
#' df <- data.frame(cbind(x=seq(1,3,by=1), y=sample(LETTERS[6:8],60,replace=TRUE)),
#' fac=sample(LETTERS[1:4], 60, replace=TRUE))
#' varnames<-c('Quality','Grade')
#' myCT <- crosstabs(df, rowvar = "x",colvar = "fac", varnames = varnames, digits =2)
#' crosstabplot(df, rowvar = "x",colvar = "fac", varnames = varnames, 
#' title = 'My Plot', subtitle = 'Foo', label = FALSE, shade = TRUE, digits = 3)
crosstabplot <- function(data, rowvar, colvar, varnames, title = NULL,
                             subtitle = NULL, label = FALSE, shade = TRUE, ...){
  .Deprecated(msg = paste("crosstabplot() is deprecated as of eeptools 1.3.0 and",
                          "will be removed in a future release.",
                          "Use vcd::mosaic() or the 'ggmosaic' package instead."))
  # crosstabs() is itself deprecated; suppress its warning here to avoid a
  # duplicate notice when called through crosstabplot().
  out <- suppressWarnings(crosstabs(data = data, rowvar = rowvar, colvar = colvar,
                   varnames = varnames, ...))
  if(label){
    vcd::mosaic(out$TABS, shade = shade, main = title, sub = subtitle, 
                labeling = labeling_cells(text = out$TABSPROPORTIONS, 
                                               clip_cells=FALSE))
  } else{
    vcd::mosaic(out$TABS, shade =shade, main = title, sub = subtitle)
  }
}


#' Build a list of crosstabulations from a dataset
#'
#' @param data a data object, matrix or dataframe, that contains the categorical 
#'    variables to compose the crosstab
#' @param rowvar a character value for the column in data that will be displayed on the rows
#'    of the crosstab
#' @param colvar a character value for the column in data that will be displayed in columns of the 
#'    crosstab
#' @param varnames a character vector of length two with the labels for rowvar and colvar
#'    respectively
#' @param digits an integer for how much to round the proportion calculations by, 
#' default is 2
#' @return a list with crosstab calculations
#' @section Deprecation:
#' Deprecated in eeptools 1.3.0; use \code{janitor::tabyl()} or
#' \code{dplyr::count()} instead. This function will be removed in a future
#' release.
#' @export
#'
#' @examples
#' df<-data.frame(cbind(x=seq(1,3,by=1), y=sample(LETTERS[6:8],60,replace=TRUE)),
#' fac=sample(LETTERS[1:4], 60, replace=TRUE))
#' varnames<-c('Quality','Grade')
#' myCT <- crosstabs(df, rowvar = "x",colvar = "fac", varnames = varnames, digits =2)
crosstabs <-function(data, rowvar, colvar, varnames, digits = 2){
  .Deprecated(msg = paste("crosstabs() is deprecated as of eeptools 1.3.0 and will",
                          "be removed in a future release.",
                          "Use janitor::tabyl() or dplyr::count() instead."))
  crosstab <- table(data[, rowvar], data[, colvar])
  rowvarcat <- levels(as.factor(data[, rowvar]))
  colvarcat <- levels(as.factor(data[, colvar]))
  proportions <- round(prop.table(crosstab), digits) * 100
  values <- c(crosstab)
  dims <- c(length((rowvarcat)), length(colvarcat))
  dimnames  <- structure(list(rowvarcat,colvarcat ), .Names = c(varnames))
  TABS <- structure( c(values), .Dim = as.integer(dims), .Dimnames = dimnames, class = "table") 
  PROPORTIONS <- structure(c(proportions), .Dim = as.integer(dims), 
                           .Dimnames = dimnames, class = "table") 
  TABSPROPORTIONS <- structure(c(paste(PROPORTIONS,"%","\n", "(",values,")",sep="")), 
                               .Dim = as.integer(dims), 
                                .Dimnames = dimnames, class = "table") 
  out <- list(TABS = TABS, PROPORTIONS = PROPORTIONS, 
              TABSPROPORTIONS = TABSPROPORTIONS)
  return(out)
}


#TODO: generalize to multivariate



#' Creates a proficiency polygon in ggplot2 for showing assessment categories
#'
#' @param data a data.frame produced by \code{\link{profpoly.data}}
#' @import ggplot2
#' @keywords ggplot2
#' @keywords polygon
#' @return a ggplot2 object that can be printed or saved
#' @seealso
#'  \code{\link[ggplot2]{geom_polygon}} which this function wraps
#'
#' @section Deprecation:
#' Deprecated in eeptools 1.3.0. This niche assessment-band helper will be
#' removed in a future release.
#' @export
#' @examples
#' grades<-c(3,4,5,6,7,8)
#' g <- length(grades)
#' LOSS <- rep(200, g)
#' HOSS <- rep(650, g)
#' basic <- c(320,350,370,390,420,440)
#' minimal <- basic-30
#' prof <- c(380,410,430,450,480,500)
#' adv <- c(480,510,530,550,580,600)
#' z <- profpoly.data(grades, LOSS, minimal, basic, proficient = prof, 
#'                   advanced = adv, HOSS)
#' profpoly(z)
profpoly <- function(data){
  .Deprecated(msg = paste("profpoly() is deprecated as of eeptools 1.3.0 and will",
                          "be removed in a future release."))
  if(!all(c("gradeP", "prof", "vals") %in% names(data))){
    stop("Please run profpoly first to generate the polygon data")
  }
  p <- ggplot(data, aes(x=gradeP, y=vals))
  p + geom_polygon(aes(fill=prof, group=prof)) + 
    scale_fill_brewer('Proficiency',type='seq')
}

#' Creates a data frame suitable for building custom polygon layers in ggplot2 objects
#'
#' @param grades a vector of tested grades in sequential order
#' @param LOSS is a vector of the lowest obtainable scale score on 
#'        an assessment by grade
#' @param minimal is a vector of the floor of the minimal assessment category by grade
#' @param basic is a vector of the floor of the basic assessment category by grade
#' @param proficient is a vector of the floor of the proficient assessment category by grade
#' @param advanced is a vector of the floor of the advanced assessment category by grade
#' @param HOSS is a vector of the highest obtainable scale score by grade
#' @keywords ggplot2
#' @keywords polygon
#' @return a dataframe for adding a polygon to layers in other ggplot2 plots
#' @seealso
#'  \code{\link[ggplot2]{geom_polygon}} which this function assists
#'
#' @section Deprecation:
#' Deprecated in eeptools 1.3.0. This niche assessment-band helper will be
#' removed in a future release.
#' @export
#' @examples
#'grades<-c(3,4,5,6,7,8)
#' g<-length(grades)
#' LOSS<-rep(200,6)
#' HOSS<-rep(650,6)
#' basic<-c(320,350,370,390,420,440)
#' minimal<-basic-30
#' prof<-c(380,410,430,450,480,500)
#' adv<-c(480,510,530,550,580,600)
#' 
#' z<-profpoly.data(grades,LOSS,minimal,basic,
#'                proficient = prof,advanced = adv, HOSS)
#' z
profpoly.data <- function(grades,LOSS,minimal,basic,proficient,advanced,HOSS){
  .Deprecated(msg = paste("profpoly.data() is deprecated as of eeptools 1.3.0 and",
                          "will be removed in a future release."))
  g<-length(grades)
  rep.invert <- function(x){
    c(x,x[order(-x)])
  }
  grades <- rep.invert(grades)
  len <- length(grades)
  minimala <- c(LOSS,minimal[order(-minimal)])
  basica <- c(minimal + 1, proficient[order(-proficient)])
  profa <- c(proficient + 1, advanced[order(-advanced)])
  adva <- c(advanced + 1, HOSS)
  prof <- c(rep(1,len), rep(2,len), rep(3,len), rep(4,len))
  vals <- c(minimala, basica, profa, adva)
  gradeP <- rep(grades, 4)
  profpoly <- cbind(gradeP, prof, vals)
  profpoly <- as.data.frame(profpoly)
  profpoly$vals <- as.character(profpoly$vals)
  profpoly$vals <- as.numeric(profpoly$vals)
  profpoly$prof <- factor(profpoly$prof, levels=unique(as.numeric(prof)))
  return(profpoly)
}





