# __Data Science for Engineers__

## __Week 6 - Regression__

### __6.1 Predictive Modelling__

__Preliminaries__:

+ n observations of x and y variables (x<sub>i</sub>,y<sub>i</sub>)
+ Sample means are given by:

![samplemeans](SampleMeans.GIF)

+ Sample Variances are given by (sometime n-1 is also used):

![samplevariances](SampleVariances.GIF)

+ Sample Covariance is given by:

![samplecovariance](SampleCovariance.GIF)

__Correlation__:

+ Indicates the strength of association between two variables.
+ Correlation DOES NOT imply Causation.
+ Scatter plots can give a visual representation of correlation. Scatter plots are a _qualitative_ metric of correlation.
+ We can _quantify_ correlation and there are several methods depending on the type of variable and the kind of association we are looking for.

__Pearson Correlation__ :

+ The Pearson's product-moment correlation coefficient is denoted by _r<sub>x</sub><sub>y</sub>_. Sometimes the symbol 'ρ' is also used.
  
![pearsoncorrelation](PearsonCorrelation.GIF)

+ The numerator: covariance between x and y. The denominator: repeesents the standard deviation. This division by the denominator is what is called as _normalization_.
+ r<sub>xy</sub> takes a value between -1 (negative correlation) and +1 (positive correlation). r<sub>x</sub><sub>y</sub> = 0 means no correlation.
+ The Pearson's correlation is a measure for the degree of linear dependence between x and y.
+ __Cannot be applied to ordinal (ranked) variables.__
+ _Sample size_ : Moderate (20 - 30) for good estimate.
+ _Robustness_ : Outliers can lead to misleading values.
+ _Note_ : There is __no__ gaurantee that if the Pearson Coeff is high then the relation is linear; we can only say that a relation is present. However, we can say that if the relation is linear, then the PC will be high (towards -1 or +1) and if the relation is non-linear then the PC may or maynot be high. And if PC =0, we can say that there is no linear relation but there could be some other relations present. Just looking at the PC we cannot make a strong conclusion.

__Spearman Rank Correlation__ :

+ Can be used for ordinal variables.
+ Gives the degree of association between 2 variables.
+ Linear or non-linear association.
+ The SR correlation will be high if x increases and y increases or decreases monotonically.
+ The SR correlation computation for n observations is given by the following where _d<sub>i</sub>_ is the difference in the ranks given to the two variables values for each item in the data.

![spearmanrankcorrelation](SpearmanRankCorrelation.GIF)

+ Example:

![spearmanrankcorrelationexample](SpearmanRankCorrelationExample.GIF)

+ r<sub>s</sub> takes a value between -1 (negative correlation) and +1 (positive correlation). r<sub>s</sub> = 0 means no correlation.
+ r<sub>s</sub> = 1 : Monotonically increasing
+ r<sub>s</sub> = -1 : Monotonically decreasing

__Kendall Rank Correlation__ :

+ Correlation coefficient to measure the association between 2 ordinal variables.
+ _Concordant Pair_ : A pair of observations (x1,y1) and (x2,y2) that follows the property x1 > x2 and y1 > y2 or x1 < x2 and y1 < y2.
+ _Discordant Pair_ : A pair of observations (x1,y1) and (x2,y2) that follows the property x1 > x2 and y1 < y2 or x1 < x2 and y1 > y2.
+ We take every pair ofobservations in the sample and then assign whether there is a concordant or discordant pair
+ The Kendall Rank Correlation Coefficient is given by:

![kendallrankcorrelation](KendallRankCorrelation.GIF)

+ The pair for which x1=x2 and y1=y2 are ignored.
+ If the value is either near +1 or -1 then there is some relation.

---

### __6.2 Linear Regression__

__Regression__ :

+ Purpose is to build a functional relationship (model) between _dependent variable(s)_ and _independent variable(s)_.
+ One of the most widely used statistical techniques.
+ Dependent variables also known as _Response variable_, _Regressand_, _Predicted variable_, _output variable_ - denoted as variable/s _y_.
+ Independent variables also known as _Predictor variable_, _Regressor_, _Exploratory variable_, _input variable_ - denoted as variable/s _x_.

__Regression Types__ :

+ __Univariate__ vs __Multivariate__
  + _Univariate_ : One dependent and one independent variable
  + _Multivariate_ : Multiple dependent and multiple independent variables
+ __Linear__ vs __Nonlinear__
  + _Linear_ : Relationship is linear between dependent and independent variable
  + _Nonlinear_ : Relationship is nonlinear between dependent and independent variable
+ __Simple__ vs __Multiple__
  + _Simple_ : One dependent and one independent variable (SISO)
  + _Multiple_ : One dependent and multiple independent variable (MISO)

__Questions to be asked before Regression Analysis__ :

+ Is there a relationship between these variables?
+ Is the relationship linear and how strong is the relationship?
+ How accurately can we estimate the relationship?
+ How good is the model for prediction purposes?

__Regression Methods__ :

+ Linear Regression Methods
  + Simple Linear Regression
  + Multiple Linear Regression
  + Ridge Regression
  + Principal Component Regression
  + Lasso Regression
  + Prtial Least Squares Regression
+ Nonlinear Regression Methods
  + Polynomial Regression
  + Spline Regression
  + Neural Networks

__The Regression Process__ :

The regression process in itself is not a once through process. It is iterative.

![regressionprocess](RegressionProcess.GIF)

__Ordinary Least Squares__ :

+ Linear model between y<sub>i</sub> and x<sub>i</sub>, i = 1,...,n is given by:

    __y<sub>i</sub> = β<sub>0</sub> + β<sub>1</sub>x<sub>i</sub> + ϵ<sub>i</sub>__

+ In OLS we assume that the error is in only the dependent variable and there is no error in independent variable. Thus if you have 2 variables, then you choose the variable with the lease error as the independent variable. If on the other hand you believe both x and y contain significant error, then perhaps you should consider other methods called Total Least Squares or Principal Component Regression

    __ϵ<sub>i</sub> = y<sub>i</sub> - β<sub>0</sub> - β<sub>1</sub>x<sub>i</sub>__

+ The sum of squares of errors (SSE):

    __Σϵ<sub>i</sub><sup>2</sup> = Σ(y<sub>i</sub> - β<sub>0</sub> - β<sub>1</sub>x<sub>i</sub>)<sup>2</sup>__

+ The minimization of SSE by optimization gives β<sub>0</sub> and β<sub>1</sub>. The hat symbol denotes that it is an estimate.

![minimizedbetas](MinimizedBetas.GIF)

__Testing the Goodness of the Fit__ :

![testingthefit](TestingFit.GIF)

---

### __6.3 Model Assessment__

Whether the model that we have fitted is reasonbly good or not.

+ How good is the linear model?
+ What are the significant coefficients of the linear model (identify the important variables)?
+ Can we improve the quality of the linear model?
  + Are assumptions made about the errors reasonable?
  + Are there bad measurements in the data?

__Properties of Estimates__ :

+ Both the estimates of β<sub>0</sub> and β<sub>1</sub> are unbiased. (The estimates of a particular parameter are denoted by a hat `^` symbol)

  ![estimateprop1](EstimateProp1.GIF)

+ Variance of the estimates:

  ![estimateprop2](EstimateProp2.GIF)

+ Estimate of σ:

  ![estimateprop3](EstimateProp3.GIF)

+ Distribution of slop estimate:

  ![estimateprop4](EstimateProp4.GIF)

