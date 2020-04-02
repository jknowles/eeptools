## Test environments
* local Windows 10 install, R 3.6.3
* ubuntu 14.04.5 (on travis-ci), R-Release
* r-hub "ubuntu-gcc-devel", "windows-x86_64-devel", "debian-gcc-release"

## R CMD check results
There were no ERRORs or WARNINGs or NOTEs. 

There is one NOTE:
* Used utils::globalVariables(c(".fitted", ".resid",".stdresid",".cooksd",
"rows",".hat")) to fix notes about unexported objects in `autoplot.lm`
* Used utils::globalVariables(c("moves", "switches", ".SD")) to fix notes about 
unexported objects in `moves_calc`
* Used utils::globalVariables(c("adv", "grade", "count", "id", "gradeP", 
"vals", "prof")) to fix notes about unexported objects in `profpoly`


## Downstream dependencies
There is one downstream dependency. It was checked and no errors were found.