# NEWS

## eeptools 1.2.6

- Fixed package documentation issues arising from changes in `roxygen`
- Made package startup message align with version number

## eeptools 1.2.5

- Removed deprecated mapping functions to address #45 the sunsetting of `maptools` 
- Cleaned up old and redirected URLs

## eeptools 1.2.3

### Bug Fixes

- Update to avoid CRAN check warnings on some platforms

## eeptools 1.2.2

### Bug Fixes

- Updated unit tests to avoid warnings associated with the new random number generator in R 3.5.3

## eeptools 1.2.1

### Bug Fixes

- In `max_mis`, there is an `if` predicate that checks if a class is of an
invalid type. Because R objects can have multiple classes, this statement relies
on the R semantics that the first value of the logical vector returned by the
predicate is used. This is a feature R-core is looking to remove as it has
considerable performance penalties. This check is now wrapped in `any()`, which
evaluates `TRUE` if any value in the logical vector is `TRUE`.

## eeptools 1.2.0

### Added

- New function `isid` for determining if a combination of variables uniquely define 
the rows in a dataframe

### Bug Fixes
- Fixed error in `statamode` with `method = "last"` thanks to PR from @larcat
- Fix import compatibility with ggplot2

## eeptools 1.1.1

- Minor fixes for CRAN repository compliance in dependencies contained in vignettes

## eeptools 1.1.0

### Added
A CONTRIBUTING.md file modeled after the excellent example in the `rio` package 
by @leeper

### Bug fixes
- Fix compatibiltiy issue for `leading_zero` function with latest version of R

### Deprecated functions
- Thanks to new and better tools the mapping functions `mapmerge` and `ggmapmerge` 
are no longer necessary thanks to `geom_map` and further enhancements to 
`ggplot2`

## eeptools 1.0.1

- Revise `readme.rmd` to include plots in package build

## eeptools 1.0.0

### Deprecated functions
- Thanks to new `ggplot2` theme options, the `theme_dpi` functions are now just 
wrappers for `theme_bw`

### Bug Fixes

- Fixed logical test in `age_calc` (GH #32)
- Fixed issue with calls to library in examples (GH #33)

## eeptools 0.9.1

### Bug Fixes
- Compatibility with `ggplot2` and `roxygen` updates

### Enhancements
- `nth_max`  performance is improved thanks to use of partial sort contributed by @sgibb

## eeptools 0.9

This is a major update including removing little used functions and renaming 
and restructuring functions.

### New Functionality
- A new package vignette is now included
- `nth_max` function for finding the `nth` highest value in a vector
- `retained_calc` now accepts user specified values for `sid` and `grade`
- `destring` function deprecated and renamed to `makenum` to better reflect the 
use of the function
- `crosstabs` function exported to allow the user to generate the data behind 
`crosstabplot` but not draw the plot

### Deprecated
- `dropbox_source` deprecated, use the `rdrop2` package
- `plotForWord` function deprecated in favor of packages like `knitr` and `rmarkdown`
- `mapmerge2` has been deprecated in favor of a tested `mapmerge`
- `mosaictabs.labels` has been deprecated in favor of `crosstabplot`

### Bug Fixes
- `nsims` in `gelmansim` was renamed to `n.sims` to align with the `arm` package
- Fixed bug in `retained_calc` where user specified `sid` resulted in wrong 
ids being returned
- Inserted a meaningful error in `age_calc` when the enddate is before the date 
of birth
- Fixed issue with `age_calc` which lead to wrong fraction of age during leap 
years
- `lag_data` now can do leads and lags and includes proper error messages
- fix major bugs for `statamode` including faulty default to method and returning
objects of the wrong class
- add unit tests and continuous integration support for better package updating
- fix behavior of `max_mis` in cases when it is passed an empty vector or a 
vector of NA
- `leading_zero` function made robust to negative values
- added NA handling options to `cutoff` and `thresh`
- Codebase is now tested with `lintr` to improve readability

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
