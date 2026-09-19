+++
title = 'Bonds and the Time Value of Money'
date = 2024-10-10
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Bonds', 'Time Value of Money']
+++

#### Bond Fundamentals

We started with the foundation, risk-reward trade offs, portfolios. Then we moved to quantitative analysis on individual assets. Mostly we have focused on a single game, a single price. But now we can think we have covered quantitative analysis. We are now going to the third book, the financial products and instruments. This would be for the non-finance people. We’re not going to flip any coins right now. In session 5 we will be flipping coins and doing finance, that’s derivatives.

Bonds give us a nice intuition, they have a lot of data. Risk is a function that goes down. Duration tells us the sensitivity of the instrument to a certain factor, in this case we will say interest raete risk. Then when we go to portfolios, we will study that.

Bonds will help us understand valuations as well.

Risk management starts with asset pricing. Seems to make sense. We can look at the sensitivity, quantify the risk. Let’s think about bonds. What are bonds subject to? Interest rates. If interest rates go up, bond prices go down. How would I price something? Think about what happened during the COVID days. Interest rates were near zero, so tech companies did well. They have cash flows coming in the future, and their assets are subject to some valuation. A simple way to think about it is the value of a payment in the future today, discount cash flow. Now we need to think, whatever will happen in the future, what is the value today? And that is the time value of money.

If you have a friend that wants to give you $100, it’s better to get it now than to get it five years from now.

We think about duration as having the beta when it comes to bonds. We have a linear risk exposure, and it tells us how much risk there is.

What is a bond? It’s a debt. We have the borrower and the lender. The lender gives the money to the borrower, and the borrower returns the money plus interest. If there is a chance that your money will not come back, you will not lend your money to anybody, so interest rates compensate for that. Let’s assume that there’s no credit risk. I’ll lend money for a year. What if I didn’t lend that money? What else could I do with it? I could invest it in a risk-free investment and would get some interest. So why would I lend that money unless the return was at least that good?

Prices also go up over time. Think about consumption. I can get 100 apples for $100 at Stevens. One year from now, the apple will become $2. If someone gives me $100 in the future, I could only buy 50 apples. If we froze the apples, we were able to acquire more apples because we bought them now.

An entrepreneur is able to increase their equity by getting a million dollar loan and improve their business. The lender is happy to lend to them because the entrepreneur pays them back. It’s a win-win situation. Financial instruments can give you situations like this. In no arbitrage pricing situations, it’s a game, so what is the fair price?
Stevens issued a bond of $200 million to build the towers, and helped raise capital. You can also have municipal bonds from Hoboken. Between these two parties of the borrower and the lender, you might have a one-time exchange, or you might have a coupon, a periodic payment. The face value of the bond, the principle, is the main course at the restaurant. The coupons are the appetizers. This keeps the lender happy because they just want the passive income from the bond.

I have a pricing equation which denotes

\(P_0 = \sum_{t=1}^T CF_{s,t} \times \mathbb{P}(s_t) \times \frac{1}{(1 + y)^t}\)

We will assume for simplicity right now that the probability of the return \(\mathbb{P}(s_t)\) is always 1.

If you have to pay back $100 for $50, that’s 100% interest.

Bonds are considered fixed-income, because they give based on contractual agreement. We get yields based on how many investors are buying them. Unlike a stochastic process, when you start getting close to time T, things get interesting. The value of the bond approaches the face value.

You can think about it as the yield \(y\) on an investment/bond as well. We also call this the IRR (Internal Rate of Return) or EAR (Effective Annual Rate). What is the return on my investment of the bonds?

\(P_0 = \sum_{t=1}^T \frac{CF_t}{(1+y)^5}\)

People started trading today, and at the end there’s a closing price. By contract, we know the bond is a payment over 30 years, and bloomberg reports the yield on this investment. We get a small coupon on 2 year bonds, but we get a high r price and a lower yield. 30 years is much better.

These bonds will pay you yields on an annual (European) or semi-annual (American) basis. This becomes

\((1 + y) = \left[1 + \frac{y_2}{2}\right]^2\)

Let’s give an example. If we have the yield of 0.1 and an investment of 1, our investment will go from 1, to 1.1, to 1.21, to 1.31…

Now let’s go for semi-annual. We will multiply by 1.05 every six months, which means that every year we will multiply by 1.1025. This is a little more.

Now what if we do continuous, and exponential growth.

\(\lim_{d \rightarrow \infty} \left(1 + \frac{y(d)}{d}\right)^d = e^{y(c)}\)
Before we talked about geometric Brownian motion, where we have a process that grows, a continuous differential time drift.

The question is what investment would give you the highest EAR. If they all have the same interest, then the answer is continuous compounding.

You can use the rule of 72 to determine how long it takes for an investment to double the investment. The number of years multiplied by the interest rate should be around 72.
