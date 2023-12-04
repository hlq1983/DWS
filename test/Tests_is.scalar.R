# This is a script to save verification tests for function is.scalar in the DWS R package



####################################################
## Test of function is.scalar
####################################################
h = 100.0
rho = 1.0259e+3
xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 0.0, -5.0), c(2.0, 0.0, -5.0), c(3.0, 0.0, -5.0), c(4.0, 0.0, -5.0), c(5.0, 0.0, -5.0), c(6.0, 0.0, -5.0), c(7.0, 0.0, -5.0), c(8.0, 0.0, -5.0), c(9.0, 0.0, -5.0), c(10.0, 0.0, -5.0)))
t = seq(from = 0.0, to = 10, by = 1)

is.scalar(h)
# [1] TRUE
is.scalar(rho)
# [1] TRUE
is.scalar(t)
# [1] FALSE
is.scalar(xyz)
# [1] FALSE
!(is.scalar(t) | is.vector(t))
# [1] FALSE
