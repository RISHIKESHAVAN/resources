## A distribution is a function or description that shows the possible values 
## of a variable and how often those values occur. (or)
## The most basic statistical summary of a list of objects or numbers
## is its distribution.

## The distribution of categorical data simply describes the 
## proportions for each category.
## A frequency table is the simplest way to show a categorical distribution. 
## Use prop.table() to convert a table of counts to a frequency table. 
## For example, the sex represented in the heights data set can be summarized 
## by the proportions of each of the two categories, female and male.
library(dslabs)
data(heights)
prop.table(table(heights$sex))
## When there are more categories in a categorical data, then a 
## simple bar plot describes the distribution.

## However, for numerical data, when data is not categorical,
## reporting the frequency of each unique entry is not an effective summary 
## since most entries are unique.

## A more useful way to define a distribution for numerical data is to define 
## a function that reports the proportion of the data below a value A,
## for all possible values of A. This function is called a 
## cumulative distribution function or CDF. F(a) = Pr(x<=a)
## Like the frequency table does for categorical data, the CDF defines the 
## distribution for numerical data.

## The proportion of observations between any two values a and b can be 
## computed from the CDF as F(b)-F(a).
## Any continuous dataset has a CDF, not only normal distributions.
## For datasets that are not normal, the CDF can be calculated manually by 
## defining a function to compute the probability above. 
## This function can then be applied to a range of values across the range 
## of the dataset to calculate a CDF. Given a dataset my_data, 
## the CDF can be calculated and plotted like this:
a <- seq(min(my_data), max(my_data), length = 100)    # define range of values spanning the dataset
cdf_function <- function(x) {    # computes prob. for a single value
  mean(my_data <= x)
}
cdf_values <- sapply(a, cdf_function)
plot(a, cdf_values)

## Note that the CDF can help compute probabilities. The probability of 
## observing a randomly chosen value between a and b is equal to the 
## proportion of values between a and b, which we compute with the CDF F(b)-F(a).

## Final note, because CDFs can be determined mathematically, as opposed to 
## using data as we do here, the word empirical is added to distinguish, 
## and we use the term empirical CDF or ECDF.
## Although CDFs are widely discussed, they are not very popular in practice.
## This is because they do not convey many characteristics of interest. 
## This brings the Histograms into the picture.

## Histograms sacrifice just a bit of information to produce plots 
## that are much easier to interpret.
## The information we lose is that, within the same bin the differences in values
## are neglected.