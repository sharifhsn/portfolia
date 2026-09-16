+++
title = 'Stochastic Integrals'
date = 2024-10-03
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Stochastic Integrals', 'Ito Integral']
+++
The FE-610 notes define an integral such as \(\int_0^T\Delta_t\,dW_t\) by starting with simple adapted processes. On each partition interval, the position \(\Delta_t\) is chosen from information already available, while the increment comes from Brownian motion.

Refining the partition gives the Itô integral. The adaptedness condition is the key financial interpretation: a trading strategy can react to the past but cannot see the next Brownian increment. The integral is itself a random variable because every Brownian path produces a different gain.

Two results organize the construction. The Itô integral is a martingale under suitable integrability, and the Itô isometry relates its second moment to the ordinary time integral of the squared integrand:

$$\mathbb E\left[\left(\int_0^T\Delta_t\,dW_t\right)^2\right]=\mathbb E\left[\int_0^T\Delta_t^2\,dt\right].$$
