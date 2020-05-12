## Throughout the series, we will create plots with the ggplot2 package. 
## ggplot2 is part of the tidyverse suite of packages, which you can load with:
library(tidyverse)
## Note that you can also load ggplot2 alone using the command library(ggplot2), 
## instead of loading the entire tidyverse.
## ggplot2 uses a grammar of graphics (gg) to break plots into building blocks 
## that have intuitive syntax, making it easy to create relatively complex and 
## aesthetically pleasing plots with relatively simple and readable code.
## Limitation: ggplot2 is designed to work exclusively with tidy data (rows are 
## observations and columns are variables).

## As an example, we will construct a graph that summarizes the US murders data set.
## Load the dataset
library(dslabs)
data(murders)

## The code needed to make this plot is relatively simple. And we'll learn to 
## create the plot part by part. The first step in learning ggplot2 is to be
## able to break a graph into components.

## The main three components that we have to be aware of are--
## -> 1. DATA component
##       the US murders data table that is summarized.
## -> 2. GEOMETRY component
##       the plot is a scatter plot. Other possible geometries are bar plot, 
##       histograms, smooth densities, q-q plots, and box plots.
## -> 3. MAPPINGS
##       The x-axis values are used to display population size.
##       The y-axis values are used to display the total number of murders.
##       Text is used to identify the states.
##       And colors are used to denote the four different regions.
##       This is referred to as the aesthetic mapping component.
##       How we define the mapping depends on what geometry we use.
## Other components of the plot worth mentioning
## -> 4. SCALE component.
##       The range of the x-axis and the y-axis appear to be defined by the 
##       range of the data. That they are both on log scales.
## -> 5. Labels, a title, a legend etc.
## -> 6. Theme/Style



## Creating a plot:
## The first step in creating a ggplot graph is to define a ggplot object.
## We do this with a function ggplot, which initializes the graph. If we read the 
## data file for this function, we see that the first argument is used to specify 
## what data is associated with the object. This is the data component.
## So to initiate an object, 
ggplot(data = murders)
## this associates the data set with the plotting object.
## We can also pipe the data. This is similar to above.
murders %>% ggplot() ## murders piped into ggplot
## Know that this code renders a plot.
## In this case, a blank slate since no geometry has been defined. The only style 
## we see is a gray background. What we have just done is that we have created an 
## object and because it was not assigned, it was automatically evaluated.
## This is why we saw that gray slab. But we can define an object like this,
p <- ggplot(data = murders)
## Here we're assigning the graph object to the object p. If we look at the class 
## of p, we see that it's a ggplot object.
class(p)
## To render the plot associated with this object, we simply print the object p.
p

## In ggplot, we create graphs by adding layers. 
## We add them component by component using +
## So, a line of code in ggplot will look like this,
## DATA %>% ggplot() + LAYER1 + LAYER2 ..... LAYERn

## Usually, the first layer is the geometry. Here, to create the scatter plot,
## the function used is geom_point.
## But for geom_point to know what to do, we need to provide data and a mapping.
## Since we have already connected an object with the murders data table, 
## if we add geom as a layer then it will default to using this data.
## For mappings, there are 2 required arguments - x and y. 
## This will be the x and y axes of the plot.
## The aes() connects the data with what we see on the graph. We refer to this 
## connection as the aesthetic mappings. Aesthetic mappings describe how 
## properties of the data connect with features of the graph (axis position, 
## color, size, etc.).The outcome of this function is often used as the 
## argument of a geometry function.
murders %>% ggplot() + geom_point(aes(x = population/10^6, y = total))
## Note that, aes() uses variable names from the object component 
## (for example, total rather than murders$total). Importantly, this behavior is 
## quite specific to aes.
## no error from this call
## p_test <- p + geom_text(aes(population/10^6, total, label = abb))
## error - "abb" is not a globally defined variable and cannot be found outside of aes
## p_test <- p + geom_text(aes(population/10^6, total), label = abb)

## Also, population/10^6 is the scale used for the x-axis in addition to 
## being used as its label.

## Layers can also be added on ggplot objects. Also, we can ommit mentioning
## x and y in the arguments of aes() as they are the default required values.
p <- ggplot(data = murders)
p + geom_point(aes(population/10^6, total))
## So, we have created a scatterplot.

## A second layer in the plot we wish to make involves adding a label to 
## each point. This will help us identify which point goes with which state.
## The geom_label() and geom_text() functions permit us to add text to the plot.
## Geom_label() adds a label with a little rectangle, and geom_text() simply 
## adds the text.
p + geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))
## p + geom_point(aes(population/10^6, total)) +
##   geom_label(aes(population/10^6, total, label = abb))

## geom_point() has other arguments in addition to aes and data. They tend to 
## be specific to the function. To increase the size of the points,
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb))
## We note that all the points are larger. Note the size is not a mapping.
## It affects all the points the same. It was outside of aes.
## Now that the points are bigger, they overwrite the labels and make it 
## impossible to read them. using the argument nudge_x we can move the labels 
## just a little bit.
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)

## However, note that we define the mapping twice - for each geom function.
## We can avoid this using the global aes function. This can be done by 
## specifying the mapping in the ggplot(). ggplot() has an argument called
## mapping that will take this value. If we define a mapping in ggplot, 
## then all the geometries that are added as layers will default to this mapping.
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) + geom_text(nudge_x = 1.5)

## Now, if we need to override the global mappings, we can do this.
## The local mappings override the global ones.
p + geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "Hello there!")) 
## The x and y values of geom text defines the position of the text in the plot

## To adjust the scales, labels, add some color, and add a line:
## Our desired scales are in the log scale. This is not the default, 
## so this change needs to be added through a scales layer.
## The functions used are scale_x_continuous() and scale_y_continuous()
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) +
  scale_x_continuous(trans = "log10") + scale_y_continuous(trans = "log10")
## since the log to base 10 scales are so common, R itself has specific  
## funcitons for them
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) +
  scale_x_log10() + scale_y_log10()

## To add axes labels and titles,
## xlab() - add a label to x-axis
## ylab() - add a label to y-axis
## ggtitle() - adds a title
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) +
  scale_x_log10() +   scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")

## Now, to change the colour of the points, we can use the col argument in the
## geom_point().
## First lets assign whatever we have done till now to p, so that we can work 
## on col argument and see what effect it has.
p <- p + geom_point(size = 3) + geom_text(nudge_x = 0.075) +
  scale_x_log10() +   scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")
p + geom_point(size = 3, color="blue") 
## But we want the color to be associated with the geographical region. 
## A nice default behavior of ggplot lets us do this. If we assign a categorical
## variable to the color argument, it automatically assigns a different color 
## to each category. And it also adds a legend.
## Now because the color of each point will depend on the category and the region
## from which each state is, we have to use a mapping and we map each point to a 
## color using aes
## We put the col argument inside an aes, but the size argument-- which applies 
## to all points-- goes outside.
p + geom_point(aes(col = region), size = 3)
## Note that we also moved aes to the first arguments, since this is where 
## the mappings are expected in this call.

## We want to add a line that represents the average murder rate for the 
## entire country. Note that once we determine the per million rate to be r for 
## the entire country, this line is defined by the formula y = r*x.
## Why? Because if a state has a population x and it has the same murder
## rate as the US, which is r, we simply multiply r by x to get the total number 
## of murders. Here y - the total murders and x - the population in millions.
## To compute the average rate for the entire country, we use dplyr.
## We have to add up all the totals, add up all the populations, and then take 
## the ratio of these two. We use the summarize function to do this.
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  pull(rate)
## To add the line, we use geom_abline(). ggplot uses 'ab' in the name to 
## remind us that we're supplying the intercept a the slope b. [eqn: y = bx + a]
## The default line for geom_abline() has slope 1 and intercept 0 i.e. y = x.
## So we only have to define the intercept.
p + geom_point(aes(col = region), size = 3) +
  geom_abline(intercept = log10(r)) 

## To changet the line type, colour and bring it under the points:
p <- p + geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3)

## Though the default behavior of ggplot is quite useful. But often we need to 
## make some minor tweaks to the default behavior. Although it's not always 
## obvious how to make this even after reading the documentation, keep in mind
## that ggplot is very flexible, and there's almost always a way to achieve
## what you want. For example, there's a small change we need to make for our 
## plot to match our original goal. And it's to capitalize the word 'region' 
## in the legend. To do this, we discover that the function scale_color_discrete
## lets us do this. So we can change it by simply adding this layer.
p <- p + scale_color_discrete(name = "Region") 
p

## Using add-on packages:
## ggthemes and ggrepel packages.
## The style of the ggplot graph can be changed using the theme function.
## Several themes are included as part of the ggplot2 package. In fact, 
## for most of the plots in this series, we're using a theme that we define, 
## and it's included in the dslabs package, and you can get it by typing:
library(dslabs)
ds_theme_set()
## Many other themes can be added using the package ggthemes.
## install.packages("ggthemes")
library(ggthemes)
p + theme_economist() 
## You can see how some of the other themes look by simply changing the function.
## For example,
## p + theme_fivethirtyeight() 
## Note, that in our plot some of the labels fall on top of each other making it 
## hard to read. The add-on package ggrepel includes a geometry that adds labels 
## ensuring that they don't fall on top of each other. So all we need to do is 
## change the geom_text layer with a geom_text_repel layer after loading the 
## ggrepel package. 
## install.packages("ggrepel")
library(ggrepel)

## So finally,
murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist()



## In this graph, we can clearly see how much states vary across population size
## and the total number of murders.
## Not surprisingly, we also see a clear relationship between murder totals
## and population size. A state falling on the dashed straight line has the 
## same murder rate as the US average. The four geographic regions are denoted 
## with color and they depict, among other things, that most southern states
## have murder rates above the average.