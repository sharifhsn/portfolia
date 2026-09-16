+++
title = 'Multidimensional Itô Calculus'
date = 2024-10-24
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Multidimensional Models', 'Correlation']
+++
When several state variables move together, the FE-610 notes replace the scalar Itô formula with its multidimensional version. The Hessian term contains both variances and cross-variations, so correlation enters the drift of a function of two stocks.

For a two-dimensional process driven by correlated Brownian motions, the covariance matrix is part of the model. A portfolio or derivative can therefore depend on both individual volatilities and the covariance term. The notes use a two-dimensional Itô process and Lévy's characterization to keep track of these cross terms.

This is the bridge from one-stock Black–Scholes to a market model with several assets: the same calculus works, but the matrix of quadratic covariations must be carried through every derivative.
