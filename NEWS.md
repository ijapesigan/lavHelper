# lavHelper 0.0.2

## Bug fixes

- `.RAM2Lav()` no longer fails for a model list without `lambda` (`lambda1` is empty by default).

## Other changes

- `.Lav2RAM()`: the branches that assigned nothing when `nu` or `alpha` is missing are removed (same results).
- Test files for `.Lav2RAM()`, `.RAM2Lav()`, `.StdRAM()`; the constraint tests of `ThetaHat()` move into `test-lavHelper-theta-hat.R`.

# lavHelper 0.0.1

## Template

- The rProject template; private `jeksterslab-psu/lavHelper`, public `ijapesigan/lavHelper`.
- `DESCRIPTION`: MIT, `Depends: R (>= 3.5.0)`, `Imports: lavaan, stats, utils`, `VignetteBuilder: knitr`.
- `Lav2RAM()`, `RAM2Lav()`, `StdRAM()`, and `ThetaHat()` are exported and documented.
- `.ThetaHatDef()` moved to `R/lavHelper-theta-hat-def-dot.R`; `R/lavHelper-no-cov.R` renamed `-dot.R` (internal; uses `utils::combn()`).
- Tests for every function; a vignette; the unused template data (`data/z.rda`) removed.

## Efficiency

- `.StdLav()` (called once per Monte Carlo draw in semmcci) is about 25-30% faster, with identical results (differences below 1e-15):
  new internal `.GetUser()` replaces `lavaan::lav_model_get_parameters(type = "user", extra = TRUE)` without its overhead;
  `.StdRAM()` takes the diagonal of `B S B'` without forming the full product and scales with `tcrossprod()`.

## Bugs fixed (each with a regression test)

- `RAM2Lav()`: models with a single latent variable failed or returned dropped (non-matrix) `lambda`, `psi`, `theta`, and `beta`
  matrices (`drop = FALSE`).
- `RAM2Lav()`: `nu[lambda1] <- 0` indexed the matrix by name and appended elements; now `nu[lambda1, ] <- 0`.
- `StdRAM()`: a model with one variable (`k = 1`) built a 2 x 2 scaling matrix (`diag()` of a scalar); now `diag(nrow = )`.
