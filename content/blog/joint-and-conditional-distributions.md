+++
title = 'Joint and Conditional Distributions'
date = 2024-11-11
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Conditional Distributions', 'Covariance']
+++

### Lecture Notes

(came late…)

#### Example 7.8

##### (a)

Keep in mind that you can’t separate ε out from Y because they are not necessarily independent.

We can use the fact that ε is complementary to divide up what X means.

\(\mathbb{P}(X \leq x)\mathbb{P}(\epsilon = 1) + \mathbb{P}(-X \leq x)\mathbb{P}(\epsilon = -1)\)

But notice that those two X densities are symmetric\! Geometrically, they mirror each other the normal density. And so we can say that these two are equal.

\(= \mathbb{P}(X \leq x)\)

And there we go\! That’s the same as X, so we can say that

\(Y = N(0, 1)\)



What about the joint distribution?

We can create a similar negative contrast.

**Open question:** work through the joint distribution exercise.

##### (c)

Since both X and Y are normal, the expectation is 0.

\(\operatorname{Cov}(X, Y) = \mathbb{E}[XY] - \mathbb{E}[X]\mathbb{E}[Y] = \mathbb{E}[X, Y]\)

We can make this easier by splitting this into two situations.

\(= \mathbb{E}[X \cdot \epsilon X] = \mathbb{E}[\epsilon]\mathbb{E}[X^2] = 0\)

The conclusion is that “X and Y are uncorrelated” because their covariance is equal to 0.

##### (d)

But they are not independent\! This is a great counterexample to the false intuition that variables that are uncorrelated are necessarily independent. That’s why it’s not enough to calculate the covariance to determine independence.

\(\mathbb{E}[X^2Y^2] = \mathbb{E}[X^2\epsilon^2X^2] = \mathbb{E}[\epsilon^2X^4] = \mathbb{E}[\epsilon^2]\mathbb{E}[X^4] = 1 \times 3 = 3\)

\(\mathbb{E}[X^2] = 1\)

\(\mathbb{E}[Y^2] = \mathbb{E}[\epsilon^2X^2] = \mathbb{E}[\epsilon^2]\mathbb{E}[X^2] = 1\)

And that indicates

\(\mathbb{E}[X^2Y^2] \neq \mathbb{E}[X^2]\mathbb{E}[Y^2]\)

And that is a proof by contradiction\!

#### Example 7.12

##### (a)

In order to prove that this is a density, we need to prove that that the area under its function (integral) is equal to 1 over the entire domain.

We need to do a double integral here because the domain is across two variables.

The result becomes the integral over the exponential distribution which is known to be 1.

##### (b)

We are going to take some basic properties. What is the marginal distribution for each variable?

\(f_Y(y) = a^2 y e^{-ay}\)

And we can recognize they take the form

\(f_Y(y) = \lambda^k e^{-\lambda y}/k!\)

#### Example 7.13

##### (a)

This type of problem is a way to flip around already understood concepts. We still need the same formula for density, but now we’re actually solving for something instead it proving something we already know.

We are taking a sum here because \(\mathbb{P}(X=x)\) is the notation used for discrete random variables.



#### Conditional Distribution: The Discrete Case

We have the marginal probability of which we are already familiar.
\(p_X(x) = \mathbb{P}(X=x) = \sum_y \mathbb{P}(X=x, Y=y) = \sum_y p(x,y)\)

From now on we will use the following notation:
\(p_{X\mid Y}(x \mid y)\)

which is the conditioning random variable.

\(p_{X\mid Y}(x\mid y) = \mathbb{P}(X=x\mid Y=y) = \frac{\mathbb{P}(X=x,Y=y)}{\mathbb{P}(Y=y)} = \frac{p(x,y)}{p_Y(y)}\)

#### Conditional CDF

\(F_{X\mid Y}(x\mid y) = \mathbb{P}(X \leq x\mid Y=y) = \sum_{t\leq x} \mathbb{P}(X=t\mid Y=y)\)

\(= \sum_{t\leq x} p_{X\mid Y}(t\mid y)\)

We can use all of thes expressions, which are the same. They might be useful in different contexts, though.

##### 8.16

#### Conditional Expectation

\(\mathbb{E}[X\mid Y=y] = \sum_x x\,\mathbb{P}(X=x\mid Y=y) = \sum_x x p_{X\mid Y}(x\mid y)\)

And this expectation generalizes across any function of X.

This is the same result of linear expectation.

##### 8.19

The joint density is not actually easy to determine here.

What is the probability that (Y = 3)? It’s a geometric random variable, based on our knowledge of the “trials until you have success” property of geometric random variables.

\(\frac{(x-1)^2}{x^2}\)

Let’s see the probability for when (Y = 3). We will take the probability of every value of (x).

We actually have a restriction on our domain here.

There’s a common identity we can use for the geometric distribution:

\(g(x) = \sum_{n=0}^{\infty}x^n = \frac{1}{1-x}\)

\(g'(x) = \sum_{n=1}^{\infty} n x^{n-1} = \frac{1}{(1-x)^2}\)

\(xg'(x) = \sum_{n=0}^{\infty}n x^n = \frac{x}{(1-x)^2}\)
