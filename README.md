# DWS: IRREGULAR OCEAN WAVES SIMULATIONS USING A DIRECTIONAL WAVE ENERGY SPECTRUM
`DWS (Directional Wave Simulation)` is an `R` package for numerical simulations of the irregular ocean waves at different locations using 
a directional wave energy spectrum. That is, based upon a 2-dimensional table with spectral variance versus frequencies and direction angles, 
we want to calculate the time series of the surface elevation, the horizontal velocity, the vertical velocity, the horizontal acceleration, 
the vertical acceleration, and the dynamic pressure at different locations (x-, y-, z- coordinates).

In obtaining the harmonic wave components, the `Linear Wave Theory (LWT)` is employed to calculate the properties of the regular waves. As we know, 
the linear wave theory can only be applied up to the Still Water Level (SWL). However, for structures at the free surface, the waves above the SWL 
may have a large influence on the response of the structure and may not be ignored. If linear theory is used, the theory is modified to account for 
the Free Surface Effect. There are several possible modifications that have been proposed, such as `First-Order Stretching`, `Linear Extrapolation`, and 
so on. `Wheeler’s Stretching` (1970) is the most used First-Order Stretching technique in the offshore structure design.

In calculating the irregular waves, two different models for the wave direction summation could be chosen to combine a variety of harmonic wave components, 
one is `Single Summation Model (SSM)` and the other is `Double Summation Model (DSM)`. For SSM, wave components of different frequencies travel at different 
directions, but at the same frequency, they travel in the same direction. For DSM, at the same frequency, wave components travel in different directions 
(energy spreading).



<img src="example\KatrinaWaveSpectrum.jpg" width="100%" />



## Installation
The `R` package `DWS` has been developed for the purpose of irregular ocean wave simulations using a direction wave energy spectrum, and the most recent
Github version can be installed using the commands as follows:

```r
# Download devtools first
install.packages("devtools")
library(devtools)

# The repository is private, you can download the R packge using the token valid until 1/4/2024
devtools::install_github("https://github.com/hlq1983/DWS/tree/master", build_vignettes = TRUE, auth_token = "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") 
```

## Example
A simple example of irregular ocean wave simulations using a direction wave energy spectrum is shown below.

Step 1: Load the DWS and other required R Package:

```r
library(DWS)
library(foreach)
library(doParallel)
library(microbenchmark)
```

Step 2: Load the Hurricane Katrina Spectrum Data:

```r
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
```

or use alternative way of lazy loading the Hurricane Katrina Spectrum Data:

```r
###########################################################################
# Save Katrina data attached to DWS package
# use_data(Katrina, overwrite = TRUE)

# Alternative way of lazy loading Katrina Data. Data becomes visible as soon as loaded.
data(Katrina)
```

Step 3: Obtain wave spectrum information from data Katrina:

```r
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
```

Step 4: Sequential simulations for small workloads:

```r
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
wavtsplot(LC1, iunit = 1)
```

Benchmarking the sequential simulations for small workload with 5 random seeds:

```r
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
```

Step 5: Parallel simulations for small workloads:

```r
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
```

Benchmarking the parallel simulations for small workload with 5 random seeds:

```r
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
```

<img src="example/Tsplot_LC1&2.jpeg" width="100%" />

Comparing the run times betweens the Load Case 1 and 2, we have a significant increase of run times for the parallel simulations due to the extra time to setup the parallel computing. 
Therefore, the parallel algorithm is NOT preferred for small workloads.

Step 6: Sequential simulations for large workloads:

```r
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
```

Benchmarking the sequential simulations for large workload with 5 random seeds:

```r
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
```

Step 7: Parallel simulations for large workloads:

```r
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
```

Benchmarking the parallel simulations for large workload with 5 random seeds:

```r
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
```

<img src="example/Tsplot_LC3&4.jpeg" width="100%" />

Comparing the run times betweens the Load Case 3 and 4, we have a decrease of run times for the parallel simulations due to the time saving from the parallel computing. 
Therefore, the parallel algorithm is preferred for large workloads.

## Acknowledgements
We thank Dr. J. Zhang (Professor Emeritus, Department of Ocean Engineering, Texas A&M Univeristy) for his direct academic guidance to develope this numerical tool, 
and thank Dr. H.C. Chen (Professor, Department of Ocean Engineering, Texas A&M Univeristy)for providing the research project with the Hurricane Katrina Spectrum data.
