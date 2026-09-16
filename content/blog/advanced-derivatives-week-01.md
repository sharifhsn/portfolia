+++
title = "Bond Pricing, Duration, and DV01"
date = 2025-01-30
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Bonds","Yield Curves","Bond Pricing","DV01","Duration","Convexity"]
+++

## Final Exam

Take-home exam format, 24/48 hours, lots of writing code, during finals week.

## Fixed Income Instruments

If a company wants money, it has options. It can issue stock, get a bank loan, or issue a bond.

What is the cost of borrowing money?

What determines this cost?

One such characteristic is that it can be determined by the market. If more people want to lend money at a certain maturity, it can lower the interest rate, with money being the commodity.

This rate is determined by the central bank, which has influence on short-term borrowing. Some governments can determine the cost of borrowing.

When a particular entity wants to borrow money, it depends on rating score. There’s a probability they don’t pay back, that’s risk.

Inflation also plays a role in long-term expectations.

### Money and Bond Markets

The main factor in the variability is the interest rates. The bonds and rates have an inverse relationship.

You can see every fixed income instruments as a stream of known (or rather contingent) cash flows.

The interest rate is not a single interest rate for a particular maturity.

If you look at Bloomberg, you will have many different rates that are associated with the Treasury, individual corporate entities, and so forth.

The money market is traded with banks and corporations. Cash flow delivery can be done up to 13 months. Can be done in cash, short-term securities. Deposits, T-bills, CDs, commercial paper, OR repo agreements. There’s a contract to repurchase a security sometime in the future, which will correspond to a rate.



There’s an interbank and eurocurrency markets. Banks are required to keep a percentage of deposits as reserve with their local Federal Reserve bank. Basically the banks will borrow reserves from each other overnight to avoid falling below this threshold. The effective federal funds rate is determined by the market, and influenced by the Federal Reserve, the open market operations.

Also, there’s a reference rate, the SOFR (Secured OVernight FInancing Rate), this is a broad measure of the cost of borrowing cash overnight, which is collateralized by treasury securities. For a long time LIBOR was taken as a reference rate, SOFR has replaced it. SOFR is an evaluated median of transaction medium, repo data collected by the Bank of New York.

The methodology is a little more complicated but this is a 50th percentile of volume. LIBOR was the rate at which banks were willing to loan to each other at. They didn’t necessarily have to have the transaction, they just had to post a quote. SOFR is data-driven.

Many fixed income securities like government bonds, agency debt, municipal debt, etc.

### Creditworthiness

Some interest rates we might consider to be risk-free, like treasuries or US government agency securities.

There are also low-risk instruments, floating coupon bonds indexed by floating rate, swaps, futures, forward rate agreements. Here the idea is, by looking at the market, you’ll be able to find many such rates. So the yield curve you’ll find is not necessarily unique, here’s one for treasuries, corporate bonds, etc.

Here we’re going to look at the construction of such yield curves.

## Bootstrapping Yield Curve

### Definitions

A **coupon paying bond** is a contract that pays a fixed coupon at future times. Typically this is given in terms of the annual rate, like 5% per annum. Such coupon is based on the principal amount of the bond. This is paid with a certain frequency. This coupon bond has the cash flow of the reimbursement of the notional value of the bond.

#### Example

Let’s say we have a bond that pays 5% annual coupon with T \= 5 years until maturity.

Let’s assume that the principal P \= $100. The cash flow diagram is very simple, with cash flows of $5 at each year after year 0, and then the max cash flow at the end.



The **zero coupon bond** for a maturity t guarantees the payment of one unit at maturity. This is important because we use this extensively. The price of a zero coupon bond paying $1 at maturity t is called the **discount factor**, d(t) or P(t, T), the price of a bond maturing at T at time t.

In general, the price of zero coupon is less than 1\. As the maturity of the contract increases, its value decreases. If you take

$$\\frac{\\partial P(t, T)}{\\partial T} \< 0$$

A **par coupon bond** is worth par, 100% of the notional. This is c(t).

A **forward rate agreement** is a commitment to lend money at a specified future rate for a specified period time. The rate of a forward loan is called forward rate. The forward rate is f(t) from t \- 1 to t.

A **floating rate note** is a contract ensuring payment of a floating rate at future dates and pays a last cash flow reimbursing the notional at T.

 A **swap** pays fixed for floating to exchange periodic interest payment.

### Bond Pricing

If you just observe the prices of the bonds, it doesn’t contain enough information to know value. You also have to compare the return holding the bond. One measure of the performance is the **Yield to Maturity**. This is the rate of return on a bond if it is held to maturity.

This is expressed as an annual rate. It’s important to understand the frequency of the rate to compare fairly. Based on current price we can compute a discount rate such that the PV of the future bond cash flows match the current price.

The constant discount rate represents the yield of the bond.

#### Example

Consider a coupon bond with 4 years to maturity at 10% annual coupon rate. Assume current bond price is $90. What is YTM?
By definition, price is PV \= 90\. Typically you take the notional in these to be $100. Therefore the price is

$$90 \= \\frac{10}{1+y} \+ \\frac{10}{(1+y)^2} \+ \\frac{10}{(1+y)^3} \+ \\frac{10}{(1+y)^4} \+ \\frac{100}{(1+y)^4}$$

Solve for y \= 0.1338 \= 13.38%

This would be the yield of this bond. If the bond price is equal to the principal then what is the yield?

$$100 \= \\frac{10}{1+y}...$$

Then y \= 0.10 \= 10%. So then the yield is the same as the coupon rate when the bond is par.

### Clean/Dirty

Clean price, also known as quoted price, is the price of the bond excluding interest that has accrued since issue or the most recent coupon payment. So the price of the bond is supposed to include this accrual of the value of that bond. However, it is not quoted with this accrual, so the clean price is quoted. Otherwise you would have to adjust rates continuously.

Dirty price, also known as cash price, is the price of a bond which includes the accrued interest. Let’s look at some calculations

#### Example

Consider buying a 3-year 12% annual coupon bond. (30/360 day count convention), 360 days and 30 days in a month, within one month from the first coupon. What is the YTM?

The coupon value is c. Then the final cash flow is 100 \+ c.

Let’s say you buy at time t which is before t1, one month before t1 the first coupon payment. There is some accrued interest at time t. The formula is the same, with the cash flows discounted to the time t. What is the accrual in this case? It’s of 11 months, which by our convention is 330/360 \* c. The coupon is 12% of the principal 100, therefore 12, so 330/360 \* 12 \= 11\.

We can say as a general formula that

$$Dirty Price \= Clean Price \+ Accrued Interest$$

$$100 \+ 11 \= \\frac{12}{(1+y)^{\\tfrac{30}{360}}} \+ \\frac{12}{(1+y)^{\\tfrac{390}{360}}} \+ \\frac{112}{(1+y)^{\\tfrac{750}{360}}}$$

Using a solver, you can find that y \= 11.97%.

The quotations would have to adjust continuously. Dirty prices can be reported but they are not typically quoted.

### Sensitivity to Yield

Consider a fixed income instrument with price P and yield Y.

We will define DV01 as the dollar value of one basis point.

$$DV01 \= \-\\frac{\\Delta P}{10,000 \\cdot \\Delta y}$$

Negative means that as one increases, the other decreases.

We also have **duration**, which is

$$D \= \-\\frac{1}{P} \\cdot \\frac{\\Delta P}{\\Delta y}$$

and **convexity**

$$C \= \\frac{1}{P} \\cdot \\frac{\\Delta^2 P}{\\Delta y^2}$$

This is written as a difference, but you can generalize this as a derivative.

You can approximate the rate of change of the price of a bond as being dependent on the duration and convexity with a formula combining them.

#### Example 1

Consider a 1-year zero coupon bond with annual yield y. What is the relationship between P and y?

$$P \= \\frac{1}{1+y}$$

Then using our formula for DV01, we get

$$DV01 \= \-\\frac{1}{10,000} \\frac{dP}{dY}$$

We can use the quotient rule (or chain rule\!) to take the derivative, which results in

$$= \\frac{1}{10,000(1+y)^2}$$


