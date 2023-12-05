#' A directional wave energy spectrum during Hurricane Katrina
#'
#' Contains water depth, wave frequencies, wave directions, and wave energy spectral variances.
#'
#' @format A data frame with 24 rows and 18 columns
#'  \describe{
#'      \item{h}{Water Depth [m]}
#'      \item{n}{No. of wave frequencies}
#'      \item{m}{No. of wave directions}
#'      \item{freq}{Wave frequency vector (length x 23) [Hz]}
#'      \item{kata}{Wave direction vector (length x 17) [deg]}
#'      \item{spevar}{Wave spectral variance matrix (size 17 x 23) [m^2/Hz/deg]}
#'      \item{dfreq}{Wave frequency band width vector (length x 23) [Hz]}
#'      \item{dkata}{Wave direction band width vector (length x 17) [deg]}
#'      }
#'
#' @source {Created in-house to serve as an example.}
#'
#' @examples
#' data(Katrina)   # Lazy loading. Data becomes visible as soon as loaded.
"Katrina"
