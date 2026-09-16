+++
title = 'FX Parity and Forward Trading'
date = 2025-02-10
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'FX Parity', 'Forward Contracts']
+++
The FE-635 notes begin with the distinction between spot and forward FX. The forward rate is the exchange rate implied by borrowing in one currency, lending in the other, and carrying the position to maturity. The notation in the class workbook uses the forward FX rate as \(S\), so the quote convention has to be fixed before a formula is evaluated.

Covered interest parity is the no-arbitrage check. Domestic and foreign discounting rates determine the forward adjustment, while day-count and currency conventions determine how those rates are applied. A forward is a contract on a future exchange, not a forecast of where spot must end up.

The practical checklist is simple: identify the domestic currency, foreign currency, spot quote, maturity, and compounding convention before comparing two prices.
