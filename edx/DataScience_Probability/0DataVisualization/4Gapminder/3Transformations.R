## Transformations can be very useful to better understand distributions.

## As an example, the Gapminder data table includes a column with the country's 
## Gross Domestic Product - GDP. GDP measures the market value of goods and services
## produced by a country in a given year. The GDP per person is often used as a 
## rough summary of how rich a country is.
## Here we divide this quantity by 365 to obtain the more interpretable measure
## dollars per day. So we're going to add this variable to our data table.
## It's the dollars per day variable.
library(tidyverse)
library(dslabs)
data(gapminder)
head(gapminder)
gapminder <- gapminder %>%
  mutate(dollars_per_day = gdp/population/365)
## Using current US dollars as a unit, a person surviving on an income of less than 
## $2 a day, for example, is defined to be living in absolute poverty. So we're 
## going to add this variable to our data table. It's the dollars per day variable.

## Note: GDP values is in our data table are adjusted for inflation and represent 
## current US dollars. So these values are meant to be comparable across the years.
## Also note that these are country averages and that within each country, there's
## much variability.

## Here's a histogram of per day incomes from 1970.
past_year <- 1970
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black")
## We see that for the majority of countries, averages are below $10 a day.
## However, the majority of the x-axis is dedicated to the 35 countries with 
## averages above 10.

## It might be more informative to quickly be able to see how many countries make 
## on average about:
## $1 a day - extremely poor, $2 a day - very poor, $4 a day - poor, 
## $8 a day - about middle, $16 a day - a well-off country, $32 a day - rich, 
## $64 a day - very rich.
## These changes are multiplicative. And so we decide to use log transformations.
## Log transformations change multiplicative changes into additive ones.
## Using base 2 for, example, means that every time a value doubles, the log 
## transformation increases by one. So to get the distribution of the log base 2
## transformed values, we simply transform the data and use the same code.
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) +
  geom_histogram(binwidth = 1, color = "black")
## In this plot, we see two clear bumps.
## In statistics, these bumps are sometimes referred to as modes. The mode of a 
## distribution is the value with the highest frequency. The mode of a normal 
## distribution is the average. But if the mode is a value with the highest 
## frequency, how can we have more than one? When a distribution like the one we 
## just saw doesn't monotonically decrease from the mode, we call the location 
## where it goes up and down again as local modes. And we say that the 
## distribution has multiple modes.
## The histogram we just saw suggests that in 1970, country income distribution
## have two modes. One at about $2 per day, one in the log2 scale, and another 
## at about $32 per day-- 5 in the log2 scale.
## This bimodality is consistent with the dichotomous world made up of countries 
## with average incomes less than $8 per day,3 on the log scale, and countries 
## above that. So we see two modes in the histogram.

## But how do we choose the base? 
## In the histogram we just saw we chose base 2. Other common choices are the 
## natural log in base 10. In general, it is not recommended to use the natural 
## log for data exploration and visualization. Why? It's because while we know 
## what 2^2,2^3,2^4,10^1,10^2 are, we can quickly compute that in our mind, it's 
## not easy to compute E^2, E^3,etc. So it is not recommended to use the natural 
## log for data exploration. In the dollar/day example, we use base 2 instead of 
## base 10 because the resulting range is easier to interpret. The range of the 
## values being plotted started from about 0.3 and ended around 50.
## In base 10, this turns to a range that includes very few integers, just 0
## and 1. With base 2, our range includes negative 2, negative 1, 0, 1, 2, 3, 4, 
## and 5. Note that it is easier to compute 2^x and 10^x when x is an integer.
## So we prefer to have more integers in the transform scale. Another consequence 
## of a limited range is that choosing the bin width is more challenging.
## With log base 2, we know that a bin width of 1 will translate to bins with 
## range x to 2^x.

## Using log transformations in plots:
## There are two ways we can use log transformation in plots. We can log the 
## values before plotting them, or we can use log scales in the axis.
## Both approaches are useful and have different strengths.
## If we log the data, we can more easily interpret intermediate values in the 
## scale. For example, if we use a scale that looks like this 
## ---1----x----2---------3----
## that has been log transformed, we know that x is 1.5. 
## If the scales are logged and we have that x in between 1 and 10,  
## ---1----x----10---------100----
## then we don't know immediately what the x is because it's 10^1.5, not an easy 
## thing to compute in our heads. However, the advantage of using log scales
## is that we see the original values on the axis. So this has an advantage 
## because we see the original values displayed in the plot which makes it very 
## easy to quickly see what numbers we're actually dealing with.
## Log scales can be achieved using scale_x_continuous(). For example, 
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2")
## when we see $32 a day, instead of 5 log base 2 dollars a day. Now let's 
## review how we make plots where the scales have been log transformed.
## Note that, we no longer transform the data before plotting it.
## The difference between this and the previous is that in the scales in the 
## x-axis, instead of seeing the log values, we see the original values in a 
## log scale - 1, 8, and 64. And we can very quickly interpret what that means 
## in terms of dollars/day.