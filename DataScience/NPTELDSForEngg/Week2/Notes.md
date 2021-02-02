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
+ Let us assume that we have many more samples than attributes for now. __Rank of the matrix__ is a concept that can be used to identify the number of linear relationships between the attributes purely using data.
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

__Null Space__:

+ The null space of a matrix A consists of all vectors β such that Aβ = 0 and β != 0. __Nullity__ is the number of vectors in the null space of the given matrix.
+ The size of the null space of the matrix provides us with the number of relationships that are among the variables. For example, if A is of size 5x5 and its null nullity is 2, then it means there are 2 relationships among the variables --> meaning there are 3 independent and 2 dependent variables.
+ Notice that if Aβ = 0, every row of A when multiplied by β becomes 0. So, this implies that the variable values in each sample behave the same. So, we have truly identified a linear relationship between these variables.
+ Now, every null space vector corresponds to one such relationship and if we have more vectors in the null space then there are more relationships to be uncovered.

__Rank Nullity theorem__:

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

### __2.2 Solving Linear Equations__

In general when we have a set of linear equations, we write them in the matrix form of __Ax = B__, where A(m x n), x(n x 1) and B(m x 1) and m -> number of equations and n -> number of variables.

| Scenario | Output |
| --- | --- |
| m = n | Number of equations and variables are the same. <br> Easiest case to solve. |
| m > n | More equations than variables. <br> Usually no solution. |
| m < n | Number of equations less than number of variables. <br> Usually multiple solutions. |

__Full row and column rank__ :

| Full row rank | Full column rank |
| --- | --- |
| When all the rows of the matrix are linearly independent. | When all the columns of the matrix are linearly independent. |
| Data sampling does not present a linear relationship (i.e.) the samples are independent of each other | Attributes are linearly independent |

For a data matrix A (m x n), the highest possible rank can only be the lowest of m or n. That is,

+ If m < n, the highest possible rank can only be m
+ If n < m, the highest possible rank can only be n

Also, always row rank = column rank. What it basically means is, whatever be the size of the matrix , if you have a certain number of independent rows, you will have only those many numbers of independent columns.

__Case 1: m = n__ :

For the case where m = n, the rank of the matrix can be one of the following:

+ A is __full rank__ (ie. m = n and rank = m or n) and |A| != 0. When A is full rank, then it means that all the equations on the LHS are independent of each other.
  + In this case there is a __unique solution__: x = (A<sup>-1</sup>)b.
+ A is __not full rank__. In this case, depending on the values on the RHS there could be 2 outputs.
  + __Consistent - infinite solutions__. A set of equations is said to be consisten if, whenever the LHS becomes linearly dependent, the same linear dependence is maintained on the RHS as well. And when the equations become consistent, the number of variables present become more than the number of available equations. In this case, there are infinite number of possible solutions for the variables. (similar to m < n scenario)
  + __Inconsistent - no soution__. When the same linear dependence on the LHS is not maintained on the RHS, then no matter what values we substitute for the variables, we will not be able to satisfy the equations.

__Case 2: m > n__ :

+ Since the number of equations is greater than the number of variables or attributes, in general, not all equations can be satisfied.
+ Hence it is sometimes termed as a no-solution case.
+ However, we can identify an appropriate solution from an optimization perspective.
  + Instead of identifying a solution to satisfy Ax - b = 0, we can identify an x such that (Ax - b) is minimized.
  + Notice that (Ax - b) is a vector and if we take each term in that vector, we can think each of those terms as an error. For example, if the equations had a perfect solution, the equations of Ax - b = 0 can be written as: a1x1 - b1 = 0; a2x2 - b2 = 0; a3x3 - b3 = 0. But since we don't have a perfect solution, the Ax - b can be equated to an error: a1x1 - b1 = e1; a2x2 - b2 = e2; a3x3 - b3 = e3
  + Therefore, there are as many error terms as there are equations.
  + Now the objective is to minimize the error. One could minimize all the errors collectively by minimizing the sum of squares of the errors (i.e.) Ʃe<sub>i</sub><sup>2</sup>. This is same a minimizing (Ax - b)<sup>T</sup>(Ax - b).
  + Therefore this optimization problem is: _min[(Ax - b)<sup>T</sup>(Ax - b)]_. After some algebraic manipulations this can be written as: _min[(x<sup>T</sup>A<sup>T</sup>Ax - 2b<sup>T</sup>Ax + b<sup>T</sup>b) = f(x)]_.
  + We observe that the optimization problem is a function of x and solving the optimization problem will result in a solution of x.
  + The solution is obtained by differentiating f(x) with respect to x and setting the differential to 0 (i.e.) d(f(x))/d(x) = 0.
  + Differentiating f(x) with respect to x and setting the differential to 0 results in: (A<sup>T</sup>A)x = A<sup>T</sup>b.
  + Assuming that all the columns are linearly independent: __x = (A<sup>T</sup>A)<sup>-1</sup>A<sup>T</sup>b__
+ However, sometimes when m>n, the equations may be in such a way that we can find a solution for them (this happens when the equations are first consistent (i.e.) they dont provide different values for a single variable). Even in this case the solution can be found using x = (A<sup>T</sup>A)<sup>-1</sup>A<sup>T</sup>b. But the important thing to remember is that, (A<sup>T</sup>A) exists if the columns of A are linearly independent.

__Case 2: m < n__ :

+ Since, the number of attributes is greater than the number of equations, we can obtain multiple solutions for the attributes. This is the infinite-solution case.
+ So, how to choose one solution from the infinite possible ones? Based on just the solvability of the equations, there is no way to distinguish the infinite possibilities and choose one from them. So, we have to bring in another metric that would help us to choose one solution.
+ Similar to the previous case, we try the optimization approach. So, we are going to minimize: __min((1/2)\*x<sup>T</sup>x) s.t. Ax = b__. Here, __s.t.__ -> "subject to". This means, minimize ((1/2)\*x<sup>T</sup>x) subject to the constraint that Ax = b (i.e.) whatever solution we get for x, it has to necessarily satisfy the equation Ax = b. There will be infinite number of values that satisfy Ax = b. So, the objective is to pick the one solution that minimizes the component ((1/2)\*x<sup>T</sup>x). The rationale for choosing x<sup>T</sup>x is that, of all the solutions I want the solution that is closest to the origin (minimum norm solution).
+ This kind of optimization problems can be solved by following a Lagrangian approach. Defining a Lagrangian function: __min[f(x, λ) = ((1/2)\*x<sup>T</sup>x) + (λ<sup>T</sup>(Ax - b))]__.
+ Differentiating the Lagrangian wrt x: __x + A<sup>T</sup>λ = 0__. Whatever solution we get for this should also satisfy the equation we get from differentiating the Lagrangian wrt λ, which is nothing but __Ax - b = 0__.
+ From x + A<sup>T</sup>λ = 0, __x = -A<sup>T</sup>λ__. Here, both x and λ are unknowns. Now, we know that whatever solution we get has to satisfy Ax - b = 0. Thus, substituting Ax = b in the equation, we finally get: __x = A<sup>T</sup>(AA<sup>T</sup>)<sup>-1</sup>b__.

_The approach followed in Case 2 and 3 can be applied for the non-full rank scenarios (consisten and inconsistent) of Case 1._

__Generalization__:

+ We have seen 3 cases wrt m & n. Is there any form in which the results obtained from all the 3 cases can be generalized?
+ The concept used to generalize the solutions is called the __Moore-Penrose Pseudo-Inverse of a Matrix__. The pseudo inverse is used as follows: if we have a set of equations in the form Ax = b, the solution is given by __x = A<sup>+</sup>b__. A<sup>+</sup> is the symbol _we_ use to denote pseudo inverse of A.
+ __Singular Value Decomposition__ is one of the many techniques that can be used to calculate the pseudo inverse or generalized inverse
+ The pseudo inverse is calculated using the `ginv()` function from the `MASS` library in R. Whatever be the sizes of the matrices A and b, we can use the same `ginv()` to get the solution. But what is important is the interpretation of the solution. Whether it is the case of m < n or m > n, just using `ginv()` will give the solution. But the interpretation is that, in case of m > n, the solution is the one that minimizes the error (least squares) and in case of m < n, the solution is the one that is closest to the origin (minimum norm solution).
