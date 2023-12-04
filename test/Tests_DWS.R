# This is a script to save verification tests for function DWS in the DWS R package
source("R/is.scalar.R")
source("R/wavnum.R")
source("R/wavcomp.R")
source("R/wavsimu.R")
source("R/DWS.R")
library(foreach)
library(doParallel)




####################################################
## Verification of Function DWS
####################################################
# Case 1
# (Single wave frequency and single wave direction for 1 location time instance):
DWS(h = 100.0, xyz = t(c(0.0, 0.0, -5.0)), t = 0.0, n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
# [1] "SI unit system: iunit = 1"
# [1] "Obtain wave properties for each wave component from a directional wave energy spectrum."
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For single wave direction m = 1, the direction band width dkata scalar is provided as follows:"
# [1] 1
# [1] "Single Summmation Model is chosen: imodel = 1"
# [1] "Calculate irregular waves time series by linear superposition of all regular wave components."
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
#
# $t
# [1] 0
#
# $eta
# [,1]
# [1,] 2.971914
#
# $phi
# [,1]
# [1,] 5.226817
#
# $u
# [,1]
# [1,] 1.080371
#
# $v
# [,1]
# [1,] 1.080371
#
# $w
# [,1]
# [1,] 1.526426
#
# $udot
# [,1]
# [1,] 0.09354415
#
# $vdot
# [,1]
# [1,] 0.09354415
#
# $wdot
# [,1]
# [1,] 0.959082
#
# $p
# [,1]
# [1,] 24448.84

# (Single wave frequency and single wave direction for 1 location time series):
DWS(h = 100.0, xyz = t(c(0.0, 0.0, -5.0)), t = seq(from = 0.0, to = 10, by = 1), n = 1, m = 1, freq = 0.1, kata = 45, spevar = 4.5, dfreq = 1, dkata = 1)
# [1] "SI unit system: iunit = 1"
# [1] "Obtain wave properties for each wave component from a directional wave energy spectrum."
# [1] "Single Summmation Model is chosen: imodel = 1"
# [1] "For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:"
# [1] 1
# [1] "For single wave direction m = 1, the direction band width dkata scalar is provided as follows:"
# [1] 1
# [1] "Calculate irregular waves time series by linear superposition of all regular wave components."
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
#
# $t
# [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
# [,1]
# [1,]  2.9719142
# [2,]  2.6450528
# [3,]  1.3078711
# [4,] -0.5288729
# [5,] -2.1636054
# [6,] -2.9719142
# [7,] -2.6450528
# [8,] -1.3078711
# [9,]  0.5288728
# [10,]  2.1636054
# [11,]  2.9719142
#
# $phi
# [,1]
# [1,]   5.226817
# [2,] -18.065626
# [3,] -34.457615
# [4,] -37.687965
# [5,] -26.522794
# [6,]  -5.226817
# [7,]  18.065626
# [8,]  34.457615
# [9,]  37.687965
# [10,]  26.522794
# [11,]   5.226818
#
# $u
# [,1]
# [1,]  1.0803708
# [2,]  0.9615479
# [3,]  0.4754464
# [4,] -0.1922595
# [5,] -0.7865288
# [6,] -1.0803708
# [7,] -0.9615479
# [8,] -0.4754464
# [9,]  0.1922595
# [10,]  0.7865288
# [11,]  1.0803708
#
# $v
# [,1]
# [1,]  1.0803708
# [2,]  0.9615479
# [3,]  0.4754464
# [4,] -0.1922595
# [5,] -0.7865288
# [6,] -1.0803708
# [7,] -0.9615479
# [8,] -0.4754464
# [9,]  0.1922595
# [10,]  0.7865288
# [11,]  1.0803708
#
# $w
# [,1]
# [1,]  1.5264264
# [2,]  1.3585447
# [3,]  0.6717452
# [4,] -0.2716382
# [5,] -1.1112650
# [6,] -1.5264264
# [7,] -1.3585447
# [8,] -0.6717452
# [9,]  0.2716382
# [10,]  1.1112650
# [11,]  1.5264264
#
# $udot
# [,1]
# [1,]  0.09354415
# [2,] -0.32331983
# [3,] -0.61668662
# [4,] -0.67450008
# [5,] -0.47467744
# [6,] -0.09354415
# [7,]  0.32331982
# [8,]  0.61668662
# [9,]  0.67450008
# [10,]  0.47467744
# [11,]  0.09354415
#
# $vdot
# [,1]
# [1,]  0.09354415
# [2,] -0.32331983
# [3,] -0.61668662
# [4,] -0.67450008
# [5,] -0.47467744
# [6,] -0.09354415
# [7,]  0.32331982
# [8,]  0.61668661
# [9,]  0.67450008
# [10,]  0.47467744
# [11,]  0.09354415
#
# $wdot
# [,1]
# [1,]  0.9590820
# [2,]  0.8535988
# [3,]  0.4220699
# [4,] -0.1706753
# [5,] -0.6982284
# [6,] -0.9590820
# [7,] -0.8535988
# [8,] -0.4220699
# [9,]  0.1706753
# [10,]  0.6982284
# [11,]  0.9590820
#
# $p
# [,1]
# [1,]  24448.843
# [2,]  21759.874
# [3,]  10759.374
# [4,]  -4350.842
# [5,] -17799.184
# [6,] -24448.843
# [7,] -21759.874
# [8,] -10759.374
# [9,]   4350.842
# [10,]  17799.184
# [11,]  24448.843

# (Single wave frequency and single wave direction for 2 location time series):
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 1, freq = c(0.1, 0.3), kata = 45, spevar = matrix(c(4.5, 0.5), 1, 2), dfreq = 1, dkata = 1)
# [1] "SI unit system: iunit = 1"
# [1] "Obtain wave properties for each wave component from a directional wave energy spectrum."
# [1] "Single Summmation Model is chosen: imodel = 1"
# [1] "For multiple wave frequencies n > 1,  the frequency band width dfreq is provided as a scalar:"
# [1] 1
# [1] "For single wave direction m = 1, the direction band width dkata scalar is provided as follows:"
# [1] 1
# [1] "Calculate irregular waves time series by linear superposition of all regular wave components."
# [1] "Linear Wave Theory is chosen: itheory = 1"
# $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
# [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
# [,1]       [,2]
# [1,]  3.4868097  2.9722716
# [2,]  3.3012373  3.6632217
# [3,]  0.3874313  0.8488729
# [4,] -0.6161943 -0.9243714
# [5,] -1.1891979 -1.0822942
# [6,] -3.4868097 -2.9722716
# [7,] -3.3012373 -3.6632217
# [8,] -0.3874313 -0.8488729
# [9,]  0.6161943  0.9243714
# [10,]  1.1891979  1.0822942
# [11,]  3.4868097  2.9722716
#
# $phi
# [,1]       [,2]
# [1,]   5.95557   8.227668
# [2,] -18.70711 -16.399893
# [3,] -34.78991 -34.124567
# [4,] -36.84111 -37.309431
# [5,] -26.71389 -27.812425
# [6,]  -5.95557  -8.227668
# [7,]  18.70711  16.399893
# [8,]  34.78991  34.124567
# [9,]  36.84111  37.309431
# [10,]  26.71389  27.812426
# [11,]   5.95557   8.227669
#
# $u
# [,1]       [,2]
# [1,]  1.1925099  1.0763477
# [2,]  1.1044583  1.1944152
# [3,]  0.2749839  0.3975753
# [4,] -0.2112772 -0.2537665
# [5,] -0.5743127 -0.5332743
# [6,] -1.1925099 -1.0763477
# [7,] -1.1044583 -1.1944152
# [8,] -0.2749839 -0.3975753
# [9,]  0.2112772  0.2537665
# [10,]  0.5743127  0.5332743
# [11,]  1.1925099  1.0763477
#
# $v
# [,1]       [,2]
# [1,]  1.1925099  1.0763477
# [2,]  1.1044583  1.1944152
# [3,]  0.2749839  0.3975753
# [4,] -0.2112772 -0.2537665
# [5,] -0.5743127 -0.5332743
# [6,] -1.1925099 -1.0763477
# [7,] -1.1044583 -1.1944152
# [8,] -0.2749839 -0.3975753
# [9,]  0.2112772  0.2537665
# [10,]  0.5743127  0.5332743
# [11,]  1.1925099  1.0763477
#
# $w
# [,1]       [,2]
# [1,]  1.6850149  1.5207506
# [2,]  1.5606505  1.6878316
# [3,]  0.3882484  0.5615450
# [4,] -0.2985333 -0.3587045
# [5,] -0.8111462 -0.7531685
# [6,] -1.6850149 -1.5207506
# [7,] -1.5606505 -1.6878316
# [8,] -0.3882484 -0.5615450
# [9,]  0.2985333  0.3587045
# [10,]  0.8111462  0.7531685
# [11,]  1.6850149  1.5207506
#
# $udot
# [,1]       [,2]
# [1,]  0.4454673  0.5423997
# [2,] -0.6331016 -0.4263298
# [3,] -0.7771541 -0.9237873
# [4,] -0.2655440 -0.3414214
# [5,] -0.5669588 -0.3863637
# [6,] -0.4454673 -0.5423997
# [7,]  0.6331016  0.4263298
# [8,]  0.7771541  0.9237873
# [9,]  0.2655440  0.3414214
# [10,]  0.5669588  0.3863637
# [11,]  0.4454673  0.5423997
#
# $vdot
# [,1]       [,2]
# [1,]  0.4454673  0.5423997
# [2,] -0.6331016 -0.4263298
# [3,] -0.7771541 -0.9237873
# [4,] -0.2655440 -0.3414214
# [5,] -0.5669588 -0.3863637
# [6,] -0.4454673 -0.5423997
# [7,]  0.6331016  0.4263298
# [8,]  0.7771541  0.9237873
# [9,]  0.2655440  0.3414214
# [10,]  0.5669588  0.3863637
# [11,]  0.4454673  0.5423997
#
# $wdot
# [,1]       [,2]
# [1,]  1.2580143  0.9665453
# [2,]  1.2345592  1.4250407
# [3,] -0.1123089  0.1164985
# [4,] -0.2213714 -0.4438651
# [5,] -0.1325177 -0.1018683
# [6,] -1.2580143 -0.9665453
# [7,] -1.2345592 -1.4250407
# [8,]  0.1123089 -0.1164985
# [9,]  0.2213714  0.4438651
# [10,]  0.1325177  0.1018683
# [11,]  1.2580143  0.9665453
#
# $p
# [,1]       [,2]
# [1,]  25295.283  24264.197
# [2,]  22838.581  23935.941
# [3,]   9246.256  11002.782
# [4,]  -4494.390  -3888.566
# [5,] -16197.349 -15219.603
# [6,] -25295.283 -24264.197
# [7,] -22838.581 -23935.941
# [8,]  -9246.256 -11002.782
# [9,]   4494.390   3888.566
# [10,]  16197.349  15219.603
# [11,]  25295.283  24264.197


# Case 2 (2 wave frequency and single wave direction for 2 location time series):
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 1, freq = c(0.1, 0.3), kata = 45, spevar = matrix(c(4.5, 0.5), 1, 2), dfreq = 1, dkata = 1)
# SI unit system: iunit = 1
# Single Summmation Model is chosen: imodel = 1
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1,  the frequency band width dfreq is provided as a scalar:
#   [1] 1
# For single wave direction m = 1, the direction band width dkata scalar is provided as follows:
#   [1] 1
# Linear Wave Theory is chosen: itheory = 1
# Calculating irregular waves time series by linear superposition of all regular wave components...
# $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
# [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
# [,1]       [,2]
# [1,]  3.4868097  2.9722716
# [2,]  3.3012373  3.6632217
# [3,]  0.3874313  0.8488729
# [4,] -0.6161943 -0.9243714
# [5,] -1.1891979 -1.0822942
# [6,] -3.4868097 -2.9722716
# [7,] -3.3012373 -3.6632217
# [8,] -0.3874313 -0.8488729
# [9,]  0.6161943  0.9243714
# [10,]  1.1891979  1.0822942
# [11,]  3.4868097  2.9722716
#
# $phi
# [,1]       [,2]
# [1,]   5.95557   8.227668
# [2,] -18.70711 -16.399893
# [3,] -34.78991 -34.124567
# [4,] -36.84111 -37.309431
# [5,] -26.71389 -27.812425
# [6,]  -5.95557  -8.227668
# [7,]  18.70711  16.399893
# [8,]  34.78991  34.124567
# [9,]  36.84111  37.309431
# [10,]  26.71389  27.812426
# [11,]   5.95557   8.227669
#
# $u
# [,1]       [,2]
# [1,]  1.1925099  1.0763477
# [2,]  1.1044583  1.1944152
# [3,]  0.2749839  0.3975753
# [4,] -0.2112772 -0.2537665
# [5,] -0.5743127 -0.5332743
# [6,] -1.1925099 -1.0763477
# [7,] -1.1044583 -1.1944152
# [8,] -0.2749839 -0.3975753
# [9,]  0.2112772  0.2537665
# [10,]  0.5743127  0.5332743
# [11,]  1.1925099  1.0763477
#
# $v
# [,1]       [,2]
# [1,]  1.1925099  1.0763477
# [2,]  1.1044583  1.1944152
# [3,]  0.2749839  0.3975753
# [4,] -0.2112772 -0.2537665
# [5,] -0.5743127 -0.5332743
# [6,] -1.1925099 -1.0763477
# [7,] -1.1044583 -1.1944152
# [8,] -0.2749839 -0.3975753
# [9,]  0.2112772  0.2537665
# [10,]  0.5743127  0.5332743
# [11,]  1.1925099  1.0763477
#
# $w
# [,1]       [,2]
# [1,]  1.6850149  1.5207506
# [2,]  1.5606505  1.6878316
# [3,]  0.3882484  0.5615450
# [4,] -0.2985333 -0.3587045
# [5,] -0.8111462 -0.7531685
# [6,] -1.6850149 -1.5207506
# [7,] -1.5606505 -1.6878316
# [8,] -0.3882484 -0.5615450
# [9,]  0.2985333  0.3587045
# [10,]  0.8111462  0.7531685
# [11,]  1.6850149  1.5207506
#
# $udot
# [,1]       [,2]
# [1,]  0.4454673  0.5423997
# [2,] -0.6331016 -0.4263298
# [3,] -0.7771541 -0.9237873
# [4,] -0.2655440 -0.3414214
# [5,] -0.5669588 -0.3863637
# [6,] -0.4454673 -0.5423997
# [7,]  0.6331016  0.4263298
# [8,]  0.7771541  0.9237873
# [9,]  0.2655440  0.3414214
# [10,]  0.5669588  0.3863637
# [11,]  0.4454673  0.5423997
#
# $vdot
# [,1]       [,2]
# [1,]  0.4454673  0.5423997
# [2,] -0.6331016 -0.4263298
# [3,] -0.7771541 -0.9237873
# [4,] -0.2655440 -0.3414214
# [5,] -0.5669588 -0.3863637
# [6,] -0.4454673 -0.5423997
# [7,]  0.6331016  0.4263298
# [8,]  0.7771541  0.9237873
# [9,]  0.2655440  0.3414214
# [10,]  0.5669588  0.3863637
# [11,]  0.4454673  0.5423997
#
# $wdot
# [,1]       [,2]
# [1,]  1.2580143  0.9665453
# [2,]  1.2345592  1.4250407
# [3,] -0.1123089  0.1164985
# [4,] -0.2213714 -0.4438651
# [5,] -0.1325177 -0.1018683
# [6,] -1.2580143 -0.9665453
# [7,] -1.2345592 -1.4250407
# [8,]  0.1123089 -0.1164985
# [9,]  0.2213714  0.4438651
# [10,]  0.1325177  0.1018683
# [11,]  1.2580143  0.9665453
#
# $p
# [,1]       [,2]
# [1,]  25295.283  24264.197
# [2,]  22838.581  23935.941
# [3,]   9246.256  11002.782
# [4,]  -4494.390  -3888.566
# [5,] -16197.349 -15219.603
# [6,] -25295.283 -24264.197
# [7,] -22838.581 -23935.941
# [8,]  -9246.256 -11002.782
# [9,]   4494.390   3888.566
# [10,]  16197.349  15219.603
# [11,]  25295.283  24264.197



# Case 3 (1 wave frequencies and 2 wave directions for 2 location time series):
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 1, m = 2, freq = 0.1, kata = c(0, 45), spevar = matrix(c(0.5, 4.5), 2, 1), dfreq = 1, dkata = 1)
# SI unit system: iunit = 1
# Single Summmation Model is chosen: imodel = 1
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For single wave frequency n = 1, the frequency band width dfreq scalar is provided as follows:
#   [1] 1
# For multiple wave directions m > 1,  the direction band width dkata is provided as a scalar:
#   [1] 1
# Linear Wave Theory is chosen: itheory = 1
# Calculating irregular waves time series by linear superposition of all regular wave components...
#   $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
# [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
# [,1]       [,2]
# [1,]  2.5353246  2.3800743
# [2,]  3.6430407  3.5900777
# [3,]  3.3591370  3.4286941
# [4,]  1.7920493  1.9575567
# [5,] -0.4596131 -0.2613782
# [6,] -2.5357286 -2.3804914
# [7,] -3.6432248 -3.5902862
# [8,] -3.3590311 -3.4286144
# [9,] -1.7916936 -1.9572192
# [10,]  0.4600826  0.2618445
# [11,]  2.5361325  2.3809085
#
# $phi
# [,1]      [,2]
# [1,]  34.562147  36.13913
# [2,]   8.941994  11.38238
# [3,] -20.094249 -17.72267
# [4,] -41.454854 -40.05803
# [5,] -46.980047 -47.09157
# [6,] -34.559050 -36.13633
# [7,]  -8.936459 -11.37699
# [8,]  20.100108  17.72860
# [9,]  41.458799  40.06223
# [10,]  46.980571  47.09244
# [11,]  34.555952  36.13353
#
# $u
# [,1]       [,2]
# [1,]  1.0708433  1.0134552
# [2,]  1.4571349  1.4406342
# [3,]  1.2868134  1.3175037
# [4,]  0.6249337  0.6910919
# [5,] -0.2756759 -0.1993216
# [6,] -1.0709902 -1.0136069
# [7,] -1.4572019 -1.4407100
# [8,] -1.2867749 -1.3174748
# [9,] -0.6248044 -0.6909693
# [10,]  0.2758466  0.1994911
# [11,]  1.0711370  1.0137585
#
# $v
# [,1]       [,2]
# [1,]  0.56155164  0.5074030
# [2,]  1.00385688  0.9779550
# [3,]  1.06268583  1.0749253
# [4,]  0.71556567  0.7612710
# [5,]  0.09509732  0.1568089
# [6,] -0.56169849 -0.5075547
# [7,] -1.00392382 -0.9780308
# [8,] -1.06264730 -1.0748963
# [9,] -0.71543638 -0.7611483
# [10,] -0.09492666 -0.1566393
# [11,]  0.56184533  0.5077063
#
# $w
# [,1]       [,2]
# [1,]  1.3022103  1.2224688
# [2,]  1.8711712  1.8439674
# [3,]  1.7253559  1.7610821
# [4,]  0.9204578  1.0054672
# [5,] -0.2360612 -0.1342417
# [6,] -1.3024178 -1.2226830
# [7,] -1.8712658 -1.8440745
# [8,] -1.7253014 -1.7610412
# [9,] -0.9202751 -1.0052939
# [10,]  0.2363023  0.1344812
# [11,]  1.3026253  1.2228972
#
# $udot
# [,1]       [,2]
# [1,]  0.6315610  0.6635510
# [2,]  0.1154334  0.1625098
# [3,] -0.4447957 -0.4006159
# [4,] -0.8351223 -0.8107156
# [5,] -0.9064414 -0.9111314
# [6,] -0.6315056 -0.6635010
# [7,] -0.1153343 -0.1624133
# [8,]  0.4449006  0.4007220
# [9,]  0.8351929  0.8107908
# [10,]  0.9064508  0.9111469
# [11,]  0.6314501  0.6634509
#
# $vdot
# [,1]       [,2]
# [1,]  0.5874639  0.6066029
# [2,]  0.2678478  0.3033312
# [3,] -0.1540868 -0.1158140
# [4,] -0.5171599 -0.4907179
# [5,] -0.6826763 -0.6781661
# [6,] -0.5874084 -0.6065528
# [7,] -0.2677488 -0.3032346
# [8,]  0.1541917  0.1159201
# [9,]  0.5172305  0.4907930
# [10,]  0.6826857  0.6781816
# [11,]  0.5873530  0.6065027
#
# $wdot
# [,1]        [,2]
# [1,]  0.8182278  0.76812230
# [2,]  1.1757361  1.15864227
# [3,]  1.0841202  1.10656821
# [4,]  0.5783725  0.63178747
# [5,] -0.1483174 -0.08433958
# [6,] -0.8183582 -0.76825691
# [7,] -1.1757955 -1.15870958
# [8,] -1.0840860 -1.10654250
# [9,] -0.5782577 -0.63167855
# [10,]  0.1484689  0.08449009
# [11,]  0.8184885  0.76839152
#
# $p
# [,1]       [,2]
# [1,]  20856.925  19579.763
# [2,]  29969.495  29533.800
# [3,]  27633.898  28206.112
# [4,]  14742.203  16103.750
# [5,]  -3781.111  -2150.334
# [6,] -20860.248 -19583.194
# [7,] -29971.010 -29535.516
# [8,] -27633.026 -28205.457
# [9,] -14739.277 -16100.974
# [10,]   3784.973   2154.170
# [11,]  20863.571  19586.625

# Case 4 (2 wave frequencies and 2 wave directions):
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)))
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
# Single Summmation Model is chosen: imodel = 1
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1
# Linear Wave Theory is chosen: itheory = 1
# Calculating irregular waves time series by linear superposition of all regular wave components...
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
#   Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.0007948875 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  0.000838995 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  0.001633883 sec.
#
# Thank you for using DWS R pacage! See you next time!
#   -------------------------------------------------------
#   $xyz
# [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
# [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
# [,1]       [,2]
# [1,]  1.426167  1.9643325
# [2,]  1.210287  1.1054716
# [3,]  4.000373  3.3676566
# [4,]  2.853661  3.4248282
# [5,] -1.362817 -0.8019845
# [6,] -1.426433 -1.9646675
# [7,] -1.210440 -1.1055782
# [8,] -4.000422 -3.3677221
# [9,] -2.853240 -3.4245031
# [10,]  1.363401  0.8026036
# [11,]  1.426700  1.9650025
#
# $phi
# [,1]       [,2]
# [1,]  31.400776  32.629798
# [2,]  15.498275  16.875736
# [3,]  -7.519549  -5.167275
# [4,] -30.099587 -28.149772
# [5,] -38.481715 -38.735920
# [6,] -31.397614 -32.626886
# [7,] -15.492870 -16.870445
# [8,]   7.525425   5.173151
# [9,]  30.103653  28.154103
# [10,]  38.482148  38.736753
# [11,]  31.394451  32.623973
#
# $u
# [,1]       [,2]
# [1,]  0.4811208  0.6056100
# [2,]  0.6146482  0.5584977
# [3,]  1.3836736  1.2359672
# [4,]  0.9063914  1.0812039
# [5,] -0.3438391 -0.2019754
# [6,] -0.4812378 -0.6057437
# [7,] -0.6147085 -0.5585513
# [8,] -1.3836691 -1.2359698
# [9,] -0.9062477 -1.0810839
# [10,]  0.3440348  0.2021782
# [11,]  0.4813547  0.6058775
#
# $v
# [,1]       [,2]
# [1,]  0.66758385  0.6930794
# [2,]  0.79017531  0.8123343
# [3,]  1.08872886  0.9916181
# [4,]  0.91315020  0.9783834
# [5,] -0.05307148  0.1059202
# [6,] -0.66770082 -0.6932132
# [7,] -0.79023566 -0.8123879
# [8,] -1.08872429 -0.9916207
# [9,] -0.91300652 -0.9782634
# [10,]  0.05326720 -0.1057175
# [11,]  0.66781777  0.6933469
#
# $w
# [,1]       [,2]
# [1,]  0.7568906  0.8920130
# [2,]  0.9406045  0.8936672
# [3,]  1.8332160  1.6452685
# [4,]  1.2836718  1.4854435
# [5,] -0.3659494 -0.1583119
# [6,] -0.7570559 -0.8922019
# [7,] -0.9406897 -0.8937429
# [8,] -1.8332096 -1.6452723
# [9,] -1.2834688 -1.4852740
# [10,]  0.3662260  0.1585985
# [11,]  0.7572211  0.8923909
#
# $udot
# [,1]       [,2]
# [1,] -0.2331960 -0.1645915
# [2,]  0.6656435  0.3655921
# [3,]  0.4207265  0.6169170
# [4,] -1.2702341 -1.0058542
# [5,] -0.7920539 -1.0925273
# [6,]  0.2332828  0.1646966
# [7,] -0.6656077 -0.3655446
# [8,] -0.4206139 -0.6168356
# [9,]  1.2703632  1.0059936
# [10,]  0.7920194  1.0925277
# [11,] -0.2333696 -0.1648017
#
# $vdot
# [,1]        [,2]
# [1,]  0.2288927  0.39207373
# [2,]  0.1885781  0.03676671
# [3,]  0.2534805  0.26347700
# [4,] -0.6898049 -0.45859085
# [5,] -0.9835329 -1.07731463
# [6,] -0.2288059 -0.39196867
# [7,] -0.1885422 -0.03671922
# [8,] -0.2533679 -0.26339557
# [9,]  0.6899340  0.45873026
# [10,]  0.9834984  1.07731502
# [11,]  0.2287190  0.39186360
#
# $wdot
# [,1]        [,2]
# [1,]  0.429717126  0.78055706
# [2,] -0.009284464 -0.05177014
# [3,]  1.568812912  1.19280511
# [4,]  1.149239954  1.44842525
# [5,] -0.858643186 -0.57681554
# [6,] -0.429767847 -0.78064402
# [7,]  0.009242638  0.05176204
# [8,] -1.568869234 -1.19286365
# [9,] -1.149086823 -1.44832347
# [10,]  0.858861519  0.57705471
# [11,]  0.429818549  0.78073096
#
# $p
# [,1]       [,2]
# [1,]  12512.4269  12416.619
# [2,]  20166.4865  19525.155
# [3,]  25818.2325  24999.776
# [4,]  17647.7788  19414.299
# [5,]   -518.3536   1520.966
# [6,] -12515.5244 -12419.916
# [7,] -20167.9515 -19526.703
# [8,] -25817.6169 -24999.359
# [9,] -17644.7446 -19411.543
# [10,]    522.4046  -1516.879
# [11,]  12518.6215  12423.212

DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 1, iseed = 150001, tol = 1.0e-5, no = 200)
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
# Single Summmation Model is chosen: imodel = 1
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1
# Linear Wave Theory with Wheeler's Stretching Technique is : itheory = 2
# Calculating irregular waves time series by linear superposition of all regular wave components...
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.0008141994 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  0.0008349419 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  0.001649141 sec.
#
# Thank you for using DWS R pacage! See you next time!
# -------------------------------------------------------
# $xyz
#      [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
#  [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
#            [,1]       [,2]
#  [1,]  1.426167  1.9643325
#  [2,]  1.210287  1.1054716
#  [3,]  4.000373  3.3676566
#  [4,]  2.853661  3.4248282
#  [5,] -1.362817 -0.8019845
#  [6,] -1.426433 -1.9646675
#  [7,] -1.210440 -1.1055782
#  [8,] -4.000422 -3.3677221
#  [9,] -2.853240 -3.4245031
# [10,]  1.363401  0.8026036
# [11,]  1.426700  1.9650025
#
# $phi
#             [,1]       [,2]
#  [1,]  30.227416  30.833844
#  [2,]  14.649209  16.204019
#  [3,]  -7.141472  -5.287946
#  [4,] -26.449085 -24.390050
#  [5,] -40.759439 -40.197764
#  [6,] -32.348469 -34.074734
#  [7,] -16.490777 -17.577273
#  [8,]   5.532761   3.075182
#  [9,]  35.649174  33.891601
# [10,]  36.443392  37.397255
# [11,]  30.221005  30.827896
#
# $u
#             [,1]       [,2]
#  [1,]  0.4825865  0.5219730
#  [2,]  0.7011080  0.6500131
#  [3,]  1.0027725  1.0015155
#  [4,]  0.7169825  0.7730876
#  [5,] -0.6059560 -0.3121667
#  [6,] -0.4612553 -0.7437051
#  [7,] -0.4586754 -0.4043988
#  [8,] -2.5934709 -1.7626648
#  [9,] -1.3248640 -1.9559306
# [10,]  0.1861192  0.1208630
# [11,]  0.4828263  0.5222134
#
# $v
#               [,1]        [,2]
#  [1,]  0.597508704  0.56704223
#  [2,]  0.817411109  0.82423897
#  [3,]  0.924292749  0.92189838
#  [4,]  0.719583451  0.74019624
#  [5,] -0.138137408  0.09451548
#  [6,] -0.768090167 -0.91805620
#  [7,] -0.726284244 -0.77736199
#  [8,] -1.355667234 -0.95176043
#  [9,] -1.343437967 -1.60748593
# [10,]  0.003105718 -0.11322750
# [11,]  0.597727971  0.56727269
#
# $w
#             [,1]        [,2]
#  [1,]  0.7292887  0.75611767
#  [2,]  1.0382827  0.99005770
#  [3,]  1.3839774  1.38174677
#  [4,]  1.0139775  1.07852906
#  [5,] -0.6632953 -0.27322084
#  [6,] -0.7786966 -1.12334658
#  [7,] -0.7582286 -0.72513706
#  [8,] -3.1537927 -2.15563642
#  [9,] -1.8804776 -2.62088268
# [10,]  0.1875396  0.07417904
# [11,]  0.7296189  0.75645313
#
# $udot
#              [,1]       [,2]
#  [1,]  0.05092402  0.1661681
#  [2,]  0.51945488  0.3336483
#  [3,]  0.01992777  0.1364927
#  [4,] -0.75491221 -0.5971534
#  [5,] -0.89569863 -1.2467693
#  [6,]  0.72967350  0.8824650
#  [7,] -0.88716616 -0.4080254
#  [8,] -2.23155685 -2.2993504
#  [9,]  2.64842196  2.3080060
# [10,]  0.71727816  0.9728680
# [11,]  0.05085949  0.1660926
#
# $vdot
#              [,1]        [,2]
#  [1,]  0.33572169  0.45299388
#  [2,]  0.20335444  0.10795228
#  [3,] -0.02457353  0.02133002
#  [4,] -0.53154840 -0.42208880
#  [5,] -1.20377083 -1.22667579
#  [6,] -0.03071800 -0.22712487
#  [7,] -0.15983155  0.07511931
#  [8,] -1.52967053 -1.12641352
#  [9,]  1.05333452  0.45340563
# [10,]  0.83779787  0.96130196
# [11,]  0.33560634  0.45285481
#
# $wdot
#             [,1]       [,2]
#  [1,]  0.4299726  0.5884906
#  [2,]  0.2546447  0.2011503
#  [3,]  0.9805547  0.9200301
#  [4,]  0.7689868  0.8424478
#  [5,] -1.4283075 -0.8021716
#  [6,] -0.4137218 -1.1444493
#  [7,]  0.4388315  0.4455568
#  [8,] -3.7316140 -1.8823255
#  [9,] -2.1231885 -3.3923240
# [10,]  0.5135785  0.4095726
# [11,]  0.4301197  0.5886435
#
# $p
#              [,1]        [,2]
#  [1,]  11922.0726  11148.2316
#  [2,]  20011.5749  19436.0759
#  [3,]  21230.1258  21695.8601
#  [4,]  15122.8701  15878.0341
#  [5,]  -2027.6080    981.8716
#  [6,] -13112.7295 -14262.9417
#  [7,] -19919.9850 -19270.6776
#  [8,] -35633.3632 -30033.3309
#  [9,] -22113.0247 -27138.8605
# [10,]   -359.5739  -1896.6565
# [11,]  11927.8751  11154.0978




####################################################
## Test of running a for loop in parallel
####################################################
# library(doRNG)
# library(rngtools)
# library(foreach)
# library(doParallel)
# require(foreach, quietly = TRUE)
# require(doParallel, quietly = TRUE)
# source("R/DWS.R")

h = 100.0
g = 9.80665
rho = 1.0259e+3
xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 0.0, -5.0), c(2.0, 0.0, -5.0), c(3.0, 0.0, -5.0), c(4.0, 0.0, -5.0), c(5.0, 0.0, -5.0), c(6.0, 0.0, -5.0), c(7.0, 0.0, -5.0), c(8.0, 0.0, -5.0), c(9.0, 0.0, -5.0), c(10.0, 0.0, -5.0)))
t = seq(from = 0.0, to = 10, by = 1)
amp = c(0, 3, 1, 1)
fk = c(0.04028293, 0.04028293, 0.36231658, 0.36231658)
fsigma = c(0.6283185, 0.6283185, 1.8849556, 1.8849556)
fkata = c(0.0000000, 0.7853982, 0.0000000, 0.7853982)
beta = c(0.1369422, 1.0299106, 4.0621247, 5.2208995)
itheory = 1
ialgorithm = 2

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

if (ialgorithm == 1) {
  # Sequential Algorithm: ialgorithm == 1
  cat("Sequential Algorithm is chosen: ialgorithm == 1\n")

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
} else if (ialgorithm == 2) {
  # Parallel Algorithm: ialgorithm == 2
  cat("Parallel Algorithm is chosen: ialgorithm == 2\n")

  # Setup parallel simulations to use as many processors as possible
  cores <- detectCores() # Detect no. of processors that the computer has
  cl <- makeCluster(cores[1]-1) # Not to fully overload computer using all cores
  cat("Initialize the clusters with specified number of processors: ", cores[1]-1, "\n")
  registerDoParallel(cl) # Initialize the clusters with specified number of processors

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
    wavsimu(h, g, rho, xyz[j, 1], xyz[j, 2], xyz[j, 3], t[i], amp, fk, fsigma, fkata, beta, itheory)
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

  # Stop the clusters after the parallel simulations
  stopCluster(cl)
  cat("Stop the clusters after the parallel simulations.\n")

} else {
  # If other value is given, stop and print error message
  stop("You can only choose either ialgorithm == 1 for Sequential Algorithm or ialgorithm == 2 for Parallel Algorithm.")
}



####################################################
## Test of Function DWS in Parallel
####################################################
# Sequential Algorithm: ialgorithm == 1
# source("R/DWS.R")
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 1, ialgorithm = 1, iseed = 150001, tol = 1.0e-5, no = 200)
#   +-----------------------------+
#   | DIRECTIONAL WAVE SIMULATION |
#   +-----------------------------+
#   Originated by Liqing Huang
# Department of Ocean Engineering
# Texas A&M University - College Station
# -------------------------------------------------------
# Welcome to use DWS R package! Your new task starts...
#
# SI unit system: iunit = 1
# The following parameters are used in calculations:
#   Gravitational acceleration: 9.80665 m/s^2
#   Ocean water density       : 1025.9 kg/m^3
# Single Summmation Model is chosen: imodel = 1
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Sequential Algorithm is chosen: ialgorithm == 1
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.2476521 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  0.1287079 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  0.3763599 sec.
#
# Thank you for using DWS R pacage! See you next time!
# -------------------------------------------------------
# $xyz
#      [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
#  [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
#            [,1]       [,2]
#  [1,]  1.426167  1.9643325
#  [2,]  1.210287  1.1054716
#  [3,]  4.000373  3.3676566
#  [4,]  2.853661  3.4248282
#  [5,] -1.362817 -0.8019845
#  [6,] -1.426433 -1.9646675
#  [7,] -1.210440 -1.1055782
#  [8,] -4.000422 -3.3677221
#  [9,] -2.853240 -3.4245031
# [10,]  1.363401  0.8026036
# [11,]  1.426700  1.9650025
#
# $phi
#             [,1]       [,2]
#  [1,]  30.227416  30.833844
#  [2,]  14.649209  16.204019
#  [3,]  -7.141472  -5.287946
#  [4,] -26.449085 -24.390050
#  [5,] -40.759439 -40.197764
#  [6,] -32.348469 -34.074734
#  [7,] -16.490777 -17.577273
#  [8,]   5.532761   3.075182
#  [9,]  35.649174  33.891601
# [10,]  36.443392  37.397255
# [11,]  30.221005  30.827896
#
# $u
#             [,1]       [,2]
#  [1,]  0.4825865  0.5219730
#  [2,]  0.7011080  0.6500131
#  [3,]  1.0027725  1.0015155
#  [4,]  0.7169825  0.7730876
#  [5,] -0.6059560 -0.3121667
#  [6,] -0.4612553 -0.7437051
#  [7,] -0.4586754 -0.4043988
#  [8,] -2.5934709 -1.7626648
#  [9,] -1.3248640 -1.9559306
# [10,]  0.1861192  0.1208630
# [11,]  0.4828263  0.5222134
#
# $v
#               [,1]        [,2]
#  [1,]  0.597508704  0.56704223
#  [2,]  0.817411109  0.82423897
#  [3,]  0.924292749  0.92189838
#  [4,]  0.719583451  0.74019624
#  [5,] -0.138137408  0.09451548
#  [6,] -0.768090167 -0.91805620
#  [7,] -0.726284244 -0.77736199
#  [8,] -1.355667234 -0.95176043
#  [9,] -1.343437967 -1.60748593
# [10,]  0.003105718 -0.11322750
# [11,]  0.597727971  0.56727269
#
# $w
#             [,1]        [,2]
#  [1,]  0.7292887  0.75611767
#  [2,]  1.0382827  0.99005770
#  [3,]  1.3839774  1.38174677
#  [4,]  1.0139775  1.07852906
#  [5,] -0.6632953 -0.27322084
#  [6,] -0.7786966 -1.12334658
#  [7,] -0.7582286 -0.72513706
#  [8,] -3.1537927 -2.15563642
#  [9,] -1.8804776 -2.62088268
# [10,]  0.1875396  0.07417904
# [11,]  0.7296189  0.75645313
#
# $udot
#              [,1]       [,2]
#  [1,]  0.05092402  0.1661681
#  [2,]  0.51945488  0.3336483
#  [3,]  0.01992777  0.1364927
#  [4,] -0.75491221 -0.5971534
#  [5,] -0.89569863 -1.2467693
#  [6,]  0.72967350  0.8824650
#  [7,] -0.88716616 -0.4080254
#  [8,] -2.23155685 -2.2993504
#  [9,]  2.64842196  2.3080060
# [10,]  0.71727816  0.9728680
# [11,]  0.05085949  0.1660926
#
# $vdot
#              [,1]        [,2]
#  [1,]  0.33572169  0.45299388
#  [2,]  0.20335444  0.10795228
#  [3,] -0.02457353  0.02133002
#  [4,] -0.53154840 -0.42208880
#  [5,] -1.20377083 -1.22667579
#  [6,] -0.03071800 -0.22712487
#  [7,] -0.15983155  0.07511931
#  [8,] -1.52967053 -1.12641352
#  [9,]  1.05333452  0.45340563
# [10,]  0.83779787  0.96130196
# [11,]  0.33560634  0.45285481
#
# $wdot
#             [,1]       [,2]
#  [1,]  0.4299726  0.5884906
#  [2,]  0.2546447  0.2011503
#  [3,]  0.9805547  0.9200301
#  [4,]  0.7689868  0.8424478
#  [5,] -1.4283075 -0.8021716
#  [6,] -0.4137218 -1.1444493
#  [7,]  0.4388315  0.4455568
#  [8,] -3.7316140 -1.8823255
#  [9,] -2.1231885 -3.3923240
# [10,]  0.5135785  0.4095726
# [11,]  0.4301197  0.5886435
#
# $p
#              [,1]        [,2]
#  [1,]  11922.0726  11148.2316
#  [2,]  20011.5749  19436.0759
#  [3,]  21230.1258  21695.8601
#  [4,]  15122.8701  15878.0341
#  [5,]  -2027.6080    981.8716
#  [6,] -13112.7295 -14262.9417
#  [7,] -19919.9850 -19270.6776
#  [8,] -35633.3632 -30033.3309
#  [9,] -22113.0247 -27138.8605
# [10,]   -359.5739  -1896.6565
# [11,]  11927.8751  11154.0978


# Parallel Algorithm: ialgorithm == 2
# source("R/DWS.R")
DWS(h = 100.0, xyz = t(cbind(c(0.0, 0.0, -5.0), c(1.0, 1.0, -5.0))), t = seq(from = 0.0, to = 10, by = 1), n = 2, m = 2, freq = c(0.1, 0.3), kata = c(0, 45), spevar = matrix(c(0.0, 4.5, 0.5, 0.5), 2, 2), dfreq = c(rep(1, 2)), dkata = c(rep(1, 2)), iunit = 1, itheory = 2, imodel = 1, ialgorithm = 2, iseed = 150001, tol = 1.0e-5, no = 200)
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
# Single Summmation Model is chosen: imodel = 1
#
# Obtaining wave properties for each wave component from a directional wave energy spectrum...
# For multiple wave frequencies n > 1, the provided frequency band width dfreq vector is as follows:
#   [1] 1 1
# For multiple wave directions m > 1, the provided direction band width dkata vector is as follows:
#   [1] 1 1
#
# Linear Wave Theory with Wheeler's Stretching Technique is chosen: itheory = 2
#
# Parallel Algorithm is chosen: ialgorithm == 2
# Initializing the clusters with specified number of processors:  11
# Parallel simulations start...
# Calculating irregular waves time series by linear superposition of all regular wave components...
# Retrieving data from parallel simulation output...
# Parallel simulations completed.
# Stop the clusters after the parallel simulations.
#
# Congratulations! Your task has been completed successfully.
#
# Run Time Summary:
# Run time for obtaining wave properties for each wave component from a directional wave energy spectrum is  0.3105109 sec.
# Run time for calculating irregular waves time series by linear superposition of all regular wave components is  6.956399 sec.
# Total run time for irregular wave simulation from a directional wave energy spectrum is  7.26691 sec.
#
# Thank you for using DWS R pacage! See you next time!
# -------------------------------------------------------
# $xyz
#      [,1] [,2] [,3]
# [1,]    0    0   -5
# [2,]    1    1   -5
#
# $t
#  [1]  0  1  2  3  4  5  6  7  8  9 10
#
# $eta
#                [,1]       [,2]
# result.1   1.426167  1.9643325
# result.2   1.210287  1.1054716
# result.3   4.000373  3.3676566
# result.4   2.853661  3.4248282
# result.5  -1.362817 -0.8019845
# result.6  -1.426433 -1.9646675
# result.7  -1.210440 -1.1055782
# result.8  -4.000422 -3.3677221
# result.9  -2.853240 -3.4245031
# result.10  1.363401  0.8026036
# result.11  1.426700  1.9650025
#
# $phi
#                 [,1]       [,2]
# result.1   30.227416  30.833844
# result.2   14.649209  16.204019
# result.3   -7.141472  -5.287946
# result.4  -26.449085 -24.390050
# result.5  -40.759439 -40.197764
# result.6  -32.348469 -34.074734
# result.7  -16.490777 -17.577273
# result.8    5.532761   3.075182
# result.9   35.649174  33.891601
# result.10  36.443392  37.397255
# result.11  30.221005  30.827896
#
# $u
#                 [,1]       [,2]
# result.1   0.4825865  0.5219730
# result.2   0.7011080  0.6500131
# result.3   1.0027725  1.0015155
# result.4   0.7169825  0.7730876
# result.5  -0.6059560 -0.3121667
# result.6  -0.4612553 -0.7437051
# result.7  -0.4586754 -0.4043988
# result.8  -2.5934709 -1.7626648
# result.9  -1.3248640 -1.9559306
# result.10  0.1861192  0.1208630
# result.11  0.4828263  0.5222134
#
# $v
#                   [,1]        [,2]
# result.1   0.597508704  0.56704223
# result.2   0.817411109  0.82423897
# result.3   0.924292749  0.92189838
# result.4   0.719583451  0.74019624
# result.5  -0.138137408  0.09451548
# result.6  -0.768090167 -0.91805620
# result.7  -0.726284244 -0.77736199
# result.8  -1.355667234 -0.95176043
# result.9  -1.343437967 -1.60748593
# result.10  0.003105718 -0.11322750
# result.11  0.597727971  0.56727269
#
# $w
#                 [,1]        [,2]
# result.1   0.7292887  0.75611767
# result.2   1.0382827  0.99005770
# result.3   1.3839774  1.38174677
# result.4   1.0139775  1.07852906
# result.5  -0.6632953 -0.27322084
# result.6  -0.7786966 -1.12334658
# result.7  -0.7582286 -0.72513706
# result.8  -3.1537927 -2.15563642
# result.9  -1.8804776 -2.62088268
# result.10  0.1875396  0.07417904
# result.11  0.7296189  0.75645313
#
# $udot
#                  [,1]       [,2]
# result.1   0.05092402  0.1661681
# result.2   0.51945488  0.3336483
# result.3   0.01992777  0.1364927
# result.4  -0.75491221 -0.5971534
# result.5  -0.89569863 -1.2467693
# result.6   0.72967350  0.8824650
# result.7  -0.88716616 -0.4080254
# result.8  -2.23155685 -2.2993504
# result.9   2.64842196  2.3080060
# result.10  0.71727816  0.9728680
# result.11  0.05085949  0.1660926
#
# $vdot
#                  [,1]        [,2]
# result.1   0.33572169  0.45299388
# result.2   0.20335444  0.10795228
# result.3  -0.02457353  0.02133002
# result.4  -0.53154840 -0.42208880
# result.5  -1.20377083 -1.22667579
# result.6  -0.03071800 -0.22712487
# result.7  -0.15983155  0.07511931
# result.8  -1.52967053 -1.12641352
# result.9   1.05333452  0.45340563
# result.10  0.83779787  0.96130196
# result.11  0.33560634  0.45285481
#
# $wdot
#                 [,1]       [,2]
# result.1   0.4299726  0.5884906
# result.2   0.2546447  0.2011503
# result.3   0.9805547  0.9200301
# result.4   0.7689868  0.8424478
# result.5  -1.4283075 -0.8021716
# result.6  -0.4137218 -1.1444493
# result.7   0.4388315  0.4455568
# result.8  -3.7316140 -1.8823255
# result.9  -2.1231885 -3.3923240
# result.10  0.5135785  0.4095726
# result.11  0.4301197  0.5886435
#
# $p
#                  [,1]        [,2]
# result.1   11922.0726  11148.2316
# result.2   20011.5749  19436.0759
# result.3   21230.1258  21695.8601
# result.4   15122.8701  15878.0341
# result.5   -2027.6080    981.8716
# result.6  -13112.7295 -14262.9417
# result.7  -19919.9850 -19270.6776
# result.8  -35633.3632 -30033.3309
# result.9  -22113.0247 -27138.8605
# result.10   -359.5739  -1896.6565
# result.11  11927.8751  11154.0978
