+++
title = 'Monte Carlo Risk Simulation'
date = 2024-09-19
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Monte Carlo', 'Simulation']
+++
The FE-535 lab notes use Monte Carlo methods to turn a model for returns into a distribution of portfolio outcomes. Simulate the relevant risk factors, revalue the portfolio on each draw, and summarize the resulting loss distribution.

The simulation is only as credible as its inputs. The notes emphasize choosing a horizon, calibrating the distribution, and checking sampling error. More paths reduce Monte Carlo noise, but they do not fix a misspecified dependence structure or a missing stress scenario.

For a portfolio with nonlinear instruments, full revaluation is often the cleanest approach. Linear approximations are faster, but their error grows exactly where risk management cares most: large moves and changes in volatility.
