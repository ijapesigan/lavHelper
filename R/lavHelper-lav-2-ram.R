#' lavaan to RAM Matrices
#'
#' Converts a list of `lavaan` model matrices
#' to a list of RAM matrices.
#'
#' @author Shu Fai Cheung
#'
#' @param lav_mod List.
#'   A list of `lavaan` model matrices for one group
#'   (for example, the output of
#'   `lavaan::lavInspect(object, what = "est")`
#'   for a single group model).
#' @return Returns a list of the `A`, `S`, `F`, and `M` RAM matrices.
#'
#' @examples
#' fit <- lavaan::sem(
#'   model = "mpg ~ wt",
#'   data = mtcars
#' )
#' Lav2RAM(
#'   lav_mod = lavaan::lavInspect(
#'     object = fit,
#'     what = "est"
#'   )
#' )
#'
#' @family Lavaan Helper Functions
#' @keywords lavHelper matrix
#' @export
Lav2RAM <- function(lav_mod) {
  .Lav2RAM(
    lav_mod = lav_mod
  )
}
