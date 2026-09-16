+++
title = 'FX Volatility Smiles and Uncertainty'
date = 2025-03-10
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Volatility', 'Smiles']
+++
The next FE-635 notes explain why a single Black–Scholes volatility is not enough for an FX market. Discrete hedging creates P&L even when the model's inputs are correct, and volatility is uncertain rather than fixed.

Options with different strikes imply different volatilities. The resulting smile or skew is a market summary of tail demand, quotation conventions, and the limits of the log-normal model. Calibration therefore fits a surface of prices or implied volatilities instead of forcing every option through one number.

The practical implication is clear: risk must be revalued under shocks to both spot and the volatility surface. A delta-only report can miss the largest loss when the smile moves with the underlying.
