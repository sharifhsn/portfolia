+++
title = 'Brownian Motion and Geometric Growth'
date = 2024-09-26
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Brownian Motion', 'Geometric Brownian Motion']
+++
The stochastic-process notes move from a random walk to Brownian motion and then to geometric Brownian motion. Brownian increments are normally distributed with variance proportional to elapsed time, while the geometric model keeps a positive asset level by applying the process to log returns.

With constant parameters, the geometric Brownian motion solution has the form

$$S_t=S_0\exp\left((\mu-\tfrac12\sigma^2)t+\sigma W_t\right).$$

The \(-\tfrac12\sigma^2\) term is the Itô correction. It matters when calibrating a model from observed returns because the mean of the log process is not the same as the mean of the price process.
