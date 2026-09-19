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

### Lecture Notes

#### Prof’s Paper

The Economic Value of Mean Squared Error: Evidence from Portfolio Selection

What’s the intuition? Everyone talks about optimization, rational agents doing the best they can. A colleague told the president of Stevens that it’s all cost benefit analysis. The question is how you measure that. We know we have model risk, you get \(\hat{w}\) never \(w^*\), only an estimate. Expectation vs reality. We’ll never get to that target. There will always be some loss.

How do we mitigate that discrepancy. Instead of trying to shrink the y-axis, you actually work with the x-axis, which is where the MSE comes from. If you want to handle this model risk ex ante, before you start, you apply this to the portfolio selection problem.

We’ll eventually show that there’s a linear relationship between MSE and decision loss.
What made this paper more interesting is that, everyone talks about ML, prediction, optimization. And there’s interesting literature on those issues.

On the website.

#### Bond

The book is very qualitative, and it talks about LTCM. It talks about the 10 days value at risk, which is too high. Chapter 14 Model Risk is a very interesting big picture chapter.

We know what compounding is.

#### Fixed Coupon Bond

A fixed coupon bond, e.g. corporate treasury bonds, will issue you coupons regularly over time.



You will pay today \(-P\) at time 0. Then you will get appetizers, some coupon \(c\). And then on the time of maturity, you’ll get another appetizer and then the major face value dinner \(c + F\).

The total cash flow is \(c \cdot T + F\)

But this is not discounted. So this value is definitely less than \(P\).

For our risk-free rate \(y\), we get

\(P_0 = c \times F\sum_{t=1}^T \frac{1}{(1+y)^t} + \frac{F}{(1+y)^T}\)
And the nice closed form solution

\(P_0 = \frac{c}{y} \times F\left[1 - \frac{1}{(1+y)^T}\right] + \frac{F}{(1+y)^T}\)

which comes from the fact that this is a geometric series.



Greeks help you understand the sensitivity of the solution.

We can get some analytical insights here because of the closed-form nature of Black-Scholes.



A bond is called selling at par, if the current price is equal to the face value.

If we think about the derivative with respect to y, it might not look so nice. But it actually ends up looking like a nice graph with a downward slope. And that’s because when interest rates go up, bond prices go down.



What’s actually being done to calculate this? You don’t want bond yields to go up, that means people are selling more bonds. When people buy more bonds, the yields go down, which is good.



You are inferring the yield from these prices. Before we took the yield for granted, but that’s not what you actually do.

The current yield is calculated by the annual coupon rate divided by the **current** market price. The yield to maturity



Campbell Harvey talks about how the inversion of the yield curve predicts a recession. Why does this occur? Let’s think about this from a risk management point of view.

This means that there’s more pressure on the prices in the long term.

During a recession, the central bank will have a soft landing by lowering interest rates. What the market is doing, they look at information. When they are holding treasury bonds with a longer maturity, you can think of it as a simple discounting factor.



If we have a bond that pays an annual coupon of 8%, and a YTM of 6%, then the price will actually decrease after a year. And this is because the appetizers are really good, so if you miss out on one then the bond will become less valuable.



We can think of an asset that pays a continuous rate over time which is reflected by GBM, which would give you the same idea.

#### LTCM



Great book about bonds. [Liar’s Poker](https://www.amazon.com/Liars-Poker-Norton-Paperback-Michael/dp/039333869X) he describes the strategies when it comes to mortgages, prepayments. Mortgages were bailed out and a lot of trading strategies developed around that. And that helps you understand the price of these instruments.

The nice thing about fixed income

Long-Term Capital management (LTCM) was a hedge fund formed in the mid-1990s. All the main people like Scholes were a part of this. They had huge returns in their first year, then they got into international bond pricing, and then Russia defaulted which caused almost all of their bonds to fail. And the banks bailed them out. From [When Genius Failed](https://www.amazon.com/When-Genius-Failed-Long-Term-Management/dp/0375758259). Three main players, two academics Merton and Scholes. John Merriwether traditional trader as well. Classic case of FRM. We had premium bonds and discount bonds. We’ll find treasury bonds domestic and foreign with the same maturity, coupons, same characteristics. So their price should be the same. LTCM went long on the cheaper ones and short on the more expensive ones, to exploit this arbitrage. Russia defaulted and they went bust. Goldman, Chase, Lehman helped break it up, but the Fed stepped in and bailed them out.

The reason that there was a divergence between those bonds to begin with was th liquidity of the bonds to begin with.

#### Interest Rate Risk

All bonds are subject to interest rate risk. The major question is what happens if yields go up? They keep moving, which causes prices to go up and down. It comes down to monetary policy, where an investor or risk manager should proactively think about how it impacts your portfolio.

Think about it from the CAPM the single risk factor is the market. The same argument is here, that the systematic risk is the interest rate risk.

We’re at a 5% interest rate, what happens if the interest rate goes up? My bond price goes down. But I want to map those basis points into an actual risk measurement.

Let’s try to do a first-order approximation for this function. This goes to **duration risk**, or **price sensitivity**. The bond price is a function of yields.
\(P_0 = f(y)\)

We want to know how the price will change when we get

\(f(y + \Delta y)\)
Let me do a Taylor expansion. I start with the price at the initial point \(P_0\), which is \(f(y_0)\). Then what else do I have? I have the first derivative with respect to that yield curve.

\(P_1 = P_0 + f'(y_0) \times (\Delta y) + \frac{1}{2} f''(y_0) \times (\Delta y)^2\)
If we ignore that second derivative, just looking at first-order, we see

\(P_1 - P_0 = f'(y_0)\Delta y\)

Now we can find our change of price for a given change in yield. That’s the *sensitivity*, and therefore the exposure.

This derivative is called the **duration**.

\(f'(y_0) = -DD = -D^*P_0 = -\frac{D}{1+y} P_0\)

These different Ds are different measures of duration. DD is the Dollar Duration, the notional amount. D\* is the modified duration. That duration is a nonnegative measure, so we make it negative to express the inverse relationship between yield and bond price.

The analytical solution is quite difficult, you can look it up on your own, so we’ll just look at the numerical solution.

The Macaulay duration, which is D, is actually more intuitive. It can be computed as

\(D = \sum_{t=1}^T w_t t\)

\(w_t = \frac{CF_t / (1+y)^t}{P_0}\)

Let’s go back to the definition of the fixed coupon bonds. What’s the risk?

Each coupon gets its own weight. It takes me time to recover my investment. The weight at time t, I’m getting a cash flow one year from now. After taking into account the time value of money, how much money did I recover from that first cash flow. I want to think about this as, I put money away, how long does it take for me to receive money, and then how long to get back my full investment.



We can see that macaulay duration equals maturity. This is easy to see when we have zero coupon bonds. It doesn’t matter what the yield is, it’s just maturity.



The higher the yield, the lower duration is. There is less weight assigned to the distant future. If you live in an environment with much higher yield, you can reinvest that as compounding.



Frequency matters because you have more coupons. And if you get more coupons, that means you have a lower duration.

If you have no coupons, that means you have a very long duration.



You can have these sensitivities for options as well, these are the Greeks.



Second order sensitivity for bond price is **convexity**. Duration is expected value of time, convexity is the second moment of time.



Convexity has w\_t, which is scaled by the discount factor squared. It gives you an approximation for the true value of the price.

#### Portfolio Duration and Convexity

I want to meet certain duration targets in my portfolio.

The market is expecting the interest rate to drop by 25 bps. That means you want to increase your duration, which is your exposure to the yield. If you work with modified duration, it’s the same as a beta, it’s a weight for each asset, in terms of exposure.
Portfolio duration (modified duration) is just the average of the duration of each of your bonds, modified by their weights.

The way you solve the bond portfolio problem is by defining it as a matrix multiplication, where the matrix of the bond durations is inverted and multiplied by the intended portfolio duration, and the resultant vector should be the weights.

The least squares solution comes into the picture if you have multiple bonds, not just two. You can do a generalized inverse on an e.g. 2x4 matrix and then solve it that way.
