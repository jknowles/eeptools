## Test environments
* local Windows 7 64-bit install, R 3.2.1
* ubuntu 12.04 (on travis-ci), R 3.2.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were no NOTES:

* Used utils::globalVariables(c(".fitted", ".resid",".stdresid",".cooksd","rows",".hat"))
to fix notes about unexported objects.
* Used utils::globalVariables(c("moves", "switches", ".SD")) to fix notes about 
unexported objects in `moves_calc`
* Used utils::globalVariables(c("adv", "grade", "count", "id")) to fix notes about 
unexported objects in `profpoly`

## Downstream dependencies
There are currently no downstream dependencies on CRAN.