+++
title = 'Forward Contracts'
date = 2024-11-07
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Forward Contracts', 'Futures']
+++
The forward-contract notes build value from replication. A forward fixes the delivery price today, while the underlying can be financed or invested until maturity. The forward price is therefore tied to the spot price, financing rate, and any income or storage benefit from holding the underlying.

For an asset with a known cash yield, the no-arbitrage relation has the form

$$F_0=S_0e^{(r-q)T},$$

with the appropriate convention for the yield or income rate. Futures add daily settlement and margin, so their value can differ from a forward when rates and prices are correlated.

The risk-management use is direct: a forward can lock a future price, but it replaces price uncertainty with counterparty, funding, and liquidity exposures.
