## ---- test-lavHelper-no-cov-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "k = 2"),
      code = {
        testthat::expect_equal(
          object = .NoCov(
            x = c("a", "b")
          ),
          expected = "a ~~ 0 * b"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "k = 3"),
      code = {
        testthat::expect_equal(
          object = .NoCov(
            x = c("a", "b", "c")
          ),
          expected = "a ~~ 0 * b\na ~~ 0 * c\nb ~~ 0 * c"
        )
      }
    )
  },
  text = "test-lavHelper-no-cov-dot"
)
