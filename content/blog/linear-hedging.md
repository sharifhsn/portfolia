+++
title = 'Linear Hedging'
date = 2024-11-21
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Hedging', 'Linear Risk']
+++

#### Linear Risk Management

Let’s say I’m trading futures. What is the log return of this?

The futures contract at time 1 is worth S\_0 e^{1r}, then at time 2 is S\_0 e^{2r}, etc.

If you look at log returns, then it’s simply a linear function of the underlying returns.



I can use a futures contract to hedge my beta (systematic risk)



#### Foreign Exchange Rates

If I have a 1 year change Q, you can calculate this as



Everything will get more expensive when Trump goes into office, making the dollar weaker relative to the euro. Tariffs will have an inflationary effect.



#### Unitary Hedge

If you’re going to trade futures on Japanese yen, each future is ¥12.5 million, which is about $80,000.

We have a risky asset called JPY, and 125 million worth. We have promised to get this payment. If someone pays me today, I will get this inventory. But they’re going to give me ¥125 million in 7 months, so I’m not sure what will happen. If we think about this under no-arbitrage pricing, or GBM, we could end up anywhere from the best case to the worst case. In the best case, JPY will become stronger, so the yen you receive is worth more. The worst case is the opposite.



International companies are getting paid in the currency for each place they are located in, so they are sensitive to currencies. How do you hedge this?

Sell a futures contract at the time you receive the payment for the export. That way you can lock in the exchange rate right now.

However, there’s a potential loss if the yen *doesn’t* weaken. You could have made more money, but you chose to lock in at a weaker price. This is **basis risk**.

To calculate the PnL for basis risk, you need Q as the amount of yen transacted and S and F as spot and future rates:

\(QS_T - QS_0 = Q \times (S_2-S_1)\)

If you plug these into the equations for the forward rates, you get

\(S_0[e^{\Theta t}-1] - S_0[e^{\Theta(T-t)}-1]\)

You can think of the hedge position as something called “trading the basis”, the difference between the underlying and the futures is the basis, and then the difference is between those two times.

## Week 12

### Lecture Notes

#### Federal Reserve

His friend worked for the OCC at the Fed, they make a lot of money when they need to fix problems. He says, Trump will keep Fed more employed. Results from politics take a long time to show up.

#### Unitary Hedge (continued)

We say that we’re going to get a delivery of ¥125 million in a few months. And if we map out the change in exchange rate between now and then, there becomes a risk in our GBM that the exchange rate weakens and the yen loses value. The value at risk is \(-S_0 + S_t\).

Why does technical analysis work? It’s because everyone uses it.



Hedging is trying to eliminate uncertainty. We need to compare apples to apples, so we want the underlying and hedge vehicle to be 100% correlated with equal volatilities. The underlying goes lik

#### Optimal Hedge

The best?

Let’s say for each million dollars on stocks, bonds, whatever, how do I come up with the decision to hedge apples with oranges? Optimal means that it minimizes the objective function.

A unit hedge has the quantities transacted as being identical. But in general, how do we decide to transact.

The example is jet fuel and heating oil. These will actually move together, and this is lab 4. Let’s imagine you’re an airline company that wants to manage liability for jet fuel and minimize the cost to pay.

Now we’re adding a futures contract. Let ΔS be the change in dollar value of inventory, and ΔF be the change in dollar value of the futures contract. The change in value of portfolio is

\(\Delta V = \Delta S + N\times\Delta F\)

What is the optimal N?

We can either think about V as the whole value of the portfolio, and also the change in the value of the portfolio. I’m buying today, selling tomorrow, what is the difference? That’s my unhedged ΔS. For ΔF, we have to know how much we’re going to sell today and buy tomorrow to balance these out. Let’s calculate variance:
\(\mathbb{V}[\Delta V] = \mathbb{V}[\Delta S] + N^2\mathbb{V}[\Delta F] + 2N\operatorname{Cov}(\Delta S,\Delta F)\)

Now how do you optimize this function?

We actually want this equate this to 0.



How would we determine the effectiveness of the hedge? By a decrease in portfolio volatility.

\(\sigma^2_{\Delta V}(N^*) = \sigma^2_{\Delta S} - \frac{\sigma^2_{S,F}}{\sigma^2_{\Delta F}}\)

What happens in a regression?

volatility of y is



The optimal hedge ratio is

\(N^* = -\beta_{s,f}\frac{Q\times s}{Q_f\times f}\)

in the long position, and negative for the short position.

Q is the inventory being hedged, in this case ¥125M. Q\_f is how many contracts you’re actually getting, in this case 12.5M.

So what is β actually? It’s estimated from the price time series on the underlying and the futures. We’re trying to explain the movement of the underlying as a result of the futures contract, and we will regress one on the other. That β is the coefficient of the futures contracts in question.



If you hedge a liability, then you go long, because you want the upside.

For an asset you short, for a liability you long.



A famous example will be used for lab 4.

Working with real data, all you have to do is figure out the beta between the two (regression) and then hedge the liability (go long).





Amal says that Srinath says that in 610
