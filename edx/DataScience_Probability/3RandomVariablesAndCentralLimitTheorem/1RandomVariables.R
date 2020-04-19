## Random variables are numeric outcomes resulting from a random process.
## Define random variable x to be 1 if blue, 0 otherwise
beads <- rep(c("red", "blue"), times = c(2, 3))
x <- ifelse(sample(beads, 1) == "blue", 1, 0)
## x is a random variabe whose value changes randomly each time a new bead is selected.
ifelse(sample(beads, 1) == "blue", 1, 0)
ifelse(sample(beads, 1) == "blue", 1, 0)
ifelse(sample(beads, 1) == "blue", 1, 0)

## In data science, we often deal with data that is affected by chance in some way.
## The data comes from a random sample - the data is affected by measurement error,
## or the data measures some outcome that is random in nature.
## Being able to quantify the uncertainty introduced by randomness
## is one of the most important jobs of a data scientist.

## Statistical inference offers a framework for doing this, as well
## as several practical tools.
## The first step is to learn how to mathematically describe
## random variables.
## We start with games of chance as an illustrative example.

## Notation for Random Variables:
## Capital letters are used to denote random variables
## Lower case letters are used for observed values.
## You'll see some notation that includes both.
## Eg. X<=x; X - random variable; x - arbitary value
## Eg. X - the number on a die roll (that's a random value); x - an actual value we see.
## So here, Pr(X = x) = 1/6
## X is not an observed quantity. Instead, it's a random quantity that 
## we will see in the future. We can talk about what we expect it to be, 
## what values are probable, but not what it is.
## But once we have the data, we do see a realization of big x,
## so data scientists talk about what could have been,
## but after we see what actually happened.
