+++
title = 'Interest Rate Risk and Duration'
date = 2024-10-24
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Interest Rate Risk', 'Duration']
+++
The interest-rate-risk notes approximate how a bond portfolio changes when yields move. Duration is the first-order sensitivity of price to yield; convexity captures the curvature that duration misses.

For a price \(P(y)\), the class defines modified duration and DV01 through the local derivative:

$$D=-\frac{1}{P}\frac{\partial P}{\partial y},\qquad
DV01=-\frac{\partial P}{10{,}000\,\partial y}.$$

The signs reflect the inverse relation between price and yield. A duration-only hedge is adequate for a small parallel move, while convexity matters for larger moves or portfolios whose cash flows are spread across maturities.
