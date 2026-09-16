+++
title = 'Martingales and Random Walks'
date = 2024-09-19
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Martingales', 'Random Walks']
+++
The FE-610 notes describe a martingale as an adapted process whose conditional expected future value equals its current value:

$$\mathbb E[M_t\mid\mathcal F_s]=M_s,\qquad s\leq t.$$

A symmetric random walk provides the discrete model. Encode heads as \(+1\) and tails as \(-1\); independent increments give zero conditional drift. A Markov process goes further by saying the current state contains enough information about the future, while a martingale says the best conditional forecast is the present value.

The notes also introduce first-order and quadratic variation. A smooth function's squared increments vanish in the limit, but a random walk's accumulated squared increments do not. That difference is why Brownian motion needs a new calculus.
