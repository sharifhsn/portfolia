+++
title = "Structured Credit and CDOs"
date = 2025-04-10
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","CDOs","Structured Credit","Tranches","Synthetic CDOs"]
+++

## Final

Last day of class is Thursday, May 8\.



The final exam is going to be posted then, take-home exam. It’ll be posted like an assignment.

Will be posted in evening around 6:30, you’ll have Friday and Saturday night to do this.

Questions will be theoretical.



## Multi-names

Last lectures we discussed the mechanics of single-name derivatives like the credit default swaps, and the calculation of the implied hazard rates. This is what is calculated in the assignments, along with default/survival probabilities.



Now we will discuss the multi-name credit derivative, mainly the **CDO: Collateralized Debt Obligation**.

These are securities whose payments are linked to the incidence of default of an underlying portfolio of credit risky assets. It’s based on not just one, but a portfolio of risky assets.



The most interesting component of this is modeling the dependencies in the portfolio, and then calculating the fractional loss in the portfolio, and essentially pricing. So  you have a basket of such credit-linked assets, then the question is, if you want to sell a portion of this portfolio, in shares, what should be that price? Basically you need to calculate the cash flows, as well as expected loss. Same idea as fair price of two legs as in CDS.



Some of these instruments are more complex, but in general, we can consider asset-backed securities. They are formed from loans, bonds, mortgages, and so forth. Usually, the income from the assets is tranched. A MBS has claims on money generated from these pools, cash flows that these mortgages generate from regular payments. If you aggregate these together, you get cash flows. These will be distributed to the owners of the pool.



MBS that are created by adding many such mortgages and selling shares on the revolving pool. For example, such security is secured by the underlying mortgages.



This kind of instrument is obviously more convenient to put in a portfolio than a single-name. If you want a single bond, you are dependent on the probability of default on the counterparty. If you have two bonds, then you have two probabilities of default. You might have probability p of default, and the probability of both defaulting is p1\*p2 (absent some dependencies between bond defaults). It’s an expectation that helps in constructing such pools.



We can calculate under different assumptions. Let’s say we assume that you have no correlations for them, that would be a simple formula. You would want to get a distribution, the probability that you have 1, 2, n names default. If you have the probability of default, if you assume that’s a homogeneous portfolio where all bonds have same probability of default. Then you would enumerate the number of ways that you can have 3 bonds default in the portfolio, which forms the distribution.



Some assumptions, it helps in some way to have diversification. But many times, these mortgage bonds wouldn’t sell because their credit rating was too bad, like DDD. You can have CMOs, which consist of multiple pools of securities, which are **tranches** (or slices). The idea is that even if it’s a homogeneous universe of very low-rated loans, like BBB, if you have the securitization of this and construct the CMO and CDO in such a way that they would have AAA rating. We will look at such a mechanism.



## Waterfall

In the case of a CMO/CDO (depends what our underlying is), the structure of instrument is usually a “waterfall”. It defines how the income is received and how it’s distributed to different tranches. So, slide 5 with diagram gives us a simplification of asset backed securities. The underlying assets (bonds) are collateralized into a CDO. Let’s say we have such pool of assets. These assets do not necessarily have the same probability of default or principal. But if you aggregate these into a special purpose vehicle (**SPV**), the purpose is to generate tranches. These tranches, you have typically a **senior**, **mezzanine**, and **equity** tranche. Sometimes we will have more specifications. The principal from the original pool is split into these tranches. And you have a target return, a promised return under the assumptions that we have no default. Typically, the principal for the senior tranche is much larger than the mezzanine and the equity tranche.



Basically, the waterfall, which is also called the structure subordination, this describes the scheduled coupon and principal payments from different securities. It also describes the losses. The arrangement of this pool will generate cash flows. This cash flow is used first to pay the senior tranche. Then after the senior tranche is completely paid, the cash flows go to mezzanine, then equity. So as long as you have no defaults, this system works. But when you have a loss, the loss is first taken by the equity tranche, then the mezzanine, and then the senior tranche. This structure of subordination or waterfall creates advantages and disadvantages for the equity tranche. This tranche is far riskier than the other tranches. The idea behind the whole mechanism is to have many market participants. The senior tranche has AAA rating. The rating agencies will rate these particular tranches. The magic of it was to take something rated BBB and turn it into something rated AAA. You could take the mezzanine tranche from multiple CDOs and get a new CDO from that. Things got kind of complicated.

## 2008

Along with the increase in prices of homes, the MBS market reached $4 trillion. Wall Street issued something like $700 billion in CDOs. This is a kind of interesting instrument. There were many problems. The mortgages given in the first place had various loose criteria. People would get houses without giving a down payment. The rating agencies also had a problem. The modeling of the dependencies of the names made the assumption that these were independent. It’s easy to calculate, but typically these names are not independent. You can argue that certain regions have high correlations, natural causes and such, so they are correlated more locally than all over the United States.



During the crisis, these defaults were kind of correlated, so more defaults generated more defaults.

They tended to use Gaussian models, which do not have tail dependence, which was the main issue. This kind of behavior wasn’t modeled, this possibility of loss.

## Synthetic CDOs

A cash CDO is an asset backed security **ABS** where the underlying assets are debt obligations. The sense is that you own the underlying assets in the portfolio. The long position in the corporate bond is similar to a short position in the CDS. So it’s a similar risk.

So another way to construct CDOs involves forming a similar structure. Instead of being long in the company bond, you can be short CDS. From a risk perspective it’s similar.

The originator of a **synthetic CDO** can select a portfolio of companies that have a certain maturity structure, and look at the CDS for the companies. The notional is the total notional of the CDS contracts.



Let’s say we have this example. We have an equity tranche which is responsible for losses in the underlying CDS until they reach 5% of the total notional principal. Let’s say this earns 1000 bp spread. The mezzanine tranche is responsible for losses between 5% and 20% (200 bp spread) and senior tranche is \>20% with 10bp spread.

In case of default, when you have such a default, the idea is that the income is paid on the remaining tranche principal. If losses reach 8% of the notional principal, then the equity tranche is wiped out, and 3% is taken from the mezzanine tranche. So tranche 2 earns the promised 200 bps spread on 80% of its principal, because they have incurred losses. The promised return is applied to the surviving principal of that particular tranche.



## Single Tranche Trading

You can trade tranches of portfolios of CDSs without actually forming the portfolio. Cash flows are calculated in the same way as if the portfolios were formed. We can discuss a little bit of the description of the waterfall for the single tranche CDO.



In general we have the buyer of protection on the tranche, and the seller of the protection. The portfolio of short CDS positions is going to be used as a reference point which defines the cash flows between these two sides. This portfolio is not created just referenced. The buyer will pay the tranche spread to the seller, and the seller pays the amount that corresponds to the losses in the reference CDS. We can discuss the pricing model.



PAGE 2 NOTES

We have a simple payoff function, and this function is dependent on the cumulative default and percentage loss on the portfolio.



We define some quantities which map the tranche to the reference portfolio.

PAGE 3 NOTES

These are two extreme points.



And we can see how fractional loss becomes a linear function.

PAGE 4 NOTES



Then the function becomes very simple.

PAGE 5 NOTES



What is the mechanics of the payments? It depends on the evolution of this function.

PAGE 5 NOTES CONTINUED

PAGE 6 NOTES



What is happening with the protection leg? This is how you protect yourself from losses on the CDS.

PAGE 7 NOTES

If there’s no change in the value, then there’s no payments.



Typically we want to run Monte Carlo simulations. The problem is that you have one default, and then you get all these different cases. So you have to simulate very large numbers. We will look at these simulations in the second part.



PAGE 8 NOTES

The percentage loss is not just 1/Nc, because it may be reduced by recovery.

PAGE 8 NOTES CONTINUED

The loss is dependent on the detachment point. The cumulative losses in the reference portfolio are going to be greater than than in the tranche.



Lecture\_8.pdf textbook image:

This is an illustration of a possible realization.

This one has some characteristics. In this case the reference portfolio consists of 100 credits with a FV exposure of $10M. That’s the reference portfolio. Then you can define a tranche, which has the FV of $30M, and the contractual spread is 250 bp. The attachment point is 3%, width is 4%, and a maturity of five years.



Then you have a simulation for a possible example. Let’s look at some characteristics.

You have a payment schedule which is quarterly. We can do some calculations. For example, we have one loss in Jun 2007 from the reference portfolio. So how does this translate? This is cumulative percentage loss in the reference portfolio.

PAGE 9 NOTES

Here we assume that it’s a homogeneous portfolio.



This means we have 5 defaults in the portfolio before the tranche will begin to incur a loss.

Let’s look at when we have 5 defaults in Jun 2009\. What is the tranche loss? This is going to be a linear function.



This means if you get one such default, you get X% loss in the tranche. The tranche notional will reduce. There will also be a loss in payment by the protection seller.



PAGE 10 NOTES

You have two sides. The protection buyer will pay the tranche spread to the seller. They will get protection for a particular principal, which covers a particular cumulative default loss in that portfolio, a certain interval. In order to get protection for the losses. The losses are constructed out of the reference portfolio. So the payments are done for protection, which are the spread, which are specific to tranche. In the case of that protection. The net flow is from the point of the view of the seller. If you have positive cash flows, and defaults and then you have to make payments.



## Senior Tranche

This works very well for the equity and mezzanine tranche. The senior tranche requires a small modification and some care.

PAGE 10 NOTES CONTINUED

Then you can calculate the tranche loss given a detachment point of 100% i.e. full loss.

PAGE 11 NOTES

This is the cumulative default loss in the portfolio.

This doesn’t make sense because if the reference portfolio is wiped out, then the tranche should be wiped out. Then the senior tranche investors continue to receive payment in 44% of the tranche value.

There is a solution to this:

PAGE 11 NOTES CONTINUED

In which case the fractional loss of such tranche is going to be map onto the maximum loss in the cumulative loss in the reference portfolio

## Correlation

We are interested in the general portfolio distribution, and such portfolio loss distribution is going to indicate the probability of certain losses in the future.

PAGE 12 NOTES

It’s important to estimate this. We need some information about the portfolio loss distribution at different horizons, 1 default, 2 default, n defaults, 1 year, 5 years, n years etc. So this density is an important quantity.

PAGE 12 NOTES CONTINUED

Here we can assume that for different maturities, the recovery rates may be different. Nc is the number of names. This is the cumulative fractional loss in the portfolio.

The important part is that we have a discrete number of names (credit derivatives) in the portfolio.



Furthermore, such loss L(T) are weighted. We can do some simplifications, (in some cases you cannot do this and you have to do simulations), if we make some assumptions.

PAGE 13 NOTES

Recovery rate R\_I is a constant, but may not be known in advance.

The expectation of the indicator function, that there is going to be a default, is the same as \[1-Q\_i(0, T)\].



The variance and the shape of distribution may be independent from the correlation, but the expectation is independent.



We can write

PAGE 13 NOTES CONTINUED



In this figure Lecture\_8.pdf portfolio loss distribution figure.

This figure shows the portfolio loss distribution, which is implied by three different values of correlation. This is generated by using the Gaussian copula model which we will discuss, essentially a multinormal distribution. Here we can look at loss distribution, other distribution of such loss function. We look at linked default between default correlation and single tranche CDO. As we saw, loss of portfolio is independent of default correlation. The expected value of the loss distribution is going to be the center at 5%, that makes sense. We illustrate when there is no zero correlation, and also when there is medium correlation and high correlation.

What can we see? When the correlation is zero, the names do not default together. The portfolio loss is between 0% and 100%. If you have a senior tranche with an attachment point of 10%, you have a very low probability that such tranche is affected. In a high correlation environment, then the credits have a high probability of surviving default together. You have a high probability of losses exceeding 10%, so the senior tranche would incur loss.

The conclusion of this, if you are a senior investor, and you are in an environment where you have very low correlation, then names should be as independent as possible. But typically, the institutions and financial firms that construct CDOs, they have an expected loss. If you hold such equity tranche, you might have a better chance of surviving this high correlation environment.



## Valuation of Tranches of Synthetic CDOs and Basket CDSs

SLIDE 11

We will look at some copula functions that follow this.

SLIDE 12

If we have a homogeneous portfolio, then… In this context Q is the cumulative default probability, not survival. We will discuss this first formula a little later when we discuss factor models. We assume we have some probability of default.



But, this would be for the names that are not correlated. We can impose some dependency between the names in the portfolio. We will look at factor models, starting with single factor, then looking at multiple factors, and generalizing with copula models. Next week we will discuss this in more depth.

## Single Factor Models

Lecture\_9.pdf

We will generalize with a single Gaussian distribution, and then make more complicated. This model has flexibility when modeling such portfolio.

PAGE 14 NOTES

## The Gaussian Latent Variable Model

We will not go through the model, just introduce the quantities. This is a factor model.

We have a random variable A\_i associated with credit i, each credit in the portfolio.

And we assume that A\_i \~ N(0, 1).

This particular model, we define that a default occurs when before time T if the value of A\_i is less than a time dependent threshold, which we will soon define.

Each name in the portfolio is associated with a normal random variable, and we assume when we have a default.



PAGE 15 NOTES

The probability of default before T is the same as the probability that the random variable is smaller than or equal to this time dependent threshold C\_i(T).

This A\_i is normally distributed. So this probability can be defined through the normal CDF.



The probability of default can also be defined as 1 \- the survival probability (for credit i) up to T.

If you have the CDS available on this instrument, that is another means of estimating the probability of default.



This is a model that can be calibrated to the market.

PAGE 16 NOTES



Then we can get the time-dependent threshold.

By having such means to calibrate, we can get the time-dependent threshold from the survival probability.



SLIDE 3

In this particular table, what do we have?

We have a relationship between the hazard rates and the survival probabilities, as previously discussed.

PAGE 16 NOTES CONTINUED

If you have such implied hazard rates, you can calculate the survival probability. This is very useful when you can use the CDS .

For a small hazard rate, it means a higher survival probability, and vice versa.



When survival probability is close to 1, 0.999, then the value of the threshold is the inverse cdf of 1 \- this value. This value is very small. So this is going to be on the left tail. The value in the threshold represents this. As you increase or decrease survival probability, this threshold changes.



We have S\_i normally distributed, if it’s smaller than the time dependent threshold, it has a variable probability. And it’s based on the real market. We can take time present to the future, and it changes, because the survival probability does as well.



If the survival probability is 0.5, then the threshold should be 0\.



This is something that you can calibrate on the market.



PAGE 16 NOTES CONTINUED REMARK



Because A\_i has no dynamics and is not observable, it is latent, hence the name.



SLIDE 4

We can see the relationship between A and the time-dependent threshold. It’s calibrated to the market, either through a single or multiple hazard rates. Either way you should be able to construct it. A\_i is fixed. At time tau\_1, A\_i hits the threshold and defaults. For each realization of S\_i, you get the time of default. Which means that you can get a distribution of times of default, expectation, and confidence. This is the relationship between S\_i and default.



PAGE 17 NOTES

For each value we simulate from A\_i, we get a time of default tau\_i. The algorithm is very simple, we calculate A\_i and calculate times of default, so we get the mean and distribution.

This is a building block.

Next week we will look at correlation. These names in the portfolio no longer need to have the same probability of default, each of them is dependent on its own hazard rate, and we can assume we have different nominal values, principal values, and we can also model initially a one-factor model, which has a single factor and also an idiosyncratic component, and then it’s about exposure to this factor. This offers a lot of flexibility in modeling. These models are about modeling the default time.



PAGE 18 NOTES

The idea is that you generate and calculate such default times. This will just give you the distribution of times of default. If the names are independent, you can generate all these times of default, and then you can get a distribution up to time T. This will have a vector. If you have 10k times, you can run this for all the credits. For time \= 1 year, what is the probability of having 1, 2, n defaults. Then you can calculate expected loss based on the principal. And this is calibrated on the market’s hazard rates.

## Next Week

Will be remote, most likely.
