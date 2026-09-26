/*
title = "Multi-Name Credit Risk"
date = 2025-04-24
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Copulas","Dependence Modelling","Multi-Name Credit Risk"]
*/

== Copulas
<copulas>
This is going to be a basic introduction, this is a complex topic to cover comprehensively.

== Limitations of Multi-Name Latent Variables
<limitations-of-multi-name-latent-variables>
The Gaussian latent-variable framework and conditional-independence construction are developed in O’Kane's Chapter 13 (pp. 241–258). Its one-factor version is useful for simulating default times and calibrating thresholds to single-name hazard rates, but one common factor constrains how the names can move together.

The Multi-Name latent variable model is single factor. There is one variable which is seen by the other credits. They each have their own idiosyncratic component. In terms of properties, simulations, that's it. We looked at conditional hazard rate and calculation of the portfolio of loss. Last assignment is related to this particular topic.

We can model the correlation, we can simulate, we can calibrate, the time-dependent threshold, based on the hazard rate and survival probabilities.

How can we extend this model?

There's #strong[limitations on the one-factor correlation structure].

In one-factor, we have a number of correlation parameters $N_c$. Recall that the correlation between two credits $i$ and $j$ is $beta_(i j)$. We have the constraint that the absolute value of each correlation parameter is less than or equal to $1$.

The entire correlation matrix has $frac(N_c\(N_c - 1\), 2)$ correlation parameters, which is a lot.

The question we can ask: Does one factor structure prevent the modeling of groups, or #strong[sectors]? The model may be insufficient.

We can look at some examples. Consider a simple portfolio of $4$ credits grouped in two sectors. How can we represent such groups? We could take $beta_1 = beta_2 = beta_a$. These two stocks will have the same exposure to the market variable $z$, and vice versa for the other sector $beta_3 = beta_4 = beta_b$.

In a single factor model, the correlation is the product of two correlation parameters for two credits.

$ C = mat(delim: "[", 1, beta_a^2, beta_a beta_b, beta_a beta_b med beta_a^2, 1, beta_a beta_b, beta_a beta_b med beta_a beta_b, beta_a beta_b 1, beta_b^2 med beta_a beta_b, beta_a beta_b, beta_b^2, 1) $

If you split this into four square matrices, then you'll see the sub-correlation matrix for each group. The correlation between the two groups.

Let's assume that beta\_a \> beta\_b \> 0. One is more exposed to the market than the other. This also implies that

$ c = beta_a^2 gt.eq beta_a beta_b gt.eq beta_b^2 $

For example, take $beta_a=0.8$ and $beta_b=0.5$. The within-sector correlations are $beta_a^2=64%$ in sector A and $beta_b^2=25%$ in sector B. The cross-sector correlation is $beta_a beta_b=40%$. Sector B is therefore more correlated with sector A than it is with itself. That is the one-factor limitation: every correlation must be the product of two loadings on the same market factor.

Sector B is not fully captured.

So we can try to extend the model, make it more complex, and accommodate this particular scenario.

In this case, we can consider a #strong[two-factor] version of the model.

For some credit i, we have

$ A_i = beta_(1 i) Z_1 + beta_(2 i) Z_2 + sqrt(1 - beta_(1 i)^2 - beta_(2 i)^2) epsilon.alt_i $

$ A_j = beta_(1 j) Z_1 + beta_(2 j) Z_2 + sqrt(1 - beta_(1 j)^2 - beta_(2 j)^2) epsilon.alt_j $

Similar to the previous formulation, but with one more factor.

The linear combination of standard normal is standard normal, so that doesn't change.

The latent variable A\_j corresponds still to the time-dependent threshold for each credit.

We can calculate the correlation between these assets in a similar kind of matrix. For each element:

$ c_(i j) = beta_(1 i) beta_(1 j) + beta_(2 i) beta_(2 j) $

We can revisit the matrix in the following case.

In sector A, the credits have a first factor weight and second factor weight beta\_1a and beta\_2a.

Sector B is similar with beta\_1b and beta\_2b

This is more generic, you would say this group has correlation to these factors.

We'll assume the first credits are from sector A.

That would be the correlation between credit a in sector a and b in sector b

$ c = mat(delim: "[", 1, beta_(1 a)^2 + beta_(2 a)^2, beta_(1 a) beta_(1 b) + beta_(2 a) beta_(2 b), beta_(1 a) beta_(1 b) + beta_(2 a) beta_(2 b) med beta_(1 a)^2 + beta_(2 a)^2, 1, beta_(1 a) beta_(1 b) + beta_(2 a) beta_(2 b), beta_(1 a) beta_(1 b) + beta_(2 a) beta_(2 b)) $

\(Bottom half is same as top half, mirrored)

For example, give sector A loadings $(beta_(1a), beta_(2a))=(0.8,0)$ and sector B loadings $(beta_(1b), beta_(2b))=(0,0.5)$. The within-sector correlations are then 64% for A and 25% for B, while the cross-sector correlation is the dot product $0.8 dot 0 + 0 dot 0.5=0$. Separate factors can represent strong dependence within each group and weaker dependence across groups. More generally, the correlation between two credits is the dot product of their factor-loading vectors.

In general, M-factors are needed to model M-sector portfolio. Three sectors? Three factors.

The simulation is very simple, but instead of generating just a Z\_1, we generate Z\_1 and Z\_2. It becomes a little more complex, with the number of parameters, compared to a single factor. We go from n(n-1)/2, to a lot more. If you want to implement these, you need to calibrate the exposure to the parameters. So the complexity becomes prohibitive, and that's a limitation.

It has some applicability, but in general, the more typical way is through copula functions.

== Copulas (Finally)
<copulas-finally>
You can model default time dependencies, correlations for default times. We also will have measures of dependency. We will look at main copulas for credit modeling, and Monte Carlo pricing of correlated products with copulas.

We'll look at some properties, and dependency limits, and some relations between copulas and the model we just discussed. And other ways of modeling dependence than correlation. If we have time, we'll have some code to visualize copulas.

Next week, I have a section for estimation of parameters of copulas, more complex. But for the final exam, copulas will not be included.

The latent variable model can also be expressed as a Gaussian copula, so they are related.

#strong[Definition: An N-dimensional copula function C is a multivariate cumulative distribution function with N uniform marginals with probabilities u\_1, u\_2, … u\_N.]

This is just the multivariate cdf. One of the characteristics is that it has uniform marginals. So we can say that thIS IS THE JOINT PROBABILITY

$ bb(P)\(hat(U_1) lt.eq u_1\,hat(U_2) lt.eq u_2 dots.h hat(U_N) lt.eq u_N\)= C\(u_1\,u_2 dots.h u_N\) $

This is the definition of such copulas where

$ hat(U_i) tilde.op upright(" Uniform")\(0\,1\) $

== Dependent Structure of Default Times of N Credits
<dependent-structure-of-default-times-of-n-credits>
Let $q_i(t)=P(tau_i<=t)$ be credit $i$'s cumulative default probability by time $t$. The default-time copula is

$C(q_1(t_1), q_2(t_2), dots.h, q_N(t_N))=P(tau_1<=t_1, tau_2<=t_2, dots.h, tau_N<=t_N)$.

It expresses the joint probability of defaults by their marginal default probabilities. A copula is a multivariate distribution with uniform marginals; it separates the choice of each name's marginal default curve from the choice of dependence across names. For continuous marginal distributions, Sklar's theorem gives a unique copula representation:

$H(x_1, dots.h, x_N)=C(F_1(x_1), dots.h, F_N(x_N))$.

Setting all but one input to one recovers that name's marginal, for example $C(1, dots.h, u_k, dots.h, 1)=u_k$. If any default probability is zero, the joint-default probability is zero. The same construction works in $N$ dimensions; the bivariate case is a convenient way to display it.

For the Gaussian latent-variable model, the bivariate default probability is

$P(tau_i<=t_i, tau_j<=t_j)=Phi_2(Phi^(-1)(q_i(t_i)), Phi^(-1)(q_j(t_j)); rho_(i,j))$.

Equivalently, its Gaussian copula is $C_(rho)^(G C)(u,v)=Phi_2(Phi^(-1)(u), Phi^(-1)(v); rho)$. This is the expression that was missing from the original note at this point (O’Kane, Chapter 14, pp. 261–263).

== Dependency Limits
<dependency-limits>
Latent variable model has #strong[dependence limits]. We kind of look to see when we have positive and negative dependence of names in the portfolio. This is not equal to the correlations, but we can think a little bit in that way.

When we have an expression for a copula, (the joint probability distribution), it's good to look at these properties to see the maximum and minimum dependence, and then how to measure them, based on differences dependency metrics.

== Independence
<independence>
The simplest is independence.

The expression for such an independence copula is

$ C\(u_1\,u_2\,dots.h u_N\)= u_1 u_2 dots.h u_N = product_(i = 1)^N u_i $

If they're independent, the joint probability distribution is the product of the marginals.

== Perfect Positive Dependence
<perfect-positive-dependence>
== Perfect Negative Dependence
<perfect-negative-dependence>
We can then state the #strong[Fréchet-Hoeffding Theorem:]

For any copula $C: [0, 1]^N arrow.r [0, 1]$

and any realization $(u_1, dots.h u_N) in [0, 1]^N$, the following bounds hold:

$ w\(u_1\,u_2 dots.h u_N\)lt.eq C\(u_1\,u_2 dots.h u_N\)lt.eq M\(u_1\,dots.h u_N\) $

Basically this theorem says if you have a copula with a particular realization, this copula is bounded above and below by two functions M and w.

w the lower Fréchet-Hoeffding bound is

$ w\(u_1\,dots.h u_N\)=\(1 - N + sum_(i = 1)^N u_i\)_(+) $

and upper bound is

$ M\(u_1\,dots.h u_N\)= min\(u_1\,dots.h u_N\) $

In the bivariate case where we only have two variables u and v, we have

$ max\(u + v - 1\,0\)lt.eq C\(u\,v\)lt.eq min\(u\,v\) $

Upper bound is perfect positive, lower bound is perfect negative.

This result holds for #strong[any copula].

Ideally we would like to estimate this copula with some data. We need to make a choice for this expression, and estimate those parameters.

But the question is, this is a representation of the original joint probability distribution, but is this a unique representation? Can we have different copulas for this?

We have one more theorem, #strong[Sklar's Theorem].

We know by definition, the copula is a multivariate distribution function.

Any such function can be written as a copula, and its representation is unique, the marginal distributions are continuous. If you have discrete distributions, then uniqueness is not guaranteed.

Let's consider more generally, any N-dimensional distribution function H with marginal distributions F\_1, F\_2, F\_N for random variables x\_1, x\_2, … x\_N. H is the joint probability distribution.

Because this is multi-dimensional, this will correspond to

$ H\(x_1\,x_2\,dots.h x_N\)= bb(P)\(X_1 lt.eq x_1\,X_2 lt.eq x_2 dots.h\,X_N lt.eq x_N\) $

We can write this as the probability that the marginal function F\_1

$ = bb(P)\(F_1\(X_1\)lt.eq F_1\(x_1\)\,F_2\(X_2\)lt.eq F_2\(x_2\)\,dots.h F_N\(X_N\)lt.eq F_N\(x_N\)\) $

We basically want to transform this to get a copula function, to get here from a generic N-dimensional function.

Let $hat(U_i) = F_i\(X_i\)$ and the realization $u_i = F_i\(x_i\)$ The marginal will take values between 0 and 1, it's a cdf.

The original function

$ H\(x_1\,x_2 dots.h x_N\)= bb(P)\(hat(U_1) lt.eq u_1\,dots.h hat(U_N) lt.eq u_N\) $

$ H\(x_1\,x_2 dots.h x_N\)= C\(F_1\(x_1\)\,F_2\(x_2\)dots.h F_N\(x_n\)\) $

We know that C is a unique copula if these Fs are continuous.

And in reverse,

$ C\(u_1\,u_2 dots.h u_N\)= H\(F_1^(- 1)\(u_1\)\,F_2^(- 1)\(u_2\)\,dots.h F_N^(- 1)\(u_N\)\) $

The relationship between these two is that the copula is going to separate the choice of the marginals from the choice of the dependency structures. It decouples these things. We can take any function and its copula representation, and calibrate it to the names of the portfolio independent of the dependency structure based on the way I want to assign dependency to this portfolio.

We might want to add some dynamics to this dependencies, the difference between credit default so we can calculate the conditional survival/default probability. We could impose this by choosing a different dependency structure.

== Alternative to Dependence Structure of Default Times
<alternative-to-dependence-structure-of-default-times>
The survival copula uses survival probabilities $s_i(t)=1-q_i(t)$:

$hat(C)(s_1(t_1), dots.h, s_N(t_N))=P(tau_1>t_1, dots.h, tau_N>t_N)$.

In the bivariate case, the default and survival copulas are related by

$hat(C)(u,v)=u+v-1+C(1-u,1-v)$.

For the Gaussian latent-variable model, default thresholds are jointly normal. The probability that both thresholds have been crossed is

$P(tau_i<=t_i, tau_j<=t_j)=Phi_2(Phi^(-1)(q_i(t_i)), Phi^(-1)(q_j(t_j)); rho_(i,j))$.

Thus the Gaussian copula is

$C_(rho)^(G C)(u,v)=Phi_2(Phi^(-1)(u), Phi^(-1)(v); rho)$.

The standard bivariate normal is unchanged when both variables are multiplied by $-1$. As a result, the Gaussian default and survival copulas have the same form. For a non-degenerate Gaussian copula, extreme joint events become less likely relative to their marginal tails as the thresholds move farther out: its upper- and lower-tail dependence coefficients are zero (O’Kane, Chapter 14, pp. 261–263, 269–270).

== Measuring Dependence
<measuring-dependence>
An important property of this is dependence, so the question is how do you measure?

There are many ways.

The most popular way is #strong[Pearson Linear Correlation].

$ rho_P = frac(bb(E)[X Y] - bb(E)[X] bb(E)[Y], sqrt(bb(E)[X^2] - bb(E)[X]^2) sqrt(bb(E)[Y^2] - bb(E)[Y]^2)) $

Advantages: easier to understand. Everyone understands correlation. It is also invariant under linear transformation. Say we change the variables by scaling and shifting (multiplying and adding), it doesn't affect the correlation.

For jointly Gaussian variables, zero correlation does imply independence.

However, there is a big disadvantage: linear correlation being 0 DOES NOT imply independence in general

Sometimes the correlation is abused. It is a measure of linear dependence between variables. But just because there's no linear dependence, doesn't mean there are other kinds of dependence.

Here is a five-point counterexample. Let $X$ take the equally likely values $-2,-1,0,1,2$, and set $Y=X^2$. Then $E[X]=0$, $E[Y]=2$, and $E[X Y]=E[X^3]=0$, so

$upright("Cov")(X,Y)=E[X Y]-E[X]E[Y]=0$.

Yet $Y$ is completely determined by $X$. The variables are dependent, but their linear correlation is zero. This illustrates why Pearson correlation alone does not describe general dependence (O’Kane, Chapter 14, §14.3, pp. 264–265).

== #strong[Rank Correlation]
<rank-correlation>
Given $n$ observations $(X_i,Y_i)$, let $R_i$ and $S_i$ be the ranks of $X_i$ and $Y_i$. A pair of observations is concordant when their order agrees:

$\(X_1-X_2\)\(Y_1-Y_2\)>0$.

It is discordant when the product is negative. Rank measures compare these orderings, so a monotone transformation of either variable does not change them.

For example, if five observations have identical ranks in both variables, then all $binom(5,2)=10$ pairs are concordant and none are discordant. Kendall's tau and Spearman's rho are both $1$. This spells out the perfectly ordered example in the notes (O’Kane, Chapter 14, §14.4, pp. 265–268).

=== Kendall's Tau
<kendalls-tau>
$ tau = frac(c - d, c + d) $

where c is the number of concordant pairs, and d is the number of discordant pairs.

Then the total number of pairs is c + d, which n choose 2 = n(n-1)/2.

In the previous case, all of these are concordant, so this is 1/1.

And if it's discordant, that's -1.

The sample estimator of Kendall's τ is

$ tau = frac(2 sum_(i = 1)^(n - 1) sum_(j = i + 1)^n "sign"\(\(x_i - x_j\)\(y_i - y_j\)\), n\(n - 1\)) $

So basically you're enumerating all these pairs, and then dividing it by the known bottom, and flipping the 2.

For continuous variables, independence gives $tau=0$, perfect positive dependence gives $tau=1$, and perfect negative dependence gives $tau=-1$.

For a continuous x, y, Kendall's tau should be

$ tau_(x y) = 4 integral_0^1 integral_0^1 C\(u\,v\)d C\(u\,v\)- 1 $

=== Spearman's Rho
<spearmans-rho>
Spearman's rho is Pearson correlation applied to the ranks. With no ties, it can be calculated directly from the rank differences:

$ rho_S = frac(sum_(i = 1)^n\(R_i - macron(R)\)\(S_i - macron(S)\), sqrt(sum_(i = 1)^n\(R_i - macron(R)\)^2) sqrt(sum_(i = 1)^n\(S_i - macron(S)\)^2)) = frac(12 sum_(i = 1)^n\(R_i - macron(R)\)\(S_i - macron(S)\), n\(n^2 - 1\)) $

Furthermore, for a continuous x and y.

$ rho_S = 12 integral_0^1 integral_0^1 C\(u\,v\)d u d v - 3 $

This is important because for each copula it's going to be dependent, as a function of those parameters, it's going to have different values in the Pearson, Kendall or Spearman value.

There are some advantages to rank correlation, which is that it's able to capture nonlinear dependence, but it has some disadvantage as well.

== Tail Dependence
<tail-dependence>
Rank correlation records whether observations tend to move in the same or opposite order, but it does not measure the magnitude of extreme co-movements. Tail dependence asks whether one variable remains extreme when the other is already in an extreme tail.

For variables with marginal CDFs $F_X$ and $F_Y$, the upper-tail dependence coefficient is

$lambda_U = lim_(u arrow.r 1) P(Y > F_Y^(-1)(u) | X > F_X^(-1)(u))$.

The lower-tail coefficient is

$lambda_L = lim_(u arrow.r 0) P(Y <= F_Y^(-1)(u) | X <= F_X^(-1)(u))$.

Here $u$ is a quantile level. In credit-risk terms, joint defaults correspond to the lower tail of latent asset values, while large portfolio losses correspond to the upper tail of losses. A positive coefficient means that an extreme observation in one variable has a non-vanishing limiting probability of being accompanied by an extreme observation in the other. The tail plot in the notes is illustrating this limiting behavior.

The Gaussian copula has zero upper- and lower-tail dependence for correlations strictly between $-1$ and $1$. It can match ordinary dependence while understating the chance of joint extremes; a copula with tail dependence is needed when that behavior matters (O’Kane, Chapter 14, §§14.5–14.6, pp. 269–270).
