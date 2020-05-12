## Property 1:
## The expected value of a sum of random variables is the sum of the expected values 
## of the individual random variables.
## E[X1 + X2 + X3 +......+Xn] = E[X1] + E[X2] + E[X3] +........+ E[Xn]
## If the x are drawn from the same urn, then they all have the same expected value.
## It is called mu here.
## ## E[X1 + X2 + X3 +......+Xn] = n(mu)

## Property 2:
## The expected value of random variables times a non-random constant is the 
## expected value times that non-random constant.
## E[aX] = a * E[X]

## A consequence of these two facts is that the expected value of the average of 
## draws from the same urn is the expected value of the urn, call it mu again.
## E[(X1 + X2 + X3 +......+Xn)/n] = (E[X1] + E[X2] + E[X3] +........+ E[Xn])/n
##                                = n(mu)/n = mu

## Property 3:
## The square of the standard error of the sum of independent random variables is 
## the sum of the square of the standard error of each random variable.
## SE[X1 + X2 + X3 +......+Xn] = sqrt(SE[X1]^2 + SE[X2]^2 +........+ SE[Xn]^2)

## Property 4:
## The standard error of random variables times a non-random constant is the 
## standard error times a non-random constant.
## SE[aX] = a * SE[X]

## A consequence of these previous two properties is that, the standard error of the
## average of independent draws from the same urn is the standard deviation of the 
## urn-- called sigma (Greek letter for s) --divided by the square root of n.
## SE[(X1 + X2 +......+Xn)/n] = SE[X1 + X2 +......+Xn]/n
##                            = sqrt(SE[X1]^2 + SE[X2]^2 +........+ SE[Xn]^2)/n
##                            = sqrt(sigma^2+sigma^2+...sigma^2)/n
##                            = sqrt(n*sigma^2)/n = sigma/sqrt(n)

## Property 5:
## If x is a normally distributed random variable, then if a and b are non-random
## constants, then aX + b is also a normally distributed random variable.
## What we are doing is changing the units of the random variable by multiplying 
## by a and then shifting the center by adding b.


## Key points
##Random variable times a constant:
## The expected value of a random variable multiplied by a constant is that 
## constant times its original expected value.
## E[aX]=a(mu)
## The standard error of a random variable multiplied by a constant is that 
## constant times its original standard error.
## SE[aX]=a(sigma)

## Average of multiple draws of a random variable:
## The expected value of the average of multiple draws from an urn is the expected
## value of the urn (mu).
##  The standard deviation of the average of multiple draws from an urn is the 
## standard deviation of the urn divided by the square root of the number of 
## draws (sigma/sqrt(n)).

## The sum of multiple draws of a random variable:
## The expected value of the sum of  n  draws of a random variable is  n  times
## its original expected value.
## E[nX]=n(mu) 
## The standard error of the sum of  n  draws of random variable is sqrt(n) times 
## its original standard error:
## SE[nX] = sqrt(n)(sigma)