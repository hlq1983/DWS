# This is a script to save verification tests for function wavcomp in the DWS R package
source("R/is.scalar.R")
source("R/wavnum.R")
source("R/wavcomp.R")



####################################################
## Verification of Function wavcomp
####################################################
# Case 1 (Single wave frequency and single wave direction):
wavnum(h = 100.0, g = 9.8065, sigma = 0.62831853)
# [1] 0.04028293
wavcomp(h = 100.0, g = 9.8065, n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For single wave direction m = 1, the direction band width dkata scalar is provided as follows:"
# [1] 1
# $amp
# [1] 3
#
# $fk
# [1] 0.04028293
#
# $fsigma
# [1] 0.6283185
#
# $fkata
# [1] 0.7853982
#
# $beta
# [1] 0.1369422


# Case 2 (2 wave frequencies and single wave direction):
wavnum(h = 100.0, g = 9.8065, sigma = 0.62831853)
# [1] 0.04028293
wavnum(h = 100.0, g = 9.8065, sigma = 1.88495559)
# [1] 0.3623166
wavcomp(h = 100.0, g = 9.8065, n = 2, m = 1, freq = c(0.1, 0.3), kata = 45, spevar = matrix(c(4.5, 0.5), 1, 2), dfreq = 1, dkata = 1)
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For single wave direction m = 1, the direction band width dkata scalar is provided as follows:"
# [1] 1
# $amp
# [1] 3 1
#
# $fk
# [1] 0.04028293 0.36231658
#
# $fsigma
# [1] 0.6283185 1.8849556
#
# $fkata
# [1] 0.7853982 0.7853982
#
# $beta
# [1] 0.1369422 1.0299106

# Case 3 (1 wave frequencies and 2 wave directions):
wavnum(h = 100.0, g = 9.8065, sigma = 0.62831853)
# [1] 0.04028293
wavnum(h = 100.0, g = 9.8065, sigma = 0.6283499)
# [1] 0.04028294
# Single Summation Model:
wavcomp(h = 100, g = 9.8065, n = 1, m = 2, freq = 0.1, kata = c(0, 45), spevar = matrix(c(0.5, 4.5), 2, 1), dfreq = 1, dkata = 1)
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:"
# [1] 1
# [1] "Single Summmation Model is chosen: imodel = 1"
# $amp
# [1] 1 3
#
# $fk
# [1] 0.04028293 0.04028694
#
# $fsigma
# [1] 0.6283185 0.6283499
#
# $fkata
# [1] 0.0000000 0.7853982
#
# $beta
# [1] 0.1369422 1.0299106

# Double Summation Model:
wavcomp(h = 100, g = 9.8065, n = 1, m = 2, freq = 0.1, kata = c(0, 45), spevar = matrix(c(0.5, 4.5), 2, 1), dfreq = 1, dkata = 1, imodel = 2)
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:"
# [1] 1
# [1] "Double Summmation Model is chosen: imodel = 2"
# $amp
# [1] 1 3
#
# $fk
# [1] 0.04028293 0.04028293
#
# $fsigma
# [1] 0.6283185 0.6283185
#
# $fkata
# [1] 0.0000000 0.7853982
#
# $beta
# [1] 0.1369422 1.0299106


# Case 4 (2 wave frequencies and 2 wave directions):
wavnum(h = 100.0, g = 9.8065, sigma = 0.62831853)
# [1] 0.04028293
wavnum(h = 100.0, g = 9.8065, sigma = 0.6283499)
# [1] 0.04028693
wavnum(h = 100.0, g = 9.8065, sigma = 1.88495559)
# [1] 0.3623166
wavnum(h = 100.0, g = 9.8065, sigma = 1.8849870)
# [1] 0.3623287
# Single Summation Model:
wavcomp(h = 100, g = 9.8065, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = 1, dkata = 1)
# [1] "For multiple wave frequencies n > 1,  the frequency band width dfreq is provided as a scalar:"
# [1] 1
# [1] "For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:"
# [1] 1
# $amp
# [1] 0 3 1 1
#
# $fk
# [1] 0.04028293 0.04028694 0.36231658 0.36232866
#
# $fsigma
# [1] 0.6283185 0.6283499 1.8849556 1.8849870
#
# $fkata
# [1] 0.0000000 0.7853982 0.0000000 0.7853982
#
# $beta
# [1] 0.1369422 1.0299106 4.0621247 5.2208995

# Double Summation Model:
wavcomp(h = 100, g = 9.8065, n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = 1, dkata = 1, imodel = 2)
# [1] "For multiple wave frequencies n > 1,  the frequency band width dfreq is provided as a scalar:"
# [1] 1
# [1] "For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:"
# [1] 1
# [1] "Double Summmation Model is chosen: imodel = 2"
# $amp
# [1] 0 3 1 1
#
# $fk
# [1] 0.04028293 0.04028293 0.36231658 0.36231658
#
# $fsigma
# [1] 0.6283185 0.6283185 1.8849556 1.8849556
#
# $fkata
# [1] 0.0000000 0.7853982 0.0000000 0.7853982
#
# $beta
# [1] 0.1369422 1.0299106 4.0621247 5.2208995
