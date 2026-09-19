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

### Lecture Notes

#### Project

On problem 2, either you optimize for risk-free or risky assets. The question becomes unconstrained optimization.

#### Final

Either we have the same thing as Exam 1, released on 13 or 19?
Bonus question on Project 2, but requires reading. Stochastic Interest Rate Models (Vasicek)

Yields are going up, because people believe that Trump will create inflationary pressure.

Last video in Modules is worth watching\!

#### Forward Contract

How do you price a forward contract?
The underlying asset is unknown. Both parties have some views on how this process will evolve, but the price must be fair.



He has to pay \(F_t(T)\).

And he can sell it for the value of the underlying \(S_t\).



We can simulate each time, where one party ins and one loses. How do you determine the actual price.

By expectation, they should both be better off.

\(\mathbb{E}[V_A] = \mathbb{E}[V_B]\)

## Week 11

### Lecture Notes

We’re going to continue derivatives, uninteresting because I’m taking 620. Then we will start linear risk, more interesting.

#### Risk Neutral Valuation

A financial engineer is someone who doesn’t know finance or engineering.

I can bundle two products together and have an outcome, so the price of the combination should be the outcome.
A derivative has some underlying value. The forward contract has the value of the stock price with the risk-free price increase of the interest rate.

The futures of EUR/USD tell us what people think the exchange rate will be at that time. The *expected value*.

We need to ensure that there is no arbitrage in this process.

The intuition of risk-neutral that you will replace the μ in the GBM to the risk-free rate, because that’s the expected return. This keeps things consistent with no-arbitrage pricing.



Why do dividends matter when it comes to the forward contract?

You can buy the asset today and start getting dividends, or you can get the forward contract that will give you the asset in the future.



The higher the dividend, the more I’m missing. So if the yield of my dividend is q, then the future price should be lowered to

\(F_t(T) = S_t e^{(r-q)\tau}\)

What do we do if the forward price is high? Remember, that’s how you acquire the asset through the contract, and then the S\_t formula is how you acquire it through the underlying. You want to short the contract and buy the underlying.

#### Example Forward Dividend

We have

\(S_0 = 990\)

\(F = 1000\)

\(q = 0.02\)

\(r = 0.04\)

\(\tau = 0.25\)



The fair price for \(F\) is $995, so there is a $5 mispricing per contract.

#### Interest Rate Parity

When you’re thinking of buying a stock that pays dividend, the same argument is used for foreign exchange. If I’m buying euros, the exchange rate should take into account the risk-free interest rate for euros, which is different from dollars.

Let’s say I pay $106 to get €100. There is a foreign interest rate that the price will increase at, different from the USD risk-free interest rate.

This is a similar formula as for dividends

\(F_t(\tau) = S_t e^{(r-r^*)\tau}\)

where r\* is the foreign interest rate.



Let’s say you need to deliver ₤1 million six months from now, when the GBP/USD rate is 1.308, and USD risk-free rate 2%. You might think that the forward price should be

\(F_0(0.5) = 1.308e^{0.02 \times 0.5} \approx 1.321\).

But actually this forward contract is *higher* than the fair price because it doesn’t take into account the foreign interest rate. If this was the true price, you would have arbitrage.

In order to exploit this, I would borrow $1.308 today and buy €

If the market becomes stronger, than there’s inflation, which will cause the interest rates to go up.

#### Futures

Standardized, traded on exchanges.

They are marked to market, which means that every day someone is going to bother you to ask you what the price is.

You can also buy these on margin, so the trade will clear. An initial margin must be posted before you initiative a position. The clearinghouses will ensure that if the person I’m trading with disappears, they will find someone else to take his place and give me my money.

There’s a joke in Hull, for trading cattle. There was a new intern who didn’t close the position and ended up double short.
