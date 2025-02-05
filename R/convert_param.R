#' Converts the mu (mean log) and sigma (standard deviation log) parameters of
#' the lognormal distribution to the mean and standard deviation
#'
#' @param mu The mu parameter (mean of natural logarithm) of the lognormal
#' distribution
#' @param sigma The sigma parameter (standard deviation of the natural
#' logarithm) of the distribution
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' lnorm_musigma2meansd(1.5, 0.9)
lnorm_musigma2meansd <- function(mu, sigma) {
  mean <- exp(mu + 0.5 * sigma^2)
  sd <- exp(mu + 0.5 * sigma^2) * sqrt(exp(sigma^2) - 1)
  list(mean = mean, sd = sd)
}

#' Converts the mean and standard deviation of a lognormal distribution into the
#' standard parameterisation of mu (mean log) and sigma (standard deviation log)
#'
#' @param mean Mean (expectation) of the lognormal distribution
#' @param sd Standard deviation of the lognormal distribution
#'
#' @return A named list with mu and sigma
#' @export
#'
#' @examples
#' lnorm_meansd2musigma(1.0, 0.4)
lnorm_meansd2musigma <- function(mean, sd) {
  sigma <- sqrt(log(sd^2 / mean^2 + 1))
  mu <- log(mean^2 / sqrt(sd^2 + mean^2))
  list(mu = mu, sigma = sigma)
}

#' Converts the shape and scale parameters of the gamma distribution to the
#' mean and standard deviation.
#'
#' @param shape The shape parameter of the gamma distribution
#' @param scale The scale parameter of the gamma distribution
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' gamma_shapescale2meansd(shape = 0.5, scale = 0.2)
gamma_shapescale2meansd <- function(shape, scale) {
  mean <- shape * scale
  sd <- sqrt(shape) * scale
  list(mean = mean, sd = sd)
}

#' Converts the mean and standard deviation of the gamma distribution to the
#' shape and scale parameterisation.
#'
#' @param mean The mean of the gamma distribution
#' @param sd The standard deviation of the gamma distribution
#'
#' @return A named list with shape and scale parameters
#' @export
#'
#' @examples
#' gamma_meansd2shapescale(mean = 2.2, sd = 0.9)
gamma_meansd2shapescale <- function(mean, sd) {
  shape <- mean^2 / sd^2
  scale <- sd^2 / mean
  list(shape = shape, scale = scale)
}

#' Converts the mean and standard deviation of the weibull distribution to the
#' shape and scale parameterisation.
#'
#' @param mean The mean of the weibull distribution
#' @param sd The standard deviation of the weibull distribution
#'
#' @return A named list with shape and scale parameters
#' @export
#'
#' @examples
#' weibull_meansd2shapescale(mean = 1.5, sd = 0.5)
#'
#' # numerical approximations are used to estimate the shape and scale
#' # parameters
#'
#' # converting between the mean and standard deviation and shape and scale does
#' # not recover the original values
#' wss <- weibull_meansd2shapescale(mean = 1.5, sd = 1)
#' weibull_shapescale2meansd(wss[["shape"]], wss[["scale"]])
#' # $mean
#' # [1] 1.5
#' # $sd
#' # [1] 0.4514356
#'
#' # the mean and standard deviation (sqrt(var)) are more accurately recovered
#' # from a larger sample size of weibull random variables
#' set.seed(1)
#' r <- rweibull(n = 1000, shape = wss[["shape"]], scale = wss[["scale"]])
#' mean(r)
#' # 1.491087
#' var(r)
#' # 0.9551043
#' r <- rweibull(n = 1000000, shape = wss[["shape"]], scale = wss[["scale"]])
#' mean(r)
#' # 1.500239
#' var(r)
#' # 0.9995295
weibull_meansd2shapescale <- function(mean, sd) {

  # give warning message about numerial inaccuracies
  message("Numerical approximation used, results may be unreliable.")

  var <- sd^2
  f <- function(k, mean, var) {
    (var / mean^2) - ((gamma(1 + 2 / k)) / (gamma(1 + 1 / k))^2) + 1
  }

  root <- stats::uniroot(f = f, interval = c(0.1, 1000), mean = mean, var = var)
  shape <- root$root
  scale <- mean / gamma(1 + 1 / shape)
  list(shape = shape, scale = scale)
}

#' Converts the shape and scale parameters of the weibull distribution to the
#' mean and standard deviation
#'
#' @param shape The shape parameter of the weibull distribution
#' @param scale The scale parameter of the weibull distribution
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' weibull_shapescale2meansd(shape = 2, scale = 1)
weibull_shapescale2meansd <- function(shape, scale) {
  mean <- scale * gamma(1 + 1 / shape)
  sd <- sqrt(scale^2 * (gamma(1 + 2 / shape) - gamma(1 + 1 / shape))^2)
  list(mean = mean, sd = sd)
}
