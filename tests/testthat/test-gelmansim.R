require(MASS)
#Examples of "sim" 
set.seed (1)
J <- 15
n <- J*(J+1)/2
group <- rep (1:J, 1:J)
mu.a <- 5
sigma.a <- 2
a <- rnorm (J, mu.a, sigma.a)
b <- -3
x <- rnorm (n, 2, 1)
sigma.y <- 6
y <- rnorm (n, a[group] + b*x, sigma.y)
u <- runif (J, 0, 3)
y123.dat <- cbind (y, x, group)
# Linear regression 
x1 <- y123.dat[,2]
y1 <- y123.dat[,1]
M1 <- glm (y1 ~ x1)

cases <- data.frame(x1 = seq(-2, 2, by=0.1))
sim.results <- suppress_deprecation(gelmansim(mod = M1, newdata = cases, n.sims=200, na.omit=TRUE))


test_that("returned dataframe is correct size", {
  expect_equal(dim(sim.results)[1], length(seq(-2, 2, by=0.1)))
  expect_equal(dim(sim.results)[2], 4)
  expect_s3_class(sim.results, "data.frame")
})

test_that("values of simulations are sensible", {  
  expect_true(all(sim.results$yhatMin < sim.results$yhats))
  expect_true(all(sim.results$yhatMax > sim.results$yhats))
  expect_true(all(!is.na(sim.results$yhats)))
  expect_true(all(!is.na(sim.results$yhatMin)))
  expect_true(all(!is.na(sim.results$yhatMax)))
})


dat <- as.data.frame(y123.dat, stringsAsFactors = TRUE)
M2 <- glm(y1 ~ x1 + group, data = dat)

cases <- expand.grid(x1 = seq(-2, 2, by = 0.1), 
                     group = seq(1, 14, by = 2))

sim.results <- suppress_deprecation(gelmansim(M2, newdata=cases, n.sims=200, na.omit=TRUE))

test_that("returned dataframe is correct size", {
  expect_equal(dim(sim.results)[1], nrow(cases))
  expect_equal(dim(sim.results)[2], 3 + ncol(cases))
  expect_s3_class(sim.results, "data.frame")
})

test_that("values of simulations are sensible", {  
  expect_true(all(sim.results$yhatMin < sim.results$yhats))
  expect_true(all(sim.results$yhatMax > sim.results$yhats))
  expect_true(all(!is.na(sim.results$yhats)))
  expect_true(all(!is.na(sim.results$yhatMin)))
  expect_true(all(!is.na(sim.results$yhatMax)))
})


dat$group <- factor(dat$group)
M3 <- glm (y1 ~ x1 + group, data=dat)

cases <- expand.grid(x1 = seq(-2, 2, by=0.1), 
                     group=seq(1, 14, by=2))
cases$group <- factor(cases$group)

sim.results <- suppress_deprecation(gelmansim(M3, newdata=cases, n.sims=200, na.omit=TRUE))

test_that("returned dataframe is correct size", {
  expect_equal(dim(sim.results)[1], nrow(cases))
  expect_equal(dim(sim.results)[2], 3 + ncol(cases))
  expect_s3_class(sim.results, "data.frame")
})

test_that("values of simulations are sensible", {  
  expect_true(all(sim.results$yhatMin < sim.results$yhats))
  expect_true(all(sim.results$yhatMax > sim.results$yhats))
  expect_true(all(!is.na(sim.results$yhats)))
  expect_true(all(!is.na(sim.results$yhatMin)))
  expect_true(all(!is.na(sim.results$yhatMax)))
})


dat$group <- factor(dat$group)
M4 <- lm(y1 ~ x1 + group, data=dat)

cases <- expand.grid(x1 = seq(-2, 2, by=0.1), 
                     group=seq(1, 14, by=2))
cases$group <- factor(cases$group)

sim.results <- suppress_deprecation(gelmansim(M4, newdata=cases, n.sims=200, na.omit=TRUE))


test_that("returned dataframe is correct size", {
  expect_equal(dim(sim.results)[1], nrow(cases))
  expect_equal(dim(sim.results)[2], 3 + ncol(cases))
  expect_s3_class(sim.results, "data.frame")
})

test_that("values of simulations are sensible", {  
  expect_true(all(sim.results$yhatMin < sim.results$yhats))
  expect_true(all(sim.results$yhatMax > sim.results$yhats))
  expect_true(all(!is.na(sim.results$yhats)))
  expect_true(all(!is.na(sim.results$yhatMin)))
  expect_true(all(!is.na(sim.results$yhatMax)))
})
