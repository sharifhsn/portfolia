+++
title = "Bond Options, Caps, Floors, and Swaptions"
date = 2025-02-13
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Interest Rate Derivatives","Bond Options","Black Model","Caps and Floors","Swaptions"]
+++

## Interest Rate Derivatives

We’re going to look at bond options, caps and floors, and everything about swaptions. Depending on time, we may go forward.



Basically these are instruments whose payoff is dependent on the level of the interest rates. Generally, interest rates are more difficult to value than equity, or fixed derivatives.



One reason is that the behavior of one individual interest rate is more complicated than that of a stock price. For example, there is some mean reversion behavior. Another reason is that the valuation of many products needs to develop that describes the behavior of the entire zero coupon yield curve. Another reason is that the volatility is different at different maturities on this curve. Typically, it’s not a good assumption that volatility is the same for all maturities. Another characteristic is that interest rates are used for discounting the payoff and also for defining the payoff.

## Bond Options

First of all, we’re going to discuss bond options.

A bond option is an option to buy or sell a particular bond by a particular date for a particular price. Typically, these bond options are traded over the counter, and they are typically embedded in bonds when they’re issued, to make them more attractive.

For example, callable bonds contain provisions that allow the issuing firm to buy back the bond at a pre-determined price at a certain time in the future. Usually they cannot be called for a few years, and the value of the call option is reflected in the yields on the bond.

Another example is the puttable bond, which contains provisions that allow the holder to demand early redemption at a pre-determined price in the future.

Obviously, such embedded put option will increase the value of the bond, these bonds tend to have a lower yield than a bond without such embedded option.

Other examples of instruments with embedded options: loans and deposits. The 5-year fixed-rate deposit issued by some institutions (banks) can be redeemed without penalty at any time, this is an American put option. You can see this deposit instrument as a bond.

Another example might be a bank loan with 5% per annum quote good for the next 2 months. By having this, you have the right to exercise over the next 2 months.



Basically there are many OTC bond options, and some embedded options are European. For this particular lecture, we will assume that the forward bond price has a constant volatility \\(\\sigma_B\\). This will allow us to use Black’s model.



There are two options for pricing interest rate options. One is to use a variant of Black’s model. Another is to use a no-arbitrage yield curve based model. Here we’re going to look at pricing such option using Black’s model. Such model will assume that the value of an interest rate, a bond price, or some other variable at time T in the future will have a log normal distribution.

## Black’s Model Revisited

We will revisit Black’s model.

Consider a European call on an asset with strike K and maturity T. Define P(t, T) as the price at time t of a zero-coupon bond expiring at time T paying $1.

Sidebar: A martingale is a zero-drift stochastic process. In general, we can say that a variable θ follows a martingale if dθ \= σdW where dW is the Wiener process. In this case, σ may be stochastic.

Then you have the martingale property defined as

$$
\\mathbb{E}[\\theta_T] = \\theta_0
$$

We can obtain an equivalent martingale result. Assume that f and g are prices of traded securities. We will assume that these prices are dependent on a single source of uncertainty. Furthermore, let’s define the ratio φ \= f/g. In this case, we’re going to call g the **numeraire**. φ will be the relative price of f with respect to g, the numeraire. We are expressing f in terms of units of g. That’s why the security price of g is the numeraire.

Let’s assume also that we have volatilities for f and g. Assume the volatilities \\(\\sigma_f\\) and \\(\\sigma_g\\) in a world where the market price of risk is \\(\\sigma_g\\). We can see that the market price of risk is the volatility of g, then the ratio f/g is a martingale for all security prices.

Here we’re going to try to review this result.

We can consider the process f, and take df as

$$
df = (r + \\sigma_g \\sigma_f) dt + \\sigma_f f dW
$$

In general, the process followed by the derivative f can be rewritten as df \= μ f dt \+ σ f dW, aka GBM. The value of μ depends on risk preferences. If the market price of risk is 0, then you have df \= r f dt \+ σ f dW.

By taking μ \= r \+ λσ, where λ is the market price of risk, or \\(\\sigma_g\\). Then you will end up with the same relationship as before.

$$
df = (r + \\sigma_g \\sigma_f) f dt + \\sigma_f f dW
$$

$$
dg = (r + \\sigma_g^2) g dt + \\sigma_g g dW
$$

Basically this derivation describes the process f/g. The market price of risk will make this process a martingale.

We can apply Itô’s lemma here (not showing work…) for ln f.

$$
d\\ln f = (r + \\sigma_g \\sigma_f) - \\tfrac{\\sigma_f^2}{2}) dt + \\sigma_f dW
$$

$$
d\\ln g = (r + \\tfrac{\\sigma_g^2}{2})dt + \\sigma_g dW
$$

If we have these two processes, we can get the differences as

$$
d(\\ln f - \\ln g) = (\\sigma_g \\sigma_f - \\tfrac{\\sigma_f^2}{2} - \\tfrac{\\sigma_g^2}{2}) dt + (\\sigma_f - \\sigma_g) dW
$$

Therefore, if you combine these terms, and get

$$
d(\\ln\\tfrac{f}{g}) = -\\frac{(\\sigma_f - \\sigma_g)^2}{2} dt + (\\sigma_f - \\sigma_g) dW
$$

Here again we can use Itô’s lemma to get the process for f/g.

$$
d(\\tfrac{f}{g}) = (\\sigma_f - \\sigma_g) \\frac{f}{g} dW
$$

Based on our previous definition/specification, f/g is a martingale.

Therefore it follows that

$$
\\frac{f_0}{g_0} = \\mathbb{E}_g\\left[\\frac{f_T}{g_t}\\right]
$$

and

$$
f_0 = g_0 \\mathbb{E}_g\\left[\\frac{f_T}{g_T}\\right]
$$

Now we can go back to the zero coupon bond price.

Let E\_T \= expectation in a world that is forward risk neutral with respect T(t, T)

What can we say about some of these values?
g is the numeraire, so g\_T \= p(T, T) \= 1, The price of a ZCB at maturity.

g\_0 \= p(0, T)

Then

$$
f_0 = p(0, T) \\mathbb{E}_T[f_T]
$$

Furthermore, for a European call option, with strike K maturity T, the price of such option will be given by c.

$$
c = p(0, T)\\mathbb{E}_T[(S_T - K)_+]
$$

where S\_T is the asset price at time T.

Furthermore, let’s define F\_0 and F\_T as the forward price of an asset at times 0 and T.

Therefore the bond option price is

$$
c = p(0, T) [F_B N(d_1) - KN(d_2)]
$$

$$
p = p(0, T) [KN(-d_2) - F_B N(-d_1)]
$$

where

$$
d_1 = \\frac{\\ln(\\tfrac{F_B}{K}) + \\sigma_B^2 \\tfrac{T}{2}}{\\sigma_B\\sqrt{T}}
$$

$$
d_2 = d_1 - \\sigma_B\\sqrt{T}
$$

The characteristic of this pricing model is that the bond price and the strike price should be the cash prices, not the quoted prices. Let’s look at an example.

## Bond Options Example (Black’s)

Let’s consider a 10-month European call option on a 9.75 years bond with a face value of $1000. What we’re saying is when the option matures, the bond will still have 8 years and 11 months. The current bond price is $960, the strike is $1000, the 10-month risk-free interest rate is 10% per annum, the volatility of F\_B for T=10 months is 9% per annum. The bond pays a coupon of 10% per year, semiannual payments. Therefore the coupon payments is $50, with the payments expected at 3 months and 9 months. Here the accrued interest at $25. Let’s suppose the risk-free interest rates are different for 3 months and 9 months, 9% and 9.5% per annum. This is a direct application of Black’s model.



In order to solve this, we can just apply Black’s model.

The value we need to calculate is the forward bond price F\_B, the expected value of the bond at some time in the future.

At some time in the future, you might have some coupons that are no longer considered in the calculations. Therefore the forward bond price is

$$
F_B = \\frac{B_0 - I}{p(0, T)}
$$

where B\_0 is bond price at time 0\.

I is present value of coupons in (0, T)

In the next 10 months, we are expected to have two coupons. One in 3 months, and one in 9 months.

The current cash price is given

B\_0 \= 960

Then we can calculate the forward

$$
F_B = \\frac{B_0 - I}{p(0, t)}
$$

small t in our case.

$$
I = 50 e^{-0.25 \\times 0.09} + t0 e^{-0.75 \\times 0.095} = 95.45
$$

We are using the time of discounting (3 months and 9 months), the coupon payment (50), and the interest rate for each coupon (0.09 and 0.095).

Forward bond price therefore is

$$
F_B = (960 - 95.45)e^{0.10 \\times \\tfrac{10}{12}} = 939.68
$$

Since the 10 month interest rate is 10%

Let’s say it’s under specified. The strike price is 1000, but this problem does not specify if the strike price is the cash price to be paid for the bond or the quoted price. For the payment, if you have the quoted price, the value of the bond is going to be quoted price \+ accrual (dirty price). We can investigate these two cases.

1) If the strike price is the cash price that would be paid for the bond on exercise.

F\_B \= 939.68; K \= 1000; \\(p(0, T) = e^{0.10 \\times \\tfrac{10}{12}} = 0.92\\); \\(\\sigma=0.2\\)

By applying the formula for the Black’s model for the call (not writing it all down)

Should be $9.49.

2) If the strike price is the quoted price.

We have one month accrual interest that must be added to K, because the most recent payment was at 9 months, and the expiration is at 10 months. Therefore K \= 1000 \+ 100 \* 1/12 \= 1008.33

The rest of the characteristics are the same.

c \= $7.97

## Standard Deviation of ln B

Stdev will rise after 0, then fall.

## Forward Bond and Forward Yield

The volatilities quoted for the bond options are many times the yield volatilities and the price volatilities. We can use the duration concept. Let’s suppose if D is the modified duration of the forward bond price at option maturity, then the relationship in the change of the forward price and the change in forward yield is given by

$$
\\frac{\\Delta F_B}{F_B} \\approx -D \\Delta y_F
$$

## Yield Vols vs Price Vols (Equation 28.4, page 652\)

## Caps and Floors

These are interest rate caps and floors. Basically, these instruments, you can think of them as insurance, protection against the increase or decrease in interest rate. They’re going to cap such an interest rate.



First of all, let’s consider a floating rate note where the interest rate is reset periodically to a floating rate. We have such reset periods. The time between the resets is known as the **tenor**. Let’s look a little bit at the mechanics.



Assume that the tenor is equal to 3 months.

- The interest rate on the note for the first 3 months is equal to the initial rate for 3 months, as observed at t \= 0
- The interest rate on the note for the next 3 months is set equal to the 3-month floating rate prevailing in the market.



The interest rate **cap** is designed to provide insurance against interest rate on the floating rat rising above a certain level (“cap rate”).



For example, assume a principal of $10 million, tenor is 3 months, life of cap is 5 years, cap rate is 4%.

This is an important characteristic for the caps, because the payments are made quarterly, so the cap rate is expressed with quarterly compounding.

Furthermore, let’s assume on a particular reset date, we have the 3-month floating rate as 5%. In this case, a floating rate note would require a payment of the period (0.25) times the rate (0.05) times the principal (10M) \= $125K.

However, with the 3-month rate capped at 4%, it resolves to $100K.

The cap provides protection, a payoff of such difference.

If you have such cap, then the cap provides a payoff of $25,000, 3 months later

So what is the value of the cap?

At each reset date that is happening during the life of the cap, the floating rate is observed.

If the floating rate is ≤4%, which is smaller than the cap rate, then there is no payoff from the cap. Furthermore, if it’s \>4%, then the payoff is the excess rate applied to the principal.

In this case, we have 19 reset dates (5 years \* 4 tenors per year \- 1 initial tenor), at times 0.25, 0.5, …, 4.75 years. There are 19 payoffs, which occur a tenor after, so at times 0.5, 0.75, …, 5 years.

## Portfolio of Interest Rate Options

**The cap can be expressed as a portfolio of call options** **on a reference floating rate** (LIBOR maybe?).

Consider a cap with a total life T, principal L, and cap rate R\_K.

The reset dates are t\_1, t\_2, \\ldots t\_n and t\_{n+1} \= T.

We will define R\_k as the floating interest rate for a period between t\_k and t\_{k+1} observed at time t\_k. The small k can take values 1 ≤ k ≤ n.

The cap leads to a payoff at time t\_{k+1}, based on the tenor. The payoff depends on the realization of the floating interest rate.

$$
\\delta_k L(R_k - R_K)_+
$$

This is applied to the principal. It’s annual, quarterly compounding, so this particular payoff will be applied for the period corresponding to the tenor, which we can mark with the delta.

$$
\\delta_k = t_{k+1} - t_k
$$

You may assume that tenors are equal, even if that’s not necessarily the case.



We can also consider it as a portfolio of puttable bond options, where the ZCB has payoff occurring at time t\_k.

The previous payoff at time t\_{k+1} is equivalent to

$$
\\frac{\\delta_k L}{1 + R_k S_k} (R_k - R_K)_+
$$

We can use algebra to determine that this is equivalent to

$$
\\left(L - \\frac{L(1 + R_K \\delta_k)}{1+R_k \\delta_k}\\right)_+
$$

Therefore the denominator is equivalent to the value at time t\_k of a ZCB that pays L(1+R\_k δ\_k) at time t\_{k+1}.



The floor is just the reverse of this, using put options, and R\_K \- R\_k.



We can then view each call option in the portfolio that represents a cap as a **caplet**. We assume that the interest rate underlying each caplet is lognormal. Then we can use Black’s model.



A collar is an instrument that guarantees that the interest rate on the underlying floating rate always lies between two levels. You can achieve this by taking a long position in a cap and a short position in a floor. In terms of valuation…

## Collar Example

The value of a caplet is

$$
L\\delta_k p(0, t_{k+1}) [F_k N(d_1) - R_k N(d_2)]
$$

using the standard d1 and d2 for option valuation.

Where F\_k is the forward interest rate for a period between t\_k and t\_{k+1}

In addition, we have to take some assumptions or make some estimates about the volatility of the forward interest rates

σ\_k \= volatility of the forward interest rate

Here you value all the caplets in order to determine the value of a cap.



Consider a contract that caps the LIBOR interest rate on $10M at 8% per annum (quarterly compounding) for 3 months starting in 1 year. This is a caplet, and could be an element of a cap.

LIBOR/swap zero curve is flat at 7% per annum,

volatility of the rate is 20% per annum

continuously compounded zero rate for all maturities is 6.9395%



Let’s consider our inputs

$$
t_k = 1, t_{k+1} = 1.25, \\delta_k = 0.25, F_k = 0.07, R_k = 0.08, L=10M, \\sigma = 0.2
$$

We need to calculate the discount factor and all the other values

$$
p(0, t_{k+1}) = p(0, 1.25) = e^{-0.069395 \\times 1.25} = 0.9169
$$

Furthermore, to calculate for our options

$$
d_1 = -0.5677
$$

$$
d_2 = -0.7677
$$



Then we can use the option valuation Black’s model to get the final value

### Assumptions

We must use spot volatilities, where the vol is different for each caplet,

or one volatility, where it’s flat and the same for each cap.

## Swaptions

The swaption or swap option gives the holder the right to enter into an interest rate swap in the future.

There are two kinds, the **right to pay** a fixed rate and receive LIBOR, or the **right to receive** fixed rate and pay LIBOR. (LIBOR \= floating)



We have a single option on the swap rate with repeated payoffs.

This is a series of cash flows

$$
\\frac{L}{m}(S_T - S_k)_+
$$

where

L \= principal

m \= frequency per year

S\_K \= swap rate

S\_T \= swap rate at time T

The value of the swaption on the swap rate with repeated payoffs where the holder has right to pay S\_k.

Each of these payoffs will be discounted to the present.

$$
\\sum_{i=1}^{mn} \\frac{L}{m} p(0, T_i) [S_0 N(d_1) - S_K N(d_2)]
$$

S\_0 is the swap rate at time 0\.

This is a natural extension of Black’s model, just with more discount factors.

This represents discount factors for mn payoffs ⬇️

$$
\\sum_{i=1}^{mn} p(0, T_i)
$$

We can define A as the value of a contract that pays 1/m at times T\_i (1 ≤ i ≤ mn)

With this notation, the value of the swaption will become

$$
LA [S_0 N(d_1) - S_K N(d_2)]
$$

## Swaption Example

Suppose that the LIBOR yield curve is flat at 6% per annum with continuous compounding. Consider a swaption that gives the holder the right to pay 6.2% in a 3-year swap starting in 5 years. The volatility of the forward swap rate is 20%. The payments are semiannually and the principal is $100 million.

Let’s set our variables

For A, this is the sum of the discounted swaps. The yield curve is flat, so it’s always 6%. We are semiannual, so we start six months after 5 years when the swap starts.

$$
A = \\frac{1}{2}(e^{-0.06 \\times 5.5} + e^{-0.06 \\times 6} + \\ldots + e^{-0.06 \\times 8} = 8
$$

We also need S\_0, the forward swap rate.

\[...skips some steps, forgot to pay attention)

$$
R_c = m \\ln (1 + \\frac{R_m}{m})
$$

Therefore

S\_0 \= 0.0609

S\_K \= 0.062

T \= 5

σ \= 0.2

$$
100M \\cdot 2.0035[0.0609 N(0.1836) - 0.063 N(-0.2636)] = \\$2.07M
$$

## Sensitivity

All these derivative have a delta, the DV01, the impact of a 1bps parallel shift in the zero curve.

## Next Lecture

We will be doing adjustments, like convexity, time, and quant adjustments



Caps protect you, if the volatility rate is too high, you might have risk for a longer period.

The swap which is fixed for floating, you can enter in the future. Once you enter the swap,
