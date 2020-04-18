## Law of Large Numbers:
## An important implication of the properties of expected value and standard error
## is that the standard error of the average of draws becomes smaller and smaller 
## as the number of draws 'n' grows larger. When n is very large, then the standard
## error is practically 0, and the average of the draws converges to the average of 
## the urn.
## This is known in statistical textbooks as the law of large numbers, or the law of
## averages. Note that the law of averages is sometimes misinterpreted.

## For example, if you toss a coin five times and you see heads each time, you might
## hear someone argue that the next toss is probably a tail because of the law of 
## averages. On average, we should 50% heads and 50% tails, so we need more tails 
## to make up. A similar argument would be to say that red is due on roulette after 
## seeing black come up five times in a row. These events are independent.
## So the chance of a coin landing heads is 50%, regardless of the previous five. 
## Similarly for the roulette outcome. The law of averages applies only when the 
## number of draws is very, very large, not in small samples.
## After a million tosses, you will definitely see about 50% heads, regardless of 
## what the first five were. Another somewhat funny misuse of the law of averages is
## in sports, where you sometimes hear TV announcers predict a player is about to 
## succeed because they have failed a few times in a row, and they need successes 
## to make up and match their average.



## How Large is Large in CLT?
## The sample size required for the Central Limit Theorem and Law of Large Numbers 
## to apply differs based on the probability of success.
## If the probability of success is high, then relatively few observations are 
## needed.
## As the probability of success decreases, more observations are needed.
## If the probability of success is extremely low, such as winning a lottery, then 
## the Central Limit Theorem may not apply even with extremely large sample 
## sizes. The normal distribution is not a good approximation in these cases, and 
## other distributions such as the Poisson distribution (not discussed here) may 
## be more appropriate.
