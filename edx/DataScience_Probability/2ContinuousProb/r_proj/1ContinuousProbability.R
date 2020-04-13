## Define x as male heights from the dslabs heights dataset:
  
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

## Given a vector x, we can define a function for computing the CDF of x using:
F <- function(a) mean(x <= a)
1 - F(70)    # probability of male taller than 70 inches


## The cumulative distribution function (CDF) is a distribution function for 
## continuous data 'x' that reports the proportion of the data below 'a'
## for all values of 'a':
##                        F(a)=Pr(x=a) 
## The CDF is the probability distribution function for continuous variables. 
## For example, to determine the probability that a male student is 
## taller than 70.5 inches given a vector of male heights  x , we can use the CDF:
##              Pr(x>70.5)=1-Pr(x=70.5)=1-F(70.5) 
## The probability that an observation is in between two values a,b is F(b)-F(a).
## Because we can compute the probability for any possible event this way,
## the cumulative probability function defines a probability distribution
## for picking a height at random from our vector of heights x.