+++
title = 'Itô Calculus'
date = 2024-10-10
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Ito Lemma', 'Geometric Brownian Motion']
+++
Itô's formula is the stochastic analogue of the multivariable chain rule. If

$$dX_t=a(t,X_t)\,dt+b(t,X_t)\,dW_t,$$

then a smooth function \(f(t,X_t)\) acquires a second-order term because \((dW_t)^2=dt\):

$$df=f_t\,dt+f_x\,dX_t+\tfrac12 f_{xx}(dX_t)^2.$$

The FE-610 notes apply the formula to Itô processes, generalized geometric Brownian motion, and short-rate examples such as Vasicek and Cox–Ingersoll–Ross. The extra curvature term is the practical difference from ordinary calculus; dropping it produces the wrong drift for a transformed process.
