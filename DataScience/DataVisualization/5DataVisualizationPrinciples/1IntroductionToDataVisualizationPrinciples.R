## We have already seen some rules to follow as we created plots for our examples.
## Here we aim to look into general principles we can use as guidelines for 
## effective data visualization. Much of this part of the course is based on a 
## talk by Karl Broman entitled "Creating Effective Figures and Tables" and from 
## class notes from Peter Aldhous titled "Introduction to Data Visualization."

## The principles are mostly based on research related to how humans detect 
## patterns and make visual comparisons. The preferred approaches are those that 
## best fit the way our brain processes visual information.

## When deciding on a visualization approach it is also important to keep our goal 
## in mind. We may be comparing a viewable number of quantities, describing 
## distributions for categories or numeric values, comparing the data from two 
## groups, or describing the relationship between two variables.

## As a final note, we also note that for a data scientist it is important to 
## adapt and optimize graphs to the audience. For example, an exploratory plot 
## made for ourselves will be different than a chart intended to communicate a 
## finding to a general audience.


## Encoding Data Using Visual Cues:
## Visual cues for encoding data include position, length, angle, area, 
## brightness and color hue.
## Position and length are the preferred way to display quantities, followed by
## angles, which are preferred over area. Brightness and color are even harder to
## quantify but can sometimes be useful.
## Pie charts represent visual cues as both angles and area, while donut charts
## use only area. Humans are not good at visually quantifying angles and are 
## even worse at quantifying area. Therefore pie and donut charts should be 
## avoided - use a bar plot instead. If you must make a pie chart, include 
## percentages as labels.
## Bar plots represent visual cues as position and length. Humans are good at 
## visually quantifying linear measures, making bar plots a strong alternative 
## to pie or donut charts.


## Know When to Include Zero:
## When using bar plots, always start at 0. It is deceptive not to start at 0 
## because bar plots imply length is proportional to the quantity displayed. 
## Cutting off the y-axis can make differences look bigger than they actually are.
## When using position rather than length, it is not necessary to include 0
## (scatterplot, dot plot, boxplot).


## Do Not Distort Quantities:
## Make sure your visualizations encode the correct quantities.
## For example, if you are using a plot that relies on circle area, make sure 
## the area (rather than the radius) is proportional to the quantity.


## Order by a Meaningful Value:
## It is easiest to visually extract information from a plot when categories are 
## ordered by a meaningful value. The exact value on which to order will depend
## on your data and the message you wish to convey with your plot.
## The default ordering for categories is alphabetical if the categories are 
## strings or by factor level if factors. However, we rarely want alphabetical 
## order.