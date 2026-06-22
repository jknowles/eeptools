## Submission

This release (1.3.0) modernizes `autoplot.lm` for `ggplot2` 4.0 (removing the
deprecated `ggplot2::fortify()` call and the deprecated `size` line aesthetic),
fixes a moved URL in the README, and begins focusing the package on education
administrative-records work by deprecating several convenience functions and
making four long-deprecated theme functions defunct. Deprecated functions still
work but emit a warning. No exported functions were removed in this release, so
there is no impact on reverse dependencies (of which there are none).

## Test environments
* local Linux install, R 4.6.0
* GitHub Actions: macOS-latest (release), windows-latest (release),
  ubuntu-latest (devel, release, oldrel-1)

## R CMD check results
There were no ERRORs or WARNINGs.

There is one NOTE:
* Uses `utils::globalVariables()` to declare non-standard-evaluation column
  names used by `data.table` and `ggplot2` in `autoplot.lm`, `moves_calc`,
  and `profpoly`.

## Downstream dependencies
There are no downstream dependencies.
