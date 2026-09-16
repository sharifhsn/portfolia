+++
title = "Credit Default Swap Valuation"
date = 2025-04-03
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Credit Default Swaps","CDS Valuation","Premium Leg","Protection Leg"]
+++

## Credit Default Swaps

We discussed the mechanics of CDS a bit, and then started on the valuation. So let’s discuss the valuation in more details.



We have two legs. The premium leg is the buyer, who buys protection against default for the underlying company. They have to make scheduled payments throughout the life of the CDS. So that if there is a credit event, there is a payment on the premium which has accrued. If there is a default in this period, you still have to pay the accrual.



In case of default, the protection leg will purchase the underlying bond at face value. That’s the other leg.

## Valuation of the Premium Leg (O’Kane 6.5)

So we want to determine the spread of the CDS. That represents the percentage of the principal that we have to pay to purchase the CDS.



Let’s review a little bit what we did last time.



We defined the present value of $1 to be paid at t\_m which cancels with zero recovery on default before t\_m

This is a *risky* ZCB as opposed to riskless.

$$
\\tilde{P}(t, t_n) = \\mathbb{E}[e^{-\\int_t^{t_n} r(s) ds} \\cdot \\mathbb{I}_{\\tau > t_n}]
$$

Furthermore, if you assume independence between short rate process and the time of default τ, which is a reasonable assumption,

then the expectation can be separated as a product because the joint expectation can be written in such a way.

We can take the survival probability:

$$
\\tilde{P}(t, t_n) = P(t, t_n) Q(t, t_n)
$$

Then you can write the present value of premium leg as

$$
S_0 \\sum_{n=1}^N \\Delta (t_{n-1}, t_n) Q(t, t_n) P(t, t_n)
$$

where Q(t, T) is the survival probability at time t of the reference entity to T.

The Δ(t, T) is the day count fraction between T and t.

This is applied to some principal.



This is the expected payment.

## Premium Accrual

Another component of the premium leg is the premium accrued.

The amount of premium accrued at default is *contingent*. The price today of $1 paid at default which occurs at \[s, s+ds\] is given by

$$
P(t, s)[-dQ(t, s)]
$$

I want to calculate the accrued premium for an infinitesimal amount, then integrate, because we don’t actually know when the default is going to happen.

So what is such premium accrued?

This is the expected such contingent payment, so it is equivalent to the expected default in that particular interval. So we’re going to get an amount with some probability of default, then we multiply the probability of default in that small interval. So that survival probability is decreasing, an infinitesimal change in Q will correspond to the probability of default between t and s.

Then we discount such contingent payment back to time t.



So then you start with CDS Spread S\_0, from the time of previous payment to time s (default).

That is the amount accrued on expectation.

$$
\\text{Accrual} = S_0 \\Delta (t_{n-1}, s)
$$

Then the expected present value of premium accrued due to a default in \[s, s \+ ds\] in the nth premium period is…

The amount is

$$
\\text{Accrual} P(t, s) [-dQ(t, s)]
$$



Note that default can happen any time during the coupon period. So the value of accrual is integrated.

$$
S_0 \\int_{t_{n-1}}^{t_n} \\Delta(t_{n-1}, s) P(t, s)[-dQ(t, s)]
$$

This is a quantity such that expected accrual in case of default between t\_n-1 and s. You can sum this over the life of the CDS. Then you will have a sum of such integrals, over each payment period.



**This is the exact formula:**

Sum over all the premium payment periods to calculate **the expected present value of the premium accrued**

$$
PA = S_0 \\sum_{n=1}^N \\int_{t_{n-1}}^{t_n} \\Delta(t_{n-1}, s) P(t, s) [-dQ(t, s)]
$$



**The present value of the premium leg** therefore becomes

$$
PV_{\\text{premium}} = S_0 \\left[\\sum_{n=1}^N \\Delta(t_{n-1}, t_n) P(t, t_n) Q(t, t_n) + PA / S_0\\right]
$$



## Approximation of Protection Leg

This is an exact expression. But there’s a problem with integration. You need the survival probability at each point.

You can do an approximation,

by valuing the function at the end of the interval and taking an average.

Important assumption: the payment happens at the end, when default occurs.

$$
PA/S_0 \\approx \\frac{1}{2} \\Delta(t_{n-1}, t_n) P(t, t_n) [Q(t, t_{n-1}) - Q(t, t_n)]
$$

Basically, the change in survival probability represents the probability of default in that interval.

Sometimes, it’s difficult to have information about the survival probability. If we look at bonds, we make the assumption that every year has the same probability of default. In terms of the formula, it’s exact, but the approximation is more useful.

Here we assume that on average, default will happen halfway.



## Valuation of Protection Leg (O’Kane 6.6)

The protection leg is a contingent payment of par minus recovery on the face value of credit following a credit event.



We have an uncertain quantity which is paid at default.

We have an assumption that we have a certain recovery rate, but we don’t know exactly how much can be recovered (depends on the restructuring process).



The price of a security which pays an uncertain amount (φ(τ)) at time of default:

$$
\\tilde{D}(t, T) = \\mathbb{E}[e^{-\\int_t^{\\tau} r(s) ds} \\cdot \\phi(\\tau) \\cdot \\mathbb{I}_{\\tau \\leq T} ]
$$

This is a more general expression, but in general in the problems, we assume

$$
\\mathbb{E}[\\phi(\\tau)] = 1 - R
$$

If you recover nothing, the payment is the full principal. So we assume this is a fixed number, depending on the type of loan. This is independent of interest rates and default time.

Then the present value of the protection leg is..

$$
PV_{\\text{protection}} = (1 - R) \\int_t^T P(t, s) [-dQ(t, s)]
$$

You have one payment but you don’t know when you’ll get it. So you take the expectation.

The infinitesimal here is the probability of default for each infinitesimal, then discount it.

This is the general formula, which is complex to use.



## Approximation of Protection Leg

One simpler approach is to discretize the time between t and T into k intervals:
$$
\\epsilon = \\frac{T - t}{k}
$$

Then we can turn this integral into a sum over discrete intervals.

$$
PV_{\\text{protection}} = (1 - R) \\sum_{k=1}^K P(t, k\\epsilon) [Q(t, (k-1)\\epsilon) - Q(t, k\\epsilon)]
$$



Another approximation:

We know that P(t, T) is a monotonically decreasing function of T, so we can define bounds

lower:

$$
L = (1 - R) \\sum_{k=1}^K P(t, t_k) [Q(t, t_{k-1}) - Q(t, t_k)]
$$

Basically, here we have a difference in survival probabilities, where one is discounted. The problem is that the cash flows have to be discounted, but right now it’s discounted at the end of the interval of kε. The discount depends on when the default happens, which can be at any time during the interval.

$$
U = (1 - R) \\sum_{k=1}^K P(t, t_k) [Q(t, t_{k-1}) - Q(t, t_k)]
$$

The lower bound is for large value of T, upper bound is for smaller value



Then we take an average to get:

$$
PV_{\\text{protection}} \\approx \\frac{1}{2} (L + U)
$$

And then for a fair value of a CDS, based on no-arbitrage argument

$$
PV_{\\text{premium}} = PV_{\\text{protection}}
$$



**SPREAD FORMULA:**

Then we can finally solve for the spread \\(S_0\\)

$$
S_0 = \\frac{(1-R) \\sum_{k=1}^K [P(t, t_k) + P(t, t_{k-1})] [Q(t, t_{k-1}) - Q(t, t_k)]}{\\sum_{n=1}^N \\Delta(t_{n-1}, t_n) P(t, t_n)[Q(t, t_{n-1}) + Q(t, t_n)]}
$$

Therefore, we need the full discount curve, the survival curve, this information.



## Example

S \= spread

We assume that payment occurs at the end of the year. We have the survival probability that the name survives, then we have an expected payment which is discounted to the present. Let’s do one calculation:

If we have a static probability of default, probability of default in second period is Q\*(1-Q), probability of survival in second period is Q^2.



Expected payment in 3rd year is Q^3 \* S.

PV of expected payment is Q^3 \* S \* e^{-r \* T}





The PV of accrual payment in event of default:

The more general formula is on the average of default happens halfway, so our time of default is 1.5, 2.5, etc.

If during third year, the probability of default (from table) is 0.0192.

Then the coupon is halved, and the accrual payment is 0.5S. If it’s every month, then you divide that by 12 as well.

Expected accrual payment at t \= 2.5 iii



With the CDS rate on the market, you can make an inference about the implied probability of default.

If mid market spread for a 5 year CDS is 100bps per year, then the conditional default probability is 1.61%.



## Implied Hazard Rates from CDS Spreads

For the problem of estimation of default probabilities and corresponding hazard rates, we will used the so-called **JPMorgan model**. This is the credit curve, the “term structure” of probabilities of default.



## Review of Hazard Rates

τ \= time to default

CDF of probability of default is F(t) \= P(τ ≤ t)

For the purpose of this, we will take survival probabilities, which are 1 \- F(t)



The hazard rate is either h or λ by convention:

The survival probability is equal to the

$$
S(t) = e^{-\\int_0^t h(u) du}
$$

If the hazard rate is constant, you have e-ht function. But this doesn’t have to be constant. Typically, we will assume it’s piecewise constant, depends on how we estimate it.



If S(t) is differentiable, then

$$
h(t) = -\\frac{d}{dt} \\ln S(t) = \\frac{F'(t)}{1-F(t)}
$$

This is the relationship between the hazard rate, survival, and default probabilities.



If you have a risky ZCB with zero recovery that pays $1 at T:

$$
\\tilde{P}(0, T) = \\mathbb{E}[P(0, T) * \\mathbb{I}_{\\tau > T}]
$$

where

$$
P(0, T) = e^{-\\int_0^T r(u) du}
$$

Then,

survival probabilities are

$$
S(t) = \\frac{\\tilde{P}(0, T)}{P(0, T)}
$$

We can also note that the risky ZCB value must be less than the riskless ZCB..



average of hazard rates will be time 0

Sometimes it’s easier to calculate an average hazard rate for some maturity, then afterwards compute the piecewise constant hazard rate.

We can determine h\_i from successive survival probabilities.



We have the survival probability, but to express in terms of hazard rates.



If you assume hazard rates are known
