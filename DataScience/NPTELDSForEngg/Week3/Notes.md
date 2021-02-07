# __Data Science for Engineers__

## __Week 3 - Statistics__

### __3.1 Statistical Modelling__

__Random Phenomena and Probability__:

+ Phenomena can be classified as the follows:
  + __Deterministic phenomena__ - whose outcome can be predicted with a very high degree of confidence.
  + __Stochastic phenomena__ - which can have many possible outcomes for the same experimental conditions. Outcome can be predicted with limited confidence.
+ We are interested in stochastic phenomena because all the data we obtain from experiments contain __errors__. The sources of these errors can be:
  + Lack of knowledge of generation process __(model error)__
  + Errors in sensors used for observing outcomes __(measurement error)__
+ Types of random phenomena:
  + __Discrete__ - Outcomes are finite
  + __Continuous__ - Infinite number of outcomes

__Sample Space__ (Discrete phenomena) :

+ Set of all possible outcomes of a random experiment.
  + Coin toss: S = {H, T}
  + Two coin tosses: S = {HH, HT, TH, TT}

__Events__ (Discrete phenomena) :

+ Subset of the sample space.
  + Occurrence of a head in the first toss of a two coin toss experiment A = {HH, HT}
+ Outcomes of a sample space are elementary events.

__Probability measure__ :

+ Associated with each of the events is a probability.
+ The probability that __Events A and B both occur__ is the probability of the intersection of A and B. It is denoted by __P(A ∩ B__). Generally, __P(A ∩ B) = P(A) P(B|A)__. This is called the __Rule of Multiplication__. If Events A and B are _mutually exclusive_, P(A ∩ B) = 0.
+ The probability that __Events A or B occur__ is the probability of the union of A and B. It is denoted by __P(A ∪ B)__. Generally, __P(A ∪ B) = P(A) + P(B) - P(A ∩ B)__. This is called the __Rule of Addition__.
+ Probability measure is a function that assigns a real value to every outcome of a random phenomena which satisfies the following axioms:
  + __0 =< P(A) =< 1__ (i.e.) Probabilities are non-negative and < 1 for any event A
  + __P(S) = 1__ (i.e.) one of the outcomes should occur
  + For two mutually exclusive events A and B: __P(A U B) = P(A) + P(B)__
+ Interpretaion of probability as a frequency:
  + Conduct an experiment (coin toss) N times. If N<sub>A</sub> is the number of times outcome A occurs, then __P(A) = N<sub>A</sub>/N__

__Independent events__ :

+ Two events are said to be independent, if occurence of one has no influence on the occurence of the other.
  + Formally, we consider A and B to be __independent__ if and only if __P(A ∩ B) = P(A) x P(B)__ (i.e.) _the joint occurence of A and B_ can be obtained by multiplying their respective probabilities.
  + For example, in a two coin toss experiment, the occurrence of head in the second toss can be assumed to be independent of head or tail in the first toss, then P(HH) = P(H in first toss) x P(H in second toss) = 0.5 x 0.5 = 0.25

__Mutually exclusive events__ :

+ Two events are mutually exclusive if the occurrence of one implies the other event does not occur.
  + In a coin toss experiment, events {HH} and {HT} are mutually exclusive. If we know that 2 heads have occurred, then it is clear that the event {HT} did not occur. Therefore, P(HH and HT) = __P(HH) + P(HT)__ = 0.25 + 0.25 = 0.5

__Other rules of probability__ :

+ Some of the important probability rules can be probed using Venn diagrams.
+ A<sup>c</sup> is the complement of event A. So, __P(A<sup>c</sup>)__ = P(S) - P(A) = __1 - P(A)__
+ If __B ⊆ A__, then P(B) < P(A).
+ Probability of A __or__ B: __P(A U B) = P(A) + P(B) - P(A ∩ B)__

__Conditional Probability__ :

+ If two events A and B are not independent, then information available about the outcome of event A can influence the prediction of event B.
+ The conditional probability is denoted as __P(B|A)__ (i.e.) _the probability of event B occurring given that event A has occurred_.
  + __P(B|A) = P(A ∩ B)/P(A)__, if P(A) > 0
  + From the above rule, we can derive the __Bayes rule__: __P(A|B)P(B) = P(B|A)P(A)__
  + __P(A) = P(A|B)P(B) + P(A|B<sup>c</sup>)P(B<sup>c</sup>)__

___

### __3.2 Random Variables, PMF and PDF__

__Random Variable__ :

+ A RV is a function which maps the outcomes of a sample space to a real line. So, there is a unique real number that is associated to every outcome in the sample space.
+ Why do we need a RV? Consider the coin toss example. The Sample space is: {H, T}. Unfortunately, we will not be able to do numerical computations with such a representation. Therefore we map these outcomes to two points on a real line: H -> 0 and T -> 1. A Random Variable or function maps the outcomes to a real line. If the outcomes of a random phenomena are already numbers (like in the case of rolling a dice), then we don't need this mapping and can work with the outcomes themselves.
+ __Discrete RV__ (throw of a dice or coin); __Continuous RV__ (sensor readings, time interval between failures)

__Probability Mass/Density Functions__ :

+ A probability mass or a density function is a measure that maps the outcomes of a RV to values between 0 and 1.
+ For a _discrete RV_, the __PMF__ assigns a probability to every outcome in a sample space.
  + Sample space of RV(x) for a coin toss: [0, 1]
  + P(x = 0) = 0.5; P(x = 1) = 0.5
+ For a _continuous RV_, the __PDF__ _f(x)_ can be used to compute the probability for every outcome of the RV within an interval.
  + In the case of a continuous RV, there will be infinity of outcomes, and therefore we can associate a probability with every outcome. However, we can associate a probability that the random variable lies within some _finite interval_.
  + Consider a RV x which can take any value in the real line from [-∞, ∞], then we define the __density function f(x)__ such that the probability that the RV lies in an interval [a, b] is defined as __P(a < x < b) = ∫<sub>a</sub><sup>b</sup>f(x) dx__. _Integral => Area_ Thus, the area under the curve f(x) in the limits a and b gives the probability.
  + Also, area under the entire curve = 1 (i.e.) ∫<sub>-∞</sub><sup>∞</sup>f(x) dx = 1
+ __Cumulative Density Function__: denoted by F() and  is the probability that the random variable x lies in the interval -∞ to b for every value of b. __F(b) = P(-∞ < x < b) = ∫<sub>-∞</sub><sup>b</sup>f(x) dx__. If b = -∞, then CDF = 0 and if b = ∞, then CDF = 1. Thus, as b: -∞ -->: ∞, the CDF: 0 --> 1

__Binomial Mass Function__ :

+ Wikipedia: _The binomial distribution with parameters n and p is the discrete probability distribution of the number of successes in a sequence of n independent experiments, each asking a yes–no question, and each with its own Boolean-valued outcome: success (with probability p) or failure (with probability q = 1 − p)._
+ Consider a coin toss experiment. What is the probability of obtaining _k_ heads in _n_ coin tosses with _p_ as the probability of obtaining a head in any toss.
+ So, the RV x represents the number of heads obtained out of the n tosses. Therefore, sample space is: [0, 1,...,n]. Each of the outcomes of the sample space has some probability associated with it which is given by:

![bmf](BinomialMassFunction.gif)

+ The equation is a PMF characterized by a single parameter _p_.

![bmfgraph](BinomialMassFunctionGraph.gif)

+ For large _n_ it tends to be a _Gaussian distribution_ - bell shaped curve. For computational purposes, for large values of n we use the Gaussian distribution instead of the Binomial distribution.
