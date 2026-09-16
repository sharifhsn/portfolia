+++
title = 'Brownian Motion'
date = 2024-09-26
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Brownian Motion', 'Quadratic Variation']
+++
Brownian motion is the continuous limit of a scaled symmetric random walk. Its increments are independent and normally distributed, with \(W_t-W_s\sim N(0,t-s)\). It is a martingale, but its paths are almost surely continuous and nowhere differentiable.

The defining calculation for stochastic calculus is its quadratic variation:

$$[W,W]_t=t,$$

or, in differential notation, \((dW_t)^2=dt\). Cross variation with ordinary time is zero. The notes use this contrast to explain why the ordinary chain rule cannot simply be applied to a Brownian path.

First-passage times and the running maximum appear here as well. They connect Brownian motion to barrier and lookback payoffs later in the course.
