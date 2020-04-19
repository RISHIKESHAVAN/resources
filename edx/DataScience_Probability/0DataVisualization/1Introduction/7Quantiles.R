## Quantiles:
## Quantiles are cutoff points that divide a dataset into intervals with 
## set probabilities. The qth quantile is the value at which q% of the observations 
## are equal to or less than that value.
## Given a dataset data and desired quantile q, you can find the 
## qth quantile of data with:
## quantile(data,q)

## Percentiles:
## Percentiles are the quantiles that divide a dataset into 100 intervals 
## each with 1% probability. You can determine all percentiles of a dataset data 
## like this:
## p <- seq(0.01, 0.99, 0.01)
## quantile(data, p)

## Quartiles:
## Quartiles divide a dataset into 4 parts each with 25% probability. They are 
## equal to the 25th, 50th and 75th percentiles. The 25th percentile is also known 
## as the 1st quartile, the 50th percentile is also known as the median, and the 
## 75th percentile is also known as the 3rd quartile.
## The summary() function returns the minimum, quartiles and maximum of a vector.

## Load the heights dataset from the dslabs package:
library(dslabs)
data(heights)
## Use summary() on the heights$height variable to find the quartiles:
summary(heights$height)
## Find the percentiles of heights$height:
p <- seq(0.01, 0.99, 0.01)
percentiles <- quantile(heights$height, p)
percentiles
## Confirm that the 25th and 75th percentiles match the 1st and 3rd quartiles. 
## Note that quantile() returns a named vector. You can access the 25th and 
## 75th percentiles like this (adapt the code for other percentile values):
percentiles[names(percentiles) == "25%"]
percentiles[names(percentiles) == "75%"]


## Finding quantiles with qnorm:
## The qnorm() function gives the theoretical value of a quantile with 
## probability p of observing a value equal to or less than that quantile value 
## given a normal distribution with mean mu and standard deviation sigma:
## qnorm(p, mu, sigma)
## By default, mu=0 and sigma=1. Therefore, calling qnorm() with no arguments 
## gives quantiles for the standard normal distribution.
## qnorm(p)
## Recall that quantiles are defined such that p is the probability of a 
## random observation less than or equal to the quantile.

## Relation to pnorm:
## The pnorm() function gives the probability that a value from a 
## standard normal distribution will be less than or equal to a z-score value z. 
## Consider:
pnorm(-1.96)  ## 0.025 
## The result of pnorm() is the quantile. Note that:
qnorm(0.025) ## -1.96
## qnorm() and pnorm() are inverse functions:
pnorm(qnorm(0.025))  ## =0.025

## Theoretical quantiles:
## You can use qnorm() to determine the theoretical quantiles of a dataset: 
## that is, the theoretical value of quantiles assuming that a dataset 
## follows a normal distribution. Run the qnorm() function with the 
## desired probabilities p, mean mu and standard deviation sigma. 
## Suppose male heights follow a normal distribution with a mean of 69 inches and 
## standard deviation of 3 inches. The theoretical quantiles are:
p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, 69, 3)
## Theoretical quantiles can be compared to sample quantiles determined 
## with the quantile function in order to evaluate whether the sample follows 
## a normal distribution.