/*
title = "Hazard Rates and Credit Default Swaps"
date = 2025-03-27
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Hazard Rates","Recovery Rates","Credit Default Swaps"]
*/

== Hazard Rate
<hazard-rate>
$Lambda$, the hazard rate, is convenient to work with.

If we integrate over it, we can get the survival probability $V\(t\)$ at time $t$.

We can also get the probability of default $Q\(t\)$ by doing $1 -$ survival probability.

== Recovery Rate
<recovery-rate>
If we have default, we will lose all future coupons/payoffs.

Typically we can recover something from the bond, depending on the structure of the debt. Bonds get paid before equity.

The recovery rate is defined as the price of the bond immediately after default as a percentage of FV.

Recovery rates DECREASE as default rates INCREASE. Recovery is not known in advance but it is estimated in a certain range based on historical data.

We can get the implied probability of default for a bond using some qualities.

- the bond price
- CDS spreads (will discuss)

CDS is basically an insurance instrument

You can also get historical data to construct hazard rates

Merton's model also (will discuss)

== Bond Prices
<bond-prices>
Obviously, there is a relationship between default and bond price. We can approximate default intensity over life of bond as

$ frac(s, 1 - R) $

where $s$ is the spread of the bond's yield over the risk-free rate and $R$ is the recovery rate.

We can look at a little more exact calculation.

Lecture 7, Part I, slide 13 (PDF p. 13) states the assumptions directly: a five-year corporate bond pays a 6% annual coupon semiannually; its continuously compounded yield is 7%, while a similar risk-free bond yields 5%. The risk-free bond is priced at 104.09 and the corporate bond at 95.34, giving an expected default loss of 8.75. The slide assumes a default probability of $Q$ per year and defaults halfway through each year, immediately before a coupon payment.

Slide 14 (PDF p. 14) evaluates a \$40 recovery amount for each possible default time. It lists the risk-free value, loss given default, discount factor, and present value of expected loss:

#table(
  columns: 7,
  align: (left, center, center, center, center, center, center),
  inset: 4pt,
  stroke: 0.5pt,
  [*Time (years)*], [*Default probability*], [*Recovery amount*], [*Risk-free value*], [*Loss given default*], [*Discount factor*], [*PV of expected loss*],
  [0.5], [Q], [40], [106.73], [66.73], [0.9753], [65.08 Q],
  [1.5], [Q], [40], [105.97], [65.97], [0.9277], [61.20 Q],
  [2.5], [Q], [40], [105.17], [65.17], [0.8825], [57.52 Q],
  [3.5], [Q], [40], [104.34], [64.34], [0.8395], [54.01 Q],
  [4.5], [Q], [40], [103.46], [63.46], [0.7985], [50.67 Q],
  [*Total*], [], [], [], [], [], [288.48 Q],
)

Slide 15 (PDF p. 15) sets $288.48 Q = 8.75$ and obtains $Q = 3.03\%$. It then notes that the analysis can allow defaults to occur more frequently and that several bonds provide more parameters for describing the default-probability distribution.

When we do pricing of a CDS, we will look more detail in this issue, where if defaults can happen at any time, we integrate over the domain.

The goal is to calculate such probability of default.

We have a coupon payment of \$3. So the YTM is

You can estimate risk-neutral default rate each year.

It's a bootstrap process. You start with lower maturity bonds, then get higher maturity bonds

== Credit Default Swaps
<credit-default-swaps>
Excess of n-bond yields of corporate bonds must equal CDS spread, otherwise there is arbitrage where you can either earn over the risk-free rate or borrow at less than the risk-free rate.

The CDS bond basis is the spread minus the excess bond yield.

From the arbitrage argument, the bond basis should be 0.

Historically, CDS bond basis $> 0$.

One leg is the protection buyer, the premium leg,

and the other is the

When you value the premium leg,

The other element is the survival probability.

The second component is that in case of default, you have to pay the accrual
