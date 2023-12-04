#' wavnum
#'
#' Calculate wave number from the Linear Dispersion Relation using Newton-Raphson Method.
#' This function is called by function wavcomp.
#'
#' @param h Water depth, m or ft
#' @param g Gravitational acceleration, m/s^2 or ft/s^2
#' @param sigma Circular wave frequency, rad/s
#' @param tol (Optional,default tol = 1.0e-5). Acceptance tolerance of convergence test for Newton-Raphson Method.
#' @param no (Optional, default no = 200) Maximum number of iteration for Newton-Raphson Method.
#'
#' @return An approximate solution wave number dk or error message of convergence failure to the console.
#' @export
#'
#' @examples wavnum(h = 100.0, g = 9.80665, sigma = 0.1000)
#' @examples wavnum(h = 100.0, g = 9.80665, sigma = 0.1000, tol = 1.0e-5)
#' @examples wavnum(h = 100.0, g = 9.80665, sigma = 0.1000, tol = 1.0e-5, no = 200)
#'
wavnum <- function(h, g, sigma, tol = 1.0e-5, no = 200) {
  # Parameters used in this function
  pi <- 3.14159265

  # Initial guess of k
  dkg <- sigma^2 / g    # Guess dk by assuming deep water scenario
  dl <- 2 * pi / dkg    # Wave number dl based on deepwater assumption

  if (h / dl >= 0.5) {
    # Deep water scenario if h/dl >= 0.5
    dk0 <- dkg
  } else if (h / dl <= 0.05) {
    # Shallow water sceario if h/dl <= 0.05
    dk0 <- sqrt(sigma^2 / g / h)     # Shallow water formulus
  } else {
    # Intermediate water scenario if 0.05 < h / dl < 0.5
    dk0 <- 0.2 # Intermediate water guess
  }

  # Calculate wave number using Newton-Raphson Method
  for (i in 1:no) {
    f <- sigma^2 - g * dk0 * tanh(dk0 * h) # function f(k)
    f1<- -g * (tanh(dk0 * h) + dk0 * h * (1 - tanh(dk0 * h) * tanh(dk0 * h))) # first derivative of f(k)
    dk <- dk0 - f / f1
    if (abs(dk - dk0) <= tol) {
      # Convergent if abs(dk - dk0) is less or equal to tol
      break
    }
    # Update dk0 with the calculated dk for next loop
    dk0 <- dk
  }

  # Error message for convergence failure
  if (i > no) {
    stop("Newton-Raphson Method failed after maximum number of iterations, try to increase no.")
  }

  # Return the final calculated wave number dk
  return(dk)
}
