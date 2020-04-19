## Cumulative Distribution Function:
## CDF of a real-valued random variable X, or just distribution function of X, 
## evaluated at x, is the probability that X will take a value less than or 
## equal to x.
## Normal Distribution:
## It is a probability function/distribution that describes how the values 
## of a variable are distributed. It fits many natural phenomena. 
## For example, heights, blood pressure, measurement error, and IQ scores
## *Mean - central tendency of the distribution. It defines the location of 
## the peak for normal distributions. Most values cluster around the mean.
## *StandardDeviation - The standard deviation is a measure of variability. 
## It defines the width of the normal distribution. It determines how far away
## from the mean the values tend to fall. 
##############

## The cumulative distribution for normal distribution is defined by a mathematical 
## formula which in R can be obtained with the function pnorm().

## We say that a random quantity is normally distributed with average, avg,
## and standard deviation, s, if its probability distribution
## is defined by f of a equals pnorm a, average, s.
##                   F(a)=pnorm(a,avg,s)
## This is useful, because if we are willing to use the normal approximation
## for say, height, we don't need the entire dataset
## to answer questions such as, what is the probability that a randomly selected
## student is taller than 70.5 inches.
## We just need the average height and the standard deviation.
## =>             1 - pnorm(70.5, mean(x), sd(x))

## Imp Notes:
## -> The normal dist is computed mathematically.
## -> the normal dist is defined for continuous variables, not for discrete.
## However for practicing data scientists, pretty much everything we do 
## involves data, which is technically speaking discrete.

# plot distribution of exact heights in data
plot(prop.table(table(x)), xlab = "a = Height in inches", ylab = "Pr(x = a)")

## With continuous distributions, the probability of a singular value 
## is not even defined. For example, it does not make sense to ask
## what is the probability that a normally distributed value is 70.
## Instead, we define probabilities for intervals.
## So we could ask instead, what is a probability that someone
## is between 69.99 and 70.01.
## In cases like height in which the data is rounded,
## the normal approximation is particularly useful
## if we deal with intervals that include exactly one round number (one integer).

## probabilities in actual data (not using approximation) 
## over length 1 ranges containing an integer
mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)

## probabilities in normal approximation match well
## The prime difference is that this approach does not require the entire 
## dataset to do the computation.
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(68.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5, mean(x), sd(x))

## probabilities in actual data over other ranges don't match normal approx as well
mean(x <= 70.9) - mean(x <= 70.1)
pnorm(70.9, mean(x), sd(x)) - pnorm(70.1, mean(x), sd(x))
## In general, we call this situation discretization.
## Although the true height distribution is continuous,
## the reported heights tend to be more common at discrete values,
## in this case, due to rounding.
## As long as we are aware of how to deal with this reality,
## the normal approximation can still be a very useful tool.