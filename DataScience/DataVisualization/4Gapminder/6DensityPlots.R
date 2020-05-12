## We have used data exploration to discover that the income gap between rich and
## poor countries has closed considerably during the last forty years. We use a 
## series of histograms and box plots to see this. smooth density plots are a 
## succinct way to convey this message with just one plot.

## Let's start by noting that the density plot for income distribution in 1970 and 
## 2010 deliver the message that the gap is closing. In the 1970s plot, we see two 
## clear modes, poor and rich. In 2010, it appears that some of the poorer 
## countries have shifted towards the right, closing the gap. The next message we 
## need to convey is that the reason for this change in distribution is that poor 
## countries became richer rather than some rich countries becoming poorer.

## To do this, all we need to do is assign a color to the groups we identified 
## during the data exploration. However, before we can do this, we need to learn 
## how to make these smooth densities in a way that preserves information of how
## many countries are in each group. To understand why we need to do this: there  
## is a discrepancy in the size of each group. If we divide the world into 
## developing and West, we have 87 developing countries and 21 Western countries.
## If we overlay the two densities, the default is to have the area represented by 
## each distribution add up to 1 regardless of the size of each group.
## This makes it seem like there's the same number of countries in each group, 
## which is incorrect. To change this, we'll need to learn to access computed 
## variables with the geom_density().

## To have the areas of the densities be proportional to the size of the groups,
## we can simply multiply the y-axis values by the size of the group. From the 
## geom_density help file, we see that the function computes a variable called 
## count that does exactly this. We want this variable to be on the y-axis rather 
## than the density value. In gg plot, we can access these variables by 
## surrounding their names with '..'. So we will use the following mapping,
library(tidyverse)
library(dslabs)
data(gapminder)
gapminder <- gapminder %>%
  mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
present_year <- 2010
country_list_1 <- gapminder %>%
  filter(year == past_year & !is.na(dollars_per_day)) %>% .$country
country_list_2 <- gapminder %>%
  filter(year == present_year & !is.na(dollars_per_day)) %>% .$country
country_list <- intersect(country_list_1, country_list_2)
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
  scale_x_continuous(trans = "log2")
p + geom_density(alpha = 0.2) + facet_grid(year ~ .)
## Notice that now we can clearly see that the developing world has more 
## countries. If you want the densities to be smoother, because we can see in the 
## Western countries, there was a lot of unsmoothness, we can change the bw 
## argument,
p + geom_density(alpha = 0.2, bw = 0.75) + facet_grid(year ~ .)

## We can see clearly that the developing world distribution is changing. A 
## third mode appears consisting of the countries that most closed the gap. We 
## can actually make this figure somewhat more informative. From the exploratory 
## data analysis, we noticed that many of the countries that most improved were 
## from Asia. We can easily alter the plot to show key regions separately.
## To do this, we use case_when().It's useful for defining groups. It currently 
## does not have a data argument. This might change. But because it doesn't, 
## we need to access the components of our data using the dot placeholder.
gapminder <- gapminder %>%
  mutate(group = case_when(
    .$region %in% west ~ "West",
    .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    .$region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
    .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
    TRUE ~ "Others")) ## Rest are just called 'Others'
## Now we turn this group variable into a factor to control the order of the 
## levels:
gapminder <- gapminder %>%
  mutate(group = factor(group, levels = c("Others", "Latin America", "East Asia", 
                                          "Sub-Saharan Africa", "West")))
## We picked this particular order for a reason that becomes clearer later when 
## we make the plots. Now we can easily plot the density for each one. We use 
## color and size to clearly see the top.
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2")
p + geom_density(alpha = 0.2, bw = 0.75) +
  facet_grid(year ~ .)
## The plot is a little bit cluttered and is hard to read, and we're going to 
## use a stacking approach to make the picture clear.
p + geom_density(alpha = 0.2, bw = 0.75, position = "stack") +
  facet_grid(year ~ .)
## Now the density plots are stacked on top of each other. Here we can see 
## clearly that the distribution from East Asia and Latin America and others 
## shift markedly to the right while Sub-Saharan Africa remain stagnant. Note 
## that we order the levels of the groups so that the West density was plotted 
## first, and then Sub-Saharan Africa. This helps us see this pattern.

## As a final point, we note that these distributions weigh every country the 
## same. So if most of the population is improving but living in a very large 
## country such as China, we might not appreciate this. We can actually weigh 
## the smooth densities using the weight mapping argument.
gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population*2)) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group, weight = weight)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)
## This shows very clearly how the income distribution gap is closing with most 
## of the poor countries remaining in Sub-Saharan Africa.
