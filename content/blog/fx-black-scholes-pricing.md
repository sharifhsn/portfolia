+++
title = 'Black–Scholes Pricing for FX'
date = 2025-02-24
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Black–Scholes', 'Option Pricing']
+++
The FE-635 workbook implements Black–Scholes-style pricing for calls, puts, forwards, and deposits. Its inputs separate the domestic discount rate from the foreign rate, because an FX option has two money-market accounts in the carry relationship.

The spreadsheet's maturity convention is explicit: \(T=\text{Days}/365\). The pricing routine then consumes forward or strike, domestic and foreign rates, and volatility. That separation is more important than the function name; passing spot where the workbook expects forward FX changes the result systematically.

The notes treat the implementation as a practitioner tool. It is a compact expression of the assumptions, not a substitute for checking quote direction, settlement, and discounting currency.
