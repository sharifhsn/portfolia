+++
title = 'Stochastic Differential Equations'
date = 2024-11-21
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'SDEs', 'Diffusions']
+++
The SDE section writes a state process as a drift plus a diffusion term,

$$dX_t=b(t,X_t)\,dt+\sigma(t,X_t)\,dW_t.$$

The coefficients describe deterministic motion and random shocks. Unlike an ordinary differential equation, an SDE is interpreted through an integral equation and a chosen filtration. The notes compare continuous diffusions with jump processes and use Itô's formula to transform solutions.

For pricing, this notation is valuable because a model can be specified by its local characteristics even when there is no closed-form path. Existence, integrability, and the chosen measure determine whether the process is usable as a financial model.
