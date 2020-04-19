## Slope Charts:
## In every single instance in which we have examined the relationship between 
## two variables, total murders versus population size, life expectancy vs 
## fertility rates, and child mortality versus income, we have used scatterplots.
## This is the plot we generally recommend. One exception where another type of 
## plot may be more informative is when you are comparing variables of the same 
## type but at different time points and for a relatively small number of 
## comparison. For example, comparing life expectancy between 2010 and 2015.
## In this case, we might consider a slope chart.

## There's no geometry for slope charts in ggplot2, but we can construct one 
## using geom_line. We need to do some tinkering to add labels and some other 
## changes.
library(tidyverse)
library(dslabs)
data(gapminder)
west <- c("Western Europe", "Northern Europe", "Southern Europe", 
          "Northern America", "Australia and New Zealand")
dat <- gapminder %>%
  filter(year %in% c(2010, 2015) & region %in% west & !is.na(life_expectancy) & 
           population > 10^7)
dat %>%
  mutate(location = ifelse(year == 2010, 1, 2),
         location = ifelse(year == 2015 & country %in% c("United Kingdom", 
                           "Portugal"), location + 0.22, location),
         hjust = ifelse(year == 2010, 1, 0)) %>%
  mutate(year = as.factor(year)) %>%
  ggplot(aes(year, life_expectancy, group = country)) +
  geom_line(aes(color = country), show.legend = FALSE) +
  geom_text(aes(x = location, label = country, hjust = hjust), 
            show.legend = FALSE) +
  xlab("") +
  ylab("Life Expectancy") 

## This piece of code produces the following slope chart. An advantage of the 
## slope chart is that it permits us to quickly get an idea of changes based on 
## the slope of the lines. Note, that we're using angle as a visual cue, but we 
## also have position to determine the exact values. Comparing the improvement 
## is a bit harder when we use the scatterplot. Note that in the scatterplot, we 
## have followed the principle use common axes since we are comparing values 
## before and after.
## But, when we have many points, the slope charge stops being useful because it 
## becomes too cluttered, and in this case, we would use a scatterplot.


## Bland-Altman plot:
## Since what we're interested in is in differences, it makes sense to dedicate 
## one of our axes to differences. The Bland-Altman plot, also known as the 
## Tukey Mean Different plot, and also the MA plot, shows the difference versus 
## the average. -Here's an example.
library(ggrepel)
dat %>%
  mutate(year = paste0("life_expectancy_", year)) %>%
  select(country, year, life_expectancy) %>% spread(year, life_expectancy) %>%
  mutate(average = (life_expectancy_2015 + life_expectancy_2010)/2,
         difference = life_expectancy_2015 - life_expectancy_2010) %>%
  ggplot(aes(average, difference, label = country)) +
  geom_point() +
  geom_text_repel() +
  geom_abline(lty = 2) +
  xlab("Average of 2010 and 2015") +
  ylab("Difference between 2015 and 2010")
## Here we quickly see which countries have improved the most as it's represented
## in the y-axis. We also get an idea of the overall value from the x-axis.


## Encoding a Third Variable:
## Encode a categorical third variable on a scatterplot using color hue or 
## shape. Use the shape argument to control shape.
## Encode a continuous third variable on a using color intensity or size.


## Avoid pseudo three dimensional plots:
## In general, pseudo-3D plots and gratuitous 3D plots only add confusion. 
## Use regular 2D plots instead.


## Avoid Too Many Significant Digits:
## In tables, avoid using too many significant digits. Too many digits can 
## distract from the meaning of your data.
## Reduce the number of significant digits globally by setting an option. For 
## example, options(digits = 3) will cause all future computations that session 
## to have 3 significant digits.
## Reduce the number of digits locally using round() or signif().
