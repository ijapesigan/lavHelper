## ---- test-lavHelper-std-ram
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitMean()
    coef <- lavaan::coef(object = fit)
    std_coef <- lavaan::standardizedSolution(object = fit)
    std_coef <- stats::setNames(
      object = std_coef[, "est.std"],
      nm = std_coef[, "label"]
    )[names(x = coef)]
    ram <- StdRAM(
      ram_est = Lav2RAM(
        lav_mod = lavaan::lavInspect(
          object = fit,
          what = "est"
        )
      )
    )
    exp_ram <- .TestRAM(coef = std_coef)
    testthat::test_that(
      desc = paste(text, "A matches lavaan"),
      code = {
        testthat::expect_equal(
          object = ram$A,
          expected = exp_ram$A,
          tolerance = 1e-6
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "S matches lavaan (the y variance is the standardized",
        "residual variance)"
      ),
      code = {
        testthat::expect_equal(
          object = ram$S[2:4, 2:4],
          expected = exp_ram$S[2:4, 2:4],
          tolerance = 1e-6
        )
        testthat::expect_equal(
          object = ram$S[1, 1],
          expected = exp_ram$S[1, 1],
          tolerance = 1e-6
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "M is zero, F is unchanged"),
      code = {
        testthat::expect_true(
          object = all(ram$M == 0)
        )
        testthat::expect_equal(
          object = unname(obj = ram$F),
          expected = diag(x = 4)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "k = 1 variable"),
      code = {
        ram_1 <- StdRAM(
          ram_est = list(
            A = matrix(data = 0, nrow = 1, ncol = 1),
            S = matrix(data = 4, nrow = 1, ncol = 1),
            F = matrix(data = 1, nrow = 1, ncol = 1),
            M = matrix(data = 2, nrow = 1, ncol = 1)
          )
        )
        testthat::expect_equal(
          object = ram_1$S[1, 1],
          expected = 1
        )
        testthat::expect_equal(
          object = ram_1$M[1, 1],
          expected = 0
        )
      }
    )
  },
  text = "test-lavHelper-std-ram"
)
