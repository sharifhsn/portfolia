+++
title = 'Multidimensional Market Models'
date = 2024-11-14
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Market Models', 'Girsanov']
+++
The multidimensional market model in the FE-610 notes has several stocks driven by several Brownian factors. Prices, drifts, volatilities, and correlations become vectors and matrices, but the no-arbitrage idea is unchanged: after discounting, tradable prices should be martingales under an equivalent measure.

The multidimensional Girsanov change shifts the Brownian vector by a market-price-of-risk process. The fundamental theorem then links existence of an equivalent martingale measure to no arbitrage, and uniqueness to completeness. In practice, the model's volatility matrix determines whether every contingent claim can be replicated.
