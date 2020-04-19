## Normal Distribution / Bell Curve / Gaussian Distribution:
## Rather than using data, the normal distribution is defined with a 
## mathematical formula.
## Pr(a < x < b) = integral(a->b)[(e^((-1/2)*(x-m/s)^2))/sqrt(2*pi*s)]dx
## For any interval, a and b, the proportion of values in the interval
## can be computed using this formula. The only parameters required  for this 
## formula are m - mean and s - standard deviation.

## The distribution is symmetric, centered at the average, and most values, 
## about 95%, are within two standard deviations from the average.
## Always has the same proportion of observations within a given distance 
## of the mean (for example, 95% within 2s).
## The fact that the distribution is defined by just two parameters
## implies that if a dataset is approximated by a normal distribution,
## all information needed to describe this distribution can be encoded in
## just two numbers, the average and the standard deviation.

## average <- sum(x)/length(x)
## sd <- sqrt(sum((x-average)^2)/length(x))
## sd can be thought of as the average distance between the values and 
## their average.

## Working with male heights:
## define x as vector of male heights
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]

## calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt(sum((x - average)^2)/length(x))

## built-in mean and sd functions
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

## When we plot the smooth density curve (making no assumptions, other than 
## assuming it's somewhat smooth) and the normal distribution curve for the 
## male heights, they are very close.
## This is telling us that the normal distribution approximate the distribution 
## of our male heights.

## Standard Units:
## For data that is approximately normal, it is convenient to think in terms 
## of standard units. The standard unit of a value tells us how many 
## standard deviations away from the average this value is.
## i.e. z = (x - average)/sd
## This is nothing but the (x-m/s) in the normal distribution formula 
## i.e. what is being exponentiated is negative z squared.
## Pr(a < x < b) = integral(a->b)[(e^((-1/2)*(z)^2))/sqrt(2*pi*s)]dx
## The maximum of e to the minus z squared over 2 is when z equals 0, 
## which explains why the maximum of the distribution is at the average.
## It also explains the symmetry, since negative z squared is symmetric around 0.
## To understand why standard units are useful, notice that if we convert 
## normally distributed data into standard units, we can quickly know if 
## for example, a person is about average height, that would mean z equals 0.
## A person that is tall would be z equals 2.
## A person that is short would be z equals negative 2.
## And extremely rare occurrences, say a 7 footer or something like that,
## would have a z bigger than 3.
## Or someone very short would have a z smaller negative 3.
## Note that it does not matter what the original units are and 
## these rules apply to any data that is approximately normal.

## calculate standard units
z <- scale(x)

## Now back to our heights example, to see how many men are within 
## two standard deviations from the average, now that we have already 
## converted to standard units, all we have to do is count the number of z's 
## that are less than 2 and bigger than negative 2, and then divide by the total.

## calculate proportion of values within 2 SD of mean
mean(abs(z) < 2)

## So it's quite useful, if we can assume that the data is approximately normal.
## Then, at least for this interval, we can predict the proportion
## without actually looking at the data. We simply know that 95% of the data 
## for normally distributed data is between negative 2 and 2.


## It is one of the most famous mathematical concepts in history.
## A reason for this is that approximately normal distributions occur in many 
## situations. Examples include, gambling winnings, heights, weights, 
## blood pressure, standardized test scores, and experimental measurement error.

## Note: The built-in R function sd() calculates the standard deviation, 
## but it divides by length(x)-1 instead of length(x). When the length of the 
## list is large, this difference is negligible and you can use the built-in 
## sd() function. Otherwise, you should compute sd by hand. 


## The 68-95-99.7 Rule
## The normal distribution is associated with the 68-95-99.7 rule. 
## This rule describes the probability of observing events within a 
## certain number of standard deviations of the mean. 

## (m - sd) to (m + sd) = 68.3% 
## About 68% of observations will be within one standard deviation of the mean 
## ( m +- sd ). In standard units, this is equivalent to a z-score of |z| <= 1.

## (m - 2sd) to (m + 2sd) = 95.4%
## About 95% of observations will be within one standard deviation of the mean 
## ( m +- 2sd ). In standard units, this is equivalent to a z-score of |z| <= 2.

## (m - 3sd) to (m + 3sd) = 99.7%
## About 99% of observations will be within one standard deviation of the mean 
## ( m +- 3sd ). In standard units, this is equivalent to a z-score of |z| <= 3.