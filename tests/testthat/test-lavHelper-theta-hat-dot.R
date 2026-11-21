## ---- test-lavHelper-theta-hat-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitReg()
    testthat::test_that(
      desc = paste(text, "same as ThetaHat"),
      code = {
        testthat::expect_equal(
          object = .ThetaHat(
            object = fit,
            est = NULL
          ),
          expected = ThetaHat(
            object = fit
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "labels replace the equation names"),
      code = {
        testthat::expect_equal(
          object = .ThetaHat(
            object = fit
          )$par_names[1:3],
          expected = c("b1", "b2", "b3")
        )
      }
    )
  },
  text = "test-lavHelper-theta-hat-dot"
)
