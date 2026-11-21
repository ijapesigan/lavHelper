# Shared test helpers (testthat sources helper-*.R before the tests).
# rProject writes this file once; it is yours after that.

# Slow tests: run on CI and on request, skipped in local builds and on CRAN.
.SkipSlow <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_not(
    condition = Sys.getenv(x = "CI") == "true" ||
      Sys.getenv(x = "RPROJECT_SLOW_TESTS") == "true",
    message = "set RPROJECT_SLOW_TESTS=true to run slow tests"
  )
}

# Proprietary software: never on CI or CRAN, and only where it is found.
.SkipIfMissing <- function(program) {
  testthat::skip_on_cran()
  testthat::skip_on_ci()
  testthat::skip_if(
    condition = Sys.which(names = program) == "",
    message = paste0(program, " is not installed")
  )
}

# Data and fitted models shared by the lavHelper tests.
.TestData <- function() {
  set.seed(seed = 1234)
  data.frame(
    y = stats::rnorm(n = 100),
    x1 = stats::rnorm(n = 100),
    x2 = stats::rnorm(n = 100),
    x3 = stats::rnorm(n = 100)
  )
}

.TestFitReg <- function(model = "y ~ b1 * x1 + b2 * x2 + b3 * x3") {
  suppressWarnings(
    expr = lavaan::sem(
      model = model,
      data = .TestData()
    )
  )
}

.TestFitMean <- function() {
  .TestFitReg(
    model = "
      y ~ b1 * x1 + b2 * x2 + b3 * x3
      y ~ b0 * 1
      x1 ~ mux1 * 1
      x2 ~ mux2 * 1
      x3 ~ mux3 * 1
      y ~~ s * y
      x1 ~~ s11 * x1
      x1 ~~ s12 * x2
      x1 ~~ s13 * x3
      x2 ~~ s22 * x2
      x2 ~~ s23 * x3
      x3 ~~ s33 * x3
    "
  )
}

.TestFitCFA <- function() {
  lavaan::cfa(
    model = "f =~ x1 + x2 + x3",
    data = .TestData()
  )
}

# Expected RAM matrices of the regression model with means
# (order y, x1, x2, x3).
.TestRAM <- function(coef) {
  nm <- c("y", "x1", "x2", "x3")
  a_mat <- s_mat <- matrix(
    data = 0,
    nrow = 4,
    ncol = 4,
    dimnames = list(nm, nm)
  )
  a_mat[1, 2:4] <- coef[c("b1", "b2", "b3")]
  s_mat[2:4, 2:4] <- coef[
    c(
      "s11", "s12", "s13",
      "s12", "s22", "s23",
      "s13", "s23", "s33"
    )
  ]
  s_mat[1, 1] <- coef["s"]
  list(
    A = a_mat,
    S = s_mat
  )
}

# A plain numeric matrix (drops the lavaan classes, keeps dimnames).
.Plain <- function(x) {
  if (is.null(x = dim(x = x))) {
    as.vector(x = x)
  } else {
    matrix(
      data = as.vector(x = x),
      nrow = nrow(x = x),
      ncol = ncol(x = x),
      dimnames = dimnames(x = x)
    )
  }
}
