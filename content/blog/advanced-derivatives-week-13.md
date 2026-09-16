+++
title = "Multi-Name Credit Risk"
date = 2025-04-24
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Copulas","Dependence Modelling","Multi-Name Credit Risk"]
+++

## Copulas

This is going to be a basic introduction, this is a complex topic to cover comprehensively.

## Limitations of Multi-Name Latent Variables

First of all, let’s start with some considerations with respect to the previous model we discussed, some of its limitations.



The Multi-Name latent variable model is single factor. There is one variable which is seen by the other credits. They each have their own idiosyncratic component. In terms of properties, simulations, that’s it. We looked at conditional hazard rate and calculation of the portfolio of loss. Last assignment is related to this particular topic.



We can model the correlation, we can simulate, we can calibrate, the time-dependent threshold, based on the hazard rate and survival probabilities.



How can we extend this model?



There’s **limitations on the one-factor correlation structure**.



In one-factor, we have a number of correlation parameters N\_c. Recall that the correlation between two credits i and j is beta\_ij. We have the constraint that the absolute value of each correlation parameter is less than or equal to 1\.



The entire correlation matrix has \\(\\frac{N_c(N_c-1)}{2}\\) correlation parameters, which is a lot.



The question we can ask: Does one factor structure prevent the modeling of groups, or **sectors**? The model may be insufficient.



We can look at some examples. Consider a simple portfolio of 4 credits grouped in two sectors. How can we represent such groups? We could take beta\_1 \= beta\_2 \= beta\_a. These two stocks will have the same exposure to the market variable z, and vice versa for the other sector beta\_3 \= beta\_4 \= beta\_b.



In a single factor model, the correlation is the product of two correlation parameters for two credits.



$$
C = \\begin{bmatrix} 1 & \\beta_a^2 & \\beta_a \\beta_b & \\beta_a \\beta_b \\ \\beta_a^2 & 1 & \\beta_a \\beta_b & \\beta_a \\beta_b \\ \\beta_a \\beta_b & \\beta_a \\beta_b 1 & \\beta_b^2 \\ \\beta_a \\beta_b & \\beta_a \\beta_b & \\beta_b^2 & 1 \\end{bmatrix}
$$

If you split this into four square matrices, then you’ll see the sub-correlation matrix for each group. The correlation between the two groups.



Let’s assume that beta\_a \> beta\_b \> 0\. One is more exposed to the market than the other. This also implies that

$$
c = \\beta_a^2 \\geq \\beta_a \\beta_b \\geq \\beta_b^2
$$



So if you take a numerical example, SEE NOTES PAGE 3



Intersector correlation is much higher, however. We don’t want that. 40% \> 25% is a big problem.

Sector B is not fully captured.



So we can try to extend the model, make it more complex, and accommodate this particular scenario.



In this case, we can consider a **two-factor** version of the model.



For some credit i, we have

$$
A_i = \\beta_{1i} Z_1 + \\beta_{2i} Z_2 + \\sqrt{1 - \\beta_{1i}^2 - \\beta_{2i}^2} \\epsilon_i
$$

$$
A_j = \\beta_{1j} Z_1 + \\beta_{2j} Z_2 + \\sqrt{1 - \\beta_{1j}^2 - \\beta_{2j}^2} \\epsilon_j
$$



Similar to the previous formulation, but with one more factor.

The linear combination of standard normal is standard normal, so that doesn’t change.



The latent variable A\_j corresponds still to the time-dependent threshold for each credit.



We can calculate the correlation between these assets in a similar kind of matrix. For each element:

$$
c_{ij} = \\beta_{1i}\\beta_{1j} + \\beta_{2i}\\beta_{2j}
$$



We can revisit the matrix in the following case.

In sector A, the credits have a first factor weight and second factor weight beta\_1a and beta\_2a.

Sector B is similar with beta\_1b and beta\_2b

This is more generic, you would say this group has correlation to these factors.



We’ll assume the first credits are from sector A.

That would be the correlation between credit a in sector a and b in sector b

$$
c = \\begin{bmatrix} 1 & \\beta_{1a}^2 + \\beta_{2a}^2 & \\beta_{1a} \\beta_{1b} + \\beta_{2a}\\beta_{2b} & \\beta_{1a} \\beta_{1b} + \\beta_{2a}\\beta_{2b} \\ \\beta_{1a}^2 + \\beta_{2a}^2 & 1 & \\beta_{1a} \\beta_{1b} + \\beta_{2a}\\beta_{2b} & \\beta_{1a} \\beta_{1b} + \\beta_{2a}\\beta_{2b} \\end{bmatrix}
$$



(Bottom half is same as top half, mirrored)



Example on notes page 6



The credits in two groups will have different correlations on the second factor.



In general, M-factors are needed to model M-sector portfolio. Three sectors? Three factors.



The simulation is very simple, but instead of generating just a Z\_1, we generate Z\_1 and Z\_2. It becomes a little more complex, with the number of parameters, compared to a single factor. We go from n(n-1)/2, to a lot more. If you want to implement these, you need to calibrate the exposure to the parameters. So the complexity becomes prohibitive, and that’s a limitation.



It has some applicability, but in general, the more typical way is through copula functions.



## Copulas (Finally)

You can model default time dependencies, correlations for default times. We also will have measures of dependency. We will look at main copulas for credit modeling, and Monte Carlo pricing of correlated products with copulas.

We’ll look at some properties, and dependency limits, and some relations between copulas and the model we just discussed. And other ways of modeling dependence than correlation. If we have time, we’ll have some code to visualize copulas.



Next week, I have a section for estimation of parameters of copulas, more complex. But for the final exam, copulas will not be included.

The latent variable model can also be expressed as a Gaussian copula, so they are related.



**Definition: An N-dimensional copula function C is a multivariate cumulative distribution function with N uniform marginals with probabilities u\_1, u\_2, … u\_N.**



This is just the multivariate cdf. One of the characteristics is that it has uniform marginals. So we can say that thIS IS THE JOINT PROBABILITY

$$
\\mathbb{P}(\\hat{U_1} \\leq u_1, \\hat{U_2} \\leq u_2 \\ldots \\hat{U_N} \\leq u_N) = C(u_1, u_2 \\ldots u_N)
$$

This is the definition of such copulas where

$$
\\hat{U_i} \\sim \\text{ Uniform}(0, 1)
$$

## Dependent Structure of Default Times of N Credits

The idea here is to express this in terms of copulas.

Consider random variable u\_i at time t\_i

$$
u_i(t_i) = 1 - Q_i(t_i)
$$

This is the probability of credit i defaulting before t\_i.



Remember, this u\_1 is a probability which can take values.



So the copula function is the same

$$
C(u_1(t_1), u_2(t_2), \\ldots u_N(t_N)) = \\mathbb{P}(\\tau_i \\leq t_i, \\tau_2 \\leq t_2, \\ldots \\tau_N \\leq t_N)
$$

where tau is the time of default.



In this copula, it’s expressed in terms of the default probabilities. So this is the “default copula”.



We have this default copula, so we can also talk about the survival copula.



There are some properties of copulas.

* Because cdf increases always, we know that if any name’s default probability increases, then the total joint probability of default will increase.
* We can get the marginal distribution of u\_k if u\_i \= 1 for all i \!= k. In order to get the marginal of any of these names, you can take \\(C(1, 1, 1, \\ldots u_k, 1, \\ldots 1) = u_k\\)
* When is the copula equal to 0? If any of them have zero probability of default, riskless like Treasury bonds, then the copula will be 0\.
* The dimensionality of the copula can be reduced from N to N \- 1 dimensions by setting any u\_i \= 1\. This is **very important** because it’s still a copula if N \> 2\. N \= 2 is useful for examples. Most textbooks describe properties in 2 dimensions. But then it’s easy to extend into N dimensions, because you can set these u\_is to 1 and collapse it.



## Dependency Limits

Latent variable model has **dependence limits**. We kind of look to see when we have positive and negative dependence of names in the portfolio. This is not equal to the correlations, but we can think a little bit in that way.



When we have an expression for a copula, (the joint probability distribution), it’s good to look at these properties to see the maximum and minimum dependence, and then how to measure them, based on differences dependency metrics.





## Independence

The simplest is independence.

The expression for such an independence copula is

$$
C(u_1, u_2, \\ldots u_N) = u_1 u_2 \\ldots u_N = \\prod_{i=1}^N u_i
$$

If they’re independent, the joint probability distribution is the product of the marginals.

## Perfect Positive Dependence

## Perfect Negative Dependence

We can then state the **Fréchet-Hoeffding Theorem:**

For any copula \\(C: [0, 1]^N \\rightarrow [0, 1]\\)

and any realization of \\((u_1, \\ldots u_N) \\in [0, 1]^N\\), the following bounds hold:

$$
w(u_1, u_2 \\ldots u_N) \\leq C(u_1, u_2 \\dots u_N) \\leq M(u_1, \\ldots u_N)
$$

Basically this theorem says if you have a copula with a particular realization, this copula is bounded above and below by two functions M and w.

w the lower Fréchet-Hoeffding bound is

$$
w(u_1, \\ldots u_N) = (1 - N + \\sum_{i=1}^N u_i)_+
$$

and upper bound is

$$
M(u_1, \\ldots u_N) = \\min(u_1, \\ldots u_N)
$$

In the bivariate case where we only have two variables u and v, we have

$$
\\max(u + v - 1, 0) \\leq C(u, v) \\leq \\min(u, v)
$$

Upper bound is perfect positive, lower bound is perfect negative.



This result holds for **any copula**.

Ideally we would like to estimate this copula with some data. We need to make a choice for this expression, and estimate those parameters.

But the question is, this is a representation of the original joint probability distribution, but is this a unique representation? Can we have different copulas for this?



We have one more theorem, **Sklar’s Theorem**.

We know by definition, the copula is a multivariate distribution function.

Any such function can be written as a copula, and its representation is unique,  the marginal distributions are continuous. If you have discrete distributions, then uniqueness is not guaranteed.



Let’s consider more generally, any N-dimensional distribution function H with marginal distributions F\_1, F\_2, F\_N for random variables x\_1, x\_2, … x\_N. H is the joint probability distribution.

Because this is multi-dimensional, this will correspond to

$$
H(x_1, x_2, \\ldots x_N) = \\mathbb{P}(X_1 \\leq x_1, X_2 \\leq x_2 \\ldots, X_N \\leq x_N)
$$

We can write this as the probability that the marginal function F\_1

$$
= \\mathbb{P}(F_1(X_1) \\leq F_1(x_1), F_2(X_2) \\leq F_2(x_2), \\ldots F_N(X_N) \\leq F_N(x_N))
$$



We basically want to transform this to get a copula function, to get here from a generic N-dimensional function.



Let \\(\\hat{U_i} = F_i(X_i)\\) and the realization \\(u_i = F_i(x_i)\\) The marginal will take values between 0 and 1, it’s a cdf.

The original function

$$
H(x_1, x_2 \\ldots x_N) = \\mathbb{P}(\\hat{U_1} \\leq u_1, \\ldots \\hat{U_N} \\leq u_N)
$$

$$
H(x_1, x_2 \\ldots x_N) = C(F_1(x_1), F_2(x_2) \\ldots F_N(x_n))
$$

We know that C is a unique copula if these Fs are continuous.

And in reverse,

$$
C(u_1, u_2 \\ldots u_N) = H(F_1^{-1}(u_1), F^{-1}_2 (u_2), \\ldots F^{-1}_N (u_N))
$$

The relationship between these two is that the copula is going to separate the choice of the marginals from the choice of the dependency structures. It decouples these things. We can take any function and its copula representation, and calibrate it to the names of the portfolio independent of the dependency structure based on the way I want to assign dependency to this portfolio.

We might want to add some dynamics to this dependencies, the difference between credit default so we can calculate the conditional survival/default probability. We could impose this by choosing a different dependency structure.

## Alternative to Dependence Structure of Default Times

We discussed about the default copula.

We have 1 \- the default probabilities, which is the survival copula

$$
\\hat{C}(1 - u_1(t_1), 1 - u_2(t_2), \\ldots, 1 - u_N(t_N)) = \\mathbb{P}(\\tau_1 > t_1, \\tau_2 > t_2 \\ldots \\tau_N > t_N)
$$

Typically survival copula has this little hat 🙂

We will look at the bivariate case, but in general we have a relationship between the survival and default copula.

$$
\\hat{C}(u, v) = u + v - 1 + C(1 - u, 1 - v)
$$



These are some kind of definitions.



We’ll make a short connection with the previous model. The latent variable model is a Gaussian copula model. If you consider this model, how would we express this?
[The displayed equation following this prompt was not recoverable from the exported note.]

That’s the probability that the time dependent threshold of credit i is smaller than the time dependent threshold

We have a bivariate normal distribution: \\(\\Phi_{2, \\rho}\\)

So how do you write this in terms of default?

See page 18 of Notes

 It has the same representation of bivariate normal. This is a Gaussian copula with marginals \\(F_i(x_i) = \\Phi(x_i)\\)

Therefore the Gaussian bi-variate CDF is notated by

$$
C_\\rho^{GC} = \\Phi_2[\\Phi^{-1}(u_1), \\Phi^{-1}(u_2)]
$$

And then we end up with an analytical expression.

The survival copula is the same, just with 1 \- u\_1 and 1 \- u\_2. And because of the properties of the cdf, you can just make it the negative inverse cdf instead of 1 \- cdf. And actually, since there are two negatives, they cancel out.

So there is symmetry: **the survival and default copulas of the Gaussian bi-variate are the same**.



Because of this property, this particular distribution does not have tail dependence. To understand this, we will look at various dependency measures. Other distributions will model this more accurately.

## Measuring Dependence

An important property of this is dependence, so the question is how do you measure?

There are many ways.

The most popular way is **Pearson Linear Correlation**.

$$
\\rho_P = \\mathbb{E}[XY] = \\frac{\\mathbb{E}[X]\\cdot\\mathbb{E}[Y]}{\\sqrt{\\mathbb{E}[X^2] - (\\mathbb{E}[X])^2)}\\sqrt{\\mathbb{E}[Y^2] - (\\mathbb{E}[Y])^2)}}
$$

Advantages: easier to understand. Everyone understands correlation. It is also invariant under linear transformation. Say we change the variables by scaling and shifting (multiplying and adding), it doesn’t affect the correlation.

Another advantage is that if the marginals are Gaussian and the correlation is 0, then we have independence.

However, there is a big disadvantage: linear correlation being 0 DOES NOT imply independence in general

Sometimes the correlation is abused. It is a measure of linear dependence between variables. But just because there’s no linear dependence, doesn’t mean there are other kinds of dependence.



A quick counterexample is on page 21 of the notes.



Let’s say we have an experiment and we get five points, in y \= x^2. And we want to determine the correlation.

Covariance is the same thing as the top of Pearson linear correlation.

Expectation of x and x^3 are both 0, so everything is 0\. But in this case, they are strictly dependent, they just have no linear dependency.



## **Rank Correlation**

If we have x, y random variables and draw n pairs (X\_i, Y\_i).

Define R\_i as the rank of X\_i. That will tell us the order/rank of the variables in our realization, in terms of smallest to largest. Basically, we can take a sorted vec, and map the indices of the sorted vec to the elements.

If S\_i is the rank of Y\_i, then the average rankings



you can express rank correlation in terms of prevalence of concordant and discordant pairs. If we have two realizations (x\_1, y\_1) and (x\_2, y\_2), the pairs are concordant if \\((x_1 - x_2)(y_1 - y_2) > 0\\)

The pairs are numeric values. It’s a product of two numbers, if it has to be greater than 0, either they are both positive or both negative.

Discordant is if it’s negative.



Example on page 24 of the notes



If we measured the rank correlation, it would be 100%. If we look at these data points.



How do we measure this? There are two ways.

### Kendall’s Tau

$$
\\tau = \\frac{c - d}{c + d}
$$

where c is the number of concordant pairs, and d is the number of discordant pairs.

Then the total number of pairs is c \+ d, which n choose 2 \= n(n-1)/2.

In the previous case, all of these are concordant, so this is 1/1.

And if it’s discordant, that’s \-1.

The sample estimator of Kendall’s τ is

$$
\\tau = \\frac{2 \\sum_{i=1}^{n-1} \\sum_{j=i+1}^n \\operatorname{sign}((x_i - x_j)(y_i - y_j))}{n(n-1)}
$$

So basically you’re enumerating all these pairs, and then dividing it by the known bottom, and flipping the 2\.



What are the dependency limits?

* Independence: τ \= 0
* Perfect Positive (Maximum): τ \= 1, or τ \= \-1

Minimum dependence does not exist, it converges to 0\.



For a continuous x, y, Kendall’s tau should be

$$
\\tau_{xy} = 4\\int_0^1 \\int_0^1 C(u, v) dC(u, v) - 1
$$



### Spearman’s Rho

Linear Pearson correlation for rank correlation



$$
\\rho_S = \\frac{\\sum_{i=1}^n (R_i - \\bar{R})(S_i - \\bar{S})}{\\sqrt{\\sum_{i=1}^n (R_i - \\bar{R})^2}\\sqrt{\\sum_{i=1}^n (S_i - \\bar{S})^2}} = \\frac{12 \\sum_{i=1}^n (R_i - \\bar{R}) (S_i - \\bar{S})}{n(n^2 - 1)}
$$



expression for min of ranks for x and y, rbar sbar



Furthermore, for a continuous x and y.



$$
\\rho_S = 12 \\int_0^1 \\int_0^1 C(u, v) du dv - 3
$$

This is important because for each copula it’s going to be dependent, as a function of those parameters, it’s going to have different values in the Pearson, Kendall or Spearman value.



There are some advantages to rank correlation, which is that it’s able to capture nonlinear dependence, but it has some disadvantage as well.



## Tail Dependence

Rank correlation does not consider the absolute magnitude of the realizations and cannot capture extremely joint behavior. From a rank perspective, it’s increasing or decreasing, or concordant or discordant.



For this reason, you can’t look at just one measure of dependence.



This refers to the probability of the joint occurrence of these events, of being in the tails.

Visual in Notes page 30\.



**Upper Tail Dependence Parameter:**

$$
\\lambda_u = \\lim_{u \\rightarrow 1} \\mathbb{P}(Y > F_Y^{-1}(u) | x > F_X^{-1}(u))
$$

where f is inverse marginal

We’ll say u is the probability of default.

Since u is large,

This is the conditional probability that y is in the tail, given that x is in the tail.

We calculated in the conditional in the survival probability in the previous class, so it’s measured similarly.

If λ\_u \> 0, x and y are upper tail dependent. Similarly for lower tail dependence:

$$
\\lambda_L = \\lim_{u \\rightarrow 0} \\mathbb{P}(Y < F_Y^{-1}(u) | x < F_X^{-1}(u))
$$

And if λ\_L \> 0, then x and y are lower tail dependent.



The Gaussian copula doesn’t have tail dependence.
