#' Syntax for Fixed Zero Covariances
#'
#' Creates `lavaan` model syntax that fixes
#' the covariances of all pairs of variables to zero.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Character vector.
#'   Variable names (at least two).
#' @return Returns a character string with one `a ~~ 0 * b` line
#'   for each pair of variables.
#'
#' @family Lavaan Helper Functions
#' @keywords lavHelper syntax internal
#' @noRd
.NoCov <- function(x) {
  out <- utils::combn(
    x = x,
    m = 2,
    FUN = function(x) {
      sprintf(
        fmt = "%s ~~ 0 * %s",
        x[1],
        x[2]
      )
    }
  )
  paste(
    out,
    collapse = "\n"
  )
}
