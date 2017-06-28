## Test environments
* local Windows 7 64-bit install, R 3.4.0
* ubuntu 12.04 (on travis-ci), R 3.4.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were was one NOTE:
* Used utils::globalVariables(c(".fitted", ".resid",".stdresid",".cooksd",
"rows",".hat")) to fix notes about unexported objects in `autoplot.lm`
* Used utils::globalVariables(c("moves", "switches", ".SD")) to fix notes about 
unexported objects in `moves_calc`
* Used utils::globalVariables(c("adv", "grade", "count", "id", "gradeP", 
"vals", "prof")) to fix notes about unexported objects in `profpoly`


## Downstream dependencies
There are currently no downstream dependencies on CRAN.