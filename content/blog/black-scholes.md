+++
title = 'Black–Scholes'
date = 2024-10-17
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Black–Scholes', 'Option Pricing']
+++
The Black–Scholes notes start with a stock following geometric Brownian motion,

$$dS_t=\mu S_t\,dt+\sigma S_t\,dW_t.$$

Constructing a delta-hedged portfolio removes the Brownian shock. Applying Itô's formula to the option value and matching the remaining drift produces the Black–Scholes PDE. With terminal payoff \(g(S_T)\), the problem is a boundary-value problem: the price is determined backward from the payoff.

The notes work through calls, puts, and the Black–Scholes–Merton form with a continuously compounded rate. The important modeling move is the hedge: risk is removed locally, so the option's drift is tied to the financing rate rather than to the stock's expected return.
