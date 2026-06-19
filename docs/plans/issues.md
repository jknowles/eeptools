# eeptools Issue Backlog

Reconciled triage from code review findings, open GitHub issues, and modernization goals.
Issues are ordered by priority (P0 first). All P0/P1 findings have been spot-checked
against the current source and include exact line references and before/after code.

**Acceptance criteria for each fix:** after completing a phase, run `devtools::check()`
and confirm the issue no longer produces an ERROR, WARNING, or NOTE.

---

## P0 — Blocks CRAN submission or causes incorrect results

---
ID: R-001
Priority: P0
Category: cran-readiness
File: R/age_calc.R
Lines: 19-20
Title: Examples use invalid POSIXct timestamps that fail R CMD CHECK

Finding:
The @examples block uses `as.POSIXct('1987-05-29 018:07:00')` — the hour "018" is
not a valid hour string and R will throw an error when the example is run during
R CMD CHECK. CRAN treats example errors as a hard failure.

Fix:
Change lines 19-20 from:
  ##' a <- as.Date(seq(as.POSIXct('1987-05-29 018:07:00'), len=26, by="21 day"))
  ##' b <- as.Date(seq(as.POSIXct('2002-05-29 018:07:00'), len=26, by="21 day"))

To:
  ##' a <- as.Date(seq(as.Date('1987-05-29'), len=26, by="21 day"))
  ##' b <- as.Date(seq(as.Date('2002-05-29'), len=26, by="21 day"))

Using `as.Date()` directly is simpler and removes the invalid time component entirely.
The time component is never used by `age_calc` since it only operates on Date-class inputs.

Verification:
Run `devtools::run_examples()` — the example block should execute without errors.
Also confirm `R CMD CHECK` produces no ERROR in the examples section.
Status: done
---

---
ID: R-002
Priority: P0
Category: code-quality
File: R/leading_zero.R
Lines: 20-30
Title: Mixed-sign vector handling is ambiguous; current behavior undocumented

Finding:
When any value in `x` is negative, `digits` is incremented by 1 for the *entire vector*,
so positive values in the same vector are padded to width `digits+1` instead of `digits`.
Example: `leading_zero(c(-5, 42), digits=2)` returns `c("-05", "042")` — the positive
42 gets width 3, not 2.

IMPORTANT — the existing test in tests/testthat/test-utils.R at lines 140-144 already
documents and expects this uniform-width behavior:
  a <- c(-5000, -50, -5, -.01, 0, 0.1, 4, 40, 400, 4000)
  a2 <- leading_zero(a, digits = 3)
  expect_identical(a2, c("-5000", "-050", "-005", "0000", "0000", "0000",
                          "0004", "0040", "0400", "4000"))

The test treats uniform-width output as correct. Before changing behavior, confirm with
the package owner whether this is intentional design or a bug. The safest fix is to
document the behavior clearly rather than change it and break the existing test.

Fix (documentation-only approach, preferred unless owner says to change behavior):
In the @details block of leading_zero (lines 9-12), replace the existing note with:

  ##' @details If \code{x} contains negative values, \code{digits} is widened by 1 for
  ##' the entire vector so that all values share a uniform total width, with the negative
  ##' sign occupying one character position. For example,
  ##' \code{leading_zero(c(-5, 42), digits = 2)} returns \code{c("-05", "042")} — both
  ##' width 3. Mixed-sign vectors are supported but produce width \code{digits + 1}
  ##' for all elements.

If behavior change is desired instead (per-element width):
Replace lines 20-30 with:
  leading_zero <- function(x, digits = 2){
    stopifnot(any(c("numeric", "integer") %in% class(x)))
    if(digits < 0){
      warning("Digits < 0 does not make sense, defaulting to 0")
      digits <- 0
    }
    width <- ifelse(x < 0, digits + 1L, digits)
    mapply(function(val, w) formatC(val, digits = w - 1L, format = "d", flag = "0"),
           x, width)
  }
WARNING: this will break the existing test at lines 140-144. Update the test to match
the new expected values if you take this approach.

Verification:
`devtools::check()` must produce no ERROR or WARNING.
`devtools::test()` must pass (whether you update the test or not, tests must be consistent).
Status: done
---

---

---
ID: R-003
Priority: P0
Category: cran-readiness
File: DESCRIPTION
Lines: 22-27 (Suggests block)
Title: testthat listed in Suggests without version constraint; tests use deprecated API

Finding:
DESCRIPTION currently has:
  Suggests:
      testthat,
      ...
No minimum version is specified. The test files use `expect_is()`, `expect_that()`,
`equals()`, `is_a()`, and `gives_warning()` which are all soft-deprecated in testthat
3.0.0 and may be removed. R CMD CHECK will warn about packages in Suggests that
the package depends on in a version-specific way.

Fix — two parts:

Part 1: Update DESCRIPTION Suggests line 23 from:
      testthat,
To:
  testthat (>= 3.0.0),

Part 2: All deprecated test API calls are addressed by R-008 and R-009. Complete
those fixes first, then this constraint becomes accurate.

Verification:
`devtools::check()` should not warn about testthat version. After completing R-008
and R-009, run `devtools::test()` — all tests must pass with zero deprecation warnings
from testthat itself. You can check for warnings with:
  withr::with_options(list(warn=2), devtools::test())
Status: done
---

---

---

## P1 — Serious deficiency causing real user friction

---
ID: R-004
Priority: P1
Category: docs
File: R/age_calc.R
Line: 2
Title: Typo in @description: "his function" missing leading T

Finding:
Line 2 reads:
  ##' @description his function calculates age in days, months, or years from a

Fix:
Change to:
  ##' @description This function calculates age in days, months, or years from a

Verification:
Run `devtools::document()` then open `man/age_calc.Rd` and confirm the Description
section starts with "This function".
Status: done
---

---
ID: R-005
Priority: P1
Category: code-quality
File: R/autoplot.lm.R
Lines: 90-93
Title: readline() blocks in non-interactive sessions (CI, CRAN, Rmd, batch)

Finding:
Lines 90-93 currently read:
  formatter <- function(.) {
    .dontcare <- readline("Hit <Return> to see next plot: ")
    grid::grid.newpage()
  }
`readline()` in a non-interactive session either blocks forever or throws an error.
R CMD CHECK runs examples in a non-interactive session, so this will fail if any
example or test triggers the single-panel code path.

Fix:
Replace lines 90-93 with:
  formatter <- function(.) {
    if (interactive()) readline("Hit <Return> to see next plot: ")
    grid::grid.newpage()
  }

The `.dontcare` assignment was only suppressing the return value of readline, which
is not needed once readline is guarded. Remove it.

Verification:
In a non-interactive R session (simulate with `interactive()` returning FALSE, or
just run `Rscript -e "library(eeptools); ..."`) confirm no hang occurs.
`devtools::check()` should produce no WARNING or NOTE from this code path.
Status: done
---

---
ID: R-006
Priority: P1
Category: code-quality
File: R/moves_calc.R
Line: 166
Title: stringsAsFactors=TRUE is opposite of modern R defaults and breaks R >= 4.0 users

Finding:
Line 166 currently reads:
  return(as.data.frame(output, stringsAsFactors = TRUE))
Since R 4.0.0 (April 2020) the default is FALSE. Explicitly forcing TRUE causes
character columns in the return value to silently become factors, breaking any
downstream code that expects character vectors.

Fix:
Change line 166 to:
  return(as.data.frame(output, stringsAsFactors = FALSE))

Verification:
Run the moves_calc examples or tests and confirm the output data frame has character
columns (not factor columns) where string data is present.
Check with: `sapply(moves_calc(test_data, ...), class)` — no column should be "factor"
unless the input data was already a factor.
Status: done
---

---
ID: R-007
Priority: P1
Category: code-quality
File: R/retained_calc.R
Lines: 22-28
Title: I() wrapper is non-standard data.table syntax; function mutates caller's data

Finding:
The function body is:
  retained_calc <- function(df, sid = 'sid', grade = 'grade', grade_val = 9){
    df$grade <- df[, grade]      # line 23 — modifies caller's df in place
    df$sid <- df[, sid]          # line 24 — modifies caller's df in place
    dt <- data.table(df, key=c("sid", "grade"))
    result <- dt[I(grade == grade_val), list(count = .N), by = key(dt)]
    result <- result[, list(sid, retained = ifelse(count > 1, 'Y', 'N'))]
    return(as.data.frame(result))
  }

Two problems:
1. Lines 23-24 assign to `df$grade` and `df$sid`, overwriting any existing columns
   named "grade" and "sid" in the caller's data frame. This is an invisible side
   effect — the caller's object is not modified (R copies on modification) but the
   code reads as though it might be, and it will silently clobber columns if the
   user passed column names different from the defaults.
2. `I()` in data.table subsetting is not the recommended way to filter. Use a bare
   expression instead.

Fix:
Replace the function body with:
  retained_calc <- function(df, sid = 'sid', grade = 'grade', grade_val = 9){
    tmp <- df
    tmp[["grade"]] <- df[[grade]]
    tmp[["sid"]]   <- df[[sid]]
    dt <- data.table::data.table(tmp, key = c("sid", "grade"))
    result <- dt[grade == grade_val, list(count = .N), by = key(dt)]
    result <- result[, list(sid, retained = ifelse(count > 1, 'Y', 'N'))]
    return(as.data.frame(result))
  }

Note: `[[` is used instead of `$` to support non-standard column names passed as
strings (the function already accepts `sid` and `grade` as string arguments).

Verification:
Run the existing retained_calc tests. Confirm the function output is unchanged.
Confirm that after calling `retained_calc(x)`, the original data frame `x` has not
been modified (check that column names and values are unchanged).
Status: done
---

---
ID: R-008
Priority: P1
Category: tests
File: tests/testthat/test-gelmansim.R
Lines: 27-29, 51-53, 75-78, 101-104
Title: Uses deprecated testthat 1.x API: expect_that, equals, is_a

Finding:
Four test blocks all use the old API. The deprecated calls and their modern replacements:
  expect_that(x, equals(y))        →  expect_equal(x, y)
  expect_that(x, is_a("class"))    →  expect_s3_class(x, "class")

Full list of changes needed:

Line 27:  expect_that(dim(sim.results)[1], equals(length(seq(-2, 2, by=0.1))))
  →       expect_equal(dim(sim.results)[1], length(seq(-2, 2, by=0.1)))

Line 28:  expect_that(dim(sim.results)[2], equals(4))
  →       expect_equal(dim(sim.results)[2], 4)

Line 29:  expect_that(sim.results, is_a("data.frame"))
  →       expect_s3_class(sim.results, "data.frame")

Line 51:  expect_that(dim(sim.results)[1], equals(nrow(cases)))
  →       expect_equal(dim(sim.results)[1], nrow(cases))

Line 52:  expect_that(dim(sim.results)[2], equals(3 + ncol(cases)))
  →       expect_equal(dim(sim.results)[2], 3 + ncol(cases))

Line 53:  expect_that(sim.results, is_a("data.frame"))
  →       expect_s3_class(sim.results, "data.frame")

Lines 75-78: same pattern — replace expect_that/equals/is_a with expect_equal/expect_s3_class
Lines 101-104: same pattern

Also remove the `context()` calls at lines 1, 40, 64, 89 — context() is deprecated
in testthat 3. Use `describe()` blocks if grouping is desired, or just leave the
test_that labels as the only grouping.

Verification:
`devtools::test(filter="gelmansim")` must pass with zero warnings about deprecated
testthat functions.
Status: done
---

---
ID: R-009
Priority: P1
Category: tests
File: tests/testthat/test-utils.R
Lines: 7-8, 26-28, 155-161, 166-168
Title: Uses deprecated testthat 1.x API: expect_is, expect_that, equals, is_a, gives_warning

Finding:
The deprecated calls and their modern replacements:
  expect_is(x, "class")            →  expect_s3_class(x, "class")
                                       (use expect_type() for atomic types like "character")
  expect_that(x, equals(y))        →  expect_equal(x, y)
  expect_that(x, is_a("class"))    →  expect_s3_class(x, "class")
  expect_that(x, gives_warning())  →  expect_warning(x)

Full list of changes needed:

Line 7:   expect_is(defac(a), "character")    →  expect_type(defac(a), "character")
Line 8:   expect_is(defac(b), "character")    →  expect_type(defac(b), "character")
Line 26:  expect_is(a2, "numeric")            →  expect_type(a2, "double")
Line 27:  expect_is(b2, "numeric")            →  expect_type(b2, "double")
Line 28:  expect_is(c2, "numeric")            →  expect_type(c2, "double")

Lines 155-161 (decomma context):
  expect_that(decomma(c), equals(d))          →  expect_equal(decomma(c), d)
  expect_that(decomma(a), gives_warning())    →  expect_warning(decomma(a))
  expect_that(decomma(a), is_a("numeric"))    →  expect_type(decomma(a), "double")
  expect_that(decomma(b), is_a("numeric"))    →  expect_type(decomma(b), "double")
  expect_that(decomma(c), is_a("numeric"))    →  expect_type(decomma(c), "double")
  expect_that(decomma(d), is_a("numeric"))    →  expect_type(decomma(d), "double")

Lines 166-168 (decomma NA context):
  expect_that(length(decomma(n)[!is.na(decomma(n))]), equals(3))  →  expect_equal(length(decomma(n)[!is.na(decomma(n))]), 3)
  expect_that(decomma(n)[6], equals(2332522))                      →  expect_equal(decomma(n)[6], 2332522)

Also remove the `context()` calls at lines 2, 17, 36, 58, 81, 95, 121, 147, 172 —
context() is deprecated in testthat 3.

NOTE on expect_is vs expect_type vs expect_s3_class:
- Use `expect_type(x, "character")` for base atomic types (character, double, integer, logical)
- Use `expect_s3_class(x, "classname")` for S3 objects (data.frame, ggplot, etc.)
- `expect_is()` accepted both forms indiscriminately; the replacements are stricter

Verification:
`devtools::test(filter="utils")` must pass with zero warnings about deprecated
testthat functions.
Status: done
---

---
ID: R-010
Priority: P1
Category: code-quality
File: R/zzz.R
Lines: 1-8 (entire file)
Title: Dead zzz() function; @importFrom directives belong in package-level file

Finding:
The entire file is:
  #' @importFrom utils tail
  #' @importFrom stats as.formula formula median model.matrix na.omit complete.cases
  #' pnorm qnorm quantile reorder rnorm sd vcov weighted.mean
  zzz <- function(){
    # Nothing
  }

The `zzz <- function(){}` body is never called and does nothing. However, the
`@importFrom` directives on the first three lines ARE used by roxygen2 to populate
NAMESPACE, so they must not simply be deleted — they need to be relocated.

Fix:
1. Open R/eeptools-package.r (the canonical package-level documentation file).
2. Add the two @importFrom lines from zzz.R to the roxygen2 block in that file,
   before the `"_PACKAGE"` line. The file currently starts with:
     utils::globalVariables(...)
     #' Evaluation of educational policy tools
     ...
     #' @keywords internal
     #' @examples
     ...
     "_PACKAGE"
   Add after the last #' tag line and before "_PACKAGE":
     #' @importFrom utils tail
     #' @importFrom stats as.formula formula median model.matrix na.omit complete.cases pnorm qnorm quantile reorder rnorm sd vcov weighted.mean
3. Delete R/zzz.R entirely.
4. Run `devtools::document()` and confirm NAMESPACE still contains the same
   importFrom entries for utils and stats that were there before.

Verification:
`devtools::document()` must complete without error.
`grep "importFrom" NAMESPACE` must still show entries for `utils::tail` and all
the stats functions that were in zzz.R.
`devtools::check()` must produce no WARNING about missing imports.
Status: done
---

---
ID: R-011
Priority: P1
Category: code-quality
File: R/proficiency_tools.R
Lines: 181-234
Title: ~50 lines of commented-out dead code clutter the source file

Finding:
Lines 181-234 contain entirely commented-out Gantt chart code using obsolete ggplot2
syntax (`opts()`, `theme_text()`) and `require(ggplot2)`. This code is inert but
confusing, and `require()` calls even inside comments can trip some linters.

Fix:
Delete lines 181-234 (the entire commented-out block). The function above it ends
at line 180 and the file ends at line 234, so this removes everything from the
closing brace of `profpoly` through the end of the file.

Do NOT delete any uncommented code. Before deleting, verify by eye that lines 181-234
all begin with `#` — if any are active code, stop and ask.

Verification:
File should end with the closing `}` of `profpoly` (currently line 180 approximately).
`devtools::check()` must produce no new ERRORs or WARNINGs.
Status: done
---

---
ID: GH-028
Priority: P1
Category: bug
File: R/proficiency_tools.R
GitHub: https://github.com/jknowles/eeptools/issues/28
Lines: 41-47
Title: Plot titles may not appear in crosstabplot when label=TRUE

Finding:
The function currently reads:
  if(label){
    vcd::mosaic(out$TABS, shade = shade, main = title, sub = subtitle,
                labeling = labeling_cells(text = out$TABSPROPORTIONS,
                                               clip_cells=FALSE))
  } else{
    vcd::mosaic(out$TABS, shade = shade, main = title, sub = subtitle)
  }

Both branches pass `main = title`. The bug report (open since 2015) says titles
do not appear when `label=TRUE`. This may be a vcd API change where passing a
`labeling` argument overrides or suppresses `main`.

Fix approach — reproduce first, then fix:
1. Run this minimal example interactively:
     library(eeptools)
     data(stuatt)
     crosstabplot(stuatt, rowvar="male", colvar="race_ethnicity",
                  varnames=c("Gender","Race"), title="My Title", label=FALSE)
     # confirm title shows
     crosstabplot(stuatt, rowvar="male", colvar="race_ethnicity",
                  varnames=c("Gender","Race"), title="My Title", label=TRUE)
     # check whether title shows

2a. If the title IS missing with label=TRUE, check vcd::mosaic documentation for
    whether `labeling` interacts with `main`. The likely fix is to pass the title
    through a `gp_labels` or `main` argument compatible with the labeling system.

2b. If the title shows correctly with current vcd, close GH-028 with a comment
    that it was fixed in a prior vcd update and add a test to prevent regression.

3. Add a test in tests/testthat/test-plots.R that calls crosstabplot with a non-NULL
   title and label=TRUE, captures the plot, and at minimum confirms no error is thrown.
   Checking title text in vcd plots from tests is difficult; an error-free run is
   sufficient.

Verification:
No error thrown by crosstabplot with label=TRUE and a non-NULL title.
Close the GitHub issue with a comment explaining what was found.
Status: done — Cannot reproduce with vcd 1.4.13 / R 4.6.0. Title renders correctly with both label=TRUE and label=FALSE. Likely fixed in a prior vcd update.
---

---
ID: D-001
Priority: P1
Category: docs
File: DESCRIPTION
Lines: 32-33
Title: URL field only has GitHub link; pkgdown URL should be added

Finding:
DESCRIPTION already has URL and BugReports (these were present — the earlier assessment
was wrong). The current URL line is:
  URL: https://github.com/jknowles/eeptools

This should be updated to list the pkgdown site first (per CRAN convention), then the
GitHub repo. The pkgdown URL should be set up at the same time as PD-001.

Fix:
Once the pkgdown site is deployed (see PD-001), update line 32 to:
  URL: https://jknowles.github.io/eeptools/, https://github.com/jknowles/eeptools

This fix is BLOCKED BY PD-001. Do not change the URL until the pkgdown site is live.

Verification:
`devtools::check()` should not warn about the URL field.
The pkgdown site URL should resolve in a browser.
Status: blocked-by: PD-001
---

---
ID: D-002
Priority: P1
Category: docs
File: README.Rmd
Lines: 1-5 (YAML header)
Title: README uses legacy output format

Finding:
The YAML header currently reads:
  ---
  output:
    md_document:
      variant: markdown_github
  ---
This is the legacy format. The modern approach is `github_document`.

Fix:
Replace the YAML header with:
  ---
  output: github_document
  ---

After changing the header, re-knit the README: run `devtools::build_readme()` or
`knitr::knit("README.Rmd", output="README.md")` to regenerate README.md.
Commit both README.Rmd and the regenerated README.md.

Verification:
README.md should render correctly on GitHub with no broken formatting.
`devtools::check()` should not note any README issues.
Status: done
---

---
ID: D-003
Priority: P1
Category: docs
File: R/eeptools.R
Line: 3
Title: Hardcoded version "1.2.7" in startup message will go stale

Finding:
Line 3 currently reads:
  packageStartupMessage("Welcome to eeptools for R version 1.2.7!", appendLF=TRUE)

Fix:
Change line 3 to:
  packageStartupMessage(paste0("Welcome to eeptools for R version ",
                               packageVersion("eeptools"), "!"), appendLF=TRUE)

While here, also update the year range on line 4 from "2012-2018" to "2012-2024"
(or remove the date entirely — startup messages generally don't need version dates).

Verification:
Run `library(eeptools)` in a fresh R session and confirm the startup message shows
the correct version number from DESCRIPTION (currently 1.2.7). After a version bump
in DESCRIPTION the message should update automatically.
Status: done
---

---
ID: D-004
Priority: P1
Category: docs
File: R/eeptools-package.r
Line: 12
Title: Package-level @note says "still in beta" — misleading at v1.2.7

Finding:
Line 12 reads:
  #' @note This package is still in beta and function names may change in the next release.
The package is at version 1.2.7 and on CRAN. This undermines user confidence.

Fix:
Delete line 12 entirely. No replacement is needed.

Verification:
Run `devtools::document()` then open `man/eeptools.Rd` and confirm there is no
"Note" section containing "beta".
Status: open
---

---
ID: CI-001
Priority: P1
Category: ci
File: .github/workflows/check-standard.yaml
Lines: 32, 34, 36, 42, 47
Title: CI uses outdated action versions

Finding:
The workflow pins outdated versions:
  actions/checkout@v3      (current: v4)
  r-lib/actions/setup-pandoc@v2
  r-lib/actions/setup-r@v2
  r-lib/actions/setup-r-dependencies@v2
  r-lib/actions/check-r-package@v2

Fix:
Update line 32:  uses: actions/checkout@v3  →  uses: actions/checkout@v4

The r-lib/actions steps are already at v2 which is still current (r-lib/actions
has not released a v3). Leave r-lib/actions pins at @v2.

Additionally, add `error-on: '"error"'` to the check-r-package step to make the
workflow fail on errors but not on notes (CRAN notes on a dev branch are acceptable):
  - uses: r-lib/actions/check-r-package@v2
    with:
      upload-snapshots: true
      error-on: '"error"'

Verification:
Push a commit to main and confirm the R-CMD-check workflow runs successfully in
GitHub Actions with the updated action versions.
Status: open
---

---

## P2 — Code quality, robustness, and modernization

---
ID: R-012
Priority: P2
Category: code-quality
File: R/theme_dpi.R
Lines: entire file
Title: Four deprecated functions still exported; should be removed

Finding:
The file exports `theme_dpi`, `theme_dpi_map`, `theme_dpi_map2`, `theme_dpi_mapPNG`.
All four call `.Deprecated("theme_bw")` and do nothing else useful. They are dead
weight that generates deprecation warnings for any user who calls them.

Fix:
1. Delete R/theme_dpi.R entirely.
2. Run `devtools::document()` — roxygen2 will remove the NAMESPACE export entries
   and the man page files for these four functions automatically.
3. Add an entry to NEWS.md under a new version header (e.g., ## eeptools 1.2.8):
     - Removed deprecated functions `theme_dpi`, `theme_dpi_map`, `theme_dpi_map2`,
       and `theme_dpi_mapPNG`. Use `ggplot2::theme_bw()` instead.
4. Check whether any test file references these functions and remove those tests.

Verification:
`devtools::check()` must produce no WARNING about objects exported but not found.
`grep -r "theme_dpi" R/ tests/` should return no results after the deletion.
Status: open
---

---
ID: R-013
Priority: P2
Category: code-quality
File: R/cleanTex.R
Lines: 15
Title: list.files(pattern=fn) treats user-supplied filename as a regex

Finding:
Line 15 uses `a <- list.files(pattern=fn)` where `fn` is user-supplied. Since
`pattern` is interpreted as a regex, a filename like "my.file" matches "myXfile".
This could cause unintended files to be deleted.

Fix:
Replace line 15:
  a <- list.files(pattern=fn)
With:
  a <- list.files()
  a <- a[a == fn | startsWith(a, paste0(fn, "."))]

This performs exact prefix matching instead of regex matching against `fn`.

Verification:
Test with a temporary directory containing files with similar names (e.g., "report",
"report.tex", "reportX.tex") and confirm only the intended file is matched.
Status: open
---

---
ID: R-014
Priority: P2
Category: code-quality
File: R/lags.R
Line: 43
Title: cbind on data frames can coerce columns to unexpected types

Finding:
Line 43: `cbind(test_data, vals)` — when both arguments are data frames,
`cbind.data.frame` can coerce factor columns to characters or produce unexpected
column names if `vals` has a dimension name that conflicts.

Fix:
Replace line 43:
  test_data <- cbind(test_data, vals)
With:
  test_data <- data.frame(test_data, vals, stringsAsFactors = FALSE,
                           check.names = FALSE)

`check.names = FALSE` preserves original column names without sanitisation.
`stringsAsFactors = FALSE` is explicit (required for R < 4.0 compatibility).

Verification:
Existing lag_data tests should pass. Also test with a data frame containing
factor columns and confirm they remain factors in the output.
Status: open
---

---
ID: R-015
Priority: P2
Category: code-quality
File: R/modsims.R
Lines: 59-87
Title: Helper function not.numeric defined inside function body on every call

Finding:
Somewhere within `gelmansim`, a helper `not.numeric <- function(x) ...` is
defined inside the function body. This creates a new function object on every
call to `gelmansim`.

Fix:
1. Find the `not.numeric <- function(x)` definition inside `gelmansim`.
2. Cut it out of the function body.
3. Paste it immediately before the `gelmansim <- function(...)` line, at the
   top level of the file, so it is defined once when the package loads.
4. The helper does not need to be exported; keep it as an internal helper.

Verification:
`devtools::test(filter="gelmansim")` must pass. Confirm with
`grep -n "not.numeric" R/modsims.R` that the definition appears before the
opening `{` of `gelmansim`.
Status: open
---

---
ID: R-016
Priority: P2
Category: code-quality
File: R/statamode.R
Lines: 28-109
Title: Class-restoration logic duplicated across three method branches

Finding:
The stata, sample, and last method branches each contain nearly identical code
to restore the class of the original input to the output value. This means if
the logic needs to change, it must be updated in three places.

Fix:
1. Read lines 28-109 of statamode.R carefully to identify the shared pattern.
2. Extract it into a file-level helper before the `statamode` definition:
     .restore_class <- function(value, original) {
       if (inherits(original, "factor")) {
         factor(value, levels = levels(original))
       } else if (inherits(original, "ordered")) {
         ordered(value, levels = levels(original))
       } else {
         class(value) <- class(original)
         value
       }
     }
3. Replace each duplicated block in the three branches with a call to `.restore_class`.
4. The leading dot in `.restore_class` marks it as internal and prevents export.

Verification:
`devtools::test()` must pass. Test with factor, ordered, numeric, and character
inputs to statamode to confirm class is correctly restored in each branch.
Status: open
---

---
ID: R-017
Priority: P2
Category: code-quality
File: R/age_calc.R
Line: 29
Title: Vectorized | used for scalar logical test

Finding:
Line 29:
  if (!inherits(dob, "Date") | !inherits(enddate, "Date")) {
`|` is the vectorised OR operator. For scalar conditionals inside `if()`,
`||` (short-circuit OR) is the correct operator.

Fix:
Change line 29 to:
  if (!inherits(dob, "Date") || !inherits(enddate, "Date")) {

Verification:
`devtools::check()` should not note this as a style issue.
`devtools::test(filter="calculators")` must still pass.
Status: open
---

---
ID: R-018
Priority: P2
Category: performance
File: R/moves_calc.R
Lines: 139-158
Title: Recursive school_switch risks stack overflow for large groups

Finding:
`school_switch` calls itself recursively and is applied per student group via
`dt[, moves := school_switch(.SD), by = sid]`. Students with many rows generate
a deep call stack.

Fix:
Rewrite `school_switch` as an iterative function. Read the current recursive
implementation carefully first to understand the stopping conditions and return value,
then convert to a while loop. Pseudocode:
  school_switch <- function(dt, x = 1L) {
    moves <- 0L
    i <- x
    while (i < nrow(dt)) {
      # replicate the recursive conditional logic here as a loop body
      i <- i + 1L  # (or whatever the recursive step was)
    }
    moves
  }

Fill in the loop body from the recursive version. The interface (takes a data.table
slice + starting index, returns move count) should remain unchanged.

Verification:
`devtools::test()` must pass — specifically any retained_calc or moves_calc tests.
Test with a synthetic student record of 1000 rows (which would overflow the stack
with the recursive version) and confirm it completes.
Status: open
---

---
ID: R-019
Priority: P2
Category: tests
File: tests/testthat/test-calculators.R
Lines: 70-133
Title: Hardcoded expected value table is fragile and unmaintainable

Finding:
The retained_calc test section spans ~60 lines of hardcoded expected output across
12 grade levels and 30 students. Any change to function logic requires manually
updating dozens of expected values.

Fix:
Replace the hardcoded table with a small set of behavior-driven tests. Keep the
test data construction but replace the specific-value assertions with targeted checks:

  test_that("retained_calc marks repeat grade correctly", {
    df <- data.frame(sid = c(1, 1, 2, 3, 3, 3),
                     grade = c(9, 10, 9, 9, 9, 10))
    result <- retained_calc(df)
    # student 1 has one grade-9 record — not retained
    expect_equal(result$retained[result$sid == 1], "N")
    # student 2 has one grade-9 record — not retained
    expect_equal(result$retained[result$sid == 2], "N")
    # student 3 has two grade-9 records — retained
    expect_equal(result$retained[result$sid == 3], "Y")
  })

  test_that("retained_calc returns one row per student", {
    df <- data.frame(sid = c(1, 1, 2), grade = c(9, 9, 9))
    result <- retained_calc(df)
    expect_equal(nrow(result), 2)  # one row per unique sid
  })

  test_that("retained_calc respects custom grade_val", {
    df <- data.frame(sid = c(1, 1, 2), grade = c(10, 10, 10))
    result <- retained_calc(df, grade_val = 10)
    expect_equal(result$retained[result$sid == 1], "Y")
    expect_equal(result$retained[result$sid == 2], "N")
  })

Remove the old hardcoded table.

Verification:
`devtools::test(filter="calculators")` passes. The new tests cover the core
retained/not-retained and custom grade_val behaviors.
Status: open
---

---
ID: R-020
Priority: P2
Category: code-quality
File: R/cutoff.R
Line: 38
Title: Returns bare NA (logical) instead of NA_integer_ on failure path

Finding:
The function returns `length(xc[xc < cutoff])` (integer) on the success path but
bare `NA` (logical) on line 38. Callers get different types depending on input,
which can cause downstream type-coercion surprises.

Fix:
Line 38 currently reads:
      NA
Change to:
      NA_integer_

Also check line 40 in the same else-branch for any other bare NA returns and apply
the same fix.

Verification:
`is.integer(cutoff(b, 0.9, na.rm=FALSE))` must return TRUE (not FALSE as it does now).
Existing tests in test-utils.R at lines 49-52 should still pass.
Status: open
---

---
ID: R-021
Priority: P2
Category: code-quality
File: R/thresh.R
Line: 35
Title: Returns bare NA (logical) instead of NA_real_ on failure path

Finding:
`thresh` returns a numeric proportion on success but bare `NA` (logical) on line 35
when `length(xc) == 0`. Same inconsistency as R-020.

Fix:
Line 35 currently reads:
      NA
Change to:
      NA_real_

Verification:
`is.double(thresh(d, 648, na.rm=FALSE))` must return TRUE.
Existing tests in test-utils.R at lines 72-73 should still pass.
Status: open
---

---
ID: R-022
Priority: P2
Category: tests
File: tests/testthat/test-plots.R
Lines: 6-34
Title: Plot tests only check file creation, not plot content

Finding:
The autoplot tests write a PNG file, check it exists, then delete it. A completely
broken `autoplot.lm` that produces no layers would still pass these tests.

Fix:
In addition to the existing PNG file tests, add structural assertions on the
returned ggplot objects. The autoplot.lm function should return a list of ggplot
objects. Add assertions like:

  test_that("autoplot.lm returns ggplot objects", {
    fit <- lm(mpg ~ wt + cyl, data = mtcars)
    plots <- autoplot(fit)
    expect_type(plots, "list")
    expect_true(length(plots) > 0)
    expect_s3_class(plots[[1]], "ggplot")
  })

Check what autoplot.lm currently returns (it may return invisibly or assign to
a list) and write the assertion to match the actual return structure.

Verification:
New tests pass. A test that deliberately breaks autoplot.lm (e.g., by removing
a layer) should cause the structural test to fail.
Status: open
---

---
ID: D-005
Priority: P2
Category: docs
File: vignettes/intro.Rmd
Title: Vignette may reference removed functions or outdated R idioms

Finding:
The intro vignette was written before R 4.0 and the removal of spatial mapping
functions (maptools-based functions removed in v1.2.5). Outdated content reduces
trust in the package.

Fix:
1. Run `devtools::build_vignettes()` and note any errors or warnings.
2. Read through intro.Rmd and identify any references to removed functions
   (theme_dpi*, mapmerge, or any maptools-related content).
3. Remove or replace those sections. If no good replacement exists, remove the
   section with a note in comments that it was removed.
4. Ensure all code blocks execute cleanly with the current package version.
5. Update any hardcoded version references or date strings.
6. Consider adding a section demonstrating `age_calc`, `statamode`, or `retained_calc`
   which are core functions not currently showcased.

Verification:
`devtools::build_vignettes()` must complete without errors or warnings.
The built vignette HTML should render without broken sections.
Status: open
---

---
ID: CI-002
Priority: P2
Category: ci
File: .github/workflows/test-coverage.yaml
Title: Add test coverage reporting with covr + Codecov

Finding:
No coverage workflow exists. Adding one enables a coverage badge and helps catch
regressions in test coverage.

Fix:
Create the file `.github/workflows/test-coverage.yaml` with this content:

  on:
    push:
      branches: [main, master]
    pull_request:
      branches: [main, master]

  name: test-coverage

  jobs:
    test-coverage:
      runs-on: ubuntu-latest
      env:
        GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}

      steps:
        - uses: actions/checkout@v4

        - uses: r-lib/actions/setup-r@v2
          with:
            use-public-rspm: true

        - uses: r-lib/actions/setup-r-dependencies@v2
          with:
            extra-packages: any::covr, any::xml2
            needs: coverage

        - name: Test coverage
          run: covr::codecov(quiet = FALSE)
          shell: Rscript {0}

Also add `covr` to the Suggests field in DESCRIPTION.

Verification:
Push to main and confirm the test-coverage workflow appears in the GitHub Actions
tab and uploads a report to Codecov (or completes successfully even if Codecov
token is not set — it will warn but not fail).
Status: open
---

---
ID: CI-003
Priority: P2
Category: ci
File: .github/workflows/pkgdown.yaml
Title: Add pkgdown build-and-deploy workflow

Finding:
No pkgdown deployment workflow exists.

Fix:
Create `.github/workflows/pkgdown.yaml` with this content:

  on:
    push:
      branches: [main, master]
    pull_request:
      branches: [main, master]
    release:
      types: [published]
    workflow_dispatch:

  name: pkgdown

  jobs:
    pkgdown:
      runs-on: ubuntu-latest
      concurrency:
        group: pkgdown-${{ github.event_name != 'pull_request' || github.run_id }}
      env:
        GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      permissions:
        contents: write
      steps:
        - uses: actions/checkout@v4

        - uses: r-lib/actions/setup-pandoc@v2

        - uses: r-lib/actions/setup-r@v2
          with:
            use-public-rspm: true

        - uses: r-lib/actions/setup-r-dependencies@v2
          with:
            extra-packages: any::pkgdown, local::.
            needs: website

        - name: Build site
          run: pkgdown::build_site_github_pages(new_process = FALSE, install = FALSE)
          shell: Rscript {0}

        - name: Deploy to GitHub pages
          if: github.event_name != 'pull_request'
          uses: JamesIves/github-pages-deploy-action@v4
          with:
            clean: false
            branch: gh-pages
            folder: docs

This workflow builds and deploys on every push to main. PRs build but do not deploy.

IMPORTANT: After creating this file, you must also:
1. Enable GitHub Pages in the repository settings (Settings → Pages → Source: Deploy
   from branch → branch: gh-pages, folder: / (root)).
2. The first push after enabling Pages will create the gh-pages branch automatically.

Verification:
Push to main and confirm the pkgdown workflow succeeds in GitHub Actions.
Confirm the site is accessible at https://jknowles.github.io/eeptools/.
Status: open
---

---
ID: CI-004
Priority: P2
Category: ci
File: .github/workflows/lint.yaml
Title: Add automated lintr workflow; delete commented-out lintr test file

Finding:
tests/testthat/test-lintr.R is entirely commented out. Linting should be a CI
check, not a testthat file.

Fix — two steps:

Step 1: Create `.github/workflows/lint.yaml`:

  on:
    push:
      branches: [main, master]
    pull_request:
      branches: [main, master]

  name: lint

  jobs:
    lint:
      runs-on: ubuntu-latest
      env:
        GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      steps:
        - uses: actions/checkout@v4

        - uses: r-lib/actions/setup-r@v2
          with:
            use-public-rspm: true

        - uses: r-lib/actions/setup-r-dependencies@v2
          with:
            extra-packages: any::lintr, local::.
            needs: lint

        - name: Lint
          run: lintr::lint_package()
          shell: Rscript {0}

Step 2: Delete `tests/testthat/test-lintr.R` entirely.
Step 3: Add `lintr` to Suggests in DESCRIPTION.

NOTE: The first run of lintr will likely produce many style warnings. These are
informational — the lint workflow should be set to `continue-on-error: true` until
the codebase is cleaned up. Add `continue-on-error: true` to the lint job until
R-style cleanup work is complete.

Verification:
Lint workflow appears in GitHub Actions. test-lintr.R no longer exists.
`grep -r "lintr" tests/` returns no results.
Status: open
---

---
ID: PD-001
Priority: P2
Category: pkgdown
File: _pkgdown.yml (create new)
Title: Create pkgdown configuration

Finding:
No `_pkgdown.yml` exists. Without one, pkgdown auto-generates a site with a flat
function reference — function groups and navbar require explicit configuration.

Fix:
Create `_pkgdown.yml` in the package root with the following content. Adjust the
url once the GitHub Pages site is confirmed live:

  url: https://jknowles.github.io/eeptools/

  template:
    bootstrap: 5

  navbar:
    structure:
      left: [intro, reference, articles, news]
      right: [search, github]
    components:
      github:
        icon: fab fa-github
        href: https://github.com/jknowles/eeptools

  reference:
    - title: Age and Date Calculations
      desc: Functions for computing age, time differences, and school moves
      contents:
        - age_calc
        - moves_calc
        - retained_calc

    - title: Data Utilities
      desc: Functions for cleaning and transforming data
      contents:
        - cleanTex
        - cutoff
        - thresh
        - leading_zero
        - decomma
        - remove_char
        - defac
        - makenum
        - max_mis
        - nth_max
        - lag_data
        - isid

    - title: Statistical Tools
      desc: Functions for simulation and mode estimation
      contents:
        - gelmansim
        - statamode
        - crosstabs
        - crosstabplot

    - title: Plotting
      desc: ggplot2 extensions and diagnostic plots
      contents:
        - autoplot.lm
        - profpoly

    - title: Datasets
      desc: Example education datasets
      contents:
        - matches("^(stuatt|midsch|schprog)$")

    - title: Internal / Deprecated
      desc: >
        Deprecated functions retained for backwards compatibility.
        These will be removed in a future release.
      contents:
        - defac
        - makenum

  Also add `pkgdown` to Suggests in DESCRIPTION.

Verification:
Run `pkgdown::build_site()` locally and confirm the site builds without errors.
Open `docs/index.html` in a browser and confirm the reference index is grouped
correctly.
Status: open
---

---

## P3 — Polish and best-practice alignment

---
ID: R-024
Priority: P3
Category: cran-readiness
File: NAMESPACE
Lines: 29-31
Title: Broad import() calls for four packages — replace with importFrom()

Finding:
NAMESPACE contains:
  import(arm)
  import(data.table)
  import(ggplot2)
  import(vcd)
These import ALL exported objects from each package, increasing collision risk and
slowing load time. CRAN prefers `importFrom()` for specific functions.

Fix (high effort — do this last):
1. For each of the four packages, identify which specific functions are actually used
   in the package source. Run:
     grep -rn "arm::\|ggplot2::\|data.table::\|vcd::" R/
   Also check for unqualified calls that rely on the broad import.
2. Add `@importFrom pkg function` roxygen2 tags to the functions that use them.
3. Remove the four `import()` lines from NAMESPACE (they will be removed automatically
   by `devtools::document()` once the `@importFrom` tags replace them).
4. Run `devtools::check()` after each package is converted to catch missing imports.

Convert one package at a time: vcd first (smallest surface area), then arm, then
data.table (largest), then ggplot2 last (most pervasive).

Verification:
`devtools::check()` must produce no WARNING about undefined or missing symbols.
Status: open
---

---
ID: R-025
Priority: P3
Category: docs
File: R/remove_char.R
Line: 18
Title: Example does not demonstrate function output

Finding:
The @example shows `as.numeric(b)` which is not what the function produces.

Fix:
Replace the @examples block with:
  ##' @examples
  ##' a <- c(1, 5, 3, 6, "*", 2, 5, "*", "*")
  ##' remove_char(a, "*")

Verification:
`devtools::run_examples(pkg=".", start="remove_char")` runs without error.
The output shows the NA-substituted character vector.
Status: open
---

---
ID: R-026
Priority: P3
Category: code-quality
File: R/isid.R
Lines: 28-33
Title: Uses cat()/print() instead of message() for verbose output

Finding:
When `verbose = TRUE`, the function calls `cat()` and `print()`. Package code
should use `message()` so output can be suppressed by `suppressMessages()`.

Fix:
Find each `cat()` call in the verbose block (lines 28-33) and replace with `message()`.
Find each `print()` call and replace with `message(capture.output(...))` or restructure
to pass the value to `message()` directly.

Example transformation:
  cat("Variables", paste(vars, collapse=", "), "do not uniquely identify rows\n")
  →
  message("Variables ", paste(vars, collapse=", "), " do not uniquely identify rows")

Verification:
`suppressMessages(isid(stuatt, vars=c("sid","school_year"), verbose=TRUE))` should
produce no output. The existing test at test-utils.R line 194 uses `expect_output()`
which checks for printed output — update that test to use `expect_message()` instead.
Status: open
---

---
ID: R-027
Priority: P3
Category: tests
File: tests/testthat/test-lintr.R
Title: Commented-out lintr test file is obsolete — delete it

Finding:
All 26 lines are commented out. Linting is now handled by CI-004.

Fix:
Delete `tests/testthat/test-lintr.R` entirely.

Verification:
`devtools::test()` runs without referencing the lintr test file.
`ls tests/testthat/` does not include test-lintr.R.
Status: open
---

---
ID: R-028
Priority: P3
Category: code-quality
File: R/defac.R
Lines: 16-18
Title: defac is a trivial wrapper — deprecate, do not remove

Finding:
`defac` wraps `as.character(x)` with no additional logic. It should be deprecated
rather than removed outright, since removing it would break existing CRAN users.

Fix:
Change the function body from:
  defac<-function(x){
    x <- as.character(x)
    x
  }
To:
  defac <- function(x){
    .Deprecated("as.character",
                msg = "'defac' is deprecated. Use 'as.character(x)' instead.")
    as.character(x)
  }

Add to NEWS.md under the new version section:
  - `defac()` is now deprecated. Use `as.character()` directly.

Verification:
`defac(as.factor(letters))` should still return a character vector AND print a
deprecation warning. `expect_warning(defac(factor("a")))` should pass.
Status: open
---

---
ID: R-029
Priority: P3
Category: code-quality
File: R/destring.R
Lines: 23-26
Title: makenum is a trivial wrapper — deprecate, do not remove

Finding:
`makenum` wraps `as.numeric(as.character(x))`. Same situation as R-028.

Fix:
Change the function body from:
  makenum <- function(x){
    x <- as.character(x)
    x <- as.numeric(x)
    return(x)
  }
To:
  makenum <- function(x){
    .Deprecated("as.numeric",
                msg = paste0("'makenum' is deprecated. ",
                             "Use 'as.numeric(as.character(x))' instead."))
    as.numeric(as.character(x))
  }

Add to NEWS.md:
  - `makenum()` is now deprecated. Use `as.numeric(as.character(x))` directly.

Verification:
`makenum(ordered(c(1,3,'09',7,5)))` should return the correct numeric vector AND
print a deprecation warning. `expect_warning(makenum(factor("1")))` should pass.
Status: open
---

---
ID: PD-002
Priority: P3
Category: pkgdown
File: README.Rmd
Title: Add coverage and pkgdown status badges to README

Finding:
Once CI-002 (coverage) and CI-003 (pkgdown) are live, update the badge section
in README.Rmd.

Fix:
In README.Rmd, replace or extend the existing badge lines near the top with:

  [![CRAN Status](https://www.r-pkg.org/badges/version/eeptools)](https://cran.r-project.org/package=eeptools)
  [![R-CMD-check](https://github.com/jknowles/eeptools/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/jknowles/eeptools/actions/workflows/check-standard.yaml)
  [![Codecov coverage](https://codecov.io/gh/jknowles/eeptools/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jknowles/eeptools)
  [![pkgdown site](https://img.shields.io/badge/docs-pkgdown-blue)](https://jknowles.github.io/eeptools/)

Re-knit README.Rmd with `devtools::build_readme()` after updating.

Verification:
README.md badges render correctly on GitHub and link to the correct destinations.
Status: blocked-by: CI-002, CI-003
---

---

## Deferred / Out of Scope

---
ID: GH-030
Priority: deferred
GitHub: https://github.com/jknowles/eeptools/issues/30
Title: Top and Bottom N functions
Finding: Feature request open since 2015. Out of scope for a tidy/revive pass.
Status: defer
---

---
ID: GH-009
Priority: deferred
GitHub: https://github.com/jknowles/eeptools/issues/9
Title: Data documentation — add graphics to dataset docs
Finding: Enhancement open since 2013. Worthwhile but not blocking any goal in this pass.
Status: defer
---

---

## Implementation Phases

### Phase 1 — CRAN-readiness baseline
Fix all P0 issues, bump CI actions. Target: `R CMD CHECK --as-cran` produces zero
ERRORs and zero WARNINGs.
- R-001 (fix timestamp in age_calc examples)
- R-002 (document or fix leading_zero mixed-sign behavior)
- R-003 (add testthat version constraint — do after R-008 and R-009)
- CI-001 (bump actions/checkout to v4)

### Phase 2 — Code quality and test modernization
Work through all P1 code and test fixes. Run `devtools::test()` after each file change.
- R-004 (typo in age_calc docs)
- R-005 (guard readline with interactive())
- R-006 (remove stringsAsFactors=TRUE in moves_calc)
- R-007 (fix retained_calc I() and mutation)
- R-008 (modernize test-gelmansim.R to testthat 3)
- R-009 (modernize test-utils.R to testthat 3)
- R-010 (remove dead zzz() function; move @importFrom)
- R-011 (delete commented-out code in proficiency_tools.R)
- GH-028 (investigate and fix crosstabplot title bug)
- D-002 (update README.Rmd output format)
- D-003 (use packageVersion() in startup message)
- D-004 (remove "still in beta" from package docs)

### Phase 3 — CI expansion and pkgdown launch
- CI-002 (add test-coverage workflow)
- CI-003 (add pkgdown deploy workflow + enable GitHub Pages)
- CI-004 (add lint workflow; delete test-lintr.R / R-027)
- PD-001 (create _pkgdown.yml)
- D-001 (update URL field in DESCRIPTION once pkgdown site is live)

### Phase 4 — P2 code quality pass
- R-012 through R-022
- D-005 (audit and update vignette)

### Phase 5 — P3 polish and deprecations
- R-024 (replace broad import() with importFrom — high effort, do last)
- R-025, R-026
- R-028, R-029 (deprecate defac and makenum)
- PD-002 (add badges to README — blocked by CI-002 and CI-003)
