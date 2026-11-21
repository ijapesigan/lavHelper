## ---- test-lavHelper-ram-2-lav-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::skip_if_not_installed(pkg = "lavaan")
    message(text)
    lav_mod <- lavaan::lavInspect(object = .TestFitMean(), what = "est")
    ram <- lavHelper:::.Lav2RAM(lav_mod = lav_mod)
    testthat::test_that(
      desc = paste(text, "round trip"),
      code = {
        out <- lavHelper:::.RAM2Lav(ram = ram, lav_mod = lav_mod)
        for (j in c("theta", "psi", "beta", "nu", "alpha")) {
          if (!is.null(x = lav_mod[[j]])) {
            testthat::expect_equal(
              object = as.vector(x = out[[j]]),
              expected = as.vector(x = lav_mod[[j]])
            )
          }
        }
      }
    )
    testthat::test_that(
      desc = paste(text, "a model list without lambda"),
      code = {
        no_lambda <- lav_mod
        no_lambda$lambda <- NULL
        testthat::expect_no_error(
          object = lavHelper:::.RAM2Lav(ram = ram, lav_mod = no_lambda)
        )
      }
    )
  },
  text = "test-lavHelper-ram-2-lav-dot"
)
