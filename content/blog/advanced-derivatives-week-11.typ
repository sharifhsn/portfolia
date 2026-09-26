/*
title = "Structured Credit and CDOs"
date = 2025-04-10
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","CDOs","Structured Credit","Tranches","Synthetic CDOs"]
*/

== Final
<final>
Last day of class is Thursday, May 8.

The final exam is going to be posted then, take-home exam. It'll be posted like an assignment.

Will be posted in evening around 6:30, you'll have Friday and Saturday night to do this.

Questions will be theoretical.

== Multi-names
<multi-names>
Last lectures we discussed the mechanics of single-name derivatives like the credit default swaps, and the calculation of the implied hazard rates. This is what is calculated in the assignments, along with default/survival probabilities.

Now we will discuss the multi-name credit derivative, mainly the #strong[CDO: Collateralized Debt Obligation].

These are securities whose payments are linked to the incidence of default of an underlying portfolio of credit risky assets. It's based on not just one, but a portfolio of risky assets.

The most interesting component of this is modeling the dependencies in the portfolio, and then calculating the fractional loss in the portfolio, and essentially pricing. So you have a basket of such credit-linked assets, then the question is, if you want to sell a portion of this portfolio, in shares, what should be that price? Basically you need to calculate the cash flows, as well as expected loss. Same idea as fair price of two legs as in CDS.

Some of these instruments are more complex, but in general, we can consider asset-backed securities. They are formed from loans, bonds, mortgages, and so forth. Usually, the income from the assets is tranched. A MBS has claims on money generated from these pools, cash flows that these mortgages generate from regular payments. If you aggregate these together, you get cash flows. These will be distributed to the owners of the pool.

MBS that are created by adding many such mortgages and selling shares on the revolving pool. For example, such security is secured by the underlying mortgages.

This kind of instrument is obviously more convenient to put in a portfolio than a single-name. If you want a single bond, you are dependent on the probability of default on the counterparty. If you have two bonds, then you have two probabilities of default. You might have probability $p$ of default, and the probability of both defaulting is $p_1 p_2$ (absent some dependencies between bond defaults). It's an expectation that helps in constructing such pools.

We can calculate under different assumptions. Let's say we assume that you have no correlations for them, that would be a simple formula. You would want to get a distribution, the probability that you have 1, 2, n names default. If you have the probability of default, if you assume that's a homogeneous portfolio where all bonds have same probability of default. Then you would enumerate the number of ways that you can have 3 bonds default in the portfolio, which forms the distribution.

Some assumptions, it helps in some way to have diversification. But many times, these mortgage bonds wouldn't sell because their credit rating was too bad, like DDD. You can have CMOs, which consist of multiple pools of securities, which are #strong[tranches] (or slices). The idea is that even if it's a homogeneous universe of very low-rated loans, like BBB, if you have the securitization of this and construct the CMO and CDO in such a way that they would have AAA rating. We will look at such a mechanism.

== Waterfall
<waterfall>
Lecture 8, slide 2 (PDF p. 2), says that securities are created from “a portfolio of loans, bonds, credit card receivables, mortgages, auto loans, aircraft leases, music royalties, etc.” Usually, “the income from the assets is tranched.” It defines a waterfall this way: “income is first used to pay the promised return to the senior tranche, then to the next most senior tranche, and so on.” Slide 4, titled “The Waterfall,” draws the asset cash flows passing through senior, mezzanine, and equity tranches.

Slide 3 (PDF p. 3) shows assets with \$100 million principal transferred to an SPV, which issues these claims:

#table(
  columns: 3,
  align: (left, center, left),
  inset: 4pt,
  stroke: 0.5pt,
  [*Tranche*], [*Principal*], [*Return*],
  [Senior], [\$80 million], [LIBOR + 60 bp],
  [Mezzanine], [\$15 million], [LIBOR + 250 bp],
  [Equity], [\$5 million], [LIBOR + 2,000 bp],
)

Basically, the waterfall, which is also called the structure subordination, this describes the scheduled coupon and principal payments from different securities. It also describes the losses. The arrangement of this pool will generate cash flows. This cash flow is used first to pay the senior tranche. Then after the senior tranche is completely paid, the cash flows go to mezzanine, then equity. So as long as you have no defaults, this system works. But when you have a loss, the loss is first taken by the equity tranche, then the mezzanine, and then the senior tranche. This structure of subordination or waterfall creates advantages and disadvantages for the equity tranche. This tranche is far riskier than the other tranches. The idea behind the whole mechanism is to have many market participants. The senior tranche has AAA rating. The rating agencies will rate these particular tranches. The magic of it was to take something rated BBB and turn it into something rated AAA. You could take the mezzanine tranche from multiple CDOs and get a new CDO from that. Things got kind of complicated.

== 2008
<section>
Along with the increase in prices of homes, the MBS market reached \$4 trillion. Wall Street issued something like \$700 billion in CDOs. This is a kind of interesting instrument. There were many problems. The mortgages given in the first place had various loose criteria. People would get houses without giving a down payment. The rating agencies also had a problem. The modeling of the dependencies of the names made the assumption that these were independent. It's easy to calculate, but typically these names are not independent. You can argue that certain regions have high correlations, natural causes and such, so they are correlated more locally than all over the United States.

During the crisis, these defaults were kind of correlated, so more defaults generated more defaults.

They tended to use Gaussian models, which do not have tail dependence, which was the main issue. This kind of behavior wasn't modeled, this possibility of loss.

== Synthetic CDOs
<synthetic-cdos>
Lecture 8, slide 5 (PDF p. 5), states: “A cash CDO is an ABS where the underlying assets are debt obligations”; “a synthetic CDO involves forming a similar structure with short CDS contracts.” It continues: “In a synthetic CDO most junior tranche bears losses first. After it has been wiped out, the second most junior tranche bears losses, and so on.”

The originator of a #strong[synthetic CDO] can select a portfolio of companies that have a certain maturity structure, and look at the CDS for the companies. The notional is the total notional of the CDS contracts.

Slide 6 (PDF p. 6) gives the tranche boundaries and spreads:

#table(
  columns: 3,
  align: (left, left, left),
  inset: 4pt,
  stroke: 0.5pt,
  [*Tranche*], [*Loss allocation*], [*Spread*],
  [Equity], [Losses up to 5% of total CDS notional], [1,000 bp],
  [Mezzanine], [Losses between 5% and 20%], [200 bp],
  [Senior], [Losses over 20%], [10 bp],
)

Slide 7 (PDF p. 7) states: “The income is paid on the remaining tranche principal.” Its example says that when losses reach 8% of the principal underlying the CDSs, tranche 1 has been wiped out and tranche 2 earns its promised 200 bp spread on 80% of its principal. The remaining 80% follows because the 5%–20% mezzanine tranche has absorbed 3 percentage points of loss out of its 15-point width.

== Single Tranche Trading
<single-tranche-trading>
Lecture 8, slide 8 (PDF p. 8), says single-tranche trading “involves trading tranches of portfolios of CDSs without actually forming the portfolios”; “cash flows are calculated in the same way as they would be if the portfolios had been formed.” The protection buyer pays the tranche spread, and the protection seller pays losses falling inside the tranche's interval.

Let $A$ be the attachment point, $D$ the detachment point, and $L(T)$ the cumulative fractional loss on the reference portfolio by time $T$. The tranche width is $D-A$. Its fractional loss is

$ell_(A,D)(T) = min(1, max(0, frac(L(T) - A, D - A)))$

Before portfolio losses reach $A$, tranche loss is zero. As losses move from $A$ to $D$, the tranche loses principal linearly. Once portfolio losses reach $D$, the tranche is fully written down. For original tranche notional $N_(A,D)$, remaining notional is $N_(A,D)(1-ell_(A,D)(T))$. The protection payment at a default is the increase in tranche loss times its original notional; the premium payment is the contractual spread applied to the surviving notional for that accrual period. If the portfolio loss has not changed, the protection leg has no payment. Each credit's portfolio loss is its exposure times loss given default, so recovery reduces the loss below the full exposure.

Slide 9 (PDF p. 9) introduces the example: “The best way to make the mechanics of an STCDO clear is to consider a specific STCDO deal.” It uses 100 reference credits with \$10 million face exposure each, for \$1 billion total notional, and a \$30 million tranche with a 250 bp spread, 3% attachment point, 4% width, and five-year maturity. The slide reproduces Table 12.3, “Coupon and loss payments on the synthetic CDO example discussed in the text”:

#table(
  columns: 8,
  align: (left, center, center, center, center, center, center, center),
  inset: 3pt,
  stroke: 0.5pt,
  [*Payment date*], [*Number of defaults*], [*Portfolio loss (%)*], [*Tranche loss (%)*], [*Notional (\$m)*], [*Coupon payment*], [*Protection leg (\$m)*], [*Net flow*],
  [31 Mar 2007], [], [0.00], [0.0], [30.00], [], [], [],
  [30 Jun 2007], [1], [0.70], [0.0], [30.00], [191 667], [], [191 667],
  [30 Sep 2007], [], [0.70], [0.0], [30.00], [191 667], [], [191 667],
  [31 Dec 2007], [2], [1.40], [0.0], [30.00], [189 583], [], [189 583],
  [31 Mar 2008], [], [1.40], [0.0], [30.00], [189 583], [], [189 583],
  [30 Jun 2008], [3], [2.10], [0.0], [30.00], [191 667], [], [191 667],
  [30 Sep 2008], [], [2.10], [0.0], [30.00], [195 833], [], [195 833],
  [31 Dec 2008], [4], [2.80], [0.0], [30.00], [189 583], [], [189 583],
  [31 Mar 2009], [], [2.80], [0.0], [30.00], [183 333], [], [183 333],
  [30 Jun 2009], [5], [3.50], [12.5], [26.25], [195 833], [-3.75], [−3 554 167],
  [30 Sep 2009], [], [3.50], [12.5], [26.25], [165 885], [], [165 885],
  [31 Dec 2009], [6], [4.20], [30.0], [21.00], [165 885], [-5.25], [−5 084 115],
  [31 Mar 2010], [], [4.20], [30.0], [21.00], [132 708], [], [132 708],
  [30 Jun 2010], [7], [4.90], [47.5], [15.75], [132 708], [-5.25], [−5 117 292],
  [30 Sep 2010], [], [4.90], [47.5], [15.75], [99 531], [], [99 531],
  [31 Dec 2010], [8], [5.60], [65.0], [10.50], [99 531], [-5.25], [−5 150 469],
  [31 Mar 2011], [], [5.60], [65.0], [10.50], [66 354], [], [66 354],
  [30 Jun 2011], [9], [6.30], [82.5], [5.25], [66 354], [-5.25], [−5 183 646],
  [30 Sep 2011], [], [6.30], [82.5], [5.25], [33 542], [], [33 542],
  [31 Dec 2011], [10], [7.00], [100.0], [], [], [-5.25], [−5 250 000],
  [31 Mar 2012], [], [7.00], [100.0], [], [], [], [],
)

== Senior Tranche
<senior-tranche>
This works very well for the equity and mezzanine tranche. The senior tranche requires a small modification and some care.

For a senior tranche whose detachment point is 100%, complete loss of the reference portfolio must mean complete loss of the tranche. The loss assigned to the tranche is the portfolio loss above attachment, capped at the tranche width; to express it as a fraction of tranche principal, divide by that width. Thus, when $L(T)=1$ and $D=1$, the numerator and width both equal $1-A$, and $ell_(A,1)(T)=1$. The 44% noted in the example is a loss measured on the portfolio scale; after normalization by the senior tranche's 44% width, it is a 100% loss of that tranche.

== Correlation
<correlation>
Pricing a tranche requires the distribution of portfolio loss at each horizon: the probabilities of one, two, or more defaults by one year, five years, or another maturity. With credit $i$ weighted by portfolio share $w_i$ and recovery rate $R_i$, cumulative fractional portfolio loss is

$L(T) = sum_(i=1)^(N_c) w_i (1 - R_i) 1_(tau_i <= T)$.

The portfolio contains a discrete number of names, and exposures, default probabilities, and recoveries can differ across them. Its expected loss is

$E[L(T)] = sum_(i=1)^(N_c) w_i (1 - R_i) Q_i(T)$,

where $Q_i(T)=P(tau_i <= T)$. Holding those marginal default probabilities and recoveries fixed, changing dependence changes the shape and variance of the loss distribution, not its mean.

Slide 10 (PDF p. 10) captions its graph “The portfolio loss distribution for three levels of correlation.” The vertical axis is probability; the horizontal axis is portfolio loss (%); and the curves are labeled zero, medium, and high correlation. With the same marginal default probabilities, correlation changes the loss distribution's shape and tail, and therefore the chance that losses reach a given tranche.

Slide 11 (PDF p. 11) calls a factor-based Gaussian copula “a popular approach” for defining correlations between times to default. It says that often all pairwise correlations and all unconditional default distributions are assumed to be the same, and that the market implies a pairwise correlation from market quotes. Slide 12 (PDF p. 12), titled “Cumulative Default Probability Conditional on Factor,” gives the conditional default probability:

$Q(t|F) = Phi(frac(Phi^(-1)(Q(t)) - sqrt(rho) F, sqrt(1-rho)))$.

Given $F$, the number of defaults among $n$ names is binomial:

$P(K=k|F) = binom(n,k) Q(t|F)^k (1-Q(t|F))^(n-k)$.

The slide writes the conditional default-count probability as $n! / ((n-k)!k!) Q(t|F)^k [1-Q(t|F)]^(n-k)$ and says: “This enables cash flows conditional on $F$ to be calculated. By integrating over $F$ the unconditional distributions are obtained.”

== Valuation of Tranches of Synthetic CDOs and Basket CDSs
<valuation-of-tranches-of-synthetic-cdos-and-basket-cdss>
Copulas provide a way to model dependence across the names when valuing synthetic CDO tranches and basket CDSs.

For a homogeneous portfolio, let $Q\(t\)$ be the cumulative probability of default by time $t$. Conditional on the common Gaussian factor $F$, the per-name default probability is $q\(t divides F\)= Phi (frac(Phi^(- 1)\(Q\(t\)\)- sqrt(rho) F, sqrt(1 - rho)))$, where $Phi$ is the standard normal CDF. For $n$ names, the number of defaults is binomial conditional on $F$: $P\(K = k divides F\)= binom(n, k) q\(t divides F\)^k\(1 - q\(t divides F\)\)^(n - k)$. This makes cash flows conditional on $F$ tractable; integrating over $F$ gives the unconditional loss distribution.

But, this would be for the names that are not correlated. We can impose some dependency between the names in the portfolio. We will look at factor models, starting with single factor, then looking at multiple factors, and generalizing with copula models. Next week we will discuss this in more depth.

== Single Factor Models
<single-factor-models>
Lecture 9, slide 3 (PDF p. 3), captions its figure: “Time dependence of the survival probabilities and default thresholds $C(T)$ for issuer curves with flat deterministic hazard rates shown.” Slide 5 (PDF p. 5) is captioned “The joint default probability as a function of the asset correlation (4 cases).”

== The Gaussian Latent Variable Model
<the-gaussian-latent-variable-model>
This factor model assigns a standard-normal latent asset value to each credit:

$A_i = beta_i Z + sqrt(1-beta_i^2) epsilon_i$,

where the common market factor $Z$ and the name-specific idiosyncratic factors $epsilon_i$ are independent standard normals. The linear combination keeps each $A_i$ standard normal. Default by time $T$ occurs when $A_i$ falls below a time-dependent threshold $C_i(T)$.

If $Q_i(T)$ is the cumulative default probability and $S_i(T)=1-Q_i(T)$ is the survival probability, then

$Q_i(T) = P(A_i <= C_i(T)) = Phi(C_i(T))$, and $C_i(T)=Phi^(-1)(Q_i(T))=Phi^(-1)(1-S_i(T))$.

This links the latent threshold to market data. A CDS survival curve or an implied hazard rate supplies $S_i(T)$; the threshold is then calibrated at each horizon. When $S_i(T)=0.5$, the threshold is zero. When survival is near one, $Q_i(T)$ is small and the threshold lies far in the lower normal tail.

The asset value $A_i$ itself is unobserved and has no dynamics in this construction, which is why it is called latent. A simulated value of $A_i$ is held fixed while the calibrated threshold moves over time. Default occurs at the first crossing,

Default time $tau_i$ is the first time $t$ for which $A_i <= C_i(t)$.

Repeating this draw gives a distribution of default times, from which one can estimate the mean and confidence intervals. The four cases in slide 5 (PDF p. 5) show how joint-default probability changes with asset correlation. With name-specific hazard rates and notionals, the same simulation produces the distribution of the number of defaults and portfolio loss at each horizon.

== Next Week
<next-week>
Will be remote, most likely.
