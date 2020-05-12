## One of our employees points out that since the bank is making about $2,000 per loan,
## that you should give out more loans. Why just n?
## You explain that finding those n clients was hard. You need a group that is 
## predictable, and that keeps the chances of defaults low.
## He then points out that even if the probability of default is higher, as long as 
## your expected value is positive, you can minimize your chances of losing money by 
## increasing n, the number of loans, and relying on the law of large numbers.
## He claims that even if the default rate is twice as high, say 4%, if we set the 
## rate just a bit higher so that this happens, you will get a positive expected value.

## So if we set the interest rate at 5%, we are guaranteed a positive expected value 
## of $640 per loan.
p <- .04
loss_per_foreclosure <- -200000
r <- 0.05
x <- r*180000
loss_per_foreclosure*p + x*(1-p)
## And we can minimize our chances of losing money by simply increasing the number of 
## loans since,
##      Pr(S < 0) = Pr(Z < - E[S]/SE[S])
## And if we do the math, we will see that we can pick an n so that this probability 
## is 1 in 100. Let's see how. 
## If we define mu and sigma to be the expected value and standard deviation of the 
## urn, that is of a single loan, we have that using the formulas above, 
## E[S] = n(mu)
## SE[S] = sqrt(n)* sigma.

## So if we define z = qnorm(0.01), then we have the following formula,
##                  -n(mu)/sqrt(n)* sigma = -sqrt(n)(mu)/sigma = z
## which tells that if  
##                  n >= (z*sigma*mu)^2,
## then we are guaranteed to have a probability of less than 0.01 of losing money.
## The implication is that as long as mu, the expected value, is positive, we can 
## find an n, a number of loans, that minimizes the probability of a loss.
## This is a form of the Law of Large Numbers: When n is large, our average earning
## per loan converges to the expected earning, mu.

## With x fixed, now what n do we need for the probability to be 0.01?
z <- qnorm(0.01)
l <- loss_per_foreclosure
n <- ceiling((z^2*(x-l)^2*p*(1-p))/(l*p + x*(1-p))^2)
n    # number of loans required
## This is the number of loans we need so that our probability of losing is about 1%.
## And furthermore, we are expected to earn a total of about $14 million.
n*(loss_per_foreclosure*p + x * (1-p))    # expected profit over n loans

## We can confirm this with a Monte Carlo simulation. We run the Monte Carlo 
## simulation, and we get the probability of losing money is about 1%.
B <- 10000
p <- 0.04
x <- 0.05 * 180000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit<0)



## This seems like a no brainer. Your colleague decides to leave your bank, and 
## start his own high-risk mortgage company. A few months later, your colleague's 
## bank has gone bankrupt. What happened?
## Your friend's scheme was based in part on the following mathematical formula,
## SE[(X1 + X2 +......+Xn)/n] = sigma/sqrt(n)
## by making n large, we minimize the standard error of our per-loan profit.

## However, for this rule to hold, the X's must be independent draws. The fact that
## one person defaults must be independent of other people defaulting.
## Note that, for example, that in the extreme of averaging the same event over and
## over, an event is certainly not independent. In that case, we get a much higher 
## standard error (It's the sqrt(n) larger).
## SE[(X1 + X1 +......+Xn)/n] = SE[(nX1/n)] = sigma > sigma/sqrt(n)

## To construct a more realistic simulation than the original one your friend ran,
## let's assume there could be a global event that affects everybody with high-risk
## mortgages, and changes their probability. We will assume that with a 50-50 chance,
## all the probabilities go up or down slightly to somewhere between 0.03 and 0.05.
## But it happens to everybody at once, not just one person. These draws are no 
## longer independent.
## Let's use a Monte Carlo simulation to see what happens under this model.
p <- 0.04
x <- 0.05*180000
profit <- replicate(B, {
  new_p <- 0.04 + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-new_p, new_p), replace = TRUE)
  sum(draws)
})
## Note that our expected profit is still large. We're expected to make about 
## $14 million.
mean(profit)    # expected profit
## However, the probability of the bank having negative earning shoots way up to 
## almost 35%.
mean(profit < 0)    # probability of losing money
## Even scarier is the probability of losing more than $10 million,which is 24%.
mean(profit < -10000000)    # probability of losing over $10 million
## To understand how this happens, we can look at the distribution of our 
## random variable.
data.frame(profits_in_millions = profit/10^6) %>%
  ggplot(aes(profits_in_millions)) +
  geom_histogram(binwidth = 5, col = "black")
## It doesn't look normal at all. The theory completely breaks down, and our random
## variable has much more variability than expected.
## The financial meltdown of 2007 was due, among other things, to financial experts
## assuming independence when there was none.