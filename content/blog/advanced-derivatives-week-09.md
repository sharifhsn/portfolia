+++
title = "Hazard Rates and Credit Default Swaps"
date = 2025-03-27
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Hazard Rates","Recovery Rates","Credit Default Swaps"]
+++

## Hazard Rate

Lambda hazard rate is convenient to work with.

If we integrate over it, we can get the survival probability V(t) at time t.



We can also get the probability of default Q(t) by doing 1 \- survival probability.



## Recovery Rate

If we have default, we will lose all future coupons/payoffs.

Typically we can recover something from the bond, depending on the structure of the debt. Bonds get paid before equity.

The recovery rate is defined as the price of the bond immediately after default as a percentage of FV.

Recovery rates DECREASE as default rates INCREASE. Recovery is not known in advance but it is estimated in a certain range based on historical data.



We can get the implied probability of default for a bond using some qualities.

- the bond price
- CDS spreads (will discuss)

CDS is basically an insurance instrument

You can also get historical data to construct hazard rates

Merton’s model also (will discuss)

## Bond Prices

Obviously, there is a relationship between default and bond price. We can approximate default intensity over life of bond as

$$\\frac{s}{1-R}$$

where s is spread of bond’s yield over risk-free rate and R is recovery rate.



We can look at a little more exact calculation.



Let’s say we have slide 13 from Part 1\.

When we do pricing of a CDS, we will look more detail in this issue, where if defaults can happen at any time, we integrate over the domain.

The goal is to calculate such probability of default.



We have a coupon payment of $3. So the YTM is



You can estimate risk-neutral default rate each year.

It’s a bootstrap process. You start with lower maturity bonds, then get higher maturity bonds

## Credit Default Swaps

Excess of n-bond yields of corporate bonds must equal CDS spread, otherwise there is arbitrage where you can either earn over the risk-free rate or borrow at less than the risk-free rate.

The CDS bond basis is the spread \- the excess bond yield.

From the arbitrage argument, the bond basis should be 0\.

Historically, CDS bond basis \> 0\.

One leg is the protection buyer, the premium leg,

and the other is the



When you value the premium leg,

The other element is the survival probability.

The second component is that in case of default, you have to pay the accrual
