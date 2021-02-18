# __Data Science for Engineers__

## __Week 5 - Optimization (Contd.)__

### __4.1 Multivariate Optimaization with Equality Constraints__

> Unconstrained minimum is not the same as constrained minimum.

When you have an objective function that you need to minimze and is subject to a constraint, then the solution that you arrive should basically satisfy both the objective function and the constraint equation.

At optimum (one equality constraint case): __-∇f(x*) = λ*∇h(x*)__

_Here, when we find some solution so satisfy the equation and the constraint, then we would have the constraint equation as __h(x1,x2,....,xn) = 0__. Thus, we need to consider this as well as one of the equations to solve for the variables. Then we would have n+1 equations to find the n+1 variables (x1,x2,....,xn and λ)._

At higher dimensions and when there are more than one equality constraint: __-∇f(x\*) = Σ<sup>l</sup><sub>i=1</sub>[∇h<sub>i</sub>(x*)]λ<sub>i</sub>\*__ (i.e.) for 2 variables it would be -∇f(x\*) =  λ<sub>1</sub>\*∇h<sub>1</sub>(x\*) + λ<sub>2</sub>\*∇h<sub>2</sub>(x\*) and so on.

Gradient lies in the space spanned by the normal of the gradients.

---

### __4.2 Multivariate Optimaization with In-Equality Constraints__

> Why do we need inequality constraint problems? They primarily come into picture when we have to categorize the points on either side of the line. Any point > 0 will be on one side of the line and any point < 0  will be on the other side with the line being 0.

In the equality constraint, we had every point on the constraint line being the feasible solution and we chose the line that is closest to the optimum minimum.

But in the case of the inequality constraint, consider the line to divide the plane into two halfspaces. Now, depending on the constraint equation (lets say ax1 + bx2 =< c) it would represent one side of the line, (i.e.) either of the 2 halfspaces and the line itself. Importantly, if the unconstrained minimum also lies in this halfspace, then basically the unconstrained minimum and the constrained minimum are the same.

_Note that in the equality constraint, the unconstrained minimum and the constrained minimum were different. But in the inequality constraint, they will be the same in any one of the halfspaces._

Now for the other constraint, ax1 + bx2 >= c, this will represent the other halfspace. (If we assume that the previous constraint resulted in the unconstrained minimum and the constrained minimum being equal) then for this constraint the minimum would possibly be on the constraint line (same as equality constraint).

__General Formulation__ :

A general Multivariate Optimization problem would contain both equality and inequatlity constraints as follows:

![generalformulation](MulVarOptGeneralFormulation.GIF)

> The equality constraints can always be represented in this way. Even if there is a constat on the RHS, it can be brought to the LHS leaving just 0 on the RHS. The inequality constraint as well can always be written as a <= condition. Even if there was a > condition, multiplying both the LHS and RHS with -1 would reverse the conditon.

+ Necessary conditions for x* to be the minimizer: __KKT condtions has to be satisfied__

![kktconditions](KKTConditions.GIF)

+ Sufficient condition: __∇<sup>2</sup>L(x*) has to be a positive definite__

> In general it is difficult to use the KKT conditions to solve for optimum of an inequality constrained problem (than for a problem with equality constraints only) because we do not know in prior which constraints are active at the optimum (i.e.) in the complementary slackness condtion we don't know whether the mu is 0 or the g(x) is 0. This makes it an __combinatorial problem__. KKT conditions are generally used to verify that a point we have reached is a candidate optimal solution. Given a point, it is easy to check which constraints are binding.

_The μs have to be positive_.
