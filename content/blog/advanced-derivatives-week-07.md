+++
title = "Short-Rate Calibration and HJM"
date = 2025-03-13
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Calibration","Vasicek","Cox-Ingersoll-Ross","Hull-White","HJM"]
+++

## Calibration

We’ll look specifically at Vasicek and CIR. Then we will make some remarks on the Hull-White two factor model, then some more complex model.

The code for this in a package in R.

### Vasicek

First we will simulate, then look at parameters.

$$
dr_t = a(b - r_t) dt + \\sigma dW_t
$$

We will use the Euler discretization scheme.

$$
r_{t + \\Delta t} - r_t = a(b - r_t) \\Delta + \\epsilon_{t + \\Delta}
$$

Then we will make a Binomial tree that uses such discretization.

where

$$
\\epsilon_{t+\\Delta} \\sim N(0, \\sigma^2 \\Delta)
$$

Then in general,

$$
r_{i\\Delta} = r_{(i - 1)\\Delta} + a(b - r_t) \\Delta + \\epsilon_{t + \\Delta}
$$

### Cox-Ingersoll-Ross

$$
dr_t = a(b - r_t) dt + \\sigma \\sqrt{r_t} dW_t
$$

Then do the same thing.

### Two-Factor

Then the two factor Vasicek model can be defined with correlated factors.

There’s a short rate and long rate factor.



One such method of calibration is the **maximum likelihood estimator** (MLE)

For Vasicek with real world data, consider



sample short rates \\(r_0, r_{\\Delta}, r_{2\\Delta}\\),

for Vasicek \\(f(r_{t+s} |r_t)\\) normal density

with \\(\\mathbb{E}[r_{t+s}|r_t] = b + (r_t - b)e^{-as}\\)

and

$$
\\mathbb{V}[r_{t+s}|r_t] = \\frac{\\sigma^2}{2a} (1 - e^{-2as})
$$

Then the MLE method determines this for the distribution.

It’s a function of parameters given the

Typically you take the ln of the likelihood and determine the maximum given the function.

$$
\\alpha^{*} = (1 - e^{-2a\\Delta}) b
$$

$$
\\beta^{*} = e^{-a\\Delta}
$$

$$
\\sigma^{*} = \\sqrt{\\tfrac{\\sigma^2}{2a} (1 - e^{-2a\\Delta})}
$$

$$
\\mathbb{E}[r_{i\\Delta} \\mid r_{(i-1)\\Delta}] = \\alpha^{*} + \\beta^{*} r_{(i-1)\\Delta}
$$

$$
\\mathbb{V}[r_{i\\Delta} \\mid r_{(i-1)\\Delta}] = (\\sigma^{*})^2
$$

Then we take the natural log of the likelihood for the normal density plugging in these parameters.

MLE estimates

$$
a = -\\frac{\\ln(\\hat{\\beta}^{*})}{\\Delta}
$$

$$
b = \\frac{\\hat{a}^{*}}{1 - \\hat{\\beta}^{*}}
$$



## Risk-Neutral Calibration

Assume that we have ZCB prices/discount factors (same thing).

The price of a ZCB under the Vasicek model is

$$
P(t, T) = e^{A(t, T) - B(t, T) r}
$$

where

$$
B(t, T) = \\frac{1}{a^{*}} (1 - e^{-a^{*}(T-t)})
$$

$$
A(t, T) = (B(t, T) - (T - t)) (b^{*} - \\frac{\\sigma^2}{2(a^{*})^2}) \\ldots
$$

for the calibration, you would want to minimize for n bonds

$$
\\sum_{i=1}^n (P_{\\text{Vasicek}} - P_{\\text{market}})^2
$$

You might use a nonlinear optimizer.

## Hull White Two Factor

$$
dr = [\\theta(t) + u  - ar] dt + \\sigma_1 dW_1
$$

$$
du = -bu + \\sigma^2 dW_2
$$

where we have another process u, and two volatilities/brownian motions.

u in this context is a random mean reversion level.

The previous model fits the term structure at time 0 and defines such mean reverting level, which is subject to some randomness. We have some historical data for htis.

You also have ρ the correlation between dW\_1 and dW\_2, and the rest are constants.



Spot rate volatility structure for Hull-White two-factor model.

$$
\\sigma_R(t, T) = \\frac{1}{T-t} \\sqrt{[B(t, T)^2 \\sigma_1]^2 + [C(t, T)\\sigma_2]^2 + w\\rho\\sigma_1\\sigma_2B(t, T)C(t, T)}
$$

Here is an example:



Price a 5 year zero coupon bond after one year i.e. four years remaining to maturity.

It has the following parameters:



t \= 1, T \= 5, r(1) \= 0.05, u(1) \= 0.01.

In order to calculate, all the implementation is in the PDF.

First calculate

B(1, 5\)

B(0, 5\)

B(0, 1\)

C(1, 5\)

C(0, 5\)

C(0, 1\)

ln A(1, 5\)

P(1, 5\)

Then you can construct the term structure will fit at time 0, and the evolution of this structure.

Then in this case, we have an analytical solution for σ \= 0.0110

10 year and 15 year interest rates will have a lot of correlations, you can graph correlations against interest rate times and get the term structure.

## Limitations of One-Factor or Two-Factor Models

Most involve only one factor of uncertainty.

The models do not give the freedom in choosing the volatility structure.

Looking at a simple example of rates, we can see that we have different volatilities for maturities, and these tend to be correlated.

Based on these considerations, we need a more general approach in specifying the volatility environment and allow multiple factors



This is the HJM Model (Heath Jarrow, and Marton Model)

In the previous short rate models, we had a single source of randomness, Brownian motion, and the instantaneous correlation between forward rates and maturities is equal to 1\.

We will consider some notation.

P(t, T) is the price of ZCB of $1 at time t maturing at T.

Ω will be the vector of past and present values of interest rates and bond prices at time t that are relevant for determining bond price volatility at that time, basically describes the information set.

Then

ν(t, T, Ω) this is nu, the volatility of P(t, T)



The process for P(t, T) looks like

$$
dP(t, T) = r(t) P(t, T) dt + \\nu (t, T, \\Omega_t) P(t, T) dW(t)
$$

Then we have some characteristics at maturity.

The forward rate is determined by the derivative with respect to the ln change in ZCB over time.



The dynamics of the forward curve (ZCB) are only dependent on the volatility.
Then we can say this is a risk-neutral process for the forward f that depends only on ν.

Then we have a process for the instantaneous forward dF which is only determined by the volatility structure. So if we have ν, then we have the term structure

There is a link between the dirft and the standard deviation of the instantaneous forward rate.



But the extension to several factors with the market is expressed int erms of the instantaneous forward rate, which is not directly observable, and it’s difficult to calibrate. And also the process for the short rate in HJM model is non-Markovian.



What is the connection between the HJM model and the previous short rate models?

We look just at the single factor model.



If you integrate the instantaneous forward rate, this is the actual short rate.

And generally you can see how the terms depend on each part of the ν expression. That’s why r is non-Markovian, a non-recombining tree.

