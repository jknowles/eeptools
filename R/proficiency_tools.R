#' Draw a visual crosstab (mosaid plot) with shading for correlations 
#' and labels in each cell.
#'
#' Improves labeling of mosaic plots over \code{mosaic} from the vcd package
#'
#' @param data a data object, matrix or dataframe, that contains the categorical 
#'    variables to compose the crosstab
#' @param rowvar a reference to the column in data that will be displayed on the rows
#'    of the crosstab, expressed as data$rowvar
#' @param colvar a reference to the column in data that will be displayed in columns of the 
#'    crosstab
#' @param varnames a character vector of length two with the labels for rowvar and colvar
#'    respectively
#' @param title a character vector of length one that contains the main title for the plot
#' @param subtitle a character vector of length one that contains the subtitle displayed 
#'    beneath the plot
#' @param label logical, if TRUE cells will be labeled, else they will not
#' @param shade logical, if TRUE cells will be shaded with Pearson residuals
#' @source http://www.rexdouglass.com/blog:3
#' @keywords mosaic
#' @keywords crosstabs
#' @keywords vcd
#' @return A mosaic plot
#' @seealso
#'  \code{\link{mosaic}} which this function wraps
#'
#'  \code{\link{structure}} which does the data manipulation for the crosstab
#' 
#' @import vcd
#' @export
#' @examples
#' df<-data.frame(cbind(x=seq(1,3,by=1), y=sample(LETTERS[6:8],60,replace=TRUE)),
#' fac=sample(LETTERS[1:4], 60, replace=TRUE))
#' varnames<-c('Quality','Grade')
#' mosaictabs.label(df,df$y,df$fac,varnames,'My Plot','Foo')
mosaictabs.label <- function(data, rowvar, colvar, varnames, title = NULL, 
                             subtitle = NULL, label = FALSE, shade = TRUE){
  mosaictabs <-function(rowvar, colvar, varnames){
    crosstab<-table(rowvar,colvar)
    rowvarcat<-levels(as.factor(rowvar))
    colvarcat<-levels(as.factor(colvar))
    proportions<-round(prop.table(crosstab , 2)*100)
    values<-c(crosstab)
    names=varnames
    dims<-c(length((rowvarcat)),length(colvarcat))
    dimnames<-structure( list(rowvarcat,colvarcat ),.Names = c(names) )
    TABS <- structure( c(values), .Dim = as.integer(dims), .Dimnames = dimnames, class = "table") 
    PROPORTIONS <- structure( c(proportions), .Dim = as.integer(dims), .Dimnames = dimnames, class = "table") 
    TABSPROPORTIONS <- structure( c(paste(PROPORTIONS,"%","\n", "(",values,")",sep="")), .Dim = as.integer(dims), 
                                   .Dimnames = dimnames, class = "table") 
    out <- list(TABS = TABS, PROPORTIONS = PROPORTIONS, 
                TABSPROPORTIONS = TABSPROPORTIONS)
    #labeling_cells(text=TABSPROPORTIONS , clip_cells=FALSE)(TABS, prefix="plot1")
  }
  out <- with(data, mosaictabs(rowvar, colvar, varnames))
  if(label){
    vcd::mosaic(out$TABS, shade=shade, main = title, sub = subtitle)
    labeling_cells(text=out$TABSPROPORTIONS, clip_cells=FALSE)(out$TABS)
  } else{
    vcd::mosaic(out$TABS, shade=shade, main = title, sub = subtitle)
  }
}

#TODO: Add better handling of inputs
#TODO: generalize to multivariate
#Correct call still requires data elements to be specified using $var

# basic, proficient, and advanced need to be the bottom threshold
# minimal is the top threshold for the minimal category
# HOSS and LOSS are highest and lowest obtainable scale score vectors
# grades is the vector of tested grades to draw polygon for
# All vectors are grade ordered and same length
# Returns a ggplot object

#' Creates a proficiency polygon in ggplot2 for showing assessment categories
#'
#' @param grades a vector of tested grades in sequential order
#' @param LOSS is a vector of the lowest obtainable scale score on 
#'        an assessment by grade
#' @param minimal is a vector of the floor of the minimal assessment category by grade
#' @param basic is a vector of the floor of the basic assessment category by grade
#' @param proficient is a vector of the floor of the proficient assessment category by grade
#' @param advanced is a vectof of the floor of the advanced assessment category by grade
#' @param HOSS is a vector of the highest obtainable scale score by grade
#' @keywords ggplot2
#' @keywords polygon
#' @return a ggplot2 object that can be printed or saved
#' @seealso
#'  \code{\link{geom_polygon}} which this function wraps
#'
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
#' z<-profpoly(grades,LOSS,minimal,basic,proficient,advanced,HOSS)
#' z
profpoly<-function(grades, LOSS, minimal, basic, proficient, advanced, HOSS){
  g<-length(grades)
  #
  rep.invert<-function(x){
    c(x,x[order(-x)])
  }
  #
  grades<-rep.invert(grades)
  len<-length(grades)
  minimala<-c(LOSS,minimal[order(-minimal)])
  basica<-c(minimal+1,prof[order(-prof)])
  profa<-c(prof+1,adv[order(-adv)])
  adva<-c(adv+1,HOSS)
  prof<-c(rep(1,len),rep(2,len),rep(3,len),rep(4,len))
  vals<-c(minimala,basica,profa,adva)
  gradeP<-rep(grades,4)
  profpoly<-cbind(gradeP,prof,vals)
  profpoly<-as.data.frame(profpoly)
  profpoly$vals<-as.character(profpoly$vals)
  profpoly$vals<-as.numeric(profpoly$vals)
  profpoly$prof<-factor(profpoly$prof,levels=unique(as.numeric(prof)))
  p<-ggplot(profpoly,aes(x=gradeP,y=vals))
  p+geom_polygon(aes(fill=prof,group=prof))+scale_fill_brewer('Proficiency',type='seq')
}

##########################################################
# More flexible output from profpoly
##########################################################

#' Creates a data frame suitable for building custom polygon layers in ggplot2 objects
#'
#' @param grades a vector of tested grades in sequential order
#' @param LOSS is a vector of the lowest obtainable scale score on 
#'        an assessment by grade
#' @param minimal is a vector of the floor of the minimal assessment category by grade
#' @param basic is a vector of the floor of the basic assessment category by grade
#' @param proficient is a vector of the floor of the proficient assessment category by grade
#' @param advanced is a vectof of the floor of the advanced assessment category by grade
#' @param HOSS is a vector of the highest obtainable scale score by grade
#' @keywords ggplot2
#' @keywords polygon
#' @return a dataframe for adding a polygon to layers in other ggplot2 plots
#' @seealso
#'  \code{\link{geom_polygon}} which this function assists
#'
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
#' z<-profpoly.df(grades,LOSS,minimal,basic,proficient,advanced,HOSS)
#' z
profpoly.df <- function(grades,LOSS,minimal,basic,proficient,advanced,HOSS){
  g<-length(grades)
  #
  rep.invert<-function(x){
    c(x,x[order(-x)])
  }
  #
  grades<-rep.invert(grades)
  len<-length(grades)
  minimala<-c(LOSS,minimal[order(-minimal)])
  basica<-c(minimal+1,prof[order(-prof)])
  profa<-c(prof+1,adv[order(-adv)])
  adva<-c(adv+1,HOSS)
  prof<-c(rep(1,len),rep(2,len),rep(3,len),rep(4,len))
  vals<-c(minimala,basica,profa,adva)
  gradeP<-rep(grades,4)
  profpoly<-cbind(gradeP,prof,vals)
  profpoly<-as.data.frame(profpoly)
  profpoly$vals<-as.character(profpoly$vals)
  profpoly$vals<-as.numeric(profpoly$vals)
  profpoly$prof<-factor(profpoly$prof,levels=unique(as.numeric(prof)))
  return(profpoly)
}

# Proficiency Polygon From Matrix
############################################
# Take a matrix of proficiency scores and  #
# produce a polygon like the blue mountain #
# Grades must be column 1 in the matrix    #
# It will sort other columns in ascending  #
# order so the order does not matter.      #
# Can take arbitrary number of levels      #
#
# Need a HOSS and a LOSS as well           #
############################################
# 
# profpoly.mat<-function(x){
#   z<-t(apply(x),1,sort)
#   
#   #
#   invt<-function(x){
#     x[order(-x)]
#   }
#   #
#   len<-ncol(z)-3 # subtract high low and grades
#   #
#   rep.invert<-function(x){
#     c(x,x[order(-x)])
#   }
#   #
#   gs<-rep(rep.invert(z[,1]),len)
#   
#   bb<-z[,2]
#   x<-NULL
#   for(i in 4:ncol(z)-1){
#     x<-append(x,c(z[,i],invt(z[,i])))
#   }
#   x
#   bb<-append(bb,x)
#   bb<-append(bb,z[,ncol(z)])
#   bb
#   length(bb)
#   
#   proflvls<-length(bb)/(2*length(z[,1]))
#   proflvls<-seq(1:proflvls)
#   proflvls<-rep(proflvls,each=length(gs)/length(proflvls))
#   
#   
# }
# 
# 
# len<-ncol(z)-3
# gs<-rep(rep.invert(z[,1]),len)
# length(gs)
# 
# bb<-c(z[,2],invt(z[,3]),z[,3]+1,invt(z[,4]),z[,4]+1,invt(z[,5]),z[,5]+1,invt(z[,6]))
# 
# length(bb)
# proflvls<-length(bb)/(2*length(z[,1]))
# proflvls<-seq(1:proflvls)
# proflvls<-rep(proflvls,each=length(gs)/length(proflvls))
# 
# profpoly<-cbind(gs,bb,proflvls)
# profpoly<-as.data.frame(profpoly)
# profpoly$proflvls<-as.factor(profpoly$proflvls)
# 
# p<-ggplot(profpoly,aes(x=gs,y=bb,fill=proflvls,colour=proflvls,group=proflvls))
# p+geom_polygon()+scale_fill_brewer(type='seq')
# 


##
# Make a Gantt Chart to Track Projects
##
# 
# 
# 
# require(ggplot2)
# tasks<-c("WISEdash","Educator Effectiveness","Value-Added","SIS","Research")
# dfr<-data.frame(
#   name = factor(tasks,levels=tasks),
#   start.date = c('01-08-2010','01-03-2011','01-01-2011','01-03-2012','01-01-2011'),
#   end.date = c('01-03-2012','01-09-2015','01-09-2016','01-09-2017','01-01-2013'),
#   funding = c('federal','unknown','unknown','state','federal')
# )
# mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))
# mdfr$value<-as.character(mdfr$value)
# g<-ggplot(mdfr, aes(as.Date(value, "%d-%m-%Y"), name, colour = as.factor(funding))) + 
#   geom_line(size = 6) + scale_colour_brewer("Funding Source",pal='Dark2')+
#   xlab("") + ylab("") +
#   theme_bw()
# 
# g+geom_vline(xintercept=15330,size=2,color='black')+
#   opts(title='Major Projects \n',axis.title.x=theme_text(size=18),
#        axis.title.y=theme_text(size=18,angle=90),
#        plot.title=theme_text(size=20),axis.text.x=theme_text(size=12),
#        axis.text.y=theme_text(size=12))
# 
# 
# tasks<-c('WISEdash','CWCS','ELO','SIS','Classroom VA','Research')
# dfr<-data.frame(
#   name=factor(tasks,levels=tasks),
#   start.date=c('1-12-2011','1-1-2010','06-30-2011','06-30-2012','06-30-2013','01-01-2011'),
#   end.date=c('10-22-2012','10-12-2011','04-09-2013','04-10-2014','04-10-2015','01-01-2013'),
#   funding=c('federal','state','federal','state','unknown','unknown')
# )
# 
# #M
# 
# mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))
# mdfr$value<-as.character(mdfr$value)
# g<-ggplot(mdfr, aes(as.Date(value, "%m-%d-%Y"), name, colour = as.factor(funding))) + 
#   geom_line(size = 6) + scale_colour_brewer("Funding Source",pal='Dark2')+
#   xlab("") + ylab("") +
#   theme_bw()
# 
# g+geom_vline(xintercept=15330,size=2,color='black')+
#   opts(title='Major DPI Projects \n',axis.title.x=theme_text(size=18),
#        axis.title.y=theme_text(size=18,angle=90),
#        plot.title=theme_text(size=20),axis.text.x=theme_text(size=12),
#        axis.text.y=theme_text(size=12))
# 
# mdfr$test<-as.Date(mdfr$value,"%m-%d-%Y")


