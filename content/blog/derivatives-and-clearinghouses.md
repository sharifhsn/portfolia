+++
title = 'Derivatives and Clearinghouses'
date = 2024-10-31
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Derivatives', 'Clearinghouses']
+++

### Lecture Notes

#### Exam Review

The Treynor ratio is intended to capture systematic risk, but doesn’t tell you anything about portfolio returns. Sharpe ratio doesn’t tell you anything about systematic risk.



R^2 tells you much of the variance is explained by the model.

The variance has a systematic component and error component.

\(\mathbb{V}[R] = \beta ^2 \sigma_m^2 + \sigma_\epsilon^2\)

Systematic volatility is the \(\beta \sigma_m\)

#### Derivatives

There’s Q finance, which is risk-neutral, that will give you martingale theories and all that. In our class we are considering P finance based off physical probabilities, real market stuff. When you get into stochastic models and pricing, then you have to make all these assumptions under Q finance.

What is a derivative? A **derivative** is an instrument whose value is derived by another underlying instrument. Let’s say we have the ETF SPY. We can take options on SPY, and that option is a derivative.

What would a farmer like to do? He makes bourbon, so he needs to hedge corn. He uses derivatives to do that.

OTC markets are actually much larger than exchanges.

The farmer would like to buy corn. He wants to secure $1 million in corn.

How do you buy S\&P? You can buy SPY, but you can also buy a futures contract. The notional is 50x the index, which is $250,000. If you want to trade these contracts, you need a lot of capital.



What’s the difference between bonds/equities and derivatives? Let’s say you have a publicly owned company. You can raise money by issuing a bond, and gaining assets. Bonds/equities are a way of raising money for a company.

Derivatives are an agreement between two parties, with a winner and a loser. So it needs to be a fair game.

Flash boys by Michael Lewis, HFT trading.

Exchanges organize trades, match buyers and sellers together. The farmer would like to sell bourbon for a certain price, but if the second party disappears, that’s a disappointment. The exchange monitors both parties and makes sure they’re both healthy, and have the capital to fulfill their obligations.

OTC market is a network of traders, financial institutions that negotiate contracts on an individual basis.

There was more oversight in OTC after the financial crisis. It used to be a bilateral agreement with no middleman, but it’s becoming more similar to exchanges. Forwards are the same as futures, just OTC vs exchanges. You can have FX futures, depends on underlying

The true value of OTC derivatives contracts is about $22 trillion, only 3% of notional. If they are liquid and traded on a day to day basis, then I can see the mark to market price

#### Clearinghouses and Robinhood

Clearinghouses are the plumbing of the financial system. If you make a trade, let’s say you use Robinhood, they hold the money.  This is when VaR is useful, because they put some money on margin, to compensate for the value at risk of the money being traded.

Robinhood got put in front of Congress because they weren’t allowing GME traders to trade.

They couldn’t allow traders to buy more GME, so if you can’t buy you can only sell.

It wasn’t a conspiracy. Robinhood got a margin call. They were telling Robinhood that their assets were way too risky. Because it was all in one asset, that was very volatile, it was risky. So they were margin called for $3 billion.

There was probably model risk that caused this, which caused reputational risk.

Could GME happen again? Another faculty, in literature, was asking about GME, but it’s too late.

Reddit coordinated in a way that hedge funds couldn’t.

#### Central Counterparties

CCPs provide more flexibility, they’re clearinghouses for OTC.

We have a financial network.

#### Project

We have three assets here, not two, and that’s the difficulty. What we do is have a closed form solution for this, based on minimizing mean variance.

I take the most and least efficient fund. When I have a risk-free rate, the dynamics change. My pension, some is risk-free, some is market.
