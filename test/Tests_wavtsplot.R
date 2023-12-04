# This is a script to save verification tests of function wavtsplot for the DWS R package
source("R/DWS.R")
source("R/wavtsplot.R")
library(foreach)
library(doParallel)



####################################################
## Test of Function wavtsplot
####################################################
# Run DWS with 2 locations and store output to LC list
xyz <- t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0)))
t = seq(from = 0.0, to = 100, by = 1)
LC1 <- DWS(h = 100.0, xyz, t, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 1, ialgorithm = 1, iseed = 150001, tol = 1.0e-5, no = 200)
# Plot time series of wave properties in SI unit
wavtsplot(LC1, iunit = 1)
# Plot time series of wave properties in English unit
wavtsplot(LC1, iunit = 2)


# Run DWS with 11 locations and store output to LC list
xyz <- t(cbind(c(0.0, 0.0, -5.0), c(1.0, 0.0, -5.0), c(2.0, 0.0, -5.0), c(3.0, 0.0, -5.0), c(4.0, 0.0, -5.0), c(5.0, 0.0, -5.0), c(6.0, 0.0, -5.0), c(7.0, 0.0, -5.0), c(8.0, 0.0, -5.0), c(9.0, 0.0, -5.0), c(10.0, 0.0, -5.0)))
t = seq(from = 0.0, to = 100, by = 1)
LC2 <- DWS(h = 100.0, xyz, t, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 1, ialgorithm = 1, iseed = 150001, tol = 1.0e-5, no = 200)
# Plot time series of wave properties in SI unit
wavtsplot(LC2, iunit = 1)
# Plot time series of wave properties in English unit
wavtsplot(LC2, iunit = 2)
