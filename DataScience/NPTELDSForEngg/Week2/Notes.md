# __Data Science for Engineers__

## __Week 2__

### __2.1 Linear Algebra__

Linear Algebra is useful for the following:

+ Data representation - Data in data science is usually represented in a matrix form.
+ Fundamental block in ML algorithms
+ Identifying linear relations between the variables in the data

What is a __matrix__?

+ Matrix is a form of organizing data into rows and columns.
+ Matrix can be used to represent samples with multiple attributes in a compact form.
+ Matrices can also be used to represent linear equations in a compact manner.
+ Linear Algebra tools can be used to manipulate the matrices and derive useful information from it.
+ Generally samples are are represented in rows and columns represent the values of the variables (or the attributes). The other way can also be followed.

R code for creating a matrix:

```r
# X and Y are column vectors pertaining to some attributes
# Matrix A is defined as a column bind of X and Y
x = c(1,2,3)
y = c(4,5,6)
A = cbind(x,y)
```

Now that we can represent data in a matrix, few questions pop up:

+ Are all the attributes in the data independent? If not, what are the important ones?
+ What is the relation between the attributes?
+ How can we reduce the size of the data matrix?

Identify the idependent attributes:

+ The first step is to _identify the idependent attributes_. In some situations, the domain knowledge might help us identify the idependent and dependen attributes and thus the relationship in the data matrix. But the real question we are intrested in asking is if the data itself can help us to identify the relationship in the data matrix.
+ Let us assume that we have many more samples than attributes for now. _Rank of the matrix_ is a concept that can be used to identify the number of linear relationships between the attributes purely using data.
+ Rank of a matrix refers to the number of linerly independent rows or columns of the matrix (which equals the number of independent variables). It can be found using the command `Rank(A)`

```r
A = matrix(c(1,2,3,2,4,6,1,0,0), ncol=3, byrow=F)
library(pracma)
Rank(A)
# returns '2'
# Since col2 = 2*col1, only col1 and col3 are independent.
# Thus rank of the matrix is 2
```

Advantages and summary of rank of the matrix:

+ Allows us to work with a reduced set of variables once the independent variables are identified.
+ The dependent attributes can be calculated from the independent variables if the data is being generated from the same data generation process.
+ If we identify that there are certain variables which are dependent on other variables and as long as the data generation process is the same, it does not matter how many samples are generated, we can always find the dependent variables as a function of the independent variables.

Now, let us assume that the number of independent variables are less than the number of variables. Then, that automatically means that there are linear relationships between these variables.

So, now the next important question 'How to identify these linear relationships among variables or attributes?'. This is answered by the concepts of null space and nullity.

Null Space:

+ The null space of a matrix A consists of all vectors β such that Aβ = 0 and β != 0. Nullity is the number of vectors in the null space of the given matrix.
+ The size of the null space of the matrix provides us with the number of relationships that are among the variables. For example, if A is of size 5x5 and its null nullity is 2, then it means there are 2 relationships among the variables --> meaning there are 3 independent and 2 dependent variables.
+ Notice that if Aβ = 0, every row of A when multiplied by β becomes 0. So, this implies that the variable values in each sample behave the same. So, we have truly identified a linear relationship between these variables.
+ Now, every null space vector corresponds to one such relationship and if we have more vectors in the null space then there are more relationships to be uncovered.

Rank Nullity theorem:

(Nullity of A) +  (Rank of A) = (Total number of attributes of A)

```r
A = matrix(c(1,3,5,2,4,6), ncol=2, byrow=F)
cols = ncol(A)
library(pracma)
rank = Rank(A)
nullity = ncol - rank
print(cols) # prints 2
print(rank) # prints 2
print(nullity) # prints 0
```
