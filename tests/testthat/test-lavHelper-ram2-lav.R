## ---- test-lavHelper-ram2-lav
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    fit <- .TestFitMean()
    lav_mod <- lavaan::lavInspect(
      object = fit,
      what = "est"
    )
    ram <- Lav2RAM(
      lav_mod = lav_mod
    )
    back <- RAM2Lav(
      ram = ram,
      lav_mod = lav_mod
    )
    testthat::test_that(
      desc = paste(text, "round trip: beta, psi, and theta"),
      code = {
        testthat::expect_equal(
          object = .Plain(x = back$beta),
          expected = .Plain(x = lav_mod$beta)
        )
        testthat::expect_equal(
          object = .Plain(x = back$psi),
          expected = .Plain(x = lav_mod$psi)
        )
        testthat::expect_equal(
          object = .Plain(x = back$theta),
          expected = .Plain(x = lav_mod$theta)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "round trip: alpha and nu"),
      code = {
        testthat::expect_equal(
          object = .Plain(x = back$alpha),
          expected = .Plain(x = lav_mod$alpha)
        )
        testthat::expect_equal(
          object = .Plain(x = back$nu),
          expected = .Plain(x = lav_mod$nu)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "standardized: correlations in psi, variances kept"),
      code = {
        std <- RAM2Lav(
          ram = ram,
          lav_mod = lav_mod,
          standardized = TRUE
        )
        testthat::expect_equal(
          object = diag(x = std$psi),
          expected = diag(x = lav_mod$psi)
        )
        testthat::expect_equal(
          object = std$psi[2, 3],
          expected = stats::cov2cor(V = lav_mod$psi)[2, 3]
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "latent variable model"),
      code = {
        fit_cfa <- .TestFitCFA()
        lav_cfa <- lavaan::lavInspect(
          object = fit_cfa,
          what = "est"
        )
        back_cfa <- RAM2Lav(
          ram = Lav2RAM(
            lav_mod = lav_cfa
          ),
          lav_mod = lav_cfa
        )
        testthat::expect_equal(
          object = .Plain(x = back_cfa$lambda),
          expected = .Plain(x = lav_cfa$lambda)
        )
        testthat::expect_equal(
          object = .Plain(x = back_cfa$psi),
          expected = .Plain(x = lav_cfa$psi)
        )
      }
    )
  },
  text = "test-lavHelper-ram2-lav"
)
