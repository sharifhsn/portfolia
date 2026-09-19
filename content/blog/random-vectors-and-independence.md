+++
title = 'Random Vectors and Independence'
date = 2024-11-04
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Random Vectors', 'Independence']
+++

## Week 10

### Lecture Notes

#### Random Vectors

Beginning chapter 7, vectors of random variables. We are concerned with a **random vector**

\(X = (X_1, \ldots, X_N)\)

The cdf of this vector is

\(F_X(x_1, \ldots, x_N) = \mathbb{P}(X_1 \leq x_1, \ldots X_N \leq x_n)\)

We can also say that if we have a random vector (X, Y) then



If you compute joint cdf, we can get marginal distribution (distribution for a subset, maybe one element) very easily

\(F_X(x) = \lim_{y \rightarrow \infty} F_{(X, Y)} (x, y)\)

and equivalently

\(\mathbb{P}(X \leq x) = \lim_{y \rightarrow \infty} \mathbb{P}(X \leq x, Y \leq y)\)

Remark 7.7 says components of vectors are independent

These results hold for every random vector.

#### Discrete Random Vectors

Now we will talk about **discrete random vectors**.

The formal definition 7.8 says that the rv is discrete when the image set \(X(\Omega)\) is a finite or countable subset of \(\mathbb{R}^n\), the product space between n different real number lines.

The pmf for a discrete random vector is given by the basic formula

\(\mathbb{P}(X_1 = x_1, \ldots X_N = x_N)\)

The density dictates that the sum must be 1.

\(\sum_{x \in X(\Omega)} \mathbb{P}(X=x) = 1\)

Then the cdf is

\(F_X(x_1, \ldots, x_n) = \sum_{u_1 \leq x_1} \ldots \sum_{u_N \leq x_N} \mathbb{P}(X_1 = u_1, \ldots, X_N = u_N)\)



In order to intuitively understand why the marginal distribution calculation works for joint distribution, imagine a table of values, which has the probability for each event in the sample space. The rows are of the first random variable’s sample space, and the columns are for the second. Then, in order to calculate the probability of an event happening for the second random variable, you need to total all the probabilities from each row in the table.

#### Independence

Example 7.4

We have (X, Y) random vector. where

\(X(\Omega) = Y(\Omega) = \{0, 1\}\)

and

\(\mathbb{P}(X=0, Y=0) = (1 - p)^2\)

\(\mathbb{P}(X=1, Y=1) = p^2\)

\(\mathbb{P}(X=0, Y=1) = \mathbb{P}(X=1, Y=0) = p(1-p)\)

How do we prove independence?

We need to prove

\(\mathbb{P}(A \cap B) = \mathbb{P}(A)\mathbb{P}(B)\)

or for joint distributions,

\(\mathbb{P}(X=x, Y=y) = \mathbb{P}(X=x) \mathbb{P}(Y=y)\)

We can use the marginal distribution calculation for this.

\(\mathbb{P}(X=0) = \mathbb{P}(X=0, Y=0) + \mathbb{P}(X=0, Y=1) = (1-p)^2 + p(1-p) = 1 - p\)

\(\mathbb{P}(X=1) = p^2 + p(1-p) = p\)

\(\mathbb{P}(Y=0) = 1 - p\)

\(\mathbb{P}(Y=1) = p\)

And then now you can verify for each combination of different X and Y that the independence equality holds. Left as exercise for reader 😅

#### Continuous Random Vectors

We can consider any function \(f: \mathbb{R}^n \rightarrow \mathbb{R}\) a density if it’s positive and

\(\int_{\mathbb{R}^n} f(x) dx = \int_{\mathbb{R}_1} \ldots \int_{\mathbb{R}_N} f(x_1, \ldots, x_n) dx_1, \ldots dx_n = 1\)

We can say that the random vector has this density given by f if

\(\mathbb{P}((X_1, \ldots X_n) \in D) = \int_D f(x_1, \ldots, x_n) dx_1 \ldots dx_n\)

Where D is the product space. And in fact, for the cdf, this D is the Borel set

For the marginal density, instead of a summation of all the others, you actually do the integral of all the others

\(f_{x_i} (x_i) = \int_{\mathbb{R}^{n-1}} f(x_1, \ldots, x_n) dx_1 \ldots dx_{i-1} dx_{i+1} \ldots dx_n\)



#### Uniformly Distributed Vector

The joint density function is given by

\(f(x, y) = \frac{1}{(b-a)(d-c)} \mathbb{I}_{(a, b]} (x) \mathbb{I}_{(c, d]} (y)\)

#### Two Dimensional Normal

The mapping which is given by

\(f(x, y) = \frac{1}{2\pi} e^{-\tfrac{x^2 + y^2}{2}}\)

This is for both variables being (N(0, 1)).



If we want to prove that a function is a density, we need to prove only positivity and equivalence to one on the integral over the interval.

#### Change of Variable

Let’s take a random vector X with density \(f_X\), and \(Y = \varphi(X)\) where this function is a multivariate function that transforms X. The density of Y is, in the most general case,

\(f_Y(y) = f_X(\varphi^{-1}(y)) \left| det(J(\varphi^{-1}(y)))\right|\)

J the Jacobian is a matrix of partials, from

\(\frac{\partial \varphi_1}{\partial x_1} \ldots \frac{\partial\varphi_1}{\partial x_n}\)

going left to right

You’re kind of stacking these multivariate functions on top of each other:

\(\varphi = (\varphi_1(x_1, \ldots, x_n) \ldots \varphi_n(x_1 \ldots x_n)\)

To get the inverse of varphi, you treat it as a system

\(\begin{cases} u = xy \\ v = \tfrac{x}{y} \end{cases} \rightarrow uv = x^2 \rightarrow x = \sqrt{uv}, y = \sqrt{\tfrac{u}{v}}\)

\(\varphi^{-1}(u, v) = (\sqrt{uv}, \sqrt{\tfrac{u}{v}})\)

Then you can get the Jacobian from the vector

\(\begin{matrix} \frac{\partial}{\partial u}\sqrt{uv} & \frac{\partial}{\partial v} \sqrt{uv} \\ \frac{\partial}{\partial x} \sqrt{\frac{u}{v}} & \frac{\partial}{\partial v} \sqrt{\frac{u}{v}} \end{matrix}\)



Then calculate each partial, then take the determinant with a calculator.

#### Convolution

The convolution will allow you to find the density of the sum of random variables.

\((f * g)(x) = \int_{\mathbb{R}} f(y) g(x - y) dy = \int_\mathbb{R} g(z) f(x-z) dz\)

Take the convolution of the two density functions to get the result.



#### Examples

If you’re determining pairwise independence, you can use the procedure described earlier.

But for mutual independence, you will need to add all them together
