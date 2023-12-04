#' wavsimu
#'
#' Construct total irregular wave at location (x, y, z) at time instance t by linear superposition
#' of all regular wave components obtained from a directional wave energy spectrum.
#' This function is called by DWS.
#'
#' @param h Water depth (from MWL to ocean bottom), m or ft.
#' @param g Gravitational acceleration, m/s^2 or ft/s^2.
#' @param rho Ocean water density, kg/m^3 or slugs/ft^3.
#' @param x X-coordinate of a specified location (positive in the wave direction of 0 deg), m or ft.
#' @param y Y-coordinate to a specified ocation (positive in the wave direction of 90 deg), m or ft.
#' @param z Z-coordinate to a specified location (positive upwards, zero at MWL), m or ft.
#' @param t Time instance to calculate water surface displacement and velocity potential at location (x,y,z), sec
#' @param amp Regular wave amplitude vector for each wave components
#' @param fk Regular wave number vector for each wave components
#' @param fsigma Regular wave circular frequency vector for each wave components
#' @param fkata Regular wave direction vector for each wave components
#' @param beta Regular wave initial random phase vector for each wave components
#' @param itheory (Optional, default itheory = 1) Choose wave theory: 1 for Linear Wave Theory, 2 for Linear Wave Theory with Wheeler's Stretching.
#'
#' @return A time instance of total irregular wave potential, total irregular wave horizontal X-velocity, total irregular wave horizontal Y-velocity, total irregular wave horizontal Z-velocity, total irregular wave horizontal X-acceleration, total irregular wave horizontal Y-acceleration, total irregular wave vertical Z-acceleration, and total irregular wave dynamic pressure at location (x, y, z)
#' @export
#'
#' @examples wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 3, fk = 0.04028232, fsigma = 0.6283185, fkata = 0.7853982, beta = 0.1369422)
#' @examples wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 3, fk = 0.04028232, fsigma = 0.6283185, fkata = 0.7853982, beta = 0.1369422, itheory = 2)
#' @examples wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(3, 1), fk = c(0.04028293, 0.36231658), fsigma = c(0.6283185, 1.884956), fkata = c(0.7853982, 0.7853982), beta = c(0.1369422, 1.0299106))
#' @examples wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(0, 3, 1, 1), fk = c(0.04028293, 0.04028694, 0.36231658, 0.36232866), fsigma = c(0.6283185, 0.6283499, 1.8849556, 1.8849870), fkata = c(0.0000000, 0.7853982, 0.0000000, 0.7853982), beta = c(0.1369422, 1.0299106, 4.0621247, 5.2208995))
#'
wavsimu <- function(h, g, rho, x, y, z, t, amp, fk, fsigma, fkata, beta, itheory = 1) {
  # Calculate regular wave phase of each regular wave component
  theta <- fk * (cos(fkata) * x + sin(fkata) * y) - fsigma * t + beta
  # Calculate regular wave elevation for each regular wave component
  deta <- amp * cos(theta)
  # Calculate total irregular wave elevation by linearly superposition of all regular wave components
  eta <- sum(deta)

  # If wave surface elevation is below Z-Coordinate, the results is set to be ZERO
  if (z > eta) {
    phi <- 0.0
    u <- 0.0
    v <- 0.0
    w <- 0.0
    udot <- 0.0
    vdot <- 0.0
    wdot <- 0.0
    p <- 0.0
  } else {
    # For wave surface elevation is greater or equal to Z-coordinate
    if (itheory == 1) {
      ###################################
      # Linear Wave Theory: itheory = 1 #
      ###################################
      # cat("Linear Wave Theory is chosen: itheory = 1\n")
      wheelerfactor <- 1
    } else if (itheory == 2) {
      #####################################
      # Wheeler's Stretching: itheory = 2 #
      #####################################
      # cat("Linear Wave Theory with Wheeler's Stretching Technique is : itheory = 2\n")
      wheelerfactor <- 1 / (1 + eta / h)
    } else {
      # If other value is given, stop and print error message
      stop("So far, you can only choose either itheory = 1 for Linear Wave Theory or itheory = 2 for Linear Wave Theory with Wheeler's Stretching. Other methods are under development in near future.")
    }

    # Calculate regular wave potential
    dphi <- amp * g / fsigma * cosh(fk * (z + h) * wheelerfactor) / cosh(fk * h) * sin(theta)
    # Calculate total irregular wave potential
    phi <- sum(dphi)

    # Calculate regular wave horizontal X-velocity
    du <- amp * fsigma * cosh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * cos(theta) * cos(fkata)
    # Calculate total irregular wave horizontal X-velocity
    u <- sum(du)

    # Calculate regular wave horizontal Y-velocity
    dv <- amp * fsigma * cosh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * cos(theta) * sin(fkata)
    # Calculate total irregular wave horizontal Y-velocity
    v <- sum(dv)

    # Calculate regular wave horizontal Z-velocity
    dw <- amp * fsigma * sinh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * cos(theta)
    # Calculate total irregular wave vertical Z-velocity
    w <- sum(dw)

    # Calculate regular wave horizontal X-acceleration
    dudot <- amp * fsigma^2 * cosh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * sin(theta) * cos(fkata)
    # Calculate total irregular wave horizontal X-acceleration
    udot <- sum(dudot)

    # Calculate regular wave horizontal Y-acceleration
    dvdot <- amp * fsigma^2 * cosh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * sin(theta) * sin(fkata)
    # Calculate total irregular wave horizontal Y-acceleration
    vdot <- sum(dvdot)

    # Calculate regular wave horizontal Z-acceleration
    dwdot <- amp * fsigma^2 * sinh(fk * (z + h) * wheelerfactor) / sinh(fk * h) * cos(theta)
    # Calculate total irregular wave vertical Z-acceleration
    wdot <- sum(dwdot)

    # Calculate regular wave dynamic pressure
    dp <- rho * g * amp * cosh(fk * (z + h) * wheelerfactor) / cosh(fk * h) * cos(theta)
    # Calculate total irregular wave dynamic pressure
    p <- sum(dp)

  }

  # Return a time instance of total irregular wave potential, total irregular wave horizontal X-velocity,
  # total irregular wave horizontal Y-velocity, total irregular wave horizontal Z-velocity,
  # total irregular wave horizontal X-acceleration, total irregular wave horizontal Y-acceleration
  # total irregular wave vertical Z-acceleration, and total irregular wave dynamic pressure
  return(list(eta = eta, phi = phi, u = u, v = v, w = w, udot = udot, vdot = vdot, wdot = wdot, p = p))
}
