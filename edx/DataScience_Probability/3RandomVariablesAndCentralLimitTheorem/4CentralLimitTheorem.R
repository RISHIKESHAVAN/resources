## Central Limit Theorem:
## when the number of independent draws (also called sample size) is large, 
## the probability distribution of the sum of these draws is approximately normal.

## We discussed that if we know that the distribution of a list of numbers 
## is approximated by the normal distribution, all we need to describe the list 
## are the average and the standard deviation.
## We also know that the same applies to probability distributions.
## If a random variable has a probability distribution that is approximated 
## with the normal distribution, then all we need to describe that 
## probability distribution are the average and the standard deviation, referred
## to as the expected value and the standard error.

## We have described sampling models for draws. We will now go over the 
## mathematical theory that lets us approximate the probability distribution 
## for the sum of draws. Once we do this, we will be able to help the 
## Casino predict how much money they will make.
----------
## The first important concept to learn is the 'expected value'.
## E[X] = mu - expected value of the random variable X is mu, is the average of 
## the values in the urn. This represents the expectation of one draw. .
  
## A random variable will vary around an expected value in a way that if you
## take the average of many, many draws, the average of the draws will 
## approximate the expected value.
## Getting closer and closer the more draws you take.
## A useful formula is that the expected value of the random variables defined
## by one draw is the average of the numbers in the urn.
## Eg. In our urn used to model betting on red on roulette, we have twenty 1's 
## and 18 negative 1's.
## Therefore, E[X] = (20 + (-18))/38 = $0.05
## It is a bit counterintuitive to say that X varies around 0.05 when the only
## values it takes is 1 and minus 1. An intuitive way to think about the 
## expected value is that if we play the game over and over, the Casino wins, 
## on average, $0.05 per game.
## Our Monte Carlo simulation confirms this,
B <- 10^6
X <- sample(c(-1, 1), B, replace = TRUE, prob = c(9/19, 10/19))
mean(X) # ~0.05

## If the urn has just 2 possibilities, a and b, with probabilities p and 1-p
## then average is avg = ap + b(1-p)
## To see this, notice that if there are nb's in the urn, then we have npa's 
## and n times 1 minus is pb's. And because the average is the sum, 
## we have: (npa + nb(1-p))/n which gives the above formula.

## The reason we define the expected value is because this 
## mathematical definition turns out to be useful for approximating the 
## probability distribution of sums, which in turn, is useful to describe the 
## distribution of averages and proportions.

## The expected value of the sum of draws is 
## the number of draws times the average of the numbers in the urn.
## So, if a 1000 people play roulette, casino earns an average of $50.
## But this is an expected value. How different can one observation be 
## from the expected value? It is important for the casino to know this because,
## if negative numbers are too likely, they may not install the roulette wheels.

## This is where Standard Error (SE) comes into the picture.
## SE gives an idea of the size of the variation around the expected value. SE[X]
## If our draws are independent (that's an important assumption),
## then the standard error of the sum is given by: sqrt(n) * sd of numbers in urn
## mathematically sd of an urn with two values = |b-a|sqrt(p(1-p))
## Therefore, Standard error of the sum of n draws of a random variable:
## sqrt(n) * |b-a| * sqrt(p(1-p))
## So, for the roulette example the sd is given as 
## |1-(-1)| sqrt(9/19(10/19)) = 0.9986 ~ 1

## The SE tells us the typical difference between a random variable
## and its expectation. So because 1 draw is obviously the sum of 1 draw,
## we can use a formula to calculate that the random variable defined by 1 draw
## has an expected value of $0.05 and a standard error of about 1.
## This makes sense since we either get a 1 or a -1
## with 1 slightly favored over the -1.
## Using the formula, the sum of 1,000 people playing has standard error of about $32.
## So when 1,000 people bet on red, the Casino is expected to win $50 
## with a standard error of $32. So it seems like a safe bet.

## But we still really can't answer the question-- How likely is the Casino 
## to lose money? Here The Central Limit Theorem will help.
## The central limit theorem tells us that the distribution of the sum of S
## is approximated by a normal distribution.
## Using the formula, we know that the expected value = $52
1000 * (20-18)/38
## and standard errors = $32
sqrt(1000) * 2 * sqrt(90)/19

## Note that the theoretical values match those obtained with the Monte Carlo
## simulation we ran earlier.
## Using the Central Limit Theorem, we can skip the Monte Carlo simulation
## and instead, compute the probability of the Casino losing
## money using the approximation.
## We write the simple code using the pnorm function and we get the answer.
mu <- 1000 * (20-18)/38
se <- sqrt(1000) * 2 * sqrt(90)/19
pnorm(0,mu,se)
## It's about 5%.
## Which, is in very good agreement-- with the Monte Carlo simulation we ran.


## KEY POINTS:
## The expected value of a random variable, E[X]=mu, is the average of the 
## values in the urn. This represents the expectation of one draw. 
## The standard error of one draw of a random variable is the standard deviation 
## of the values in the urn.
## The expected value of the sum of draws is the number of draws times the 
## expected value of the random variable. 
## The standard error of the sum of independent draws of a random variable is the
## square root of the number of draws times the standard deviation of the urn. 

## EQUATIONS:
## These equations apply to the case where there are only two outcomes, a and
## b with proportions p and 1???p respectively. The general principles above also 
## apply to random variables with more than two outcomes.

## Expected value of a random variable: ap+b(1-p)
## Expected value of the sum of n draws of a random variable:  n * ap+b(1-p)
## Standard deviation of an urn with two values: |b-a|sqrt(p(1-p)) 
## Standard error of the sum of n draws of a random variable: sqrt(n) |b-a|sqrt(p(1-p))