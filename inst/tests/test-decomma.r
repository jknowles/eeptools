context("Check processing")


a <- c("12,124", "21,131", "A,b")
b <- c("12124", "21131", "Ab")

c <- a[1:2]
d <- as.numeric(b[1:2])

test_that("decomma returns the right class", {
  expect_that(decomma(c), equals(d))
  expect_that(decomma(a), gives_warning())
  expect_that(decomma(a), is_a("numeric"))
  expect_that(decomma(b), is_a("numeric"))
  expect_that(decomma(c), is_a("numeric"))
  expect_that(decomma(d), is_a("numeric"))
})

context("Check NA handling")

n <- c(NA, NA, NA, "7,102", "27,125", "23,325,22", "Ab")

test_that("decomma handles NAs properly", {
  expect_that(length(decomma(n)[!is.na(decomma(n))]), equals(3))
  expect_that(decomma(n)[6], equals(2332522))
})

