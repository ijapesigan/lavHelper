## ---- test-lavHelper-theta-hat
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitReg()
    thetahat <- ThetaHat(
      object = fit
    )
    fixed <- thetahat$est[thetahat$fixed]
    est <- lavaan::parameterEstimates(object = fit)
    testthat::test_that(
      desc = paste(text, "elements"),
      code = {
        testthat::expect_equal(
          object = names(x = thetahat),
          expected = c(
            "est", "par_names", "def", "ceq", "cin", "fixed", "free"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "fixed names"),
      code = {
        testthat::expect_equal(
          object = names(x = fixed),
          expected = c(
            "x1~~x1", "x1~~x2", "x1~~x3", "x2~~x2", "x2~~x3", "x3~~x3"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "fixed values"),
      code = {
        testthat::expect_equal(
          object = unname(obj = fixed),
          expected = est[5:10, "est"]
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "free names and values"),
      code = {
        free <- thetahat$est[thetahat$free]
        testthat::expect_equal(
          object = names(x = free),
          expected = names(x = lavaan::coef(object = fit))
        )
        testthat::expect_equal(
          object = unclass(x = free),
          expected = unclass(x = lavaan::coef(object = fit))
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "est replaces the estimates"),
      code = {
        new <- seq_len(length.out = nrow(x = est))
        out <- ThetaHat(
          object = fit,
          est = new
        )
        testthat::expect_equal(
          object = unname(obj = out$est),
          expected = new
        )
        testthat::expect_equal(
          object = out$par_names,
          expected = thetahat$par_names
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "no constraints or defined parameters"),
      code = {
        testthat::expect_length(
          object = thetahat$def,
          n = 0
        )
        testthat::expect_length(
          object = thetahat$ceq,
          n = 0
        )
        testthat::expect_length(
          object = thetahat$cin,
          n = 0
        )
      }
    )
  },
  text = "test-lavHelper-theta-hat"
)

## ---- test-lavHelper-theta-hat-constraint
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitReg(
      model = "
        y ~ b1 * x1 + b2 * x2 + b3 * x3
        b1 == (b2 + b3)^2
        b1 > exp(b2 + b3)
        b1b2 := b1 * b2
      "
    )
    thetahat <- ThetaHat(
      object = fit
    )
    testthat::test_that(
      desc = paste(text, "constraint and defined parameter names"),
      code = {
        testthat::expect_equal(
          object = thetahat$ceq,
          expected = "b1"
        )
        testthat::expect_equal(
          object = thetahat$cin,
          expected = "b1"
        )
        testthat::expect_equal(
          object = thetahat$def,
          expected = "b1b2"
        )
        testthat::expect_true(
          object = all(c("b1_ceq", "b1_cin") %in% thetahat$par_names)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "defined parameter value"),
      code = {
        est <- thetahat$est
        testthat::expect_equal(
          object = unname(obj = est["b1b2"]),
          expected = unname(obj = est["b1"] * est["b2"])
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "free parameters"),
      code = {
        testthat::expect_equal(
          object = thetahat$free,
          expected = names(x = lavaan::coef(object = fit))
        )
      }
    )
  },
  text = "test-lavHelper-theta-hat-constraint"
)
