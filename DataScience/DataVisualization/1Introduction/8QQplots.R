## Quantile-quantile plots, or QQ-plots, are used to check whether 
## distributions are well-approximated by a normal distribution.
## Given a proportion p, the quantile q is the value such that 
## the proportion of values in the data below q is p.

## In a QQ-plot, the sample quantiles in the observed data are compared 
## to the theoretical quantiles expected from the normal distribution. 
## If the data are well-approximated by the normal distribution, then the points 
## on the QQ-plot will fall near the identity line (sample = theoretical).

# define x and z
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]
z <- scale(x)

## calculate observed and theoretical quantiles
p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(x, p)
theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))
## qnorm() will calculate quantiles for the standard normal distribution 
## (mu=0,sigma=1) by default, but it can calculate quantiles for any 
## normal distribution given mean() and sd() arguments.

## make QQ-plot
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)
## Note that the points fall almost on the line, meaning that the 
## normal approximation is a pretty good approximation.

## This code becomes slightly simpler if we use standard units. If we use 
## standard units, we don't have to define the mean and the standard deviation 
## in the function qnorm. So the code simplifies and looks like this.
observed_quantiles <- quantile(z, p)
theoretical_quantiles <- qnorm(p)
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)


## Note:
## If a distribution is not normal, it cannot be summarized with only the 
## mean and standard deviation. Provide a histogram, smooth density or boxplot 
##instead.
## A plot can force us to see unexpected results that make us question the 
## quality or implications of our data.