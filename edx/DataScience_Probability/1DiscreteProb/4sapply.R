## So to find the probability of the 2 people having same bdays for any group(n)
compute_prob <- function(n, B = 10000) {
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

## we can apply this function to any values of n, lets say 1 to 60
n <- seq(1,60)

## now to call the function for each value of n, we can use a for loop.
## but for loops are generally not preferred in R.
## In general, we try to perform entire functions on vectors.
## Arithmetic operations operate on vectors element wise.
x <- 1:10
sqrt(x)  ## this returns a vector of square roots of each element of x
## So, there is really no need of FOR loops
## But not all functions work this way. eg, the function we wrote does not work 
## element wise as it needs a scalar n.
## sapply permits us to perform element wise functions.
## sapply(x, sqrt) - same as sqrt(x)
prob <- sapply(n, compute_prob)
plot(n,prob) ## n - x axis, prob - y axis
## You might face an error like -'Error in plot.new() : figure margins too large'
## In such cases, just expand the plot window in you RStudio. That should fix the bug
################

## Now instead of using Monte Carlo to get the best guess, 
## we can compute the actual probability mathematically
## To make the math simple, instead of calculating the probability of people having the same bday, 
## we will compute the probability of it not happening.
## So, Pr(Person 1 has a unique bday) = 1
## Pr(Person 2 has a unique bday | Person 1 has a unique bday) = 364/365
## Pr(Person 2 has a unique bday | Person 2 and 1 has a unique bday) = 363/365
## If we follow this, then the probability of all 50 people having unique bdays would be,
## 1 * 364/365 * 363/365 * ....... * (365 - n + 1)/365
exact_prob <- function(n) {
  unique_bday <- seq(365, 365-n+1)/365
  1-prod(unique_bday)
}
exact_prob(50)
a <- seq(1,60)
probs <- sapply(a, exact_prob)
plot(n,prob)
lines(a, probs)
