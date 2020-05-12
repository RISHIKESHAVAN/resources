## Summarizing data is an important part of exploratory data analysis.
library(tidyverse)
library(dslabs)
data(heights)
## The summarize() from the dplyr/tidyverse package computes summary statistics
## from the data frame. It returns a data frame whose column names are 
## defined within the function call.
s <- heights %>%
  filter(sex == "Male") %>%
  summarize(average = mean(height), standard_deviation = sd(height))
s
## class(s) returns "data.frame"
## Like most dplyr functions, summarize() is aware of variable names 
## within data frames and can use them directly.

## Because the resulting table stored in s is a data frame, we can access the 
## components with the accessor dollar sign, which in this case will be numeric.
s$average
s$standard_deviation

## summarize() can compute any summary function that operates on vectors and 
## returns a single value, but it cannot operate on functions that return 
## multiple values. For example, to compute the min, median and max:
heights %>%
  filter(sex == "Male") %>%
  summarize(median = median(height),
            minimum = min(height),
            maximum = max(height))
## However, the quantile() also returns the same values
quantile(heights$height, c(0, 0.5, 1))
## but, we cannot use this inside the summarize(). This will throw an error as 
## it returns multiple values.
heights %>%
  filter(sex == "Male") %>%
  summarize(range = quantile(height, c(0, 0.5, 1)))
## error: summarize can only take functions that return a single value



## Using the dot placeholder:
## We can make the summarize() return a vector instead of data.
## Working on the murders dataset, we can add a murder_rate column like this:
data(murders)
murders <- murders %>% mutate(murder_rate = total/population*100000)
summarize(murders, mean(murder_rate))
murders
## Note that the US murder rate is not the average of the state murder rates.
## If you do that, you get 2.78. This is not the US murder rate, which is 
## closer to 3. This is because in this computation we're counting the 
## small states just the same as the large states, and when we compute the 
## average US murder rate, it needs to take into account bigger states more 
## than smaller states. The US murder rate is proportional to the total US murders
## divided by the total US population. So the correct computation is as follows.
us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population) * 100000)
us_murder_rate
class(us_murder_rate)
## Now, suppose we want to use a function that requires just a numeric value,
## we can't use the US murder rate object because it's a data frame.
## Most of the dplyr functions, including summarize, always return data frames.
## So this might be problematic with functions that requires a numeric value.
us_murder_rate %>% .$rate
class(us_murder_rate)
## In one line,
us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population * 100000)) %>%
  .$rate



## Group the summarize:
## A very common operation is to first split the data into groups and then
## summarize. Grouping can be done using the group_by(). It converts a 
## data frame to a grouped data frame, creating groups using one or more 
## variables. Example:
heights %>% group_by(sex) 
## This returns a very different result. Although not immediately obvious 
## from its appearance, this is now a special data frame called a
## "group data frame".
## And dplyr functions, in particular summarize, will behave differently when 
## acting on this object. For example,
heights %>%
  group_by(sex) %>%
  summarize(average = mean(height), standard_deviation = sd(height))
## This returns a different result. It gives the mean and sd for men and women 
## separately.
## For another example, let's compute the median murder rate in the four 
## regions of the country.
murders <- murders %>%
  mutate(murder_rate = total/population * 100000)
murders %>%
  group_by(region) %>%
  summarize(median_rate = median(murder_rate))



## Sorting data tables:
## The arrange() function from dplyr sorts a data frame by a given column.
## Just mention the column name by which you want to sort the data.
## By default, arrange() sorts in ascending order (lowest to highest).
murders %>% arrange(population) %>% head()
## This gives the first states with lease population.
murders %>% arrange(murder_rate) %>% head()
## sorted with murder_rate instead of population.
## To instead sort in descending order, use the desc() inside of arrange().
murders %>% arrange(desc(murder_rate)) %>% head()
## Nested sorting is also possible. Let's say we're ordering by a column, 
## and there's ties. We can break the ties with the second column, or a third 
## or a fourth.
murders %>% arrange(region, murder_rate) %>% head()
## This first sorts the data on basis of region. In case of any ties, we break
## the tie with murder_rate.

## Top_n function:
## The head() lists the first 6 rows. But to increase the number of data 
## displayed, we can use the top_n()
murders %>% top_n(10, murder_rate)
## This shows the  top 10 states with the highest murder rates. However,
## the results are not ordered. To order it, we use the arrange()
murders %>% arrange(desc(murder_rate)) %>% top_n(10)