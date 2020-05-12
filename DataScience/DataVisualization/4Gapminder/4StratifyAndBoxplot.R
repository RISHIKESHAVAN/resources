## The histogram showed us that the income distribution values show a dichotomy.
## However, the histogram does not show us if the two groups of countries are west 
## vs the developing world. To see distributions by geographical region, we first 
## stratify the data into regions, and then examine the distribution for each.

## Now, because the number of regions is large in this case, 
library(tidyverse)
library(dslabs)
data(gapminder)
length(levels(gapminder$region))

## it's 22, looking at histograms or smooth densities for each will not be useful.
##  Instead, we can stack box plots next to each other.
gapminder <- gapminder %>%
  mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(region, dollars_per_day))
p + geom_boxplot()
## Note that we can't read the region names because the default ggplot behavior is 
## to write the labels horizontally and here we run out of room. We can easily 
## fix this by rotating the labels. We can rotate the names by changing the theme 
## through element_text(). The hjust=1 argument justifies this text so that it's 
## next to the axis. And angle equals 90, rotates it.
p + geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
## We can already see that there is indeed a west versus the rest dichotomy.
## The box plots that are high, are North America, northern Europe, Australia,
## New Zealand, and Western Europe.There are a few more adjustments we can make
## to this plot to help uncover this reality to help relay this message.

## First, it helps to order the regions in some other order that is not 
## alphabetical. Ordering alphabetically is completely arbitrary. We can order by 
## something meaningful.
## The reorder() helps us achieve this. It lets us change the order of the levels
## of a factor variable based on a summary computed on a numeric vector.
## As a simple example to understand the function,
## Let's define a vector with 5 entries, Asia, Asia, west, west, west.
## If we turn this vector into factor, the levels of this factor are ordered 
## alphabetically. This is the default in r.
fac <- factor(c("Asia", "Asia", "West", "West", "West"))
levels(fac)
## But suppose that each of these elements of the original vector are associated 
## with a value arbitarily - 10, 11, 12, 6, 4. Let's suppose that we want to order
## the levels based on the mean value of these numbers. In this case, the west has
## a lower mean. It's the mean of 12, 6, 4. Compared to the mean of Asia, which is 
## the mean of 10 and 11. So if we use the function to order like this,
value <- c(10, 11, 12, 6, 4)
fac <- reorder(fac, value, FUN = mean)
levels(fac)
## We can see that the new factor that's created has levels ordered differently.
## Now west is the first one. Why? Because it has a smaller mean value of the 
## value vector.

## In our Gapminder example, we have regions. These are the different parts of a 
## continent. We also have continents. And then we have divided the world into 
## West versus the rest. So we have three different ways of dividing the data.
## The first thing we're going to do to improve our plot, is to simply reorder 
## the regions by their median income level. To achieve this, we write the same 
## code as before but we add to mutate that changes region to a new factor
## where the levels are reordered.
p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%    # reorder
  ggplot(aes(region, dollars_per_day, fill = continent)) +    # color by continent
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("")
p

## Now we can see that the box plots are ordered by their medium value. And we 
## very quickly see that there's four box plots that stand out at the end.
## The four highest ones. These are Western Europe, Australia and New Zealand, 
## northern Europe, and North America. This is what we define as the West.
## Now there's another change we made to the plot to help convey this message,
## and that's that we use color to show another variable. We use color to show 
## continent.To add color to define the different continents, we use the fill 
## argument in the aesthetic mappings of ggplot. We simply say fill=continent.
## And now each continent gets its own color.
## Now, this helps us see that, for example, the blue box plots are towards the 
## right because these are the European countries. We also see that the red 
## countries, the red box plots, are to the left. These are the countries in the 
## African continent.

## The last change we can make to this plot to help us see the data little bit 
## better, is to change the scale to the log scale. We want to change it to log2
## scale in this case, so we add the layer scale_y_continuous(), and we use the 
## log2 transformation.
p + scale_y_continuous(trans = "log2")
## And this helps us see the differences between the countries with the lower 
## income. For example, we see a difference now between the African continent, 
## which is in red, and Asia, which is in green.

## The last change we can make to this plot to make it give us even more 
## information, is to show the data. In many cases, we don't show the data, the 
## actual individual points, because it adds too much clutter to the plot and it
## obfuscates the message. But in this particular example, we don't have that 
## many points. So we can add a layer of points by simply adding the geom_point().
p + scale_y_continuous(trans = "log2") + geom_point(show.legend = FALSE)
## And now we can see the individual points which shows exactly where every single 
## country lies.
