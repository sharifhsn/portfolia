+++
title = 'CDS and Credit Markets'
date = 2025-03-31
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'CDS', 'Credit Markets']
+++
The FE-635 syllabus turns to credit as a traded asset through credit default swaps. A CDS exchanges a premium leg for protection against a defined credit event. The buyer pays the spread while the reference entity survives and receives a loss payment after default, subject to the contract's recovery convention.

The notes connect the CDS price to a survival curve and a recovery assumption. A quoted spread is therefore not a pure probability of default; it also contains funding, liquidity, and risk premia. The premium and protection legs must be discounted consistently and aligned on payment dates.

This is why the risk-engineering workbook keeps instrument conventions explicit rather than hiding them behind a single “credit” input.
