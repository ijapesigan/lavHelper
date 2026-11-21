#' RAM to lavaan Matrices
#'
#' Converts a list of RAM matrices
#' to a list of `lavaan` model matrices.
#'
#' @author Shu Fai Cheung
#'
#' @param ram List.
#'   A list of RAM matrices (`A`, `S`, `F`, and `M`) for one group.
#' @param lav_mod List.
#'   A list of `lavaan` model matrices for one group.
#'   They are used as holders of the output.
#' @param standardized Logical.
#'   If `TRUE`, the `psi` and `theta` matrices
#'   contain the correlations (the variances are kept).
#'   Default is `FALSE`.
#' @return Returns a list of `lavaan` model matrices for one group.
#'
#' @examples
#' fit <- lavaan::sem(
#'   model = "mpg ~ wt",
#'   data = mtcars
#' )
#' lav_mod <- lavaan::lavInspect(
#'   object = fit,
#'   what = "est"
#' )
#' RAM2Lav(
#'   ram = Lav2RAM(
#'     lav_mod = lav_mod
#'   ),
#'   lav_mod = lav_mod
#' )
#'
#' @family Lavaan Helper Functions
#' @keywords lavHelper matrix
#' @export
RAM2Lav <- function(ram,
                    lav_mod,
                    standardized = FALSE) {
  .RAM2Lav(
    ram = ram,
    lav_mod = lav_mod,
    standardized = standardized
  )
}
