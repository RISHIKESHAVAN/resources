## Show the Data:
## A dynamite plot - a bar graph of group averages with error bars denoting standard
## errors - provides almost no information about a distribution.
## By showing the data, you provide viewers extra information about distributions.
## Jitter is adding a small random shift to each point in order to minimize the 
## number of overlapping points. To add jitter, use the  geom_jitter() geometry 
## instead of geom_point(). (See example below.)
## Alpha blending is making points somewhat transparent, helping visualize the 
## density of overlapping points. Add an alpha argument to the geometry.

library(tidyverse)
library(dslabs)
data("heights")
## dot plot showing the data
heights %>% ggplot(aes(sex, height)) + geom_point()
## jittered, alpha blended point plot
heights %>% ggplot(aes(sex, height)) + geom_jitter(width = 0.1, alpha = 0.2)


## Ease Comparisons: Use Common Axes
## Ease comparisons by keeping axes the same when comparing data across multiple 
## plots.
## Align plots vertically to see horizontal changes. Align plots horizontally 
## to see vertical changes.
## Bar plots are useful for showing one number but not useful for showing 
## distributions.


## Consider Transformations:
## Use transformations when warranted to ease visual interpretation.
## The log transformation is useful for data with multiplicative changes. The 
## logistic transformation is useful for fold changes in odds. The square root 
## transformation is useful for count data.


## Ease Comparisons: Compared Visual Cues Should Be Adjacent
## When two groups are to be compared, it is optimal to place them adjacent 
## in the plot.
## Use color to encode groups to be compared.
## Consider using a color blind friendly palette like the one below.
color_blind_friendly_cols <- c("#999999", "#E69F00", "#56B4E9", "#009E73", 
                               "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
p1 <- data.frame(x = 1:8, y = 1:8, col = as.character(1:8)) %>%
  ggplot(aes(x, y, color = col)) +
  geom_point(size = 5)
p1 + scale_color_manual(values = color_blind_friendly_cols)
