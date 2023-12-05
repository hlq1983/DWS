#' wavspec
#'
#' Obtain spectral information from a directional wave energy spectrum.
#'
#' @param spectrum A matrix (at lease 2 X 2) contains all information of a directional wave energy spectrum.
#' @param dfreq (Optional, default NULL) Wave frequency band width scalar or vector.
#' @param dkata (Optional, default NULL) Wave direction band width scalar or vector.
#'
#' @return All necessary wave spectral information for function DWS.
#' @export
#'
#' @examples wavspec(spectrum)
#' @examples wavspec(spectrum, dfreq = 1, dkata = 1)
#' @examples wavspec(spectrum, dfreq = c(rep(1, 23)), dkata = c(rep(1, 17)))
#'
wavspec <- function (spectrum, dfreq = NULL, dkata = NULL) {
  # Check spectrum dimensions
  if (is.matrix(spectrum) & nrow(spectrum) >= 2 & ncol(spectrum) >= 2) {
    cat("The spectrum is given as follows: \n")
    print(spectrum)
  } else {
    stop("The spectrum must be a matrix (at lease 2 X 2) contains all information of a directional wave energy spectrum.")
  }

  # Water depth h is set in the first row first column of the Katrina data matrix
  h <- spectrum[1, 1]
  cat("The water depth is given as follows: \n")
  print(h)

  # Wave frequency vector freq is set in the first row except the first entry
  freq <- as.matrix(spectrum[1, -1])
  # Obtain no. of wave frequency vector freq
  n <- length(freq)
  cat("The wave frequency vector freq with length of ", n, " is given as follows: \n")
  print(freq)

  # Wave direction vector kata is set in the first column except the first entry
  kata <- as.vector(spectrum[-1, 1])
  # Obatin no. of wave direction vector kata
  m <- length(kata)
  cat("The wave direction vector kata with length of ", m, " is given as follows: \n")
  print(kata)

  # Wave energy spectral variances matrix spevar is set in data matrix from second row to end and from the second column to end
  spevar <- as.matrix(spectrum[-1, -1])
  cat("The wave energy spectral variance matrix with size of ", n, " X ", m, " is given as follows: \n")
  print(spevar)

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
      # Keep wave direction kata within the range [-180, 180] deg
      # For kata > 180 deg, kata = kata - 360
      kata <- ifelse(kata > 180, kata - 360, kata)
      cat("The wave direction vector kata with length of ", m, " is regularized within the range [-180, 180] deg as follows: \n")
      print(kata)
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

  # Return All necessary wave spectral information for function DWS.
  return(list(h = h, n = n, m = m, freq = freq, kata = kata, spevar = spevar, dfreq = dfreq, dkata = dkata))
}
