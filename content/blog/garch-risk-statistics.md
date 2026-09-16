+++
title = 'GARCH Risk Statistics'
date = 2025-03-24
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'GARCH', 'Volatility Estimation']
+++
The risk-statistics portion of FE-635 introduces GARCH as a way to model time-varying volatility. Returns may have little serial correlation while their squared returns cluster: calm periods tend to be followed by calm periods, and shocks tend to persist.

A simple GARCH(1,1) recurrence is

$$\sigma_t^2=\omega+\alpha\epsilon_{t-1}^2+\beta\sigma_{t-1}^2.$$

The parameters describe long-run variance, reaction to a new shock, and persistence. Estimation and diagnostics matter as much as the recurrence; a fitted model should be checked against the horizon and the tail behavior of the risk report.
