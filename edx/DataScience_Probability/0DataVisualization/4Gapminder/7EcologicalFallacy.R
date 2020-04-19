## Throughout this section, we have been comparing regions of the world.
## We have seen that on average some regions do better than others in health 
## outcomes and economic outcomes. 
## Now we wil focus on the importance of describing  the variability within the 
## groups. While we do this, we'll also look into some other ggplot functions as 
## well as a transformation called the logit transformation.

## As an example for this, we will focus on the relationship between country child
## survival rates and average income. We start by comparing these quantities across 
## regions. Before we start, we're going to find a few more regions using the 
## case_when(). We're going to define the West, Northern Africa, East Asia, 
## Southern Asia, Latin America, Sub-Saharan Africa, and the Pacific Islands.
library(tidyverse)
library(dslabs)
data(gapminder)

gapminder <- gapminder %>%
  mutate(group = case_when(
    .$region %in% west ~ "The West",
    .$region %in% "Northern Africa" ~ "Northern Africa",
    .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    .$region == "Southern Asia" ~ "Southern Asia",
    .$region %in% c("Central America", "South America", "Caribbean") ~ "Latin America",
    .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
    .$region %in% c("Melanesia", "Micronesia", "Polynesia") ~ "Pacific Islands"))
## Once we do this, we can compute the quantities that we're interested in for 
## each region. We'll compute the average.
surv_income <- gapminder %>%
  filter(year %in% present_year & !is.na(gdp) & !is.na(infant_mortality) & !is.na(group)) %>%
  group_by(group) %>%
  summarize(income = sum(gdp)/sum(population)/365,
            infant_survival_rate = 1 - sum(infant_mortality/1000*population)/sum(population))
surv_income %>% arrange(income)
## This shows a dramatic difference. While in the West less than 0.5% of children
## die, in Sub-Saharan Africa, the rate is higher than 6%. In fact, the 
## relationship between these two variables is almost perfectly linear.


## Logit transformation:
## The logistic or logit transformation for a proportional rate p is defined as 
## follows: f(p)=log(p/1-p)
## When p -> proportion or probability, the quantity that is being logged,
## p/1-p, is called the odds.
## And the case p is the proportion of children that survive.
## The odds tells us how many more children are expected to survive than to die.
## The log transformation makes this quantity symmetric. If the rates are the 
## same, then the log odds is 0. Fold increases or decreases turn into positive 
## and negative increments respectively. This scale is useful when we want to 
## highlight differences that are near 0 or near 1.
## For survival rates, this is important because a survival rate of 90% is 
## unacceptable while the survival rate of 99% is relatively good. We would much 
## prefer a survival rate closer to 99.9%. We want our scale to highlight these 
## differences and the logit does this.
## Note that 99.9/0.1 >(10 times)> 99/1 >(10 times)>90/10.
## By using the log, these fold changes turn into constant increases.
## In this plot, we also use the limit argument. The limit argument lets us 
## change the range of the axis.
surv_income %>% ggplot(aes(income, infant_survival_rate, label = group, color = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.25, 150)) +
  scale_y_continuous(trans = "logit", limit = c(0.875, .9981),
                     breaks = c(.85, .90, .95, .99, .995, .998)) +
  geom_label(size = 3, show.legend = FALSE) 
## We are making the range larger than the data needs because we will later 
## compare this plot we just saw to one with more variability. And we want the 
## ranges to be the same.
## Based on this plot, do we conclude that a country with a low income is 
## destined to have low survival rate? Do we conclude that all survival rates 
## in Sub-Saharan Africa are all lower than in southern Asia, which in turn
## are lower than in the Pacific Islands and so on?
## Jumping to this conclusion based on the plot, the plot that shows 
## only the averages is referred to as the ecological fallacy.
## The almost perfect relationship between survival rates and income is only 
## observed for the averages at the regional level. Once we show the data, we see
## a somewhat more complicated story.
## And when we see the plot for every individual country, we can see that there is
## a large amount of variability. We can see that the countries from the same  
## regions can be quite different. And that countries within the same income can 
## have different survival rates. For example, while on average Sub-Saharan Africa
## had the worst health and economic outcomes, there is wide variability within 
## that group. For example, we can also see that Mauritius and Botswana are doing
## much better than Angola and Sierra Leone with Mauritius comparable to Western
## countries.
