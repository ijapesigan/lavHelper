## ---- test-lavHelper-theta-hat-def-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitReg()
    est <- lavaan::parameterEstimates(object = fit)[, "est"]
    names_all <- paste0(
      fit@ParTable$lhs,
      fit@ParTable$op,
      fit@ParTable$rhs
    )
    out <- .ThetaHatDef(
      object = fit,
      thetahat_est = est,
      thetahat_names_free = c("b1", "b2", "b3"),
      thetahat_names = names_all
    )
    testthat::test_that(
      desc = paste(text, "elements"),
      code = {
        testthat::expect_equal(
          object = names(x = out),
          expected = c("est", "par_names", "def", "ceq", "cin", "fixed", "free")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "fixed parameters are the fixed names"),
      code = {
        testthat::expect_equal(
          object = out$fixed,
          expected = names_all[fit@ParTable$free == 0]
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "est is named"),
      code = {
        testthat::expect_equal(
          object = names(x = out$est),
          expected = names_all
        )
      }
    )
  },
  text = "test-lavHelper-theta-hat-def-dot"
)
