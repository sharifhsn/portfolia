+++
title = 'FX Discrete Hedging and Greeks'
date = 2025-03-03
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Greeks', 'Discrete Hedging']
+++
The FE-635 notes move from an ideal continuous hedge to the discrete hedges used in practice. A delta hedge removes the first-order response to an FX move at one instant; between rebalances, spot and volatility can move and leave a residual.

The workbook exposes the main sensitivities directly: delta, gamma, vega, and domestic and foreign rho. Gamma measures how quickly delta changes, vega measures sensitivity to volatility, and the two rho functions separate the currencies' discounting effects.

The lesson is operational as much as mathematical. A hedge report should state the rebalance frequency, quote direction, and whether the risk is measured per unit of foreign currency or in domestic dollars.
