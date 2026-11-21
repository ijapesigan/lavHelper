#' Extract Parameter Estimates
#'
#' Extracts the parameter estimates of a `lavaan` object,
#' including fixed parameters, defined parameters,
#' and equality and inequality constraints.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `lavaan`.
#' @param est Numeric vector.
#'   If not `NULL`, the parameter estimates are replaced
#'   with the supplied vector
#'   (one value for each row of the parameter table).
#'   This is used to update the values in the parameter vector
#'   using new estimates.
#' @return Returns a list with the following elements
#' \describe{
#'   \item{est}{Parameter estimates.}
#'   \item{par_names}{Parameter names.}
#'   \item{def}{Defined parameters.}
#'   \item{ceq}{Equality constraints.}
#'   \item{cin}{Inequality constraints.}
#'   \item{fixed}{Fixed parameters.}
#'   \item{free}{Names of the free parameters.}
#' }
#'
#' @examples
#' fit <- lavaan::sem(
#'   model = "mpg ~ b1 * wt",
#'   data = mtcars
#' )
#' ThetaHat(
#'   object = fit
#' )
#'
#' @family Lavaan Helper Functions
#' @keywords lavHelper parameters
#' @export
ThetaHat <- function(object,
                     est = NULL) {
  .ThetaHat(
    object = object,
    est = est
  )
}
