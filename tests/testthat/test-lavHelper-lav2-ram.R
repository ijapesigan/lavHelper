## ---- test-lavHelper-lav2-ram
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitMean()
    coef <- lavaan::coef(object = fit)
    ram <- Lav2RAM(
      lav_mod = lavaan::lavInspect(
        object = fit,
        what = "est"
      )
    )
    exp_ram <- .TestRAM(coef = coef)
    nm <- c("y", "x1", "x2", "x3")
    testthat::test_that(
      desc = paste(text, "names"),
      code = {
        testthat::expect_equal(
          object = names(x = ram),
          expected = c("A", "S", "F", "M")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "A"),
      code = {
        testthat::expect_equal(
          object = ram$A,
          expected = exp_ram$A
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "S"),
      code = {
        testthat::expect_equal(
          object = ram$S,
          expected = exp_ram$S
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "F"),
      code = {
        f_mat <- diag(x = 4)
        dimnames(x = f_mat) <- list(nm, nm)
        testthat::expect_equal(
          object = ram$F,
          expected = f_mat
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "M"),
      code = {
        m_mat <- matrix(
          data = coef[c("b0", "mux1", "mux2", "mux3")],
          nrow = 1,
          dimnames = list(NULL, nm)
        )
        testthat::expect_equal(
          object = ram$M,
          expected = m_mat,
          ignore_attr = TRUE
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "latent variable: k = 4 variables, p = 3 indicators"),
      code = {
        ram_cfa <- Lav2RAM(
          lav_mod = lavaan::lavInspect(
            object = .TestFitCFA(),
            what = "est"
          )
        )
        testthat::expect_equal(
          object = rownames(x = ram_cfa$A),
          expected = c("x1", "x2", "x3", "f")
        )
        testthat::expect_equal(
          object = dim(x = ram_cfa$F),
          expected = c(3L, 4L)
        )
        testthat::expect_equal(
          object = unname(obj = ram_cfa$A[1, 4]),
          expected = 1
        )
      }
    )
  },
  text = "test-lavHelper-lav2-ram"
)
