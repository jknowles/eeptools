# Lifecycle tests: confirm deprecated functions warn and defunct functions error.
# Each deprecated function calls .Deprecated() on its first line, so
# first_warning() captures the deprecation notice before any heavy work runs.

test_that("trivial base-R wrappers are deprecated", {
  expect_match(first_warning(defac(factor("a"))), "deprecated")
  expect_match(first_warning(makenum(factor("1"))), "deprecated")
  expect_match(first_warning(decomma("1,000")), "deprecated")
})

test_that("superseded statistical and plotting tools are deprecated", {
  expect_match(first_warning(gelmansim(mod = NULL, newdata = NULL, n.sims = 1)),
               "deprecated")
  expect_match(first_warning(autoplot(structure(list(), class = "lm"))),
               "deprecated")
  df <- data.frame(x = c("a", "b", "a", "b"), y = c("p", "q", "p", "q"))
  expect_match(first_warning(crosstabs(df, "x", "y", varnames = c("X", "Y"))),
               "deprecated")
  expect_match(first_warning(crosstabplot(df, "x", "y", varnames = c("X", "Y"))),
               "deprecated")
})

test_that("assessment-band and lag helpers are deprecated", {
  expect_match(first_warning(profpoly(data.frame())), "deprecated")
  expect_match(first_warning(
    profpoly.data(grades = NULL, LOSS = NULL, minimal = NULL, basic = NULL,
                  proficient = NULL, advanced = NULL, HOSS = NULL)),
    "deprecated")
  td <- expand.grid(id = letters[1:3], time = 1:3)
  td$v <- rnorm(9)
  expect_match(
    first_warning(lag_data(td, group = "id", time = "time",
                           values = "v", periods = 1)),
    "deprecated")
})

test_that("cleanTex is deprecated", {
  d <- tempfile()
  dir.create(d)
  old <- setwd(d)
  on.exit(setwd(old), add = TRUE)
  expect_match(first_warning(cleanTex("no_such_file_xyz")), "deprecated")
})

test_that("legacy DPI themes are defunct", {
  expect_error(theme_dpi(), "defunct")
  expect_error(theme_dpi_map(), "defunct")
  expect_error(theme_dpi_map2(), "defunct")
  expect_error(theme_dpi_mapPNG(), "defunct")
})
