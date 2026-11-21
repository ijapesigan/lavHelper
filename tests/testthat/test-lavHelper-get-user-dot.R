## ---- test-lavHelper-get-user-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitMean()
    testthat::test_that(
      desc = paste(
        text,
        "equals lavaan::lav_model_get_parameters"
      ),
      code = {
        testthat::expect_equal(
          object = .GetUser(
            lavmodel = fit@Model
          ),
          expected = lavaan::lav_model_get_parameters(
            lavmodel = fit@Model,
            type = "user",
            extra = TRUE
          ),
          tolerance = 1e-12
        )
      }
    )
  },
  text = "test-lavHelper-get-user-dot"
)
