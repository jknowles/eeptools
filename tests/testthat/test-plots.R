# Test plotting functions


context("Test that regression can be autoplotted")

test_that("Autoplot works as expected for linear models", {
  a <- runif(1000)
  b <- 7*a+rnorm(1)
  mymod <- lm(b~a)
  test_plot_file <- "lmautoplot.png"
  png(test_plot_file)
  p1 <- autoplot(mymod)
  dev.off()
  expect_true(file.exists(test_plot_file))
  unlink(test_plot_file)
  
  # Multivariate
  data(mpg)
  mymod <- lm(cty~displ + cyl + drv, data=mpg)
  test_plot_file <- "lmautoplot.png"
  png(test_plot_file)
  p1 <- autoplot(mymod)
  dev.off()
  expect_true(file.exists(test_plot_file))
  unlink(test_plot_file)
  
  test_plot_file <- "lmautoplot.png"
  png(test_plot_file)
  p2 <- autoplot(mymod, which = 1:5, mfrow = c(1, 5))
  dev.off()
  expect_true(file.exists(test_plot_file))
  unlink(test_plot_file)

})


