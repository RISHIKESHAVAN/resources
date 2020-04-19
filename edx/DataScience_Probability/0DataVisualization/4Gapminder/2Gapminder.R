## The gapminder dataset can be loaded as follows:
library(tidyverse)
library(dslabs)
data(gapminder)
head(gapminder)

## Differences in child mortality across different countries.
## Compare the following
## Sri Lanka and Turkey
## South Korea and Poland
## Malaysia and Russia
## Pakistan and Vietnam
## Thailand and South Africa

## For each of the pairs of countries here, which country do you think had the 
## highest child mortality in 2015? And also, which pairs do you think are 
## most similar?
## When answering these questions without data, the non-European countries are 
## typically picked as having higher mortality rates, Sri Lanka over Turkey,
## South Korea over Poland, and Malaysia over Russia. It is also common to assume 
## that countries considered to be part of the developing world, Pakistan, Vietnam, 
## Thailand, and South Africa, have similarly high mortality rates.

## However, when we answer the questions with data,
gapminder %>% filter(year == 2015 & country %in% c("Sri Lanka", "Turkey")) %>%
  select(country, infant_mortality)
## This  shows that Turkey has a higher mortality rate over Sri Lanka. 
## South Korea has a lower mortality rate than Poland, Malaysia has a lower 
## mortality rate than Russia, and Pakistan is very different from Vietnam,
## and South Africa is very different from Thailand. From here, we see that 
## these comparisons, the European countries have higher rates.
## We also see that the countries from the developing world can have very 
## different rates. It turns out that most people do worse than if they were 
## just guessing, which implies that we're more than ignorant, we're misinformed.


## Life Expectancy and Fertility Rates:
## Worldview: The world is divided into two groups, the Western World, composed
## of Western Europe and North America, which is characterized by long lifespans 
## and small families versus the developing world, Africa, Asia, and Latin 
## America, characterized by short lifespans and large families.

## The data for this comparison is available in the gapmider dataset.
## The first plot we make is a scatterplot of life expectancy versus 
## fertility rates.
## Fertility rates are defined as the average number of children per woman.
## We will start by looking at data from about 50 years ago when, perhaps, 
## this worldview was cemented in our minds.
ds_theme_set()    # set plot theme
filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy)) +
  geom_point()
## Note that most points do, in fact, fall into two distinct categories, one
## with life expectancies around 70 years and three or less children per family
## and the other with life expectancies lower than 65 years and with more than 
## five children per family. Now, to confirm that indeed these countries are 
## from the regions, we add colour to the points.
filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point()
## So indeed, in 1962, the West versus developing worldview was grounded in 
## some reality, but is this still the case 50 years later?
## To answer to this question, we will use faceting.

## For comparing data, side by side plots are preferable. This is achieved by 
## faceting variables using facet_grid(). We stratify the data by some variable and make the 
## same plot for each strata. Here we are faceting by the year.
## The facet_grid() lets you facet by up to two variables using columns to 
## represent one variable and rows to represent the other and both are separated
## by a tilde.
## Facet by continent and year:
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(continent ~ year)
## So continent will be in the rows, and year will be in the columns.
## But what we need is much more simpler. We need to compare only the years
## 1962 and 2012. So we have only one variable. We use the '.' to tell 
## facet_grid() that we will be using only one variable.
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(. ~ year)
## The plot clearly shows that the majority of countries have moved from the 
## developing world cluster to the Western world one. They went from having 
## large families and short lifespans to having smaller families and longer 
## lifespans. In 2012, the Western versus developing world view no longer makes 
## sense. This is particularly clear when we compare Europe to Asia.
## Asia includes several countries that have made great improvements in the last 
## 40 to 50 years.

## To explore how this transformation happened through the years, we can make the 
## plot for several years. For example, we can add 1970, 1980, 1990, and 2000 to 
## the plot. Now, if we do this using facet_grid(), it will desplay all the plots
## on the same row. This is the default behavior of facet_grid. If we do this, 
## the plots will become too thin, and we won't be able to see the data.
## Instead, we might want to have the plots across different rows and columns.
## For this, we can use the facet_wrap(). It automatically wraps the series of 
## plots so that most displays has viewable dimensions.
years <- c(1962, 1980, 1990, 2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>%
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_wrap(.~year) ## you can use . or ommit the variable not used 
## Now, we're only showing Asia and Europe, but the function clearly shows us how
## the Asian countries have made great improvements throughout the years.

## Now, note that the default choice for the range of the axes is an important 
## one. When not using facet, this range is determined by the data shown in the 
## individual plot. When using facet, the range is determined by the data shown 
## in all plots. And therefore, it's kept fixed across the plots. This makes 
## comparisons across plots much easier.

## But once we see these plots, new questions emerge. For example, which 
## countries are improving more? Which ones are improving less? Was the 
## improvement constant during the last 50 years, or was there more of an 
## acceleration during a specific certain period?
## To answer these questions, we can use time series plots.
## Time series plots have time in the x-axis, and an outcome, or measurement
## of interest, on the y-axis.
gapminder %>%
  filter(country == "United States") %>%
  ggplot(aes(year, fertility)) +
  geom_point()
## When the points are regularly spaced and densely packed as they are here,
## we can create curves by joining points with lines.
## This conveys that these data are from a single country.
## This can be done using geom_line() instead of geom_point().
gapminder %>%
  filter(country == "United States") %>%
  ggplot(aes(year, fertility)) +
  geom_line()
## This is particularly helpful when we look at two or more countries.
## Let's subset the data to include two countries - one from Europe and one from 
## Asia. When we use the same code as above,
countries <- c("South Korea", "Germany")
gapminder %>% filter(country %in% countries) %>%
  ggplot(aes(year, fertility)) +
  geom_line()
## Rather than a line for each country, this code has produced a line that goes 
## through the points for both countries-- they're both joined.
## This is actually expected, since we have not told ggplot anything about 
## wanting two separate lines.
## To let ggplot know that there are two curves that need to be made separately,
## we assign each point to a group, one for each country.
gapminder %>% filter(country %in% countries) %>%
  ggplot(aes(year, fertility, group = country)) +
  geom_line()
## We can see the two lines, one for each country. However, we don't know which 
## line goes with which country. We can use color() to distinguish the two 
## countries. A useful side effect of using color() to assign different colors to 
## each country is that ggplot automatically groups the data by the color value.
gapminder %>% filter(country %in% countries) %>%
  ggplot(aes(year, fertility, col = country)) +
  geom_line()
## This adds a legend by default.

## However, for time series plots, it is actually recommended to label the 
## curves rather than using legends. This suggestion actually applies to most 
## plots. Labeling is usually preferred over legends. However, legends are easier
## to make and appear by default in many of ggplot's functions.
## Labels can be added as follows,
labels <- data.frame(country = countries, x = c(1975, 1965), y = c(60, 72))
gapminder %>% filter(country %in% countries) %>%
  ggplot(aes(year, life_expectancy, col = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none")
## We define a data table with the label locations (we pick these by eye). And 
## then we use a second mapping just for the labels. In the geom_text, we
## are using the labels data frame as the data, so that those labels are put in 
## those positions. Then we have to tell the plot not to add a legend through the 
## theme function.

## And we can see how the plot shows how an improvement in life expectancy
## followed the drops in fertility rates. While in 1960, Germans lived more than 
## 15 years more on average than South Koreans, by 2010 the gap is completely 
## closed. Another commonly held notion is that wealth distribution across the 
## world has become worse during the last decades. When general audiences are 
## asked if poor countries have become poorer and rich countries have become 
## richer, the majority answer yes. By using histograms, smooth densities, and 
## box plots, will be able to understand if this is in fact the case.
