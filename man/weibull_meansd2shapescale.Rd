% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_param.R
\name{weibull_meansd2shapescale}
\alias{weibull_meansd2shapescale}
\title{Converts the mean and standard deviation of the weibull distribution to the
shape and scale parameterisation.}
\usage{
weibull_meansd2shapescale(mean, sd)
}
\arguments{
\item{mean}{The mean of the weibull distribution}

\item{sd}{The standard deviation of the weibull distribution}
}
\value{
A named list with shape and scale parameters
}
\description{
Converts the mean and standard deviation of the weibull distribution to the
shape and scale parameterisation.
}
\examples{
weibull_meansd2shapescale(mean = 1.5, sd = 0.5)

# numerical approximations are used to estimate the shape and scale 
# parameters

# converting between the mean and standard deviation and shape and scale does
# not recover the original values
wss <- weibull_meansd2shapescale(mean = 1.5, sd = 1)
weibull_shapescale2meansd(wss[["shape"]], wss[["scale"]])
# $mean
# [1] 1.5
# $sd
# [1] 0.4514356

# the mean and standard deviation (sqrt(var)) are more accurately recovered 
# from a larger sample size of weibull random variables
set.seed(1)
r <- rweibull(n = 1000, shape = wss[["shape"]], scale = wss[["scale"]])
mean(r)
# 1.491087
var(r)
# 0.9551043
r <- rweibull(n = 1000000, shape = wss[["shape"]], scale = wss[["scale"]])
mean(r)
# 1.500239
var(r)
# 0.9995295
}
