## ---- test-lavHelper-std-ram-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::skip_if_not_installed(pkg = "lavaan")
    message(text)
    ram <- Lav2RAM(
      lav_mod = lavaan::lavInspect(object = .TestFitMean(), what = "est")
    )
    testthat::test_that(
      desc = paste(text, "unit variances and zero means"),
      code = {
        std <- lavHelper:::.StdRAM(ram_est = ram)
        b_inv <- solve(a = diag(x = nrow(x = std$A)) - std$A)
        testthat::expect_equal(
          object = unname(obj = diag(x = b_inv %*% std$S %*% t(x = b_inv))),
          expected = rep(x = 1, times = nrow(x = std$A))
        )
        testthat::expect_true(
          object = all(std$M == 0)
        )
      }
    )
  },
  text = "test-lavHelper-std-ram-dot"
)
