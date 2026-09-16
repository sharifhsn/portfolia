+++
title = 'Poisson Processes'
date = 2024-11-28
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Poisson Processes', 'Jump Diffusion']
+++
The FE-610 notes introduce Poisson processes as counting processes with independent increments and a constant arrival intensity. For a rate \(\lambda\), the number of arrivals by time \(t\) has distribution

$$\mathbb P(N_t=k)=e^{-\lambda t}\frac{(\lambda t)^k}{k!}.$$

The waiting time to the first arrival is exponential, and independent waiting times produce the full process. Adding random jump sizes gives a compound Poisson process; combining it with Brownian motion gives a jump-diffusion model.

The notes return to quadratic variation: jumps contribute their squared sizes, while the continuous part contributes its usual diffusion variation. That decomposition is the starting point for an Itô formula with jumps.
