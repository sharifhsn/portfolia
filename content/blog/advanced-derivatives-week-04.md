+++
title = "Interest Rate Adjustments and Currency Swaps"
date = 2025-02-20
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Interest Rate Derivatives","Convexity Adjustment","Timing Adjustment","Change of Numeraire","Currency Swaps"]
+++

## Adjustments

We may have to make some adjustments when we value interest rate derivatives. These are convexity, timing, and quant adjustments. We will see when it is appropriate to make these adjustments.

## A general two-step procedure for valuing a European style derivative

First, calculate the expected payoff by assuming that the expected value of each underlying variable equals its forward value.

Then, we discount it based on the interest rate.



For non-standard interest rate derivatives, we need to modify the first step with adjustments to the forward value



If you look at the forward yields and forward prices, this kind of convexity adjustment may be necessary to make when the derivative is dependent on the yield of the bond. Basically, we define the forward yield on a bond as being the yield calculated from the forward bond price.

There is a non-linear relationship between bond yields and bond prices.

It follows that when the forward bond price equals the expected future bond price, the forward yield does not necessarily equal the expected future yield, you cannot have both.



Suppose:

B\_T \= price of a bond at T

y\_T \= yield of a bond at T

We have a relationship here that we can write as

B\_T \= G(y\_T)

where G is a nonlinear function

F\_0 \= forward bond price at time 0 for a transaction maturing at time T

y\_0 \= forward yield at time 0



We have a relationship where F\_0 \= G(y\_0)

![Hand-drawn bond price and bond yield curves from the source notes.](/static/img/advanced-derivatives-week-04-bond-price-yield.png)

If we make our forward equivalent to the expected future bond price, then

$$F\_T \= \\mathbb{E}\[B\_T\] \= B\_2$$

Then our yield is

$$\\mathbb{E}\[y\_T\] \= \\frac{1}{3} \\sum\_{i=1}^3 y\_i$$

Such value is going to be greater than y\_2.

## Convexity Adjustment

Since we are incorporating convexity, we will adjust the expectation of the yield

Suppose that the payoff from a derivative at time T depends on the bond yield observed at T.

Define

y\_0 \= forward bond yield for a contract maturing at T

y\_T \= bond yield at T

B\_T \= price of bond at T

σ\_y \= volatility of forward bond yield

We have the relationship previously expressed that

B\_T \= G(y\_T)

One thing we can do is expand G(y\_T) in a Taylor series about y\_0.

Here we can write

\\(B_T \\approx G(y_0) + (y_T - y_0)G'(y_0) + \\tfrac{1}{2}(y_T-y_0)^2 G''(y_0)\\)

I can take the expectation of both expressions, left and right, in a world that is forward risk neutral with respect to a zero-coupon bond, maturing at T.

$$\\mathbb{E}_T[B_T] = G(y_0) + \\mathbb{E}_T[y_T - y_0]G'(y_0) + \\frac{1}{2}\\mathbb{E}_T[(y_T-y_0)^2]G''(y_0)$$

What is G(y\_0)? F\_0, the forward bond price.

We would say the forward is the expected value. But this assumption does not work for the yield. Let us assume anyway.

F\_0 \= E\_T\[B\_T\]

Now let’s crack this apart.

We can see that y\_T \- y\_0 is a constant.

Also, E\_T\[(y\_T \- y\_0)^2\] \= σ\_y^2 y\_0^2 T. Not sure why… maybe something to do with quadratic variation? I will post the proof online, using Itô’s lemma.

$$\\mathbb{E}_T[y_T] = y_0 - \\frac{1}{2}y_0^2 \\sigma_y^2 T \\frac{G''(y_0)}{G'(y_0)}$$

This ½ term is considered the “convexity adjustment”.

It’s the difference between the expected bond yield and the forward bond yield at t=0.

Let’s assume that we have a GBM, and that we have a numeraire at time T.

Suppose that the growth rate of forward bond yield is denoted by α and its volatility $$\\sigma\_y$$. For example, we can use Itô’s lemma to calculate the process for the forward bond price.

$$dy \= \\alpha y dt \+ \\sigma\_y y dW$$

From Itô’s lemma we get

$$
d[G(y)] = [G'(y)\\,dy + \\frac{1}{2}G''(y)\\sigma_y^2y^2]dt + G'(y)\\sigma_y y\\,dW
$$

Given that the expected growth rate of G(y) is zero,

We can find that

$$G'(y) \\alpha y + \\frac{1}{2} G''(y) \\sigma_y^2 y^2 = 0$$

or

$$\\alpha = -\\frac{1}{2}\\frac{G''(y)}{G'(y)} \\sigma_y^2 y$$

which results in our final convexity adjustment.

## Applications for Interest Rate Derivatives

Consider an instrument that provides a cash flow at time T equal to the interest rate between T and t\* applied to principal L.

The cash flow at time T is going to be equal to the principal and rate and tau

$$LR\_T\\tau$$

where τ is T\* \- T.

In order to apply this convexity adjustment, we have the relationship between price and yield. For a ZCB, G(y) is

$$G(y) \= \\frac{1}{1+y\\tau}$$

From the previous equations, the expected value of such a rate is

$$\\mathbb{E}_T[R_T] = R_0 - \\frac{1}{2}R_0 \\sigma_R^2 T\\frac{G''(R_0)}{G'(R_0)}$$

or, if you take the derivative of such expectations, you get

$$\\mathbb{E}_T[R_T] = R_0 + \\frac{R_0 \\sigma_R^2 \\tau T}{1 + R_0 \\tau}$$

where $$R\_0$$ is the forward rate applicable between T and T\*.



Then the present value of the instrument is

$$P(0, T) L \\tau \[R\_0 \+ \\frac{R\_0 \\sigma\_R^2 \\tau T}{1 \+ R\_0 \\tau}\]$$

## Numeric Example of Convexity Adjustment

An instrument:

payoff in 3 years equal to 1 year zero coupon rate multiplied by $1000

vol is 20%, yield curve is flat at 10%, annual compounding,

convexity adjustment is 10.9 bps.

Value of instrument is 75.95

If we have T \= 3, T\* \= 4, τ \= 1, R\_0 \= 0.10, σ\_R \= 0.20

Value of derivative is

$$1000 \\times 1 \\times \[0.10 \+ \\frac{0.10^2 \\cdot 0.20^2 \\cdot 1 \\cdot 3}{1 \+ 0.10 \- 1}\]$$

And you also have to discount the payoff, the yield curve is flat so it ends up being

$$\\frac{1}{1.10^3}$$

## Convexity Adjustment for Swap Rate

The adjustment is for the life of the swap. The derivative is on the swap observed at T, the life is from T to T \+ τ. What is different here? Just the reference instrument.

A direct application

Swap rate is approximated as the yield on a 12% bond.

$$G(y) \= \\frac{0.12}{(1+y)} \+ \\frac{0.12}{(1+y)^2} \+ \\frac{1.12}{(1+y)^3}$$

$$G'(y) = -\\frac{0.12}{(1+y)^2} - \\frac{0.24}{(1+y)^3} - \\frac{3.36}{(1+y)^4}$$

Furthermore,

$$G''(y) = \\frac{0.24}{(1+y)^3} + \\frac{0.72}{(1+y)^4} + \\frac{13.44}{(1+y)^5}$$



In this case, the forward yield y\_0 \= 0.12.

G'(y_0) = -2.4018; G''(y_0) = 8.2546.

Then plug it into the convexity adjustment equation:

will get you 0.1236, 12.36%

Therefore the value of the instrument is

The basic procedure is to find the nonlinear function G, then take its derivatives, then plug the parameters in to this equation.

## Timing Adjustment

Consider a case where a market variable **v** is observed at time T and its value is used to calculate the payoff that occurs later at time T\*.

Define

v\_T \= value of v at time T

$$\\mathbb{E}\_T\[v\_T\]$$ \= the expected value of v\_T in a world that is forward risk neutral (FRN) with respect to P(t, T)

$$\\mathbb{E}_{T\*}[v_T]$$ = the expected value of v_T* in a world that is forward risk neutral (FRN) with respect to P(t, T\*)

$$w \= \\frac{P(t, T\*)}{P(t, T)}$$ the ratio of the ZCB at different times, equal to the forward price of ZCB from T to T\*.

σ\_v \= volatility of v

σ\_w \= volatility of w

ρ\_vw \= correlation between v and w

So then what is this expectation at T\*?

$$\\mathbb{E}\_{T\*}\[v\_T\]$$

## Change of Numeraire

One way to look at this is by discussing the change of numeraire, what is the impact of that, if we’re following the market variable?

Assume that the variable is the price of a traded security **f** in a world where the market price of risk is λ\_i.

$$df \= \[r \+ \\sum\_{i=1}^n \\lambda\_i \\sigma\_{f,i} \]fdt \+ \\sum\_{i=1}^n \\sigma\_{f, i} dW\_i$$

When market price of risk is λ\_i\*

$$df \= \[r \+ \\sum\_{i=1}^n \\lambda\_i\* \\sigma\_{f,i} \]fdt \+ \\sum\_{i=1}^n \\sigma\_{f, i} dW\_i$$

Then what is the effect of moving from the first world to the second world (star world)? The expected growth rate of price of any traded security f.

$$\\sum\_{i=1}^n (\\lambda\_i\* \- \\lambda\_i) \\sigma\_{f, i}$$

Define $$w \= \\frac{h}{g}$$

## Quantos

Derivatives where the payoff is defined using variables measured in one currency, and paid in another currency. Essentially this represents the exchange rate. It’s very similar to the timing adjustment.

No adjustment is necessary for vanilla swap, cap, or swaption.

## Skipped Nonstandard, rest of stuff…

## Currency Swaps

A swap for LIBOR in two currencies is theoretically worth 0\.

However, this will have a spread in the exchange typically.

So we need to adjust for this.



There are also more complex swaps. They cannot be valued by assuming that forward rates will be realized.

LIBOR-in-arrears swap,

constant maturity swaps (CMS/CMT)

### LIBOR-in-arrears

Rate is observed and paid at time T, not T\*. Convexity adjustment to each forward rate underlying the swap.

This one is dependent on time when you have resets.

![Handwritten sketch from the Week 4 source notes.](/static/img/advanced-derivatives-week-04-rate-adjustment.png)
