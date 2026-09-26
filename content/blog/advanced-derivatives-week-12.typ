/*
title = "Dependence and Copulas"
date = 2025-04-17
description = "Lecture notes on minimum, independent, and maximum dependence in a one-factor credit model."
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit", "Dependence", "Copulas"]
*/

= Dependence cases

The one-factor model associates each credit with a latent asset value

$A_i = beta_i Z + sqrt(1-beta_i^2) epsilon_i$,

where $Z$ is the common market factor and each $epsilon_i$ is an independent idiosyncratic factor. The coefficients $beta_i$ determine how much each credit is exposed to the common factor; the asset correlation of two credits is $rho_(i,j)=beta_i beta_j$. The Lecture 9 notes introduce this model on PDF page 1.

Let $p_i(T)=P(tau_i<=T)$ be credit $i$'s default probability by time $T$. Changing the signs and sizes of the market-factor loadings gives three limiting dependence cases.

== Minimum dependence

The smallest joint-default probability comes from opposite exposures to the same market factor. In the limit, set $beta_i=1$ and $beta_j=-1$. Both idiosyncratic components disappear and the asset correlation is $rho_(i,j)=-1$. The joint-default probability is

$P(tau_i<=T, tau_j<=T)=max(p_i(T)+p_j(T)-1, 0)$.

It is zero whenever the two default probabilities sum to at most one. If their sum exceeds one, the joint probability is the excess over one.

== Independence

Set $beta_i=beta_j=0$. Each asset value is then only its own idiosyncratic factor, the correlation is zero, and the default events are independent:

$P(tau_i<=T, tau_j<=T)=p_i(T)p_j(T)$.

== Maximum dependence

Set $beta_i=beta_j=1$. Both credits have the same asset value $Z$ and their asset correlation is $1$. The joint-default probability is the smaller of their marginal default probabilities:

$P(tau_i<=T, tau_j<=T)=min(p_i(T),p_j(T))$.

Lecture 9, slide 5 (PDF p. 5), captions its graph “The joint default probability as a function of the asset correlation (4 cases).”

== Conditional hazard and portfolio loss

The April 17 handwritten lecture notes then condition on a realized common factor $Z=z$. With a flat deterministic conditional hazard rate, they write conditional survival as

$S_i(T|z)=e^(-lambda_i(T|z)T)=Phi(frac(beta_i z-C_i(T), sqrt(1-beta_i^2)))$,

so that

$lambda_i(T|z)=-frac(1,T) ln Phi(frac(beta_i z-C_i(T), sqrt(1-beta_i^2)))$.

Here $C_i(T)$ is the default threshold calibrated from the single-name survival curve. Conditioning on $z$ makes the credits independent: compute the portfolio-loss distribution at that factor value, then integrate over the common factor to obtain the unconditional distribution. The notes state this procedure on PDF page 4.

Lecture 9, slide 6 (PDF p. 6), captions the conditional hazard-rate plot: “Plot of conditional hazard rate distribution for $beta=0, 0.2, 0.4$,” assuming an unconditional hazard rate of 2% and a one-year horizon. Slide 3 (PDF p. 3) shows the time dependence of survival probabilities and default thresholds for issuer curves with flat deterministic hazard rates.
