+++
title = 'Probability and Regression Review'
date = 2024-10-17
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Probability', 'Regression']
+++

### Exam Review

#### Chapter 2: Fundamentals of Probability

For a

\(Z = aX + bY\)

then

\(\mathbb{E}[Z] = a\mathbb{E}[X] + b\mathbb{E}[Y]\)

and for variance,

\(\mathbb{V}[Z] = a^2\mathbb{V}[X] + b^2\mathbb{V}[Y] + 2ab cov(X, Y)\)

We can actually do this from a portfolio perspective, it’s the same idea. We have some weight

\(Z = w_1 \cdot R_1 + w_2 R_2\)

What’s the variance?
\(\mathbb{V}[Z] = w_1 \sigma_1^2 + w_2^2 \sigma_2^2 + 2w_1w_2 \sigma_{12}\)

It’s the same in this exercise where we substitute the weights for the coefficients and the random variables for X and Y.

Another way to look at this problem is through matrix algebra.

We have a vector v,

\(\vec{w} = \begin{bmatrix} a \\ b \end{bmatrix}\)

We can rewrite \(Z\) as

\(Z = \vec{w}^T \vec{R}\)

Then the expectation and variance becomes

\(\mathbb{E}[Z] = \vec{w}^T \mathbb{E}[R]\)

This is nice because if you have a covariance matrix you don’t have to look at all the pairwise. The question gives us that this X and Y have covariance 0.35. Be mindful of the difference between covariance and correlation.

The formula for covariance is that

\(\sigma_{12} = \rho \sigma_1 \sigma_2\)

so that’s where correlation comes into it. That \(\rho\) is correlation.

We can then rewrite our problem into

\(w' \Sigma w\)

based on considering this as matrix.



If you $100 today, it can either go to $110 or $90. Up is 0.3, Down is 0.7. We’ll have the same increase and decrease amounts and probabilities at each step.

We’re actually interested in the value of

\(\mathbb{E}[S_2|S_0]\)

But in this case we have discrete outcomes, not like in GBM. If we have a random variable, it’s either going to be 120, 100, or 80. There is a probability assigned to each of these for a given \(S_0\).

We know that the probability for 120 is 0.3 \* 0.3 or 0.09, for 80 it’s 0.7 \* 0.7 = 0.49. For 110 we have to consider both the possibility of 0.3 \* 0.7 up and down and 0.7 \* 0.3 down and up, which becomes 0.42. And we can show that these all add to 1.

So how do we actually calculate probability? We think about it simply as

\(\mathbb{E}[X] = \sum_{\forall x} \mathbb{P}(X = x) \times x\)

and

\(\mathbb{E}[x^2] = \sum_{\forall x} \mathbb{P}(X = x) \times x^2\)

And we can generalize this to any function \(g(X)\).

Therefore the simple calculation is multiplying each probability of each outcome by its value and adding them together.

For variance we can use the same logic.

\(\mathbb{V}[S_2] = \mathbb{E}[S_2^2] - \mathbb{E}[S_2]^2\)

For the second one it’s simple, it must be \(92^2\). And for the expectation of squares we can use the \(g(X)\) property.

Then afterwards we take the square root to get the volatility.

What about ten steps ahead? It’s not as intuitive if we continue to use the tree model, there are too many possibilities.

We can actually solve this problem using binomial process.

One way you can think about it is success and no success. So, we could think about it as, we have a process

\(B_2 \sim \text{ Binom}(2, 0.3)\)

And the question is of how many possibilities do we have, and what’s the probability of success? Let’s use some reasoning

When \(B_2 = 0\), we know that \(P_2 = 80\). So we can think about it as

\(P_2 = 0 \cdot 20\)

As this is a random variable which modifies our answer. And we get either 80, 100, or 120 depending on the value \(B_2\). And we can in fact say that

\(\mathbb{P}_2 = 80 + B_2 \cdot 20\)
Therefore,

\(\mathbb{E}[P_2] = 80 + 20 \mathbb{E}[B_2]\)

\(\mathbb{V}[P_2] = 0 + 20^2 \mathbb{V}[B_2]\)

So now let’s try to understand the distribution of our random variable \(B_2\).

We can actually leverage some common knowledge which tells us that the answer is based on the formulas.



If we have a general

\(X \sim N(\mu, \sigma^2)\)

and we want to know

\(\mathbb{P}(X < a)\)

We know this is the same thing as asking

\(\phi\left(\frac{a - \mu}{\sigma}\right)\)

And then you can use the Excel formula

NORMDIST((a - mu)/ sigma)

Remember that in order to solve this, you can consult the table or Excel. There is a standardized reference.

##### 5.

If we have stock returns iid, with annual vol of 30% what is daily VaR at 99% confidence level.

This is tricky because we have to convert between annual and daily. If we have iid variables, than the VaR can be written as

\(VaR(X, \alpha) = \sigma Z_{1 - \alpha}\)

If we consider daily, we have

\(VaR_\d = \sigma_d \cdot Z_{1 - \alpha}\)

and we are given that \(\alpha\) is 0.01.

We are not given information about \(\sigma_d\), but we know \(\sigma_A = 0.3\). To some extent, we are looking at the aggregation. If we have log returns, the annual returns of A is the summation of these returns from days until 252. So

\(\sigma_A^2 =252 \cdot \sigma_d\)

That means that actually

\(\sigma_d = \frac{1}{\sqrt{252}} \cdot \sigma_A\)

We can plug this value in to get \(\sigma_d\).

That’s how we move between periods. For the \(Z\), we just refer to the normal distribution table, which is the 99th percentile.

##### 6.

In order to get the 10 day VaR, we use the formula

\(VaR_d = \sqrt{d} \cdot VaR\).

##### 7.

What does value at risk mean?

In 1 out of however many days (represented by confidence level), the portfolio will decline by the value at risk *or more*.

e.g. for 95% confidence level, this is 1 out of 20 days.

#### Regression Analysis

There’s a portfolio  on Canvas, an Excel spreadsheet in the FE\_535\_Session\_01\_Portfolio\_CAPM.xlsx. The file looks at the composition of TSLA returns. That’s what regression does.

##### 8.

What is the correlation between these two assets? What is \(\beta\), what does it stand for? It is the derivative of the regression, how will covariance change x?

\(\beta = \frac{cov(x, y)}{\mathbb{V}[X]}\)

If \(\beta\) is positive, that tells us correlation is positive, so we can consider them related. This is also

\(\frac{\sigma_{xy}}{\sigma_x^2}\)

We can play a little trick here to get

\(\frac{\sigma_{xy}}{\sigma_x \sigma_y} \cdot \frac{\sigma_y}{\sigma_x}\)

And that first expression is the correlation \(\rho_{xy}\)

So we have calculated

\(\beta = \rho_{xy} \frac{\sigma_y}{\sigma_x}\)

Let’s take the square here.

\(\beta^2 = \rho_{xy}^2 \frac{\sigma_y^2}{\sigma_x^2}\)

I can write the volatility of this asset as systematic volatility.

\(\sigma_y^2 = \frac{\beta^2 \sigma x^2}{\rho{xy}^2}\)

There’s a proportion of total volatility that will be explained by this variable x.

If we have

\(R^2 = \frac{\beta^2 \sigma_x^2}{\sigma_y^2}\)

this is the meaning of this statistical property.

We can actually explain the total volatility as the systematic volatility (\(\beta\)) as

\(\sigma_y^2 = \beta^2 \sigma_x^2 + \sigma_e^2\)

When you look at
