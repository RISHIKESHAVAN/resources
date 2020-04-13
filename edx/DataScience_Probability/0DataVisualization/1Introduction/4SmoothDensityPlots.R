## Smooth density plots can be thought of as histograms where the 
## bin width is extremely or infinitely small. The smoothing function makes 
## estimates of the true continuous trend of the data given the available sample 
## of data points.

## The main new concept is that we assume that our list of observed values 
## of observed heights comes from a much, much larger list of unobserved values.
## That is, in the case of male heights, you can imagine our lists of 
## students heights comes from a hypothetical list containing all the heights 
## of all the male students in all the world measured very precisely.

## So as an example, let's suppose that we have a million of these.
## This list of values, like any other list of values, has a distribution.
## Though, we don't get to see it, we can make an assumption 
## that helps us perhaps approximate. Because we're assuming that we have 
## a million values measured very precisely, we can make a histogram with 
## very, very small bins. This is going to help us understand what 
## smooth densities are. The assumption is that if we do this, 
## consecutive bins will be similar. This is what we mean by smooth. Because,
## when we make the bins smaller and smaller, the edges start disappearing 
## and the histogram becomes smoother.
## The degree of smoothness can be controlled by an argument in the plotting function.
## We compute the curve on the frequency scale rather than the count scale.

## Now, coming back to reality, we have only 708 values - not million. So, how to
## estimate this hypothetical smooth curve that we would see if we would see 
## all the measurements? 
## For this, we're going to start make a histogram with our data, compute
## frequencies rather than counts, and using the bin size appropriate for our data.
## Because it is a small sample, we  will get unsmooth variation in these heights.
## To smooth the histogram we're going to draw a smooth curve that goes through 
## the top of these histograms bars. This is the smooth density.

## Smooth is a relative term. We can control the smoothness of the curve in the 
## gg plot option. We need to choose the  degree of smoothness with care, as the 
## resulting visualization might change our intrepretaion of the data.

## Important: while the histogram is an assumption free summary, the smooth density
## is based on assumptions and choices that you make as a data analyst.

## Y-axis of the smooth density plot: It is scaled in such a way that the area
## under the curve = 1. This means that interpreting values on the y-axis 
## is not straightforward.
## So if you imagine, you form a bin with a base that is 1 unit long. The y-axis 
## value tells us the proportion of values in that bin. But this is only true 
## if the bin is of size 1. For other size intervals, the best way to determine 
## the proportion of data in that interval is by computing the proportion of 
## the total area contained in that interval.

## Advantage of smooth densities over histograms: it makes it easier to compare 
## two distributions. This is in large part because the jagged edges of the 
## histogram add clutter, so when we're comparing two histograms, 
## it makes it a little bit hard to see.