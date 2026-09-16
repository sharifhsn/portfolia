+++
title = 'Exotic Options'
date = 2024-12-12
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Exotic Options', 'Barrier Options']
+++
The final FE-610 notes apply the earlier stopping-time and maximum results to path-dependent payoffs. A barrier option depends on whether the underlying crosses a level before expiry; a lookback option depends on the running maximum or minimum.

The running maximum \(M_t=\max_{0\leq u\leq t}W_u\) is not determined by the terminal value alone. The pair \((W_t,M_t)\) is the useful Markov state. Reflection arguments relate events involving the maximum to ordinary Brownian probabilities, which makes joint distributions and first-passage calculations possible.

These products are a natural reason to study stochastic calculus: their value depends on the whole path, so a terminal-price shortcut is insufficient.
