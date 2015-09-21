[![Build Status](https://travis-ci.org/jknowles/eeptools.png?branch=master)](https://travis-ci.org/jknowles/eeptools) [![Coverage Status](https://coveralls.io/repos/jknowles/eeptools/badge.svg?branch=master&service=github)](https://coveralls.io/github/jknowles/eeptools?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/eeptools)](http://cran.r-project.org/package=eeptools) [![Github Issues](http://githubbadges.herokuapp.com/jknowles/eeptools/issues.svg)](https://github.com/jknowles/eeptools/issues) [![Pending Pull-Requests](http://githubbadges.herokuapp.com/jknowles/eeptools/pulls.svg?style=flat)](https://github.com/jknowles/eeptools/pulls) [![Downloads](http://cranlogs.r-pkg.org/badges/eeptools)](http://cran.rstudio.com/package=eeptools)

<!-- README.md is generated from README.Rmd. Please edit that file -->
Introduction
============

eeptools is a project for R that seeks to make it easier for administrators at state and local education agencies to analyze and visualize their data on student, school, and district performance. By putting simple wrappers around a number of R functions to make many common tasks simpler and lower the barrier to entry to statistical analysis.

The goal is not to invent new functionality for R, but instead to lower the barrier of entry to doing common and routine data manipulation, visualization, and analysis tasks with education data. By collaborating with other users of education data we can build transparent, efficient, reproducible, and easy to use functions for analysts.

Datasets
========

`eeptools` provides three new datasets of interest to education researchers.

``` r
library(eeptools)
#> Loading required package: ggplot2
data("stuatt")
head(stuatt)
#>   sid school_year male race_ethnicity birth_date
#> 1   1        2004    1              B      10869
#> 2   1        2005    1              H      10869
#> 3   1        2006    1              H      10869
#> 4   1        2007    1              H      10869
#> 5   2        2006    0              W      11948
#> 6   2        2007    0              B      11948
#>   first_9th_school_year_reported hs_diploma      hs_diploma_type
#> 1                           2004          0                     
#> 2                           2004          0                     
#> 3                           2004          0                     
#> 4                           2004          0                     
#> 5                             NA          1     Standard Diploma
#> 6                             NA          1 College Prep Diploma
#>   hs_diploma_date
#> 1                
#> 2                
#> 3                
#> 4                
#> 5        6/5/2008
#> 6       5/24/2009
```

The `stuatt`, student attributes, dataset is provided from the [Strategic Data Project Toolkit for Effective Data Use](http://sdp.cepr.harvard.edu/toolkit-effective-data-use). This dataset is useful for learning how to clean data in R and how to aggregate and summarize individual unit-record data into group-level data.

``` r
data(stulevel)
head(stulevel)
#>     X school  stuid grade schid dist white black hisp indian asian econ
#> 1  44      1 149995     3   495  105     0     1    0      0     0    0
#> 2  53      1  13495     3   495   45     0     1    0      0     0    1
#> 3 116      1 106495     3   495   45     0     1    0      0     0    1
#> 4 244      1  45205     3   205   15     0     1    0      0     0    1
#> 5 274      1 142705     3   205   75     0     1    0      0     0    1
#> 6 276      1  14995     3   495  105     0     1    0      0     0    1
#>   female ell disab sch_fay dist_fay luck   ability    measerr      teachq
#> 1      0   0     0       0        0    0  87.85405  11.133264 39.09024712
#> 2      0   0     0       0        0    1  97.78756   6.822394  0.09848192
#> 3      0   0     0       0        0    0 104.49303  -7.856159 39.53885270
#> 4      0   0     0       0        0    1 111.67151 -17.574152 24.11612277
#> 5      0   0     0       0        0    0  81.92539  52.983338 56.68061304
#> 6      0   0     0       0        0    0 101.92904  22.604145 71.62196655
#>   year attday schoolscore district schoolhigh schoolavg schoollow   readSS
#> 1 2000    180    29.22427        3          0         1         0 357.2865
#> 2 2000    180    55.96326        3          0         1         0 263.9046
#> 3 2000    160    55.96326        3          0         1         0 369.6722
#> 4 2000    168    55.96326        3          0         1         0 346.5957
#> 5 2000    156    55.96326        3          0         1         0 373.1254
#> 6 2000    157    55.96326        3          0         1         0 436.7607
#>     mathSS     proflvl race
#> 1 387.2803       basic    B
#> 2 302.5724 below basic    B
#> 3 365.4614       basic    B
#> 4 344.4964       basic    B
#> 5 441.1581       basic    B
#> 6 463.4033  proficient    B
```

The `stulevel` dataset is a simulated student-level longitudinal record.

``` r
data("midsch")
head(midsch)
#>   district_id school_id subject grade n1   ss1 n2   ss2 predicted
#> 1          14       130    math     4 44 433.1 40 463.0  468.7446
#> 2          70        20    math     4 18 443.0 20 477.2  476.4765
#> 3         112        80    math     4 86 445.4 94 472.6  478.3509
#> 4         119        50    math     4 95 427.1 94 460.7  464.0586
#> 5         147        60    math     4 27 424.2 27 458.7  461.7937
#> 6         147       125    math     4 17 423.5 26 463.1  461.2470
#>    residuals     resid_z     resid_t       cooks test_year     tprob
#> 1 -5.7445937 -0.59189645 -0.59170988 0.000171271      2007 0.2787298
#> 2  0.7235053  0.07455731  0.07452135 0.000003510      2007 0.4706873
#> 3 -5.7508949 -0.59266905 -0.59248250 0.000244921      2007 0.2774827
#> 4 -3.3585931 -0.34605798 -0.34591020 0.000059900      2007 0.3650957
#> 5 -3.0936928 -0.31877383 -0.31863490 0.000054100      2007 0.3762745
#> 6  1.8530072  0.19093568  0.19084643 0.000019800      2007 0.4250936
#>   flagged_t95
#> 1           0
#> 2           0
#> 3           0
#> 4           0
#> 5           0
#> 6           0
```

The `midsch` dataset contains an analysis on abnormality in school average assessment scores.

Administrative Data Functions
=============================

For analysts using unit-record data of some type, there are several `calc` functions which automate common tasks including calculating ages (`age_calc`), grade retention (`retained_calc`), and student mobility (`moves_calc`).

``` r
age_calc(dob = as.Date('1995-01-15'), enddate = as.Date('2003-02-16'))
#> [1] 97.03571
```

``` r

x <- data.frame(sid = c(101, 101, 102, 103, 103, 103, 104, 105, 105, 106, 106),
                 grade = c(9, 10, 9, 9, 9, 10, 10, 8, 9, 7, 7))
  retained_calc(x)
#>   sid retained
#> 1 101        N
#> 2 102        N
#> 3 103        Y
#> 4 105        N
```

``` r

df <- data.frame(sid = c(rep(1,3), rep(2,4), 3, rep(4,2)),
                   schid = c(1, 2, 2, 2, 3, 1, 1, 1, 3, 1),
                   enroll_date = as.Date(c('2004-08-26',
                                           '2004-10-01',
                                           '2005-05-01',
                                           '2004-09-01',
                                           '2004-11-03',
                                           '2005-01-11',
                                           '2005-04-02',
                                           '2004-09-26',
                                           '2004-09-01',
                                           '2005-02-02'),
                                         format='%Y-%m-%d'),
                   exit_date = as.Date(c('2004-08-26',
                                         '2005-04-10',
                                         '2005-06-15',
                                         '2004-11-02',
                                         '2005-01-10',
                                         '2005-03-01',
                                         '2005-06-15',
                                         '2005-05-30',
                                         NA,
                                         '2005-06-15'),
                                       format='%Y-%m-%d'))
  moves <- moves_calc(df)
  moves
#>   sid moves
#> 1   1     4
#> 2   2     4
#> 3   3     2
#> 4   4    NA
```

Manipulate Data
===============

Regression Models
=================

Plotting Themes
===============

Helping Out
===========

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
