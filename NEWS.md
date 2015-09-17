# NEWS

## eeptools 0.9

This is a major update including removing little used functions and renaming 
and restructuring functions.

### New Functionality
- `destring` function deprecated and renamed to `makenum` to better reflect the 
use of the function

### Deprecated
- `plotForWord` function deprecated in favor of packages like `knitr` and `rmarkdown`
- `mapmerge2` has been deprecated in favor of a tested `mapmerge`

### Bug Fixes
- `lag_data` now can do leads and lags and includes proper error messages
- fix major bugs for `statamode` including faulty default to method and returning
objects of the wrong class
- add unit tests and continuous integration support for better package updating
- fix behavior of `max_mis` in cases when it is passed an empty vector or a 
vector of NA
- `leading_zero` function made robust to negative values
- added NA handling options to `cutoff` and `thresh`

## eeptools 0.3

### New Functionality
- `moves_calc` function from Jason Becker
- `gelmansim` function to do post-estimation prediction on new data from model 
objects using functionality in the `arm` package
- `statamode` updated to work with `data.table`
- `age_calc` function from Jason Becker given new precision option
- `lag_data` function to create groupwise nested lags quickly

### Bug Fixes
- unit tests for `decomma`, `gelmansim`, and `statamode` using `testthat` package

## eeptools 0.2

### New Functionality
- new functions for building maps with shapefiles including 
  - `mapmerge` to merge a dataframe and a shapefile, and 
  - `ggmapmerge` to convert this to a document for making a map in ggplot2

- `statamode` updated to allow for multiple methods for handling multiple modes

- `emove_stars` deleted and replaced with `remove_char` to allow for users to specify 
an arbitrary character string to be removed

- add `plotForWord` function to export plots in a Windows MetaFile for inclusion in 
Microsoft Office documents

- add `age_calc` function to allow calculating the age of a vector of birthdates 
relative to the current date (h/t Jason Becker)

### Bug Fixes
- fix typos in documentation
- fix startup message behavior
- reduce dependencies of the package dramatically so loading is faster 
and more lightweight