## ---- test-lavHelper-std-lav-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitMean()
    testthat::test_that(
      desc = paste(
        text,
        "standardized solution of the regression coefficients"
      ),
      code = {
        std <- .StdLav(
          est = lavaan::coef(object = fit),
          object = fit
        )
        std_lav <- lavaan::standardizedSolution(object = fit)
        reg <- std_lav$op == "~" & std_lav$rhs != "1"
        testthat::expect_equal(
          object = unname(obj = std[1:3]),
          expected = std_lav[reg, "est.std"],
          tolerance = 1e-6
        )
      }
    )
  },
  text = "test-lavHelper-std-lav-dot"
)
