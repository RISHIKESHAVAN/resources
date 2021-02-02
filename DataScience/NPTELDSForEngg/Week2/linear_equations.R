# Uncomment the below lines and instally the necessary packages
# install.packages('pracma') # necessary for Rank()
# install.packages('MASS') # necessary for pseudo inverse

# Load the necessary packages
library(pracma)
library(MASS)

# To find the solution for a set of equations where m = n
# and it is a full rank matrix
A = matrix(c(1,2,3,4), ncol = 2)
x = c('x1', 'x2')
b = c(7, 10)
A
b
# rank of the matrix A
Rank(A)
# checking if the determinant of A is non-zero
det(A)
# Therefore the inverse of A exists
# In this case there is a unique solution: x = (A^-1)b
x = solve(A)%*%b
# Note that there is only one unique solution
x

# To find the solution for a set of equations where m = n
# and it is not a full rank matrix and the equations are consistent.
A = matrix(c(1,2,2,4), ncol = 2)
x = c('x1', 'x2')
b = c(5, 10)
A
b
# rank of the matrix A
Rank(A)
# Since the rank = 1, the nullity = 1
# So there is only one linearly independent column (and row).
# Therefore in the equations, one will be a multiple of the other. Since the 
# the same linear dependence on the LHS is also maintained on the RHS also, the
# equations are consistent with only one linearly independent equation.
# The solution set for (x1, x2) is infinite because we have only one linearly
# independent equation and 2 variables.

# To find the solution for a set of equations where m = n
# and it is not a full rank matrix and the equations are inconsistent.
A = matrix(c(1,2,2,4), ncol = 2)
b = c(5, 9)
A
b
# rank of the matrix A
Rank(A)
# Since the rank = 1, the nullity = 1
# So there is only one linearly independent column (and row).
# Therefore in the equations, one will be a multiple of the other. Since 
# the same linear dependence on the LHS is not maintained on the RHS also, the
# equations are inconsistent with only one linearly independent equation.
# Therefore, generally there is no solution for this.

# To find the solution of a set of equations where m > n.
# Since m > n, not all equations can be satisfied and hence it is a
# no-solution case.
A = matrix(c(1,2,3,0,0,1), ncol = 2)
x = c('x1', 'x2')
b = matrix(c(1, -0.5, 5), ncol = 1)
A
b
# Here the first 2 equations are not consistent. The 2 equations 
# provide 2 different values for x1 and thus cannot be solved. 
# From an optimization perspective the solution is provided as,
x = inv(t(A)%*%A)%*%t(A)%*%b
x
# This solution, (x1, x2) = (0,5), does not solve all the initial equations.
# As already said, this is the best (optimized) solution in the sense of 
# collective minimization of errors and not the true solution.

# To find the solution of a set of equations where m > n.
# Since m > n, not all equations can be satisfied and hence it is a
# no-solution case.
A = matrix(c(1,2,3,0,0,1), ncol = 2)
x = c('x1', 'x2')
b = matrix(c(1, 2, 5), ncol = 1)
A
b
# Here, all the equations are satisfied for x1 = 1 and x2 = 2.
# Though m > n, the equations are in such a way that we can get a 
# single solution that satisfies all the equations.
# From an optimization perspective the solution is provided as,
x = inv(t(A)%*%A)%*%t(A)%*%b
x
# This solution, (x1, x2) = (1,2), is the same as what we got before.

# To find the solution of a set of equations where m < n.
# Since m < n, there are infinite possible solutions for the variables.
A = matrix(c(1,0,2,0,3,1), ncol = 3)
x = matrix(c('x1', 'x2', 'x3'), ncol = 1)
b = matrix(c(2,1), ncol = 1)
A
x
b
# Using the optimization concept
x = t(A)%*%inv(A%*%t(A))%*%b
x
# The solution is x1=-0.2, x2=-0.4 and x3=1. With x3=1, we could have
# found any number of values for x1 and x2. But -0.2 and -0.4 is the
# minimum norm solution (or this vector is the closest to the origin
# that satisfies the equation Ax = b). This solution satisfies the 
# original equation as well.

# To find the solution of a set of equations using the pseudo inverse.
A = matrix(c(1,0,2,0,3,1), ncol = 3)
x = matrix(c('x1', 'x2', 'x3'), ncol = 1)
b = matrix(c(2,1), ncol = 1)
A
x
b
# Using the optimization concept
x = ginv(A)%*%b
x
# This gives the same solution as the one arrived using the 
# optimization approach.
# Whatever be the sizes of the matrices A and b, we can use the 
# same ginv() to get the solution.