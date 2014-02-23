context("Correct mode selected")

test_that("statamode selects the mode right for each method", {
  expect_that(statamode("a"), matches("a"))
  expect_that(statamode(c("a", "a", "b", "b"), method="stata"), matches("."))
  expect_that(statamode(c("a", "a", "b", "b"), method="last"), matches("b"))
 # expect_that(statamode(c("a", "a", "b", "b"), method="sample"), matches(c("a", "b"),all=FALSE))
})


a <- c(7, 7, 3, 1, 9, 8, 4, 4)
b <- statamode(a, method="last")
c <- statamode(a, method="stata")
d <- statamode(a, method="sample")


test_that("statamode returns correct modes for each method using numbers", {
  expect_is(c, "character")
  expect_is(b, "character")
  expect_is(d, "character")
  #expect_match(c, ".")
  #expect_match(b, "7")
  #expect_true(d %in% c("4", "7"))
})

#context("Correct NA Type Returned")


# test_that("statamode returns NAs of the proper type", {
#   expect_that(statamode(c()), gives_warning())
#   expect_that(statamode(c()), equals(NA_character_))
#   expect_that(statamode(c(), method="sample"), equals(NA_character_))
#   expect_that(statamode(c(), method="last"), equals(NA_character_))
# })
