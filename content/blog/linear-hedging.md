+++
title = 'Linear Hedging'
date = 2024-11-21
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Hedging', 'Linear Risk']
+++
The linear-risk notes approximate a portfolio's change by its sensitivities to risk factors. A hedge chooses positions whose factor exposures offset the portfolio's exposures, often by solving a covariance-weighted least-squares problem.

For a single factor, the minimum-variance hedge ratio is proportional to covariance divided by the variance of the hedging instrument. The unitary hedge examples show why the sign and units must be checked: a hedge ratio is a position size, not a probability.

The approximation is local. Basis risk, nonlinear payoffs, liquidity, and changing correlations can all make the realized hedge error larger than the linear estimate.
