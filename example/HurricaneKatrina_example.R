# Application of R package "DWS.R" to the observed Directional Wave Energy Spectrum data during Hurricane Katrina
source("R/DWS.R")
source("R/wavspec.R")
source("R/wavtsplot.R")
source("R/wavnum.R")
source("R/wavcomp.R")
source("R/wavsimu.R")
source("R/is.scalar.R")
library(foreach)
library(doParallel)
library(devtools)
library(usethis)
library(microbenchmark)
library(DWS)



###########################################################################
# Load the Hurricane Katrina Directional Wave Energy Spectrum data from a "spectrum.txt"
spectrum <- read.table("data/spectrum.txt", header = F, colClasses = "numeric")
spectrum <- as.matrix(spectrum)

# Wave frequency band width for Katrina has been incorporated into the wave energy spectral variances
dfreq <- c(rep(1, 23))
# Wave direction band width for Katrina has been incorporated into the wave energy spectral variances
dkata <- c(rep(1, 17))

# Obtain spectral information from a directional wave energy spectrum.
Katrina <- wavspec(spectrum, dfreq, dkata)





###########################################################################
# Save Katrina data attached to DWS package
# use_data(Katrina, overwrite = TRUE)

# Alternative way of lazy loading Katrina Data. Data becomes visible as soon as loaded.
data(Katrina)



###########################################################################
# Water depth h
h <- Katrina$h
# No. of wave frequency vector freq
n <- Katrina$n
# Wave frequency vector freq
freq <- Katrina$freq
# No. of wave direction vector kata
m <- Katrina$m
# Wave direction vector kata
kata <- Katrina$kata
# Wave energy spectral variances matrix spevar
spevar <- Katrina$spevar
# Wave frequency band width vector dfreq
dfreq <- Katrina$dfreq
# Wave direction band width vector dkata
dkata <- Katrina$dkata



###########################################################################
# Load Case 1: Set 2 locations xyz of interest for sequential simulation
xyz <- t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0)))
nxyz <- nrow(xyz)
# Set simulation time series from 0 to 100 seconds with time step of 0.1 second
t <- seq(from = 0.0, to = 100, by = 0.1)
nt <- length(t)
# The Hurricane Katrina Wave Spectrum data are in SI Unit
iunit <- 1
# Single Summation Model is chosen for regular wave superposition to avoid non-uniformity and cancellation of wave components at the same frequency in the opposite direction
imodel <- 2
# Linear wave theory with Wheeler's stretch technique is chosen for wave simulation to account for the Free Surface Effect
itheory <- 2
# Sequential simulation is carried out as comparison for large workloads
ialgorithm <- 1
# Large odd integer is chosen for obtaining random initial wave phases
iseed <- 150001

# Load Case 1 Simulation
LC1 <- DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = 150001, tol = 1.0e-5, no = 200)

# Plot time series of wave properties in SI unit
wavtsplot(LC = LC1, iunit = 1)

#   +-----------------------------+
#   | DIRECTIONAL WAVE SIMULATION |
#   +-----------------------------+
#   Originated by Liqing Huang
# Department of Ocean Engineering
# Texas A&M University - College Station
# -------------------------------------------------------
#   Welcome to use DWS R package! Your new task starts...
#
# SI unit system: iunit = 1
# The following parameters are used in calculations:
#   Gravitational acceleration: 9.80665 m/s^2
# Ocean water density       : 1025.9 kg/m^3
#
# Double Summmation Model is chosen: imodel = 2
#
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
#
# Sequential Algorithm is chosen: ialgorithm == 1
# Sequential simulation starts.
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Sequential simulation completed.
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.004212856 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  1.53721 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  1.541423 sec.
#
# Thank you for using DWS R package! See you next time!
# -------------------------------------------------------



# Benchmarking the sequential simulations for small workloads
microbenchmark(
  DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1.0e-5, no = 200),
  times = 5
)

# Unit: seconds
#                                                                                                                                 expr      min       lq     mean   median       uq      max neval
# DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1e-05, no = 200) 1.542247 1.567411  1.63682 1.673597 1.676939 1.723905     5
#
# The median run time is: 1.673597 seconds



###########################################################################
# Load Case 2: Set 2 locations xyz of interest for parallel simulation
# Parallel simulation is NOT preferred for small workloads
ialgorithm <- 2
# Large odd integer is chosen for obtaining random initial wave phases
iseed <- 150001

# Load Case 2 Simulation
LC2 <- DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = 150001, tol = 1.0e-5, no = 200)

# Plot time series of wave properties in SI unit
wavtsplot(LC2, iunit = 1)

#   +-----------------------------+
#   | DIRECTIONAL WAVE SIMULATION |
#   +-----------------------------+
#   Originated by Liqing Huang
# Department of Ocean Engineering
# Texas A&M University - College Station
# -------------------------------------------------------
#   Welcome to use DWS R package! Your new task starts...
#
# SI unit system: iunit = 1
# The following parameters are used in calculations:
#   Gravitational acceleration: 9.80665 m/s^2
# Ocean water density       : 1025.9 kg/m^3
#
# Double Summmation Model is chosen: imodel = 2
#
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
#
# Parallel Algorithm is chosen: ialgorithm == 2
# Initializing the clusters with specified number of processors:  11
# Parallel simulations start...
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Parallel simulations completed.
# Stop the clusters after the parallel simulations.
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.006484985 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  5.261965 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  5.26845 sec.
#
# Thank you for using DWS R package! See you next time!
# -------------------------------------------------------



# Benchmarking the parallel simulations for small workloads
microbenchmark(
  DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1.0e-5, no = 200),
  times = 5
)

# Unit: seconds
#                                                                                                                                 expr      min       lq     mean   median       uq      max neval
# DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1e-05, no = 200) 5.016533 5.104629 5.101333 5.109457 5.121715 5.154333     5
#
# The median run time is: 5.109457 seconds



###########################################################################
# Load Case 3: Set 11 locations xyz of interest for sequential simulation
xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 0.0, -5.0), c(2.0, 0.0, -5.0), c(3.0, 0.0, -5.0), c(4.0, 0.0, -5.0), c(5.0, 0.0, -5.0), c(6.0, 0.0, -5.0), c(7.0, 0.0, -5.0), c(8.0, 0.0, -5.0), c(9.0, 0.0, -5.0), c(10.0, 0.0, -5.0)))
nxyz <- nrow(xyz)
# Set simulation time series from 0 to 10800 seconds with time step of 0.1 second
t = seq(from = 0.0, to = 10800, by = 0.1)
nt <- length(t)
# The Hurricane Katrina Wave Spectrum data are in SI Unit
iunit <- 1
# Single Summation Model is chosen for regular wave superposition to avoid non-uniformity and cancellation of wave components at the same frequency in the opposite direction
imodel <- 2
# Linear wave theory with Wheeler's stretch technique is chosen for wave simulation to account for the Free Surface Effect
itheory <- 2
# Sequential simulation is preferred for small workloads
ialgorithm <- 1
# Large odd integer is chosen for obtaining random initial wave phases
iseed <- 150001

# Load Case 3 Simulation
LC3 <- DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = 150001, tol = 1.0e-5, no = 200)

# Plot time series of wave properties in SI unit
wavtsplot(LC3, iunit = 1)

#   +-----------------------------+
#   | DIRECTIONAL WAVE SIMULATION |
#   +-----------------------------+
#   Originated by Liqing Huang
# Department of Ocean Engineering
# Texas A&M University - College Station
# -------------------------------------------------------
#   Welcome to use DWS R package! Your new task starts...
#
# SI unit system: iunit = 1
# The following parameters are used in calculations:
#   Gravitational acceleration: 9.80665 m/s^2
# Ocean water density       : 1025.9 kg/m^3
#
# Double Summmation Model is chosen: imodel = 2
#
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
#
# Sequential Algorithm is chosen: ialgorithm == 1
# Sequential simulation starts.
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Sequential simulation completed.
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.01780891 min.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  24.44506 min.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  24.44536 min.
#
# Thank you for using DWS R package! See you next time!
# -------------------------------------------------------



# Benchmarking the sequential simulations for large workloads
microbenchmark(
  DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1.0e-5, no = 200),
  times = 5
)

# Unit: seconds
#                                                                                                                                 expr      min       lq     mean   median       uq      max neval
# DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1e-05, no = 200) 1265.799 1266.099 1326.751 1266.786 1269.926 1565.147     5
#
# The median run time is: 1266.786 seconds


###########################################################################
# Load Case 4: Set 11 locations xyz of interest for parallel simulation
# Parallel simulation is preferred for large workloads
ialgorithm <- 2
# Large odd integer is chosen for obtaining random initial wave phases
iseed <- 150001

# Load Case 4 Simulation
LC4 <- DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = 150001, tol = 1.0e-5, no = 200)

# Plot time series of wave properties in SI unit
wavtsplot(LC4, iunit = 1)

#   +-----------------------------+
#   | DIRECTIONAL WAVE SIMULATION |
#   +-----------------------------+
#   Originated by Liqing Huang
# Department of Ocean Engineering
# Texas A&M University - College Station
# -------------------------------------------------------
#   Welcome to use DWS R package! Your new task starts...
#
# SI unit system: iunit = 1
# The following parameters are used in calculations:
#   Gravitational acceleration: 9.80665 m/s^2
# Ocean water density       : 1025.9 kg/m^3
#
# Double Summmation Model is chosen: imodel = 2
#
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
#
# Parallel Algorithm is chosen: ialgorithm == 2
# Initializing the clusters with specified number of processors:  11
# Parallel simulations start...
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Parallel simulations completed.
# Stop the clusters after the parallel simulations.
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.01335406 min.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  15.35305 min.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  15.35327 min.
#
# Thank you for using DWS R package! See you next time!
# -------------------------------------------------------



# Benchmarking the parallel simulations for large workloads
microbenchmark(
  DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1.0e-5, no = 200),
  times = 5
)

# Unit: seconds
#                                                                                                                                 expr      min       lq     mean   median       uq      max neval
# DWS(h, xyz, t, n, m, freq, kata, spevar, dfreq, dkata, iunit, imodel, itheory, ialgorithm, iseed = iseed + 1, tol = 1e-05, no = 200)  904.6454 911.135 915.4537 919.4522 919.5371 922.4989     5
#
# The median run time is: 919.4522 seconds
