utils::globalVariables(c("adv", "grade", "count", "id", "gradeP", "vals", "prof"))
#' Evaluation of educational policy tools
#' @description Make common tasks for educational evaluation easier to do!
#' @name eeptools
#' @details \tabular{ll}{
#' Package: \tab eeptools\cr
#' Type: \tab Package\cr
#' Version: \tab 1.2.0 \cr
#' Date: \tab 2018-06-01\cr
#' License: \tab GPL-3 \cr
#' }
#' his package has a number of useful shortcuts for common tasks. It includes 
#' some themes for ggplot2 plots, processing arbitrary text files of data, 
#' calculating student characteristics, and finding thresholds within vectors. 
#' Future development work will include methods for tuning and evaluating early 
#' warning system models.
#' @author Jared E. Knowles
#' @note This package is still in beta and function names may change in the next release.
#' @docType package
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
NULL

