#' DWS
#'
#' DWS (Directional Wave Simulation) numerically simulates the time series of
#' the irregular wave at different locations in the ocean based upon a directional
#' wave energy spectrum. Based upon the input of a 2 dimensional table with spectral
#' variance versus frequencies and directions and linear wave theory, DWS calculates
#' the time histories of the surface elevation, the horizontal velocity, the vertical
#' velocity, and the dynamic pressure at any location (x, y, z) at a time series t.
#'
#' @param h Water depth (from MWL to ocean bottom) scalar, m or ft.
#' @param xyz Location coordinates (X, Y, Z) matrix [k x 3]. X coordinate of a specified location (positive in the wave direction of 0 deg), m or ft. Y coordinate to a specified ocation (positive in the wave direction of 90 deg), m or ft. Z coordinate to a specified location (positive upwards, zero at MWL), m or ft.
#' @param t Time series vector, sec.
#' @param n Total number of wave frequencies.
#' @param m Total number of wave directions.
#' @param freq Wave frequency vector [n], Hz.
#' @param kata Wave direction vector [m], degree.
#' @param spevar Directional wave spectral variance matrix [m x n], m^2/Hz/deg or ft^2/Hz/deg.
#' @param dfreq (Optional, default NULL) If NULL, wave frequency band width vector dfreq shall be calculated based on the provided wave frequency vector freq; if provided, the length of dfreq shall be 1 or n. For n = 1, dfreq must be given.
#' @param dkata (Optional, default NULL) If NULL, wave direction band width vector dkata shall be calculated based on the provided wave direction vector kata; if provided, the length of dkata shall be 1 or m. For m = 1, dkata must be given.
#' @param iunit (Optional, default iunit = 1) Choose unit system: 1 for SI unit system, 2 for English Unit.
#' @param imodel (Optional, default imodel = 1) Choose linear superposition model for directional wave simulation: 1 for Single Summation Model, 2 for Single Summation Model.
#' @param itheory (Optional, default itheory = 1) Choose wave theory: 1 for Linear Wave Theory, 2 for Linear Wave Theory with Wheeler's Stretching.
#' @param ialgorithm (Optional, default ialgorithm = 1) Choose irregular wave simulation algorithm: 1 for Sequential Algorithm, 2 for Parallel Algorithm.
#' @param iseed (Optional, default iseed = 150001) Initial large odd integer for generating randomly selected initial phases.
#' @param tol (Optional, default tol = 1.0e-5) Acceptance tolerance of convergence test for Newton-Raphson Method.
#' @param no (Optional, default no = 200) Maximum number of iteration for Newton-Raphson Method.
#'
#' @return A time series of total irregular wave potential, total irregular wave horizontal X-velocity, total irregular wave horizontal Y-velocity, total irregular wave horizontal Z-velocity, total irregular wave horizontal X-acceleration, total irregular wave horizontal Y-acceleration, total irregular wave vertical Z-acceleration, and total irregular wave dynamic pressure at different locations (x, y, z) listed in xyz matrix.
#' @import foreach
#' @import doParallel
#' @export
#'
#' @examples DWS(h = 100.0, xyz = t(c(0.0, 0.0, -5.0)), t = 0.0, n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
#' @examples DWS(h = 100.0, xyz = t(c(0.0, 0.0, -5.0)), t = seq(from = 0.0, to = 10, by = 1), n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
#' @examples DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 1, freq = c(0.1, 0.3), kata = 45, spevar = matrix(c(4.5, 0.5), 1, 2), dfreq = 1, dkata = 1)
#' @examples DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 1, m = 2, freq = 0.1, kata = c(0, 45), spevar = matrix(c(0.5, 4.5), 2, 1), dfreq = 1, dkata = 1)
#' @examples DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)))
#' @examples DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 2, ialgorithm = 2, iseed = 150001, tol = 1.0e-5, no = 200)
#'
DWS <- function(h, xyz, t, n, m, freq, kata, spevar, dfreq = NULL, dkata = NULL, iunit = 1, imodel = 1, itheory = 1, ialgorithm = 1, iseed = 150001, tol = 1.0e-5, no = 200) {

  # Greetings output to screen
  cat("           +-----------------------------+\n")
  cat("           | DIRECTIONAL WAVE SIMULATION |\n")
  cat("           +-----------------------------+\n")
  cat("              Originated by Liqing Huang\n")
  cat("           Department of Ocean Engineering\n")
  cat("        Texas A&M University - College Station\n")
  cat("-------------------------------------------------------\n")
  cat("Welcome to use DWS R package! Your new task starts...\n")
  cat("\n")

  # Starting timing
  Tstart <- Sys.time()

  # Parameters used in this function with different unit system
  pi <- 3.14159265
  if (iunit == 1) {
    # SI unit system: iunit = 1
    cat("SI unit system: iunit = 1\n")
    cat("The following parameters are used in calculations:\n")
    cat("  Gravitational acceleration: 9.80665 m/s^2\n")
    cat("  Ocean water density       : 1025.9 kg/m^3\n")
    g <- 9.80665      # Gravitational acceleration, m/s^2
    rho <- 1.0259e+3  # Ocean water density, kg/m^3
  } else if (iunit == 2) {
    # English unit system: iunit = 2
    cat("English unit system: iunit = 2\n")
    cat("The following parameters are used in calculations:\n")
    cat("  Gravitational acceleration: 32.174 ft/s^2\n")
    cat("  Ocean water density       : 1.9905 slugs/ft^3\n")
    g <- 32.1740      # Gravitational acceleration, ft/s^2
    rho <- 1.9905     # Ocean water density, slugs/ft^3
  } else {
    stop("You can only choose iunit = 1 for SI unit system or iunit = 2 for English unit system.")
  }

  # Check compatibility of h
  if (!(is.scalar(h) & (h > 0))) {
    stop("Water depth h must be a scalar greater than 0.")
  }

  # Check compatibility of xyz
  if (!(is.matrix(xyz) & (ncol(xyz) == 3))) {
    stop("Location coordinate matrix xyz must have exact 3 columns.")
  }

  # Check compatibility of t
  if (!(is.scalar(t) | is.vector(t))) {
    stop("Time t must be either a scalar or a vector.")
  }

  # Obtain size of xyz and t
  nxyz <- nrow(xyz)
  nt <- length(t)

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

  # Obtain wave properties, such as wave amplitude, wave number, wave circular frequency, wave direction,
  # and wave initial random phase for each wave component from a directional wave energy spectrum
  cat("\n")
  if (imodel == 1) {
    cat("Single Summmation Model is chosen: imodel = 1\n")
  } else if (imodel == 2) {
    cat("Double Summmation Model is chosen: imodel = 2\n")
  } else {
    # If other value is given, stop and print error message
    stop("You can only choose either imodel = 1 for Double Summmation Model or imodel = 2 for Single Summation Model.")
  }
  cat("\n")
  cat("Obtaining wave properties for each wave component from a directional wave energy spectrum...\n")
  regwav <- wavcomp(h, g, n, m, freq, kata, spevar, dfreq, dkata, imodel, iseed, tol, no)
  amp <- regwav$amp
  fk <- regwav$fk
  fsigma <- regwav$fsigma
  fkata <- regwav$fkata
  beta <- regwav$beta

  # Running time for obtaining wave properties for each wave component from a directional wave energy spectrum
  Tend1 <- Sys.time()
  Runtime1 <- Tend1 - Tstart

  cat("\n")
  if (itheory == 1) {
    cat("Linear Wave Theory is chosen: itheory = 1\n")
  } else if (itheory == 2) {
    cat("Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2\n")
  } else {
    # If other value is given, stop and print error message
    stop("So far, you can only choose either itheory = 1 for Linear Wave Theory or itheory = 2 for Linear Wave Theory with Wheeler's Stretching. Other methods are under development in near future.")
  }

  # Calculate irregular waves time series by linear superposition of all regular wave components
  cat("\n")

  if (ialgorithm == 1) {
    # Sequential Algorithm: ialgorithm == 1
    cat("Sequential Algorithm is chosen: ialgorithm == 1\n")
    cat("Sequential simulation starts.\n")
    cat("Calculating irregular waves time series by linear superposition of all regular wave components...\n")
    for (j in 1:nxyz) {
      # Obtain (X, Y, Z) coordinates for each location in matrix xyz
      # x <- xyz[j, 1]
      # y <- xyz[j, 2]
      # z <- xyz[j, 3]
      for (i in 1:nt) {
        # For each time instance, calculate irregular wave by linear superposition of all regular wave components
        irregwav <- wavsimu(h, g, rho, xyz[j, 1], xyz[j, 2], xyz[j, 3], t[i], amp, fk, fsigma, fkata, beta, itheory)
        eta[i, j] <- irregwav$eta
        phi[i, j] <- irregwav$phi
        u[i, j] <- irregwav$u
        v[i, j] <- irregwav$v
        w[i, j] <- irregwav$w
        udot[i, j] <- irregwav$udot
        vdot[i, j] <- irregwav$vdot
        wdot[i, j] <- irregwav$wdot
        p[i, j] <- irregwav$p
      }
    }
    cat("Sequential simulation completed.\n")
  } else if (ialgorithm == 2) {
    # Parallel Algorithm: ialgorithm == 2
    cat("Parallel Algorithm is chosen: ialgorithm == 2\n")

    # Setup parallel simulations to use as many processors as possible
    cores <- detectCores() # Detect no. of processors that the computer has
    cl <- makeCluster(cores[1]-1) # Not to fully overload computer using all cores
    cat("Initializing the clusters with specified number of processors: ", cores[1]-1, "\n")
    registerDoParallel(cl) # Initialize the clusters with specified number of processors

    cat("Parallel simulations start...\n")
    cat("Calculating irregular waves time series by linear superposition of all regular wave components...\n")
    # foreach (j = 1:nxyz, .combine = cbind, .multicombine = TRUE) %dopar% {
    output <- foreach (j = 1:nxyz, .combine = 'list', .multicombine = TRUE, .export=c("wavsimu")) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE, .export=c("wavsimu")) %dopar% {
      # output <- foreach (j = 1:nxyz, i = 1:nt, .combine = c, .multicombine = TRUE) %dopar% {
      # for (j in 1:nxyz) {
      # Obtain (X, Y, Z) coordinates for each location in matrix xyz
      # x <- xyz[j, 1]
      # y <- xyz[j, 2]
      # z <- xyz[j, 3]
      # for (i in 1:nt) {
      # output1 <- foreach (i = 1:nt, .combine = rbind, .multicombine = TRUE, ) %do% {
      # for (i in 1:nt) {
      irregwav <- wavsimu(h, g, rho, xyz[j, 1], xyz[j, 2], xyz[j, 3], t[i], amp, fk, fsigma, fkata, beta, itheory)
      # eta[i, 1] <- irregwav$eta
      # phi[i, 1] <- irregwav$phi
      # u[i, 1] <- irregwav$u
      # v[i, 1] <- irregwav$v
      # w[i, 1] <- irregwav$w
      # udot[i, 1] <- irregwav$udot
      # vdot[i, 1] <- irregwav$vdot
      # wdot[i, 1] <- irregwav$wdot
      # p[i, 1] <- irregwav$p
    }
    # # Retrieve data from parallel simulation output sequentially
    # for (j in 1:nxyz) {
    #   for (i in 1:nt) {
    #     eta[i, j] <- output[[j]][[i, 1]]
    #     phi[i, j] <- output[[j]][[i, 2]]
    #     u[i, j] <- output[[j]][[i, 3]]
    #     v[i, j] <- output[[j]][[i, 4]]
    #     w[i, j] <- output[[j]][[i, 5]]
    #     udot[i, j] <- output[[j]][[i, 6]]
    #     vdot[i, j] <- output[[j]][[i, 7]]
    #     wdot[i, j] <- output[[j]][[i, 8]]
    #     p[i, j] <- output[[j]][[i, 9]]
    #   }
    # }
    # Retrieve data from parallel simulation output in parallel
    cat("Retrieving data from parallel simulation output...\n")
    eta <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 1]]
    }
    phi <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 2]]
    }
    u <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 3]]
    }
    v <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 4]]
    }
    w <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 5]]
    }
    udot <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 6]]
    }
    vdot <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 7]]
    }
    wdot <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 8]]
    }
    p <- foreach (j = 1:nxyz, .combine = 'cbind', .multicombine = TRUE) %:% foreach (i = 1:nt, .combine = 'rbind', .multicombine = TRUE) %dopar% {
      output[[j]][[i, 9]]
    }
    cat("Parallel simulations completed.\n")

    # Stop the clusters after the parallel simulations
    stopCluster(cl)
    cat("Stop the clusters after the parallel simulations.\n")

  } else {
    # If other value is given, stop and print error message
    stop("You can only choose either ialgorithm == 1 for Sequential Algorithm or ialgorithm == 2 for Parallel Algorithm.")
  }

  # Running time for Calculating irregular waves time series by linear superposition of all regular wave components
  Tend2 <- Sys.time()
  Runtime2 <- Tend2 - Tend1
  Runtime3 <- Tend2 - Tstart

  # Congratulations output to screen
  cat("\n")
  cat("Congratulations! Your task has been completed successfully.\n")
  cat("\n")
  cat("Run Time Summary:\n")
  cat("Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is ", Runtime1, "sec.\n")
  cat("Run time for calculating irregular waves time series by linear superposition of all regular wave components is ", Runtime2, "sec.\n")
  cat("Total run time for irregular wave simulation from a directional wave energy spectrum is ", Runtime3, "sec.\n")
  cat("\n")
  cat("Thank you for using DWS R package! See you next time!\n")
  cat("-------------------------------------------------------\n")

  # Return a time series of total irregular wave potential, total irregular wave horizontal X-velocity,
  # total irregular wave horizontal Y-velocity, total irregular wave horizontal Z-velocity,
  # total irregular wave horizontal X-acceleration, total irregular wave horizontal Y-acceleration
  # total irregular wave vertical Z-acceleration, and total irregular wave dynamic pressure at different locations (x, y, z) listed in xyz matrix.
  return(list(xyz = xyz, t = t, eta = eta, phi = phi, u = u, v = v, w = w, udot = udot, vdot = vdot, wdot = wdot, p = p))
}
