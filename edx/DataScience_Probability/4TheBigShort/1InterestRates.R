## In a way, the sampling models we've been talking about are also used by banks to
## decide interest rates. Let's see how this could be.

## Suppose you run a small bank that has a history of identifying potential 
## homeowners that can be trusted to make payments. In fact, historically in a 
## given year only 2% of your customers default (don't pay back the money).
## However, note that if you simply loan money to everybody without interest, you'll
## end up losing money due to this 2%. Although you know 2% of your clients will 
## probably default, you don't know which ones.

## However, by charging everybody just a bit extra you can make up for the losses 
## incurred due to the 2%, and also pay the employees at work to make these loans 
## happen. You can also make a profit, but if you set the interest rate too high 
## your clients will go to another bank. We use all these facts and some probability
## theory to decide what interest rates we should charge.

## Suppose your bank will give out 1,000 loans for 180,000 this year. Also suppose 
## that your bank loses, after adding up all the costs, $200,000 per foreclosure.
## (including all operational costs.)
## A sampling model for this scenario is coded like this.
## We either default and lose money = 1, or not default and not lose money = 0.
n <- 1000
loss_per_foreclosure <- -200000
p <- 0.02
defaults <- sample(c(0,1), n, prob=c(1-p, p), replace = TRUE)
sum(defaults)
sum(defaults * loss_per_foreclosure)
## Note that the total loss defined by the final sum is a random variable. Every 
## time you run the code you get a different answer. This is because it's a 
## probability of defaulting. It's not going to happen for sure.
## We can easily construct a Monte Carlo simulation to get an idea of the 
## distribution of this random variable.
B <- 10000
losses <- replicate(B, {
  defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE) 
  sum(defaults * loss_per_foreclosure)
})
library(tidyverse)
data.frame(losses_in_millions = losses/10^6) %>%
  ggplot(aes(losses_in_millions)) +
  geom_histogram(binwidth = 0.6, col = "black")
## We can see that we're going to lose money because of these people that default. 
## And the distribution tells how much money we're going to lose in millions.
## However, we don't really need a Monte Carlo simulation. CLT tells us that because
## our losses are a sum of independent draws, its distribution is approximately 
## normal with expected value and standard deviation given by the following formula.
n*(p*loss_per_foreclosure + (1-p)*0) # expected value
sqrt(n)*abs(loss_per_foreclosure)*sqrt(p*(1-p)) # standard deviation

## We can now set an interest rate to guarantee that on average, we break even.
## Basically, we need to add a quantity 'x' to each loan, which in this case are 
## represented by draws, so that the expected value is zero. That means breaking 
## even. That is,
## If l -> loss per foreclosure, then we need to set x such that the following 
## expression holds:
##                lp + x(1-p) = 0
##              => x = -lp/(1-p)
x = -loss_per_foreclosure*p/(1-p) # = 4081.633
## On a $180,000 loan, this equals an interest rate of:
x/180000 ## This is an interest rate of ~2%

## Although this interest rate guarantees that on average we break even, there's a 
## 50% chance that we will lose money. If our bank loses money, we have to close it 
## down. So we need to pick an interest rate that makes it unlikely for this to 
## happen. At the same time, if the interest rate is too high our clients will go to
## another bank. So we must be willing to take some risks. So, let's they say that 
## we want our chances of losing money to be 1 in 100.
## That is, we want the sum (S) to have the probability of S < 0 to be 0.01.
## Pr(S < 0) = 0.01
## We know that S is approximately normal. The expected value of S is given by:
## E[S] = {lp + x(1-p)}*n
## n -> number of draws, i.e. the number of loans.
## The standard error is given by:
## SE[S] = |x - l| sqrt(np(1-p))
## These are just the formulas used earlier, but using more compact symbols.

## Now we're going to use a mathematical trick that is very common in statistics.
## We're going to add and subtract the same quantities to both sides of the event 
## S < 0 so that the probability does not change, and we end up with a standard 
## normal random variable on the left, which will then permit us to write down an 
## equation with only x as an unknown.
##              Pr(S < 0) = 0.01
##              Pr((S - E[S])/SE[S] < - E[S]/SE[S]) = 0.01
## The term on the left is a standard normal random variable, Z.
##              Pr(Z < - E[S]/SE[S])
##              Pr(Z < -({lp + x(1-p)}*n)/(|x - l| sqrt(np(1-p))))
## Here, l,p,n are all known numbers and only x is unknown.

## Now, because Z is a normal random variable with expected value of 0 and standard 
## error 1, it means that the quantity on the right must be equal to qnorm(0.01)
qnorm(0.01)
## Then the equation above will hold true. Remember that if we set z to be qnorm(0.01)
## this will give you a value of z for which the following formula is true.
## Pr(Z <= z) = 0.01
## So this means that the right side of the complicated equation must be equal to 
## qnorm(0.01). So we have this formula:
##          -({lp + x(1-p)}*n)/(|x - l| sqrt(np(1-p))) = z
## Solving for x,
l <- loss_per_foreclosure
z <- qnorm(0.01)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
rate <- x/180000
## Note also that by choosing this interest rate, we now have an expected profit 
## per loan of about $2,124, which is a total expected profit of about $2 million.
loss_per_foreclosure*p + x*(1-p)    # expected value of the profit per loan
n*(loss_per_foreclosure*p + x*(1-p)) # expected value of the profit over n loans


## We can run a Monte Carlo simulation and check our theoretical approximation. 
## We do that, and we indeed get that value again. And again, the probability of 
## profit being less than zero according to the Monte Carlo simulation is about 1%.
B <- 100000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit)    # expected value of the profit over n loans
mean(profit<0)    # probability of losing money
