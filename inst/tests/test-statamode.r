context("Correct mode selected")

test_that("statamode selects the mode right for each method", {
  expect_that(statamode("a"), matches("a"))
  expect_that(statamode(c("a", "a", "b", "b"), method="stata"), matches("."))
  expect_that(statamode(c("a", "a", "b", "b"), method="last"), matches("b"))
  expect_that(statamode(c("a", "a", "b", "b"), method="sample"), matches(c("a", "b"),all=FALSE))
})

context("Correct Type Returned")

# sample and last

test_that("statamode returns NAs of the proper type", {
  expect_that(statamode(c()), gives_warning())
  expect_that(statamode(c()), equals(NA_character_))
  expect_that(statamode(c(), method="sample"), equals(NA_character_))
  expect_that(statamode(c(), method="last"), equals(NA_character_))
})