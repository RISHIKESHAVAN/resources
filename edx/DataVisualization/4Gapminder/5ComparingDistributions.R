## The exploratory data analysis we have conducted has revealed two characteristics 
## about average income distributions in 1970. Using a histogram, we found a 
## bimodal distribution with the most relating to poor and rich countries.
## Then by stratifying by region and examining box plots, we found that the rich 
## countries were mostly in Europe and Northern America, along with Australia, 
## New Zealand, and then the poor countries were mostly in the rest of the world.

## So we are going to define a vector that defines the regions in the West.
west <- c("Western Europe", "Northern Europe", "Southern Europe", "Northern America", 
          "Australia and New Zealand")
## Now we want to focus on comparing the differences in distribution across time.
## We start by confirming that the bi-modality observed in 1970 is explained by a 
## west versus developing world economy. We do this by creating a histogram for the 
## groups previously defined. Note that we create the two groups with an if-else 
## inside a mutate and then use facet grid to make histograms for each group.
library(tidyverse)
library(dslabs)
data(gapminder)
gapminder <- gapminder %>%
  mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(. ~ group)
## This shows that the countries in the West have higher incomes. The histogram is 
## shifted to the right. Countries in the developing world are shifted towards 
## the left. Now we're ready to see if the separation is worse today than it was 
## 40 years ago. We do this by now faceting by both region ie. the grooup and year
present_year <- 2010
gapminder %>%
  filter(year %in% c(past_year, present_year) & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(year ~ group)
## When we look at this figure, we can see that the developing world has shifted
## to the right more than the West. Meaning that it has gotten closer.
## The income distribution of the developing countries has gotten closer to those 
## from the west. Before we interpret the findings of this plot further, we note
## that there are more countries represented in the 2010 histograms than in the 
## 1970s ones. The total counts are larger. One reason for this is that several 
## countries were founded after 1970. For example, the Soviet Union turned into 
## several countries, including Russia and Ukraine during the '90s. Another reason
## is that data is available for more countries in 2010 compared to 1970.
## So we're going to remake the plots, but using only countries
## with data available for both years.
country_list_1 <- gapminder %>%
  filter(year == past_year & !is.na(dollars_per_day)) %>% .$country
country_list_2 <- gapminder %>%
  filter(year == present_year & !is.na(dollars_per_day)) %>% .$country
country_list <- intersect(country_list_1, country_list_2)
## So, now using only the countries present in both 1970 & 2010,
gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%    # keep only selected countries
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(year ~ group)
## We now see that while the rich countries have become a bit richer percentage 
## wise, the poorer countries appear to have improved more. The histogram has 
## shifted more to the right than for the rich countries. In particular, we see 
## that the proportion of developing countries earning more than $16/day 
## increases substantially.

## To see which specific regions improve the most, we can remake the box plots 
## that we made earlier, but now adding 2010.
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("") + scale_y_continuous(trans = "log2")
p + geom_boxplot(aes(region, dollars_per_day, fill = continent)) +
  facet_grid(year ~ .)
## We use facet_grid to divide into 2010 and 1970.
## And we can see which countries have gone up more. Now these box plots, it's a 
## little bit hard to compare, because we're trying to compare box plots that are
## on top of each other. It's helpful to put them next to each other. So we're 
## going to learn to "ease the comparisons".
## Because we want to compare each region before and after, it would be convenient
## to have the 1970 box plot next to the 2010 box plot. In general, comparisons 
## are easier when data are plotted next to each other. So instead of faceting, 
## we keep the data from each year together. But ask ggplot plot to color or fill
## the box block depending on the year. ggplot automatically separates them and 
## puts the two box plots next to each other. This is very convenient. Because 
## year is a number, we turn it into a factor so that each is a category. This is 
## because ggplot automatically assigns a color to each level of a factor if we 
## assign that factor to the color argument.
p + geom_boxplot(aes(region, dollars_per_day, fill = factor(year)))
## And we can see which countries have improved the most.For example, 
## Eastern Asia went from way down around 8 all the way up almost to 64.
## And finally we point out that if what we are most interested in is in 
## comparing before and after values, it might make more sense to plot the 
## ratios, or differences in the log scale.
## (But, we're still not ready to learn the code that achieves this)