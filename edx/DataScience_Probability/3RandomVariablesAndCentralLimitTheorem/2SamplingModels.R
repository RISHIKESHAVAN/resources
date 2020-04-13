## A sampling model models the random behavior of a process as the sampling of draws 
## from an urn. The probability distribution of a random variable is the 
## probability of the observed value falling in any given interval.
## We can define a CDF  F(a)=Pr(S<=a)  to answer questions related to 
## the probability of S being in any interval.
## The average of many draws of a random variable is called its expected value.
## The standard deviation of many draws of a random variable is called its standard error.
--------------------------------

## Suppose a very small casino hires you to consult on
## whether they should set up a roulette wheel.
## They want to know if they can make money off it, or if it's too risky
## and they might lose.
## To keep the example simple, we will assume that 1,000 people will play,
## and that the only game you can play is to bet on red or black.
## The casino wants to predict how much money they will make or lose.
## They want a range of values that are possible,
## and in particular, they want to know, what is the chance of losing money?

## A roulette wheel has 18 red pockets, 18 black pockets, and 2 green ones.
## So playing a color in one game of roulette is equivalent to 
## drawing from the urn containing 18 red, 18 black and 2 greens.
color <- rep(c("Black", "Red", "Green"), c(18, 18, 2))

## If red comes up, the gambler wins, and the casino loses $1,
## so we draw a negative 1. Otherwise, the casino wins $1, and we draw a 1.
## We can code 1,000 independent draws using the following code.
n <- 1000 # number of roulette players
## sampling model 1: define urn, then sample
X <- sample(ifelse(color == "Red", -1, 1), n, replace = TRUE)
X[1:10] ## gives the first 10 values of the 1000 draw

## Now since we know the probabilities of 1s and -1s (probability of red = 18/38 &
## probability of black + green = 20/38), we can generate the draws without using color.
## sampling model 2: define urn inside sample function by noting probabilities
x <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))
s <- sum(x)    # total winnings = sum of draws
s # s is a random variable

## The probability distribution of a random variable tells us the probability of
## the observed value falling in any given interval.
## So for example, if we want to know the probability that we lose money,
## we're asking, what is the probability that s is in the interval s
## less than 0?
## Note that if we can define a cumulative distribution function--
## let's call it f(a) = Pr(s<=a), then we'll be able to answer any question related
## to the probability of events defined by a random variable S,
## including the event S less than 0. 
## f(a) is called the random variable's distribution function.

## We can estimate the distribution function for the random variable S
## by using a Monte Carlo simulation to generate many, many realizations
## of the random variable.
B <- 10000    # number of Monte Carlo experiments
S <- replicate(B, {
  X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))    # simulate 1000 spins
  sum(X)    # determine total profit
})
## mean(S <= a) gives the cdf
mean(S < 0)    # probability of the casino losing money


## we can visualize the distribution by creating a histogram 
## showing the probability. From the histogram, we also see that that distribution
## appears to be approximately normal. If, in fact, the distribution is normal, 
## then all we need to define is the distribution's average and standard deviation.
## Because we have the original values from which the distribution is created,
## If we add a normal density with this average and standard deviation
## to the histogram we created earlier, we see that it matches very well.
library(tidyverse)
s <- seq(min(S), max(S), length = 100)    # sequence of 100 values across range of S
## mean(S) => expected value; sd(S) => standard error
normal_density <- data.frame(s = s, f = dnorm(s, mean(S), sd(S))) # generate normal density for S
data.frame (S = S) %>%    # make data frame of S for histogram
  ggplot(aes(S, ..density..)) +
  geom_histogram(color = "black", binwidth = 10) +
  ylab("Probability") +
  geom_line(data = normal_density, mapping = aes(s, f), color = "blue")

## It actually turns out that statistical theory provides a way
## to derive the distribution of a random variable defined as independent draws
## from an urn. Specifically, in our example, we can show that S plus n divided by 2
## follows what is known as a binomial distribution.
