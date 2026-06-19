utils::globalVariables(c("adv", "grade", "count", "id", "gradeP", "vals", "prof"))
#' Evaluation of educational policy tools
#' @description Make common tasks for educational evaluation easier to do!
#' @name eeptools
#' @details
#' This package has a number of useful shortcuts for common tasks. It includes 
#' some themes for ggplot2 plots, processing arbitrary text files of data, 
#' calculating student characteristics, and finding thresholds within vectors. 
#' Future development work will include methods for tuning and evaluating early 
#' warning system models.
#' @author Jared E. Knowles

#' @importFrom utils packageVersion tail
#' @importFrom stats as.formula formula median model.matrix na.omit complete.cases pnorm qnorm quantile reorder rnorm sd vcov weighted.mean
#' @keywords internal
#' @examples 
#' gender<-c("M","M","M","F","F","F")
#' statamode(gender)
#' statamode(gender[1:5])
#' 
#' missing_data<-c(NA,NA,NA)
#' max_mis(missing_data)
#' 
#' makenum(gender)
#' gender <- factor(gender)
#' defac(gender)
"_PACKAGE"

