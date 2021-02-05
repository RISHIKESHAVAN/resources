# __Data Science for Engineers__

## __Week 2 - Linear Algebra__

### __2.1 Linear Equations__

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

---

### __2.2 Distance,Hyperplanes and Halfspaces,Eigenvalues,Eigenvectors__

+ Till now we were viewing X = [x1 x2] as a set of variables for which we were trying to calcualte the possible solutions. But this x can also take up __geometric views__.
+ X = [x1 x2] can be viewed as a point in the 2D space with axes X1 and X2 and x1 and x2 being the distances along the respective axes. 3 x values would make it a point in the 3D space and so on.
+ X can also be viewed as a vector between the origin and the data point. The __length__ (__magnitude__) of this vector is given by: __|X| = sqrt(x1<sup>2</sup>+x2<sup>2</sup>)__
+ Geometric concepts are easier to visualize in 2D or 3D and difficult to do so in higher dimensions. However, the fundamental mathematics remains the same irrespective of the dimensions of the vector.
+ In the scenario of 2 points in the 2D space: X1 = [x1<sup>1</sup> x2<sup>1</sup>], X2 = [x1<sup>2</sup> x2<sup>2</sup>]. The distance between these two can be calculated as: __l = |X2-X1|<sub>2</sub>__. This becomes l = sqrt((x1<sup>2</sup> - x1<sup>1</sup>)<sup>2</sup> + (x2<sup>2</sup> - x2<sup>1</sup>)<sup>2</sup>) = sqrt((X2 - X1)<sup>T</sup>(X2 - X1)).

__Unit vectors__:

+ It is a vector with magnitude 1 (distance from the origin). __a^ = A/|A|__
+ Unit vectors are used to definde directions in the coordinate system.
+ Any vector can be written as a product of a unit vector and a scalar magnitude

__Orthogonal Vectors__:

+ Two vectors are said to be orthogonal if their __dot product__ (scalar product) is 0.
+ The dot product of two vectors A and B is given by: __A.B = Ʃ<sup>n</sup><sub>i=1</sub>a<sub>i</sub>b<sub>i</sub>__. This can also be written as __A<sup>T</sup>B__.

__Orthonormal Vectors__:

+ Orthonormal vectors are orthogonal vectors with unit magnitude.
+ So what we can do is, we can take orthogonal vectors and get the unit vectors for them using A/|A|. The unit vectors of orthogonal vectors will still be orthogonal because all we are doing is just divide the vector with a scalar constant. These unit vectors are orthonormal vectors.
+ All orthonormal vectors are orthogonal.

__Basis Vectors__ :

+ Basis vectors are set of vectors that are __independent__ and __span the space__.
+ Consider a 2D space R<sup>2</sup> (the superset 2 here means that each vector in the this space has 2 components and thus '2D'). There would be infinite number of vectors in it. If there is any set of vectors such that, all the vectors in the 2D space can be shown as a linear combination of those set of vectors, then those set of vectors form a basis for all the vectors in the 2D space. Those set of vectors are called the __basis vectors__. Most importantly, all the basis vectors must be independent. This is because we want each of the basis vectors to provide unique information. So, we dont want any of them to be dependent on any of the other basis vectors.
+ Basis vectors are __not__ unique. We can find many many sets of basis vectors all of which share the same property.
+ We __cannot__ have 2 basis sets with different number of vectors in them (i.e.) while we could have many sets of basis vectors,all of them being equivalent, the number of vectors in each set will be the same.
+ It is __not__ necessary that the basis set must have the same number of vectors in them as the number of components in space vectors (i.e.) the vectors in the _2D sub-space_ of R<sup>4</sup> could  have a basis set with only 2 vectors (of size 4). However, if we take every vector in R<sup>4</sup>, then we would need 4 basis vectors to explain all of them.
+ This can also be interpreted as: "Since a collection of vectors in the R<sup>4</sup> space can be explained using just 2 basis vectors (instead of 4), it means that the collection of vectors fall on a '2D' sub-space of the R<sup>4</sup> space". This is an important concept of sub-space from a data science perspective.

__Finding basis vectors__:

+ For the collection of vectors in a space, the number of basis vectors is given by the rank of the matrix formed by arranging all the vectors as columns. This is because, the rank gives the number of linearly independent columns (vectors in this case) and all the other columns (vectors) can be explained as a linear combination of these columns (vectors).
+ Once we have the number of independent vectors, choosing them is easy. We can pick any of the {rank number of} linearly independent vectors from the matrix above as the basis vectors.

__Representation of line and plane__:

+ Single equation (ax1 + bx2 + c = 0) in 2D space represents a line. 2 equations in 2 variables represent a point if the equations are solvable together. If you have no relationships between these variables, then we would say that we are representing all the points in the 2-D space and there is no relationship that constraints these points to either lie on a line or be a single point and so on.
+ Now rewriting the equation ax1 + bx2 + c = 0 in a form that is generally used: __n<sup>T</sup>X + b = 0__. n is the column vector [a b], X is a vector of variables [x1 x2]

![lineimg](lineandplane1.png)

+ In the image, the n vector is shown orthogonal to the line. Why?
+ The points X1 and X2 are on the line. So substituting them in the general form we get, _n<sup>T</sup>X1 + b = 0_ and _n<sup>T</sup>X2 + b = 0_. Subtracting both, _n<sup>T</sup>(X2 - X1) = 0_.
+ Here, by vector addition, (X2 - X1) is in the direction of the line joining the 2 points on the image. From orthogonality we saw that if a<sup>T</sup>b = 0, then a and b are orthogonal. Thus, n is orthogonal to (X2 - X1).
+ Now, extending to 3D space, single equation (n<sup>T</sup>X + b = 0) in 3D space represents a plane. Similar to n representing a line in the 2D space, in 3D it would represent a vector. 2 equations in a 3D space represent a line and 3 equations represent a point as long as the 3 equations are consistent and solvable.

__Projections__ (Mathematical approach):

+ v1 and v2 (v pronounced as nu) are the basis vectors of the plane.

![projecitonsimg](projections1.png)

+ The vector X is coming out of the plane. So, from the data science viewpoint if you want to make an analogy as "I have a data here X which is represented by this vector. I want to write this simply as only a function of v1 and v2". But we can't do it exactly since it is projecting out of the plane.
+ So the next best thing is to project the vector on to the plane. But since there are many vectors on the plane, we need to find the best possible projection. This would be the point on the plane such that the distance between the point and the tip of the vector X is minimized. This would be the line that is _perpendicular_ to the plane and touching the tip of the vector X and is shown as 'n' in the image and the projected vector is shown as X^.
+ We can define the projection (X^) of a vector (X) on to a lower dimension (2D in the picture) mathematically as: __X^ = c1v1 + c1v2__ (v -> nu) (This is from the concept of basis vectors. Since v1 and v2 are the basis vectors, X^ can given as the linear combination of those vectors). Here, c1 and c2 are unknown.
+ By vector addition, X = X^ + n. Therefore, __X = c1v1 + c1v2 + n__. Here, the fact that we are using the porjection X^ comes from n being perpendicular to the plane. Since, n is perpendicular to the plane, n<sup>T</sup>v1 = v1<sup>T</sup>n = 0; n<sup>T</sup>v2 = v2<sup>T</sup>n = 0.
+ We solve v1<sup>T</sup>n = 0 and X = c1v1 + c1v2 + n by subsituting values from one eqn to the other. We have 2 scenarios while solving them:
  + If the projections are onto __general orthogonal directions__ (2 in this case), then v1<sup>T</sup>v2 = 0. Then we will get __c1 = v1<sup>T</sup>X/v1<sup>T</sup>v1__. Using the same idea and solving for v2<sup>T</sup>n = 0 would result in __c2 = v2<sup>T</sup>X/v2<sup>T</sup>v2__. We can subsitute these values of c1 and c2 onto the equation X^ = c1v1 + c1v2 and find the value of the projection (Importantly, first check if the v1 and v2 are orthogonal. Only then this formula can be applied.). This can be extended to 3, 4,... orthogonal directions.
  + The second scenario is to project them in certain number of directions that are not orthogonal. We will try to generalise them so that it can be used in many places. Consider the problem of projecting X (as X^) onto a space spanned by k linearly independent vectors (non orthogonal). Because this X^ is in a space spanned by the k linearly independent vectors, we can write X^ as a linear combination of these k vectors: X^ = Ʃ<sup>k</sup><sub>j=1</sub>cjvj. This can also be written as X^ = [v1....vk][c1....ck]<sup>T</sup> = Vc, where V = [v1....vk] and c = [c1....ck]<sup>T</sup>. V is of dimension (nxk) and c is of dimension (kx1). Therefore X^ will be of dimension (nx1). Using the orthogonality idea, n is perpendicular to the space spanned by the k linearly independent vectors (i.e.) V<sup>T</sup>n = V<sup>T</sup>(X - X^) = V<sup>T</sup>(X - Vc) = 0 (Here, V is the matrix of all the basis vectors - v). Solving this finally gives, __X^ = V(V<sup>T</sup>V)<sup>-1</sup>V<sup>T</sup>X__. [_Whenever we take inverses, we have to always make sure that the inverse first exists. Here, the v vectors are already taken to be linearly independent and thus the columns of (V<sup>T</sup>V) will be linearly independent. This ensures that the inverse of (V<sup>T</sup>V) exists_]. This is the formula for projections in general directions.  

__Hyperplane__:

+ Hyperplane is a geometric entity whose dimensions is one less than that of its ambient space. Example: hyperplanes for a 3D space are 2D planes and hyperplanes for a 2D space are 1D lines and so on.
+ The hyperplane is usually described by an equation as: __X<sup>T</sup>n + b = 0__ (i.e.) in 2D space the equation of the hyperplane will be as x1n1 + x2n2 + b = 0 and this represents a line.
+ Hyperplanes in general are not subspaces; however, if we have hyperplanes of the form __X<sup>T</sup>n = 0__; (i.e.) if the plane goes through the origin, then an hyperplane also becomes a subspace.

__Halfspaces__:

![halfspace2d](halfspace1.png)

+ We have a 2D space in the image. As discussed before, an equation in a 2D space would be a line - which would be a hyperplane. The equation of the line is given by X<sup>T</sup>n + b = 0 and in this space it can be written as x1n1 + x2n2 + b = 0.
+ In reality, the line extends on the both the ends. And when it does that, it splits the whole 2D space into two spaces, one on eithere side of the line. These 2 spaces are called the __halfspaces__.
+ Now we are interested to know if there is some characteristic that separates the points on one halfspace from the points on the other halfspace. This is an important question in solving _classification problems_.
+ In a specific classification problem called the _binary classisfication problem_, we draw a line to between the two classes to segregate them into two halfspaces. We would like if there is some characteristic that holds to one particular side of the line so that we could use that characteristic as a discriminant function for doing this binary classification problem. This is the data science perspective to the halfspaces.

![halfspace2d](halfspace2.png)

+ Now, we would like to know the position of any particular point (i.e.) whether the point is on the line or on any one of the halfspace.
+ (After a couple of algebraic manipulations and proofs) it can be shown that:
  + X<sup>T</sup>n + b = 0 ∀ X ∈ line (X1)
  + X<sup>T</sup>n + b > 0 ∀ X ∈ subspace in the direction of the vector 'n' (X3)
  + X<sup>T</sup>n + b < 0 ∀ X ∈ subspace in the direction of the vector '-n' (X2)
+ To explain this with an example: Consider a 2D space with n = [1 3] _(it is a column vector)_ and b = 4.
  + The solution: So, X = [x1 x2] _(it is a column vector)_. And the equation as we have seen already is: X<sup>T</sup>n + b = 0. Substituting X, n and b we get: _x1 + 3x2 + 4 = 0_. Now consider a point (-1,-1). Putting them in the equation, we get 0. Thus this point lies _on the line_. Consider another point (1,-1). Substituting them in the equation gives 2 which is > 0. Thus, this point lies in the _positive halfspace_ and similarly the point (1,-2) lies on the _negative halfspace_.

__Eigen values and Eigen vectors__:

+ We have previously seen linear equations of the form: __Ax = b__ (Here, A is of size (nxn) and is of size (nx1)). This can be interpreted as: "When vector _x_ is operated on by _A_, we obtain a new vector _b_ with a different orientation.
+ Now we we ask the following question: Are there directions (x) for a matrix A such that when the matrix operates on these directions, they maintain their orientation save for multiplication by a scalar(+ve or -ve) (i.e.) __Ax = λx__ - here we can see that the vector _x_ remains the same on both the sides and it is only multiplied by a scalar(λ). The constant λ (positive) represents the amount of stretch (if λ>1) or shrinkage (if λ<1) the atributes of _x_ go through in the _x_ direction. If λ is negative then the vector will be in the exact opposite direction without changing the orientation.
+ The solutions x are called the __eigenvectors__ and their corresponding λ are called the __eigenvalues__.
+ So now the question is, does every matrix have eigenvectors? If yes, how do we compute them and the eigenvalues? We can find the eigenvalues as follows: Ax = λx. This can be written as Ax - λIx = 0. Therefore, (A - λI)x = 0.
+ Thus the eigenvalues of the equation can be identified using: __|A = λI| = 0__. Once the eigenvalues are identified, subsituting them in the original equation - Ax = λx - will help us identify the solutions for eigenvectors x.
+ The R code for finding the eigenvalues is as follows:

```r
A = matrix(c(8,7,2,3),2,2,byrow=TRUE)
ev = eigen(A)
values = ev$values
values
# gives the output as [10 1].
# These are the two eigenvalues.

# The eigen vectors are then subsituted in the equation Ax = λx
# one by one and the corresponding eigenvectors are found.
```

__Important note__: _Irrespective of the values in the matrix, the solution for an eigen problem could either be real or complex depending on the polynomial you end up with._

---

### __2.3 Connections between eigenvectors, column space and null space__

+ We know that eigenvalues can be complex even for real matrices. When eigenvalues become complex, eigenvectors also become complex. Also, when some of eigenvalues are repeated, the eigenvectors corresponding to those eigenvalues may either by independent or not. So, finding n linearly independent eigenvectors is not always guaranteed for any general matrix
+ However, if the __matrix is symmetric__ (i.e. A = A<sup>T</sup>), then the __eigenvalues are always real__. As a result, the __eigenvectors are always real__. Further, there will always be __n linearly independent eigenvectors__ for symmetric matrices irrespective of the number of times the eigenvalues are repeated.
+ Symmetric matrices of type AA<sup>T</sup> or A<sup>T</sup>A are often encountered in data science. Eigenvalues of matrices of the form __AA<sup>T</sup> or A<sup>T</sup>A__ while being __real are also non-negative__.

What is the connection between eigenvectors and the column space and the null space of a (symmetric) matrix?

The following result is true whether the matrix is symmetric or not:

+ From the eigenvalue equation we know that Av = λv. Now,what happens if the eigenvalues become zero (i.e.) Av = 0? Here, v (nu) is the eigenvector corresponding to the eigenvalue 0. Comparing Av = 0 with the null space equation Aβ = 0, we can say that: __The eigenvectors corresponding to the zero eigenvalues are in the null space of the matrix__. Conversely, if the eigevalue corresponding to the eigenvector is not zero, then the eigenvector cannot be in the null space. Thus, if none of the eigenvalues are zero, then it means that the matrix is full rank and I can never solve Av = 0 and get non-trivial solution.

The following result is true for symmetric matrices:

+ Consider a symmetric matrix A(nxn) with n real eigenvalues. Lets assume that r of these eigencalues are 0. Therefore, there are n-r non-zero eigenvalues.
+ From what we say earlier, we know that the eigenvectors corresponding to the r eigenvalues are in the null space. This means that the dimension of the null space is r.
+ So, from rank-nullity theorem, the rank of A is = n-r. This basically means that there are (n-r) independent vectors in the columns of the matrix.
+ Now, we could ask what could be a basis set for this column space? Or what could be the (n-r) independent vectors that we can use as the columns subspace?
+ It is possible to prove that: The (n-r) eigenvectors are a linear combination of the columns of A. We also know that the dimension of the column space is n-r. This implies that the eigenvectors corresponding to the non-zero eigenvalues form a basis for the column space.

---
