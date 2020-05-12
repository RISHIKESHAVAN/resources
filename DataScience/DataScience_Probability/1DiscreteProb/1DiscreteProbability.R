beads <- rep(c("red", "blue"), times = c(2,3))    # create an urn with 2 red, 3 blue
beads    # view beads object
sample(beads, 1)    # sample 1 bead at random
##########################
##Monte Carlo simulation##
B <- 10000    # number of times to draw 1 bead
events <- replicate(B, sample(beads, 1))    # draw 1 bead, B times
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab)    # view table of outcome proportions

## We actually dont need to use replicate function, because sample function 
## allows us to pick more than one bead. but however this happens without 
## replacement. i.e, the  beads are picked each time without being put back.
## The following 3 functions return the same 5 beads, with the orders 
## rearranged.
sample(beads, 5)
sample(beads, 5)
sample(beads, 5)

## In the same case, a number greater than 5 would return an error because 
## the beads are not replaced back in the urn. sample(beads, 8) would throw
## an error.
## This can be overriden using the replace=TRUE option.
events <- sample(beads, B, replace=TRUE)    # draw B beads, putting the bead back each time
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab) 

################
##Setting seed##

#?set.seed- A popular way to pick the seed is the year - month - day.

##Probability of drawing a blue bead at random.
##beads <- rep(c("red", "blue"), times = c(2,3))
##beads
##mean(beads == "blue") - this return 0.6
