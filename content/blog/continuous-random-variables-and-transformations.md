+++
title = 'Continuous Random Variables and Transformations'
date = 2024-10-14
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Continuous Distributions', 'Change of Variables']
+++
The continuous part of the FE-540 notes replaces sums with integrals. If \(X\) has density \(f_X\), then

$$\mathbb E[h(X)]=\int_{-\infty}^{\infty}h(x)f_X(x)\,dx.$$

The same idea gives probabilities by integrating the density over an interval. The notes then work through a monotone transformation \(Y=h(X)\). For an invertible differentiable map, the density picks up the Jacobian factor:

$$f_Y(y)=f_X\left(h^{-1}(y)\right)\left|\frac{d}{dy}h^{-1}(y)\right|.$$

The absolute derivative is the part that preserves mass when the coordinate system changes. The derivation proceeds through the CDF, a change of variables, and differentiation, which is safer than memorizing the final expression without its support.
