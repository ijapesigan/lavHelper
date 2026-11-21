## ---- test-lavHelper-lav-2-ram-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::skip_if_not_installed(pkg = "lavaan")
    message(text)
    lav_mod <- lavaan::lavInspect(object = .TestFitMean(), what = "est")
    testthat::test_that(
      desc = paste(text, "A, S, F, M"),
      code = {
        ram <- lavHelper:::.Lav2RAM(lav_mod = lav_mod)
        testthat::expect_equal(
          object = names(x = ram),
          expected = c("A", "S", "F", "M")
        )
        testthat::expect_equal(
          object = ram,
          expected = Lav2RAM(lav_mod = lav_mod)
        )
      }
    )
  },
  text = "test-lavHelper-lav-2-ram-dot"
)
