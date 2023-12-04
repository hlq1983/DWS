#' wavcomp
#'
#' Obtain wave properties, such as wave amplitude, wave number, wave circular frequency,
#' wave direction, and wave initial random phase for each regular wave component from a
#' directional wave energy spectrum which describes the energy content of an ocean wave
#' and its distribution over a frequency range and a direction range of the random wave.
#' This function is called by DWS.
#'
#' @param h Water depth (from MWL to ocean bottom), m or ft.
#' @param g Gravitational acceleration, m/s^2 or ft/s^2.
#' @param n Total number of wave frequencies in a directional wave energy spectrum.
#' @param m Total number of wave directions in a directional wave energy spectrum.
#' @param freq Wave frequency scalar or vector [n], Hz.
#' @param kata Wave direction scalar or vector [m], degree.
#' @param spevar Directional wave spectral variance array [m x n], m^2/Hz/deg or ft^2/Hz/deg.
#' @param dfreq (Optional, default NULL) If NULL, wave frequency band width vector dfreq shall be calculated based on the provided wave frequency vector freq; if provided, the length of dfreq shall be 1 or n. For n = 1, dfreq must be given.
#' @param dkata (Optional, default NULL) If NULL, wave direction band width vector dkata shall be calculated based on the provided wave direction vector kata; if provided, the length of dkata shall be 1 or m. For m = 1, dkata must be given.
#' @param imodel (Optional, default imodel = 1) Choose linear superposition model for directional wave simulation: 1 for Single Summation Model, 2 for Single Summation Model.
#' @param iseed (Optional, default iseed = 150001) Initial large odd integer for generating randomly selected initial phases.
#' @param tol (Optional, default tol = 1.0e-5) Acceptance tolerance of convergence test for Newton-Raphson Method.
#' @param no (Optional, default no = 200) Maximum number of iteration for Newton-Raphson Method.
#'
#' @return Return regular wave properties such as amplitude, wave number, wave circular frequency, wave direction, and wave initial random phase for each wave components.
#' @export
#'
#' @examples wavcomp(h = 100.0, g = 9.80665, n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
#' @examples wavcomp(h = 100.0, g = 9.80665, n = 2, m = 1, freq = c(0.1, 0.3), kata = 45, spevar = matrix(c(4.5, 0.5), 1, 2), dfreq = 1, dkata = 1)
#' @examples wavcomp(h = 100.0, g = 9.80665, n = 1, m = 2, freq = 0.1, kata = c(0, 45), spevar = matrix(c(0.5, 4.5), 2, 1), dfreq = 1, dkata = 1)
#' @examples wavcomp(h = 100.0, g = 9.80665, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)))
#' @examples wavcomp(h = 100.0, g = 9.80665, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), imodel = 1, iseed = 150001, tol = 1.0e-5, no = 200)
#'
wavcomp <- function(h, g, n, m, freq, kata, spevar, dfreq = NULL, dkata = NULL, imodel = 1, iseed = 150001, tol = 1.0e-5, no = 200) {
  # Parameters used in this function with different unit system
  pi <- 3.14159265

  # Check compatibility of n with length of freq, length of dfreq (if provided) and ncol of spevar
  if (n <= 0 | !(n %% 1 == 0)) {
    stop("n must be a positive integer.")
  } else if (n == 1) {
    # For single wave frequency n = 1, the frequency band width dfreq shall be provided as a scalar
    if (!(is.null(dfreq)) | is.scalar(dfreq)) {
      cat("For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:\n")
      print(dfreq)
    } else {
      stop("For single wave frequency n = 1, the frequency band width dfreq shall be provided as a scalar.")
    }
  } else if (n > 1) {
    if (is.null(dfreq)) {
      # For multiple wave frequencies n > 1, calculate the frequency band width vector dfreq based on the provided wave frequency vector freq
      # n <- as.integer(n)
      freq <- as.vector(freq)
      dfreq <- rep(NA, n)
      # Calculate wave frequency band width vector if dfreq is NULL
      dfreq[1] <- abs(freq[2] - freq[1])
      dfreq[n] <- abs(freq[n] - freq[n - 1])
      for (i in 2:n-1) {
        dfreq[i] <- abs(freq[i + 1] - freq(i - 1)) / 2
      }
      cat("For multiple wave frequencies n > 1,  the frequency band width dfreq is NULL, calculate the frequency band width vector dfreq based on the provided wave frequency vector freq as follows:\n")
      print(dfreq)
    } else if (is.scalar(dfreq)) {
      cat("For multiple wave frequencies n > 1,  the frequency band width dfreq is provided as a scalar:\n")
      print(dfreq)
    } else if (is.vector(dfreq) & n == length(dfreq)) {
      cat("For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:\n")
      print(dfreq)
    } else {
      stop("For multiple wave frequencies n > 1, the provided frequency band width dfreq shall be either a scalar or a vector of length compatible with n.")
    }
  }
  # Check compatibility of n with length of freq
  if (n != length(freq)) {
    stop("n must equal to length of freq.")
  }
  # Check compatibility of n with ncol of spevar
  spevar <- as.matrix(spevar)
  if (n != ncol(spevar)) {
    stop("n must equal to column number of spevar.")
  }

  # Check compatibility of m with length of kata, length of dkata (if provided), and nrow of spevar
  if (m <= 0 | !(m %% 1 == 0)) {
    stop("m must be a positive integer.")
  } else if (m == 1) {
    # For single wave direction m = 1, the direction band width dkata shall be provided as a scalar
    if (!(is.null(dkata)) | is.scalar(dkata)) {
      cat("For single wave direction m = 1, the direction band width dkata scalar is provided as follows:\n")
      print(dkata)
    } else {
      stop("For single wave direction m = 1, the direction band width dkata shall be provided as a scalar.")
    }
  } else if (m > 1) {
    # For multiple wave directions m > 1, calculate the direction band width vector dkata based on the provided wave direction vector kata
    if (is.null(dkata)) {
      # m <- as.integer(m)
      kata <- as.vector(kata)
      # Keep wave direction kata in the range [-180, 180] deg
      # For kata > 180 deg, kata = kata - 360
      kata <- ifelse(kata > 180, kata - 360, kata)
      dkata <- rep(NA, n)
      # Calculate wave direction band width, deg
      dkata[1] <- abs(kata[2] - kata[1])
      dkata[m] <- abs(kata[m] - kata[m - 1])
      for (j in 2:m-1) {
        dkata[j] <- abs(kata[j + 1] - kata(j - 1)) / 2
      }
      cat("For multiple wave directions m > 1, the direction band width vector dkata is NULL, calculate the direction band width vector dfreq based on the provided wave direction vector kata as follows:\n")
      print(dkata)
    } else if (is.scalar(dkata)) {
      cat("For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:\n")
      print(dkata)
    } else if (is.vector(dkata) & m == length(dkata)) {
      cat("For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:\n")
      print(dkata)
    } else {
      stop("For multiple wave directions m > 1, the direction band width vector dkata shall be either a scalar or a vector of length compatible with m.")
    }
  }
  # Check compatibility of m with length of kata
  if (m != length(kata)) {
    stop("m must equal to length of kata.")
  }
  # Check compatibility of m with nrow of spevar
  if (m != nrow(spevar)) {
    stop("m must equal to row number of spevar.")
  }

  # Initialization of vectors and arrays
  sigma <- rep(NA, n)
  skata <- rep(NA, m)
  dk <- rep(NA, n)
  fk <- rep(NA, m * n)
  ffreq <- rep(NA, m * n)
  fsigma <- rep(NA, m * n)
  fspevar <- rep(NA, m * n)
  fkata <- rep(NA, m * n)
  amp <- rep(NA, m * n)
  beta <- rep(NA, m * n)

  # Calculate wave circular frequency sigma from wave frequency freq
  sigma <- freq * 2 * pi

  # Convert the unit for wave direction directions from deg to radians
  skata <- kata * pi / 180

  # Linear superposition models for directional Wave simulation
  imodel <- as.integer(imodel)
  if (imodel == 1) {
    #######################################
    # Single Summmation Model: imodel = 1 #
    #######################################
    # cat("Single Summmation Model is chosen: imodel = 1\n")
    if (is.scalar(dfreq)) {
      # For given scalar frequency band width dfreq
      # Force the wave components at the same frequency in different directions to have slightly different frequencies in different directions
      bfreq <- dfreq / 100000    # Band width of the each difference frequency group is set to 1/100000 of given scalar frequency band width
      bsigma <- bfreq * 2 * pi
      ufreq <- bfreq / m          # Frequency difference incremental for m directions
      usigma <- ufreq * 2 * pi
      for (i in 1:n) {
        for (j in 1:m) {
          l <- m * (i - 1) + j
          # Calculate forced slightly different frequencies in different directions
          ffreq[l] <- freq[i] + ufreq * (j - 1)
          fsigma[l] <- ffreq[l] * 2 * pi
          if (m == 1) {
            # For single wave direction, keep the original wave frequencies
            fsigma[l] <- sigma[i]
          }
          fk[l] <- wavnum(h, g, fsigma[l], tol, no)
          fkata[l] <- skata[j]
          if (is.scalar(dkata)) {
            fspevar[l] <- spevar[j, i] * dfreq * dkata
          } else if (is.vector(dkata)) {
            fspevar[l] <- spevar[j, i] * dfreq * dkata[j]
          }
        }
      }
    } else if (is.vector(dfreq)) {
      # For given vector frequency band width dfreq
      bfreq <- rep(NA, n)
      ufreq <- rep(NA, n)
      bfreq <- dfreq / 100000    # Band width of each slightly different frequency group are set to 1/100000 of given frequency band width vector
      bsigma <- bfreq * 2 * pi
      ufreq <- bfreq / m          # Frequency difference incremental for m directions
      usigma <- ufreq * 2 * pi
      for (i in 1:n) {
        for (j in 1:m) {
          l <- m * (i - 1) + j
          # Calculate forced slightly different frequencies in different directions
          ffreq[l] <- freq[i] + ufreq[i] * (j - 1)
          fsigma[l] <- ffreq[l] * 2 * pi
          if (m == 1) {
            # For single wave direction, keep the original wave frequencies
            fsigma[1] <- sigma[i]
          }
          fk[l] <- wavnum(h, g, fsigma[l], tol, no)
          fkata[l] <- skata[j]
          if (is.scalar(dkata)) {
            fspevar[l] <- spevar[j, i] * dfreq[i] * dkata
          } else if (is.vector(dkata)) {
            fspevar[l] <- spevar[j, i] * dfreq[i] * dkata[j]
          }
        }
      }
    }
  } else if (imodel == 2) {
    ######################################
    # Double Summation Model: imodel = 2 #
    ######################################
    # cat("Double Summmation Model is chosen: imodel = 2\n")
    for (i in 1:n) {
      # Calculate wave number for each wave frequency
      dk[i] <- wavnum(h, g, sigma[i], tol, no)
      for (j in 1:m){
        l <- m * (i - 1) + j
        ffreq[l] <- freq[i]
        fsigma[l] <- sigma[i]
        fk[l] <- dk[i]
        fkata[l] <- skata[j]
        if (is.scalar(dfreq) & is.scalar(dkata)) {
          fspevar[l] <- spevar[j, i] * dfreq * dkata
        } else if (is.vector(dfreq) & is.scalar(dkata)) {
          fspevar[l] <- spevar[j, i] * dfreq[i] * dkata
        } else if (is.scalar(dfreq) & is.vector(dkata)) {
          fspevar[l] <- spevar[j, i] * dfreq * dkata[j]
        } else if (is.vector(dfreq) & is.vector(dkata)) {
          fspevar[l] <- spevar[j, i] * dfreq[i] * dkata[j]
        }
      }
    }
  } else {
    # If other value is given, stop and print error message
    stop("You can only choose either imodel = 1 for Double Summmation Model or imodel = 2 for Single Summation Model.")
  }

  # Calculate wave amplitude of each regular wave component
  amp <- sqrt(2 * fspevar)

  # Generate randomly selected initial phase beta: 0 <= beta <= 2 * pi
  iseed <- as.integer(iseed)
  set.seed(iseed)
  beta <- c(runif(m * n)) * 2 * pi

  # Return regular wave properties such as amplitude, wave number, wave circular frequency, wave direction, and wave initial random phase for each wave components
  return(list(amp = amp, fk = fk, fsigma = fsigma, fkata = fkata, beta = beta))
}
