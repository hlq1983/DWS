# This is a script to save verification tests for function wavsimu in the DWS R package
source("R/is.scalar.R")
source("R/wavnum.R")
source("R/wavcomp.R")
source("R/wavsimu.R")



####################################################
## Verification of Function wavsimu
####################################################
# Case 1 (Single wave frequency and single wave direction at time instance):
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 3, fk = 0.04028232, fsigma = 0.6283185, fkata = 0.7853982, beta = 0.1369422)
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 2.971914
#
# $phi
# [1] 5.226819
#
# $u
# [1] 1.080371
#
# $v
# [1] 1.080371
#
# $w
# [1] 1.526426
#
# $udot
# [1] 0.09354416
#
# $vdot
# [1] 0.09354417
#
# $wdot
# [1] 0.9590819
#
# $p
# [1] 24546.55

wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 3, fk = 0.04028232, fsigma = 0.6283185, fkata = 0.7853982, beta = 0.1369422, itheory = 2)
# [1] "Linear Wave Theory with Wheeler's Stretching Technique is : itheory = 2"
# $eta
# [1] 2.971914
#
# $phi
# [1] 4.680817
#
# $u
# [1] 0.9675134
#
# $v
# [1] 0.9675135
#
# $w
# [1] 1.366653
#
# $udot
# [1] 0.08377239
#
# $vdot
# [1] 0.08377239
#
# $wdot
# [1] 0.8586932
#
# $p
# [1] 21982.38


# Case 2 (2 wave frequency and single wave direction at time instance):
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 3, fk = 0.04028293, fsigma = 0.6283185, fkata = 0.7853982, beta = 0.1369422)
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 2.971914
#
# $phi
# [1] 5.226803
#
# $u
# [1] 1.080367
#
# $v
# [1] 1.080367
#
# $w
# [1] 1.526422
#
# $udot
# [1] 0.09354387
#
# $vdot
# [1] 0.09354388
#
# $wdot
# [1] 0.959079
#
# $p
# [1] 24546.48

wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = 1, fk = 0.36231658, fsigma = 1.884956, fkata = 0.7853982, beta = 1.0299106)
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 0.5148955
#
# $phi
# [1] 0.7287323
#
# $u
# [1] 0.1121359
#
# $v
# [1] 0.1121359
#
# $w
# [1] 0.1585842
#
# $udot
# [1] 0.3519135
#
# $vdot
# [1] 0.3519135
#
# $wdot
# [1] 0.2989242
#
# $p
# [1] 849.7996

wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(3, 1), fk = c(0.04028293, 0.36231658), fsigma = c(0.6283185, 1.884956), fkata = c(0.7853982, 0.7853982), beta = c(0.1369422, 1.0299106))
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 3.48681
#
# $phi
# [1] 5.955535
#
# $u
# [1] 1.192503
#
# $v
# [1] 1.192503
#
# $w
# [1] 1.685006
#
# $udot
# [1] 0.4454574
#
# $vdot
# [1] 0.4454574
#
# $wdot
# [1] 1.258003
#
# $p
# [1] 25396.28


# Case 3 (1 wave frequencies and 2 wave directions):
# Single Summation Model:
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(1, 3), fk = c(0.04028293, 0.04028694), fsigma = c(0.6283185, 0.6283499), fkata = c(0.0000000, 0.7853982), beta = c(0.1369422, 1.0299106))
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 2.535325
#
# $phi
# [1] 34.56204
#
# $u
# [1] 1.07084
#
# $v
# [1] 0.5615498
#
# $w
# [1] 1.302206
#
# $udot
# [1] 0.6315589
#
# $vdot
# [1] 0.5874619
#
# $wdot
# [1] 0.8182252
#
# $p
# [1] 20940.21

# Double Summation Model:
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(1, 3), fk = c(0.04028293, 0.04028693), fsigma = c(0.6283185, 0.6283185), fkata = c(0.0000000, 0.7853982), beta = c(0.1369422, 1.0299106))
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 2.535325
#
# $phi
# [1] 34.56369
#
# $u
# [1] 1.070812
#
# $v
# [1] 0.5615218
#
# $w
# [1] 1.302167
#
# $udot
# [1] 0.6315002
#
# $vdot
# [1] 0.5874033
#
# $wdot
# [1] 0.8181754
#
# $p
# [1] 20940.21


# Case 4 (2 wave frequencies and 2 wave directions):
# Single Summation Model:
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(0, 3, 1, 1), fk = c(0.04028293, 0.04028694, 0.36231658, 0.36232866), fsigma = c(0.6283185, 0.6283499, 1.8849556, 1.8849870), fkata = c(0.0000000, 0.7853982, 0.0000000, 0.7853982), beta = c(0.1369422, 1.0299106, 4.0621247, 5.2208995))
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 1.426166
#
# $phi
# [1] 31.40072
#
# $u
# [1] 0.4811211
#
# $v
# [1] 0.6675791
#
# $w
# [1] 0.7568891
#
# $udot
# [1] -0.2331752
#
# $vdot
# [1] 0.2289007
#
# $wdot
# [1] 0.4297174
#
# $p
# [1] 12562.4

# Double Summation Model:
wavsimu(h = 100.0, g = 9.80665, rho = 1030.0, x = 0.0, y = 0.0, z = -5.0, t = 0.0, amp = c(0, 3, 1, 1), fk = c(0.04028293, 0.04028293, 0.36231658, 0.36231658), fsigma = c(0.6283185, 0.6283185, 1.8849556, 1.8849556), fkata = c(0.0000000, 0.7853982, 0.0000000, 0.7853982), beta = c(0.1369422, 1.0299106, 4.0621247, 5.2208995))
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $eta
# [1] 1.426166
#
# $phi
# [1] 31.40296
#
# $u
# [1] 0.4811093
#
# $v
# [1] 0.6675672
#
# $w
# [1] 0.7568718
#
# $udot
# [1] -0.2332315
#
# $vdot
# [1] 0.2288444
#
# $wdot
# [1] 0.4296852
#
# $p
# [1] 12562.7
