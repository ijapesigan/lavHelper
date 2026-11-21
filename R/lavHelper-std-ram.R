#' Standardized Solution from RAM Matrices
#'
#' Computes the standardized solution from RAM matrices.
#'
#' @details Standardized solution for the means is not yet supported
#'   (the standardized `M` matrix is set to zero).
#'
#' @author Shu Fai Cheung
#'
#' @param ram_est List.
#'   A list of RAM matrices (`A`, `S`, `F`, and `M`) for one group
#'   with unstandardized estimates.
#' @return Returns a list of RAM matrices with the standardized solution.
#'
#' @examples
#' fit <- lavaan::sem(
#'   model = "mpg ~ wt",
#'   data = mtcars
#' )
#' StdRAM(
#'   ram_est = Lav2RAM(
#'     lav_mod = lavaan::lavInspect(
#'       object = fit,
#'       what = "est"
#'     )
#'   )
#' )
#'
#' @family Lavaan Helper Functions
#' @keywords lavHelper matrix standardized
#' @export
StdRAM <- function(ram_est) {
  .StdRAM(
    ram_est = ram_est
  )
}
