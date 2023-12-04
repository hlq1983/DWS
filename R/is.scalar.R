#' is.scalar
#'
#' Check if the input is a scalar.
#'
#' @param x input.
#'
#' @return TRUE if x is a scalar or FAULSE otherwise.
#' @export
#'
#' @examples is.scalar(100)
#' @examples is.scalar(1.0259e+3)
#' @examples is.scalar(seq(from = 0.0, to = 10, by = 1))
#' @examples is.scalar(t(cbind(c(0.0, 0.0, -5.0), c(1.0, 0.0, -5.0), c(2.0, 0.0, -5.0), c(3.0, 0.0, -5.0), c(4.0, 0.0, -5.0), c(5.0, 0.0, -5.0), c(6.0, 0.0, -5.0), c(7.0, 0.0, -5.0), c(8.0, 0.0, -5.0), c(9.0, 0.0, -5.0), c(10.0, 0.0, -5.0))))
#'
is.scalar <- function(x) is.atomic(x) && length(x) == 1L && Im(x)==0
