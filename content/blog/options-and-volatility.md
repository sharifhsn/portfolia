+++
title = 'Options and Volatility'
date = 2024-12-12
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Options', 'Volatility']
+++

### Lecture Notes

#### Options

The straddle strategy is owning a call and put option with the same characteristics.

If I end up long a call option and short a put, it ends up being a forward contract.



I can cook with stocks and bonds to replicate a put option.

#### paul wilmott

Some famous trader who spoke about Black Scholes

[https://web.archive.org/web/20080724100130/http://www.wilmott.com/blogs/paul/index.cfm/2008/4/29/Science-in-Finance-IX-In-defence-of-Black-Scholes-and-Merton](https://web.archive.org/web/20080724100130/http://www.wilmott.com/blogs/paul/index.cfm/2008/4/29/Science-in-Finance-IX-In-defence-of-Black-Scholes-and-Merton)

#### Exam

Replicate Black-Scholes model in Excel.

Simulate to verify.

Will be on exam\!

Expect to be able to price a bond

discounted payoffs at each time step

Does this also have a closed-form solution? **Open question:** verify.



you might get coupons, which I can put in a savings account to accumulate interest

the bond can get more expensive if it has appetizers like this

it also reduces duration risk (look this up)

In futures hedging on equities, you can invest in treasury bonds in order to make your portfolio beta neutral

And the same idea will lead you to having a bond portfolio duration neutral



Another item to check.

extraction of duration from real bond price data.

Process is in Exam II Review.





The Black Scholes model tells you what a

The intuition behind implied volatility:

black-scholes relies on historical volatility

but a risk manager might use forward looking information in the volatility

this comes from the implied volatility



#### VIX

VIX measures implied volatility in the market. It is **the fear gauge**.

Let’s look at calls and puts

If we graph their prices as a function of strike price, they form this interesting graph

\[\!graph\]

And then we get this area under the curve, and that is the typical calculation method for VIX.

But what happens when the market crashes

People are paying higher prices, insurance. Pushes the put price up which actually increases



start with the black-scholes model

Numerical exercise over the winter (**Open question:** complete it).
