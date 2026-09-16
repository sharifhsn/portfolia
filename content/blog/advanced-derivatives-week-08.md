+++
title = "LIBOR Market Model and Hazard Rates"
date = 2025-03-20
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","LIBOR Market Model","Interest Rate Models","Hazard Rates"]
+++

## LMM

The **LIBOR Market Model** (or **Brace-Gatarek-Musiela Model**)

is a model constructed in terms of the forward rates underlying caplet prices.

HJM was defined as a process for the forwards.

Basically the benefit was that it could model the entire term structure, as long as you input all the volatilities for the term structure.

But the problem is the calibration.



Notation

\\(t_k\\) kth reset date

So t would progress like t\_0 \= 0, t\_1 \= 0.25, t\_2 \= 0.5…

\\(F_k\\) forward rate between k and k \+ 1

m(t) index for next reset date at time t.

So if t \= 0.4, then m(t) \= 0.5



δ\_k \= t\_k+1 \- t\_k

So basically you can imagine that you have your forward curve,



xi: ξ(t) \= volatility of F\_k(t) at time t



Assume that we have only one factor

This factor is the forward risk neutral process with respect to P(t, t\_k+1)

Then, our process

$$
dF_k(t) = \\xi_k (t) F_k(t) dW
$$

The change is driven by the volatility, existing forward rate, and Brownian motion.



Applying some change of numeraire, skipping some steps, you get

the rolling forward rate process (in notes)



Price of a ZCB at time t\_i which is discounted, the ratio of that to t\_i+1

$$
\\frac{P(t, t_i)}{P(t, t_{i+1})} = 1 + \\delta_i F_i(t)
$$

If you apply the natural log, you get

$$
\\ln P(t, t_i) - \\ln P(t, t_{i+1}) = \\ln [1 + \\delta_i F_i(t)]
$$

This is the relationship between the ZCB and the forward.

Then if you apply Ito’s lemma… and equate coefficient of dW



something long…



Then you can take the substitution of the forward process.

$$
\\frac{dF_k(t)}{F_k(t)} = \\sum_{i= m(t)}^k \\frac{\\delta_i F_i(t) \\xi_i(t) \\xi_k(t)}{1+\\delta_i F_i(t)} dt + \\xi_k(t) dW
$$

This is the process followed by the forward rate between t\_k and t\_k+1, in a risk-neutral world.

In the limiting case, when this interval becomes smaller, this converges to HJM



The idea is being able to calibrate this model.

It can be simplified with:

## Simplified Model

Assume that ξ\_k(t) function only on the number of whole accrued periods between the next date and t\_k.



Define Λ\_i as the value of ξ\_k(t) (volatility of forward) when there are i such accrued periods.

Then the volatility of the forward can be redefined as

\\(\\xi_k(t) = \\Lambda_{k-m(t)}\\) which is a step function

And such values like Λ\_i can be estimated from the volatilities used to value caplets in Black’s model.

Recall that to value a caplet, we have

$$
L\\delta_k P(0, t_{k+1}) [F_k N(d_1) - R_k N(d_2)]
$$

blah blah blah d\_1 and d\_2

If we equate the variances between Black’s model and this, we get

$$
\\sigma_k^2 t_k = \\sum_{i=1}^k \\Lambda_{k-i}^2 \\delta_{i-1}
$$



Example in the slides for converting Black volatilities to Lambda, use to check



## Implementation

How would I use this model to price a bond. If you observe the volatility, then you can price a bond under this?



This would be done via Monte Carlo simulation



$$
\\frac{dF_k(t)}{F_k(t)} = \\sum_{i=m(t)}^k \\frac{\\delta_i F_i(t) \\Lambda_{i - m(t)}\\Lambda_{k-m(t)}}{1 + \\delta_i F_i(t)} dt + \\Lambda_{k-m(t)} dW
$$

Then, by Ito’s lemma,

$$
d\\ln F_k(t) = \\left[\\sum_{i=m(t)}^k \\frac{\\delta_i F_i(t) \\Lambda_{i-m(t)} \\Lambda_{k-m(t)}}{1 + \\delta_i F_i(t)}\\right]dt + \\text{same thing as above}
$$

Then we can approximate the drift by approximating \\(F_i(t)\\) and \\(t\\)

Then,

$$
F_k(t_{j+1}) = F_k(t) \\exp\\left[\\biggl(\\sum_{i=j+1}^k \\frac{\\delta_i F_i(t_j) \\Lambda_{i-j-1}}{1 + \\delta_i F_i (t_j)} - \\frac{\\Lambda^2_{k-j-1}}{2}\\biggr) \\delta_j + \\Lambda_{k-j-1} \\epsilon \\sqrt{d_j}\\right]
$$



Slide 8 has more calculations that I can use for testing.

ipynb file is provided



Each approximation of the drift the forward rate remains constant.

If we define the rolling forward in the risk neutral world, it allows us to discount bond from one date to the next one.

In terms of simulation, what’s happening in the code is that if you assume that we want to simulate a zero curve with N accrued periods.

On each trial, we start with the forward rate at time 0, which is calculated from the initial zero curve.

F\_0(0), F\_1(0), … F\_N-1(0)

Then we can use an approximation formula (described above) to calculate F\_1(t\_1), F\_2(t\_1)...



Limitations of the theoretical model

## Credit Risk

LMM is a little complicated, this is just an introduction to the topic.

Credit risk is the probability that a debtor will default on their debts. We have always assumption that the cash flow is 100% likely i.e. with treasury bonds.



For single-name derivatives, we will look at CDS and CDOs. Then we will look at portfolios. We are interested in expected loss, with a discrete number of names in the portfolio, to estimate the losses in order to price the portfolio correctly.



Rating agencies will rate the credit risk of bonds.

S\&P says AAA, AA, A, BBB, BB, B, CCC, CC, C

Moody’s has Aaa, Aa, A, Baa, Ba, B, Caa, Ca and C

Bonds with ratings of BBB and above are investment grade

These are measured as bands of probabilities.



### Question about Diversification

By diversifying your portfolio into multiple assets, you decrease the credit risk. Then you can securitize the portfolio by splitting it into tranches, and then get the CDO.

And then payment in the bonds

You can have nonlinear dependence between variables, and tail dependence between variables which is conditional. Then the probability of default, what is the likelihood of this house being on fire if this other house is on fire? If the answer is not 0, then you have tail dependence.

We will look at different models that measure this.



### Hazard Rates

Also known as default intensity, this is the probability of default for  a certain time period conditional on no earlier default.

Unconditional default probability is from 0\.

We are given a table that has cumulative default rates.

In order to calculate the probability that A defaults in the first year, you take the actual probability. Then if it’s the second year, we’re concerned with the cdf(2) \- cdf(1).

Then the probability of survival is 1 \- this

This is all unconditional default probability.



Then the conditional probabilities are known as default intensities or hazard rates



The unconditinal probability of default within a certain default vs the survival probability.

The survival probability is V(t)

$$\\lambda(t) \\Delta t \= \\frac{V(t) \- V(t \+ \\Delta t)}{V(t)}$$

Then you get the ODE

$$\\frac{dV(t)}{dt} \= \-\\lambda(t) V(t)$$

$$V(t) \= e^{-\\int\_0^t \\lambda(t) dt}$$

Then the survival probability can be found by integrating over the hazard rate. So if you have a specification of the hazard rate, you can find the cumulative survival probability.



Then we can also discuss the cumulative default probability.



We can use the CDS to determine the piecewise constant hazard rates and then construct the survival probabilities.

So this is a calibration in which we can price the risk of default through CDS.

First we will look at bonds.



