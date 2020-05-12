## We can try to make some of the summary plots we have previously described.
## Let's start with the histogram for the male heights.
## So in a first step, we need to filter the heights to only include the males.
## We do this using the filter function.
library(tidyverse)
library(dslabs)
data(heights)
heights %>% filter(sex == "Male")
## Now that we have a data set, the next step is deciding what geometry we need.
## geom_histogram is the correct geometry for making histograms in ggplot.
## Looking at the help file for this function, we learn that the only required 
## argument is x, the variable for which we will construct a histogram.
## We're going to do it in two steps. First, we're going to define a graph object
## p, that has the data piped into the ggplot function and defines the aesthetic 
## mapping that tells us that heights is what we're going to make a histogram of.
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
## And then we add the geom_histogram layer, which will create the plot.
p + geom_histogram()
## Now when we do this, we notice that we get a warning or a message saying that 
## the bin width was not picked, and it was picked for us. We can add the bin width
## that we want through the arguments.
p + geom_histogram(binwidth = 1)
## We have geometry_histogram and we define the band width to be one.

## To change colour and add a title:
p + geom_histogram(binwidth = 1, fill = "blue", col = "black") +
  xlab("Male heights in inches") +
  ggtitle("Histogram")


## To create Smooth Densities:
##  geom_density() on the same plot object p and add colour.
p + geom_density()
p + geom_density(fill = "blue")


## QQ plots:
## geom_qq()
## For geom_qq() we need to specify the sample argument. We will look into sample
## later. For now, sample is where you specify the data for qq plot
## We need to redefine p as we need to use the argument sample.
p <- heights %>% filter(sex == "Male") %>%
  ggplot(aes(sample = height))
p + geom_qq()
## By default, the Q-Q plot is compared to the normal distribution with avg = 0
## and sd = 1. To change this, we need to use the dparams argument. For that, we 
## we create a separate object.
params <- heights %>%
  filter(sex == "Male") %>%
  summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params)
## We can then add identity lines to see how well the normal approximation works.
## And in this case, we simply add the layer geom_abline(), which adds an 
## identity line. And we see that the points fall roughly on the line.
## This is because this data is approximately normal.
p + geom_qq(dparams = params) +
  geom_abline()
## Another option here is to first scale the data so that we have them in
## standard units and plot it against the standard normal distribution.
## This saves us the step of having to compute the mean and standard deviation.
heights %>%
  ggplot(aes(sample = scale(height))) +
  geom_qq() +
  geom_abline()


## Grid Plots:
## One way to do that is to use the gridExtra package, which has a function
## called grid.arrange that lets us show different plot objects next to each other.
## To do that, what we do is we first define plots and we assign them to objects.
## We save them into objects.
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")
## So in this case, we're creating three different histograms.
## And we're saving them to the objects p1, p2, p3. Then to show them next to 
## each other we use the grid.arrange().
## install.packages("gridExtra")
library(gridExtra)
grid.arrange(p1, p2, p3, ncol = 3)
