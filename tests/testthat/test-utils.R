# Test utils

#defac
context("Test defac conversion of factors")

test_that("defac works for all types of factors", {
  a <- as.factor(LETTERS)
  b <- ordered(c(1, 3, '09', 7, 5, "B"))
  expect_is(defac(a), "character")
  expect_is(defac(b), "character")
  a2 <- defac(a)
  b2 <- defac(b)
  expect_identical(levels(a), a2)
  expect_true(all(levels(b) %in% b2))
  expect_identical(length(a), length(a2))
  expect_identical(length(b), length(b2))
})

context("Forcing numerics with makenum")

test_that("makenum works for all types of factors", {
  a <- ordered(c(1, 3, '09', 7, 5))
  a2 <- makenum(a)
  b <- factor(c(1, 3, '09', 7, 5))
  b2 <- makenum(b)
  c <- factor(c(1, 3, '09', 7, 5, "B"))
  c2 <- makenum(c)
  expect_is(a2, "numeric")
  expect_is(b2, "numeric")
  expect_is(c2, "numeric")
  expect_identical(length(a), length(a2))
  expect_identical(length(b), length(b2))
  expect_identical(length(c), length(c2))
  expect_identical(a2, b2)
  expect_identical(c2[6], NA_real_)
})

context("Test that cutoff is numerically accurate")

test_that("cutoff gets the desired result", {
  a <- rnorm(1000, mean = 0, sd = 1)
  b <- rlnorm(1000, meanlog = 2, sdlog = 1)
  cutoff(a, .05) 
  cutoff(b, .8)
  
})

context("Test the threshold function for numeric accuracy")


test_that("thresh gets the accurate result", {
  #thresh
  ##' # for vector
  ##' a <- rnorm(100, mean=6, sd=1)
  ##' thresh(a, 8) #return minimum number of elements to account 70 percent of total
  ##' 
})

context("Test that max_mis works correctly")

test_that("max_mis handles missing data correctly", {
  #maxmis
  ##' max(c(7,NA,3,2,0),na.rm=TRUE)
  ##' max_mis(c(7,NA,3,2,0))
  ##' max(c(NA,NA,NA,NA),na.rm=TRUE)
  ##' max_mis(c(NA,NA,NA,NA))
  ##' 

  
})

context("Remove character")

test_that("Remove character works for multiple character type", {
  # remov_char
  ##' a <- c(1, 5, 3, 6, "*", 2, 5, "*", "*")
  ##' b <- remove_char(a, "*")
  ##' as.numeric(b)
})


context("Leading zero functions as desired")

test_that("Function works for multiple types of inputs", {
  a <- seq(1, 9)
  a2 <- leading_zero(a, digits = 2)
  expect_is(a2, "character")
  expect_true(all(sapply(a2, nchar)==2))
  expect_error(leading_zero(a2, digits = -1))
  expect_error(leading_zero(a2, digits = 0))
  expect_identical(leading_zero(a, digits = -1), leading_zero(a, digits = 0))
  
  a <- seq(9, 25)
  a2 <- leading_zero(a, digits = 3)
  expect_is(a2, "character")
  expect_true(all(sapply(a2, nchar)==3))
  a2 <- leading_zero(a, digits = 1)
  expect_false(all(sapply(a2, nchar)==1))
  
  expect_error(leading_zero(c("A", "B", "C", digits = 2)))
  a <- c(-5000, -50, -5, -.01, 0, 0.1, 4, 40, 400, 4000)
  a2 <- leading_zero(a, digits = 3)
  expect_identical(a2, c("-5000", "-050", "-005", "0000", "0000", "0000", 
                         "0004", "0040", 
                         "0400", "4000"))
})


