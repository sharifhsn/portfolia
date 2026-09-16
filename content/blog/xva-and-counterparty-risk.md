+++
title = 'XVA and Counterparty Risk'
date = 2025-04-21
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'XVA', 'Counterparty Risk']
+++
The XVA section adds counterparty and funding effects to an otherwise clean derivative value. CVA is the expected loss from counterparty default on positive exposure; FVA captures the funding cost of carrying an uncollateralized position. The exact decomposition depends on collateral, netting, and the institution's convention.

The calculation is path dependent: simulate or approximate future exposure, combine it with default probabilities and recovery, and discount the expected loss. Netting sets and collateral agreements can change the exposure more than a small shift in a market input.

The class notes use XVA to connect pricing and risk governance. A model output is meaningful only when the legal agreement and the exposure definition are the same ones used by the desk.
