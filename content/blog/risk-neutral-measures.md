+++
title = 'Risk-Neutral Measures'
date = 2024-11-07
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Risk-Neutral Pricing', 'Girsanov']
+++
The risk-neutral section motivates a change of measure rather than assuming investors literally expect the risk-free rate. Discounted tradable prices should be martingales under a pricing measure \(\mathbb Q\). Under that measure, a payoff \(H_T\) is valued as

$$V_t=\mathbb E^{\mathbb Q}\left[e^{-r(T-t)}H_T\mid\mathcal F_t\right].$$

Girsanov's theorem explains how the drift changes when the Brownian motion is shifted. The new measure is equivalent to the original one, so zero-probability events stay zero; only the weights of possible paths change. The notes use the density process and the discounted asset to connect this measure change to no-arbitrage pricing.
