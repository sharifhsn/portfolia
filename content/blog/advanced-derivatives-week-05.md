+++
title = "Constant Maturity Swaps and Short-Rate Models"
date = 2025-02-27
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Constant Maturity Swaps","Short Rate Models","Vasicek","Cox-Ingersoll-Ross","Hull-White"]
+++

## Continuing Adjustments

Timing and quanto adjustments, we also looked at nonstandard swaps, LIBOR for LES? Another kind of nonstandard swap is…

## Constant Maturity Swaps (CMS)

The definition of a CMS is

**an interest rate swap where the floating rate equals the swap rate for another reference swap for a certain life**



If you want to write an example, here you can say

floating payment on a CMS can be made every six months at rate equal to 5-year swap rate.



The frequency of this CMS rate must be smaller than the reference rate. Usually the swap rate is equal to a previously observed swap rate.



Furthermore, if we assume that we have reset dates \\(t_0, t_1, t_2 \\ldots\\)

And payment dates: \\(t_1, t_2, t_3 \\ldots\\)

We will also consider L \= notional principal

What is going to be the floating payment? At \\(t_{i+1}\\), this would be the

swap rate \\(s_i\\) applied to the principal for a period \\(\\tau_i\\)

$$
\\tau_i L s_i
$$

where \\(\\tau_i = t_{i+1} - t_i\\)



Now we have to do some adjustments. The convexity adjustment is, the frequency of these coupons is going to be the same as the bonds.



We will also have to do a timing adjustment, a combination of these two. If you apply these to another currency, then we will also have a quanto adjustment.



Let’s say \\(y_i\\) is the forward value of the swap rate.

By using a convexity/timing adjustment.



We can say the **realized swap rate** is assumed:

$$
y_i - \\frac{1}{2} y_i^2 \\sigma^2_{y_i} t_i \\frac{G_i''(y)}{G_i' (y)} - \\frac{y_i \\tau_i F_i\\rho_i \\sigma_{y,i} \\sigma_{F,i} t_i}{1 + \\bar{T}_i \\tau_i}
$$

where

\\(\\sigma_{y, i}\\) is the volatility of the forward swap rate

\\(F_i\\) is the current forward interest rate between \\(t_i\\) and \\(t_{i+1}\\)

\\(\\sigma_{F, i}\\) is the volatility of the forward rate

\\(G_i(x)\\) this is basically the price of a bond which pays at time i, the same amount as the reference swap.

The forward rate will be implied by the “Kaplan?” prices.

\\(\\rho_i\\) the correlation can be estimated from historical data.

### Example

6 year CMS swap (life of swap is 6 years)

5 year swap rate is received, fixed rate of 5% is paid on notional $100M

exchange of payments is semiannual, on both 5-year underlying swap and on CMS swap.

The exchange rate on the payment date is determined from the swap rate on the previous payment date.

The term structure is flat at 5% per annum with semiannual compounding. (that’s where the timing adjustment comes in)

The volatility of the options on five-year swaps have 15% IV (\\(\\sigma_{y, i}\\)) and in this simplified problem we’ll say caplets with 6 month tenor have a 20% IV. The correlation \\(\\rho_i\\) between each cap rate and each swap rate is 0.7



The fixed rate \\(y_i\\) is 0.05. This is semiannual payment, so \\(\\tau_i = 0.5\\). Given volatility \\(\\sigma_{F, i} = 0.20\\). Then the forward rate is also \\(F_i = 0.05\\) from the term structure, and the correlation given is \\(\\rho_i = 0.7\\).

Then what is the relevant function G in this case?



We have the reference rate which is a 5 year swap rate, which has a semiannual payment.



We can express this as a bond, so a sum of coupons. The 2.5M is the coupon payment (halved

$$
G_i(x) = \\sum_{i=1}^{10} \\frac{2.5}{1 + \\tfrac{x}{2})^i} + \\frac{100}{(1 + \\tfrac{x}{2})^10}
$$

Then the derivative is

$$
G_i'(y_i) = -437.603, G_i'' (y_i) = 2261.23
$$

Then the total convexity/timing adjustment is, \\(0.0001197t_i\\)

We’re going to have different values, so for example the 5 year swap rate t \= 4 should be assumed to be 5.0479% instead of 5%.

Therefore the net cash flow at t \= 4.5 should be 0.5 \* 0.000479 \* 100M.

Then we can calculate for all these cash payments, the value of the CMS

## Models of the Short Rate

There are different specifications of such models. The models presented so far in our previous discussions make the assumption that the probability distribution of variables (interest rates, bond prices, …) are log normally distributed. That allows us to use Black’s model.



There are some issues with this kind of approach.

- These models do not provide a description on how the interest rates evolve in time, just the underlying distribution.
- Cannot be used to value American style options.

In this lecture, we will discuss the **“term structure model”**. Such interest rate model will describe the evolution of all zero-coupon interest rates, a little more general.



We will focus on some classical models.

The behavior of the **“short-rate”** or instantaneous short rate. This rate is considered in a risk-neutral world. Basically, that means in a very short period of time, between t and \\(t + \\Delta t\\), investors earn \\(r(t) \\Delta t\\), the risk-free interest rate.

For example, the dollar money market account is a security that is worth $1 at time 0 and earns the instantaneous risk-free rate r at any given time. This r may be stochastic.

Furthermore, if g equals the money market account, then the process \\(dg = rg dt\\). Here we can see that the r the risk-free rate can be stochastic, so this will be the drift of g being stochastic, with volatility being 0\.

We saw last lecture that

\\(\\frac{f}{g}\\) is a martingale in a world where the market price of risk is 0.



Therefore the expected value is

$$
f_0 = g_0 \\hat{\\mathbb{E}}[\\frac{f_T}{g_T}]
$$

Then if you take g as the money market account, then by definition

$$
g_0 = 1
$$

And for \\(g_T\\)? You might expect the e^rt general, but because this is stochastic, we express this as

$$
g_T = e^{\\int_0^T r dt}
$$

Therefore, the expectation of f at T must be discounted

$$
f_0 = \\mathbb{E}[f_T e^{-\\int_0^T r dt}]
$$

You could also express this as

$$
f_0 = \\hat{E}[e^{-\\bar{r}T} f_T]
$$

where \\(\\bar{r}\\) is the average value of r.



## Interest Rate Derivative Valuation

A regular way to value an interest rate derivative, typically these will follow these steps:

1. Simulate short-term interest rate paths. (in some cases we will have closed-form solutions, but generally we simulate)
2. Calculate expected payoff on these paths.
3. Discount at average value of short rate on the sampled path.

In general, the value at time t of an interest rate derivative is based on providing a payoff \\(f_T\\) at time T

$$
\\hat{\\mathbb{E}}[f_T e^{-\\bar{r}(T - t)}]
$$

Basically you calculate the value of such derivatives between t and T.

Furthermore, if you refer back to \\(P(t, T)\\) for the price function at time t of a ZCB with payoff of $1 at time T, we can say that

$$
P(t, T) = \\hat{\\mathbb{E}} [e^{-\\bar{r}(T - t)}]
$$



Now we will make connection to the interest rate.

Generally, if R(t, T) is continuously compounded interest rate at time t, for a term (T \- t), then we can say

$$
P(t, T) = e^{-R(t, T)(T - t)}
$$

then we can rearrange as

$$
R(t, T) = -\\frac{1}{T - t} \\ln P(t, T)
$$

Then finally we will arrive at the relationship

$$
R(t, T) = -\\frac{1}{T-t} \\ln \\hat{\\mathbb{E}}[e^{-\\bar{r}(T-t)}]
$$

This equation is what enables the calculation of the term structure of the interest rate at any given time.

Based on the description of the risk-free rate, which may be stochastic, can help you describe the entire curve.

All the models we discuss will be models of this short rate, there are some models of the instantaneous forward, but generally they will be instantaneously spot. These classical models give descriptions of stochastic processes that the short rate will have this particular expression.

And this is the zero curve

## Equilibrium Models

Rendleman & Bartter, Vasicek, Cox Ingersoll & Ross

These models start with some assumptions about the economic variables, then the variable process from the short rate r. This will explore what the process for r implies about the bond prices and option prices. This model might be one factor, or two factor. We will look now just at one factor models.



In a one factor equilibrium model, the process for r involves only one source of uncertainty.

$$
dr = m(r) dt + s(r) dW
$$

This general specification, m(r) is the instantaneous drift, and s(r) is the instantaneous volatility (stdev).

For these models, m(r) and s(r) are *assumed* to be a function of r, but *independent* of time.

This is different from the no-arbitrage models.

Some of these models, historically, have been proposed. Some of them are not necessarily very good (lol).



### Rendleman and Bartter

$$
dr = \\mu r dt + \\sigma r dW
$$

Where \\(\\mu\\) and \\(\\sigma\\) are constant, it basically means that r follows GBM.

But this is bad because r doesn’t follow GBM.

These interest rates have some mean-reverting behavior, so that has to be included somehow. When r is high, it will tend to have negative drift, and when it’s low, it will tend to have positive drift.

Economic argument, high r will cause the economy to slow down, less borrowing, and vice versa. These models can also be calibrated, will be discussed next time.

### Vasicek

$$
dr = a(b - r) td + \\sigma dW
$$

where a, b, σ are constants. Here we can see the mean reverting component. In the long-run, the value, when r is small, it will be a positive number and increase, and vice versa. a is the speed of mean reversion, b is the mean.

This model has an analytical solution. Vasicek shows that if

$$
P(t, T) = \\hat{\\mathbb{E}}\\left[e^{-\\bar{r}(T-t)}\\right]
$$

then the price will be a function

$$
P(t, T) = A(t, T) e^{-B(t, T) \\cdot r(t)}
$$

This is a general form for the analytical solution to the Vasicek model, where

$$
B(t, T) = \\frac{1 - e^{-a(T - t)}}{a}
$$

$$
A(t, T) = \\exp\\{\\frac{[B(t, T) - T + t](a^2 b - \\tfrac{\\sigma^2}{2})}{a^2} - \\frac{\\sigma^2B^2(t, T)}{4a}\\}
$$

Gives you more flexibility, it’s an alternative.

There’s one more alternative…

### Cox-Ingersoll-Ross

$$
dr = a(b - r) dt + \\sigma \\sqrt{r} dW
$$

Again a, b, σ constants.

What is the advantage of this model? You can look at the evolution of term structure over time. It’s observed that as the interest rate changes, the volatility also changes. Therefore the model should include this behavior.

The price function for CIR has the same general expression as Vasicek:

$$
P(t, T) = A(t, T) e^{-B(t, T) r(t)}
$$

The functions are just slightly different. We will discuss the similarities and properties of these models.

$$
B(t, T) = \\frac{2\\left(e^{\\gamma(T-t)} - 1\\right)}{(\\gamma + a)\\left(e^{\\gamma(T-t)} - 1\\right) + 2\\gamma}
$$

$$
A(t, T) = \\left[\\frac{2\\gamma e^{(a + \\gamma)(T - t)/2}}{(\\gamma + a)(e^{\\gamma(T - t)} - 1) + 2\\gamma}\\right]^{2ab/\\sigma^2}
$$

where

$$
\\gamma = \\sqrt{a^2 + 2 \\gamma^2}
$$

Basically, it has an analytical solution.

### Properties of CIR vs Vasicek

A(t, T) and B(t, T) are different, but

P(t, T) is fundamentally the same general expression.

$$
\\frac{\\partial P(t, T)}{r(t)} = -B(t, T) \\cdot P(t, T)
$$
This function B can be used therefore as an alternative to duration.

From the rate expression,

$$
R(t, T) = -\\frac{1}{T - t} \\ln P(t, T)
$$
The zero rate at time t for a period T \- t is, if you take the natural log of this general AB expression, because it’s a product, you will get

$$
R(t, T) = -\\frac{1}{T-t} \\ln A(t, T) + \\frac{1}{T-t} B(t, T) r(t)
$$

Here in this case, the entire term structure can be determined as a function of r(t) *if* a, b, σ are known.

Here we define the modified duration of a bond Q.

$$
\\hat{D} = B(t, T)
$$

The shape is going to be a function of r(t), and dependent on t.

The duration of such bond

$$
\\frac{\\Delta Q}{Q} = -D \\Delta y
$$
If you consider that the yield of a bond.

Alternatively, the duration by Vasicek & CIR is

$$
\\frac{\\Delta Q}{Q} = - \\hat{D} \\Delta r
$$

or

$$
\\frac{\\partial Q}{\\partial r} = -\\hat{D} Q
$$

### Example

Let’s consider the zero-coupon bond lasting four years.

Duration s \= 4, so 10bps parallel shift in the term structure should lead to decrease of 0.4% in the bond price, this is the sensitivity of the model. If we use Vasicek’s model, with a \= 0.1, then

$$
\\hat{D} = B(0, 4) = \\frac{1 - e^{-0.1 \\cdot 4}}{0.1} = 3.29
$$

The duration is a function of the mean-reversion rate.

That means the short rate is 0.329%.

Can you calibrate a using the duration? Hmmmm.



Consider Q a portfolio of ZCBs (a coupon-bearing bond).

$$
P(t, T_i) (1 \\leq i \\leq m)
$$

\\(c_i\\) is the principal of the \\(i^{\\text{th}}\\) bond.

Then the duration of our portfolio is

$$
\\hat{D} = -\\frac{1}{Q} \\frac{\\partial Q}{\\partial r} = - \\frac{1}{Q} \\sum_{i-1}^m \\frac{\\partial P(t, T_i)}{\\partial r} c_i = \\sum_{i=1}^m \\frac{c_i P(t, T_i)}{Q} \\hat{D}_i
$$

Where we have \\(\\hat{D}\\) for a coupon bearing bond being the weighted average of the duration of the underlying ZCBs.

### Vasicek/CIR Pricing Example

Suppose we are given a \= 0.1, b \= 0.1. The initial short rate is 10%. The initial stdev of short rate change in a short time Δt is \\(\\sqrt{\\Delta t}\\)

Then we will get one point in the term structure, but we can use code to get the entire term structure.

## No-Arbitrage Model

These models are designed to be consistent with today’s term structure.

Even if it’s used as parameters, it may not be exact.

Equilibrium models generate today’s term structure.

No-arbitrage models use term structure (the observed rates in the market) as an input.

In equilibrium models, drift is not a function of time.

In no-arbitrage models, drift *is* a function of time.



We will look briefly at the Ho-Lee and Hull-White model.

### Ho-Lee Model

$$dr \= \\theta(t) dt \+ \\sigma dW$$

\\(\sigma\\) is the instantaneous standard deviation of the short rate.

These parameters are defined so they fit the initial term structure.



\\(\theta(t)\\) can be calculated analytically. For the instantaneous forward rate \\(F_t = \\frac{\\partial F}{\\partial t}\\).

$$\\theta(t) \= F\_t(0, t) \+ \\sigma^2 t$$

As an approximation, you can take

$$\\sigma(t) \\approx F\_t(0, t)$$

This is something kind of similar to what we observe before. The drift is no longer a constant, it is chosen to match the initial term structure.

However, the price of a zero coupon bond.

$$P(t, T) \= A(t, T) e^{-r(t) (T \- t)}$$

has the analytical solution (skipping derivations)
$$\\ln A(t, T) \= \\ln \\frac{P(0, T)}{P(0, t)} \+ (T \- t) F(0, t) \- \\frac{1}{2} \\sigma^2 t (T \- t)^2$$

The advantage of this over previous models is that this will match our term structure. But it’s deficient in some components so it’s not so popular.

Assumes that all forward rates have the same stdev

### Hull-White Model

$$dr \= \[\\theta(t) \- ar\]dt \+ \\sigma dW$$

or

$$dr \= a\[\\tfrac{\\theta(t)}{a} \- r\] dt \+ \\sigma dW$$

a, σ are constant

This is the golden goose one factor model. It can be viewed as an extension of the Vasicek model that fits the term structure, with a time-dependent reversion level.

Or we can say that it’s similar to Ho-Lee with time-dependent reversion level.

$$\\theta(t) \= F\_t(0, t) \+ aF(0, t) \+ \\frac{\\sigma^2}{2a}(1 \- e^{-2at})$$

That last term is small, so we can approximate it.



We can say that r follows the slope of the initial instantaneous forward rate curve. Basically this is the partial derivative.

Then we can calculate the bond prices,

$$P(t, T) \= A(t, T) e^{-B(t, T) r(t)}$$

$$B(t, T) = \\frac{1 - e^{-a(T-t)}}{a}$$

$$\\ln A(t, T) \= \\ln \\frac{P(0, T)}{P(0, t)} \+ B(t, T) F(0, t) \- \\frac{1}{4a^3} \\gamma^2 (e^{-aT} \- e^{-at})^2 (e^{2at} \- 1)$$

## Some other models

Black-Derman-Toy

$$d \\ln(r) \= \[\\theta(t) \- a(t) \\ln(r) \] dt \+ \\sigma(t) dW$$

where \\(a(t) = -\\frac{\\sigma'(t)}{\\sigma(t)}\\)

Then volatility is related to the speed of mean reversion.



Black-Karasinski model is more general,

a(t) and σ(t) are determined independently.



It has the advantage that interest rates cannot be negative, and the future value is lognormal. However, it’s very difficult to model analytically.



These are simple one-factor models as well. The only thing is that they are very difficult to calibrate, especially the more general they get.

### Bond Options

We can also have closed form solution for the price of a bond option for Vasicek and Hull-White models:

$$LP(0, s)N(h) \- KP(0, T)N(H \- \\sigma\_P)$$

where h and σ are VERY COMPLICATED.

The idea is that you have a closed form solution and can solve using analytical methods.

## Assignment 1 (BTW)

[https://github.com/pola-rs/polars/issues/5255\#issuecomment-1857124471](https://github.com/pola-rs/polars/issues/5255#issuecomment-1857124471)

See this why you can’t have float linspace. Workaround is to multiply by 10 to an integer, floor, cast to int, do an arange, then recast to float and divide by the same magnitude.
