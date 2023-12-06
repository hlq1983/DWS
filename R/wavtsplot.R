#' wavtsplot
#'
#' Plot time series of wave properties in a plotting window with 3 X 3 matrix based on a output list from DWS function.
#'
#' @param LC Output list from DWS function.
#' @param iunit (Optional, default iunit = 1) Choose unit system: 1 for SI unit system, 2 for English Unit.
#'
#' @return A plotting window with 3 X 3 matrix for time series plots of wave properties.
#' @export
#'
#' @examples wavtsplot(LC1)
#' @examples wavtsplot(LC = LC1, iunit = 1)
#'
wavtsplot <- function(LC, iunit = 1) {
  # Check is LC is a list
  if (!(is.list(LC))) {
    stop("LC is not a list from DWS output.")
  }

  # Obtain sizes of t and xyz
  t <- LC$t
  nt <- length(t)
  xyz <- LC$xyz
  nxyz <- nrow(xyz)

  # Initialization of matrix
  eta <- matrix(NA, nt, nxyz)
  phi <- matrix(NA, nt, nxyz)
  u <- matrix(NA, nt, nxyz)
  v <- matrix(NA, nt, nxyz)
  w <- matrix(NA, nt, nxyz)
  udot <- matrix(NA, nt, nxyz)
  vdot <- matrix(NA, nt, nxyz)
  wdot <- matrix(NA, nt, nxyz)
  p <- matrix(NA, nt, nxyz)

  # Retrieve data from simulation output sequentially
  cat("Retrieving data from simulation output...\n")
  for (j in 1:nxyz) {
    for (i in 1:nt) {
      eta[i, j] <- LC$output[[j]][[i, 1]]
      phi[i, j] <- LC$output[[j]][[i, 2]]
      u[i, j] <- LC$output[[j]][[i, 3]]
      v[i, j] <- LC$output[[j]][[i, 4]]
      w[i, j] <- LC$output[[j]][[i, 5]]
      udot[i, j] <- LC$output[[j]][[i, 6]]
      vdot[i, j] <- LC$output[[j]][[i, 7]]
      wdot[i, j] <- LC$output[[j]][[i, 8]]
      p[i, j] <- LC$output[[j]][[i, 9]]
    }
  }

  # Set a plotting window with 3 rows and 3 columns
  # par(mfrow=c(3, 3))
  par(oma = c(8, 1, 2, 1), mfrow = c(3, 3), mar = c(4, 4, 3, 1))

  # Obtain ploting line color vector from rainbow
  cl <- rainbow(nxyz)

  # Plot 1: wave surface elevations eta vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(eta), max(eta)), main = "Surface Elevation", xlab = "t [s]", ylab = expression(paste(eta, " [m]")))
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(eta), max(eta)), main = "Surface Elevation", xlab = "t [s]", ylab = expression(paste(eta, " [ft]")))
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, eta[, i], col = cl[i], type = 'l')
  }

  # Plot 2: wave velocity potential phi vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(phi), max(phi)), main = "Velocity Potential", xlab = "t [s]", ylab = expression(paste(phi, " [m^2/s]")))
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(phi), max(phi)), main = "Velocity Potential", xlab = "t [s]", ylab = expression(paste(phi, " [ft^2/s]")))
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, phi[, i], col = cl[i], type = 'l')
  }

  # Plot 3: wave dynamic pressure p vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(p), max(p)), main = "Dynamic Pressure", xlab = "t [s]", ylab = "p [N/m^2]")
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(p), max(p)), main = "Dynamic Pressure", xlab = "t [s]", ylab = "p [lbf/ft^2]")
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, p[, i], col = cl[i], type = 'l')
  }

  # Plot 4: wave horizontal Velocity-X u vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(u), max(u)), main = "Horizontal Velocity-X", xlab = "t [s]", ylab = "u [m/s]")
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(u), max(u)), main = "Horizontal Velocity-X", xlab = "t [s]", ylab = "u [ft/s]")
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, u[, i], col = cl[i], type = 'l')
  }

  # Plot 5: wave horizontal Velocity-Y v vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(v), max(v)), main = "Horizontal Velocity-Y", xlab = "t [s]", ylab = "v [m/s]")
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(v), max(v)), main = "Horizontal Velocity-Y", xlab = "t [s]", ylab = "v [ft/s]")
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, v[, i], col = cl[i], type = 'l')
  }

  # Plot 6: wave vertical Velocity-Z w vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(w), max(w)), main = "Vertical Velocity-Z", xlab = "t [s]", ylab = "w [m/s]")
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(w), max(w)), main = "Vertical Velocity-Z", xlab = "t [s]", ylab = "w [ft/s]")
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, w[, i], col = cl[i], type = 'l')
  }

  # Plot 7: wave horizontal Acceleration-X udot vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(udot), max(udot)), main = "Horizontal Acceleration-X", xlab = "t [s]", ylab = expression(paste(dot(u)," [m/s^2]")))
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(udot), max(udot)), main = "Horizontal Acceleration-X", xlab = "t [s]", ylab = expression(paste(dot(u)," [ft/s^2]")))
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, udot[, i], col = cl[i], type = 'l')
  }

  # Plot 8: wave horizontal Acceleration-Y vdot vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(vdot), max(vdot)), main = "Horizontal Acceleration-Y", xlab = "t [s]", ylab = expression(paste(dot(v)," [m/s^2]")))
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(vdot), max(vdot)), main = "Horizontal Acceleration-Y", xlab = "t [s]", ylab = expression(paste(dot(v)," [ft/s^2]")))
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, vdot[, i], col = cl[i], type = 'l')
  }

  # Plot 9: wave vertical Velocity-Z wdot vs t
  if (iunit == 1) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(wdot), max(wdot)), main = "Vertical Acceleration-Z", xlab = "t [s]", ylab = expression(paste(dot(w)," [m/s^2]")))
  } else if (iunit == 2) {
    plot(0, 0, type = "n", xlim = c(t[1], t[nt]), ylim = c(min(wdot), max(wdot)), main = "Vertical Acceleration-Z", xlab = "t [s]", ylab = expression(paste(dot(w)," [ft/s^2]")))
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }
  for (i in 1:nxyz) {
    lines(t, wdot[, i], col = cl[i], type = 'l')
  }

  # Place Common Legend at the outside bottom for all plots of wave property time series
  par(fig = c(0, 1, 0, 1), oma = c(1, 0, 1, 0), mar = c(0, 0, 1, 0), new = TRUE, xpd = TRUE)
  if (iunit == 1) {
    plot(0, 0, type = 'n', bty = 'n', xaxt = 'n', yaxt = 'n', main = "Time Series of Wave Properties in SI Unit")
    legend("bottom",  legend = paste(1:nxyz, " (", xyz[1:nxyz, 1],", ", xyz[1:nxyz, 2],", ",xyz[1:nxyz, 3],") [m] "), col = cl, bty = "n", lty=c(1,nxyz), ncol = 5, xjust = 0.5, yjust = 1, title="Location of Interest: ")
  } else if (iunit == 2) {
    plot(0, 0, type = 'n', bty = 'n', xaxt = 'n', yaxt = 'n', main = "Time Series of Wave Properties in English Unit")
    legend("bottom",  legend = paste(1:nxyz, " (", xyz[1:nxyz, 1],", ", xyz[1:nxyz, 2],", ",xyz[1:nxyz, 3],") [ft] "), col = cl, bty = "n", lty=c(1,nxyz), ncol = 5, xjust = 0.5, yjust = 1, title="Location of Interest: ")
  }
  par(xpd=FALSE)
}
