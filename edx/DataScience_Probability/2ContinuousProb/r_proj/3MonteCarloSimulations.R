## R provides a function to generate normally distributed outcomes.
## rnorm() arguments-- size; average (default 0); standard deviation (default 1)

## define x as male heights from dslabs data
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

## generate simulated height data using normal distribution 
## - both datasets should have n observations
## rnorm() here generates the normally distributed outcomes
n <- length(x)
avg <- mean(x)
s <- sd(x)
simulated_heights <- rnorm(n, avg, s)

## plot distribution of simulated_heights
## Unsurprisingly, they look normal because they were genrated to look normal.
data.frame(simulated_heights = simulated_heights) %>%
  ggplot(aes(simulated_heights)) +
  geom_histogram(color="black", binwidth = 2)

## Thus rnorm() is one of the most important function in R that will let us 
## to generate data that mimics naturally occuring events and 
## and it'll let us answer questions related to what could happen
## by chance by running Monte Carlo simulations.

## For example, if we pick 800 males at random, what is the distribution 
## of the tallest person?
## Specifically, we could ask, how rare is that the tallest person is a seven
## footer?

B <- 10000
tallest <- replicate(B, {
  simulated_data <- rnorm(800, avg, s) ## generate 800 normally distributed random heights
  max(simulated_data) ## determine the tallest height
})
mean(tallest >= 7*12) ## proportion of times that tallest person exceeded 7 feet