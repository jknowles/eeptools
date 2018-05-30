## Test environments
* local Windows 10 install, R 3.5.0
* ubuntu 14.05 (on travis-ci), R devel, R-Release
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There is one NOTE:
* Used utils::globalVariables(c(".fitted", ".resid",".stdresid",".cooksd",
"rows",".hat")) to fix notes about unexported objects in `autoplot.lm`
* Used utils::globalVariables(c("moves", "switches", ".SD")) to fix notes about 
unexported objects in `moves_calc`
* Used utils::globalVariables(c("adv", "grade", "count", "id", "gradeP", 
"vals", "prof")) to fix notes about unexported objects in `profpoly`


## Downstream dependencies
There are currently no downstream dependencies on CRAN.