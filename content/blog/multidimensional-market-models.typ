/*
title = 'Multidimensional Market Models'
date = 2024-11-14
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Market Models', 'Girsanov']
*/

== Week 10
<week-10>
=== Lecture Notes
<lecture-notes>
==== Midterm Review
<midterm-review>
==== Multi-Dimensional Girsanov
<multi-dimensional-girsanov>
The Girsanov states that

$Z\(t\)= exp (- integral_0^t Theta \( u \) d W \( u \))$

The norm of a process is the Euclidean Norm: $parallel Theta\(t\)parallel = sqrt(sum_(j = 1)^d Theta_j^2\(t\))$

And so the square of the norm is just that.

I have my Brownian motion

$tilde(W)\(t\)= W\(t\)+ integral_0^t Theta\(u\)d u$

And this is true for each dimension of a Brownian motion.

Once I'm in this fixed space, let's take a martingale $M\(t\)$. There is an adapted dimensional process $Gamma\(u\)$ such that

$M\(t\)= M\(0\)+ integral_0^t Gamma\(u\)thin d W\(u\)$

nonrandom initial constant plus Ito integral

There has to be vector under $tilde(bb(P))$ that satisfies this.

We already proved that any Ito integral with respect to a martingale is a martingale. Importantly, we can see that this is an Ito integral because we are evaluating from the left point, not mid or right point.

==== Multidimensional Market Model
<multidimensional-market-model>
This is a representation of this model. We are going to assume we have $m$ stocks, and $d$ different sources of noise. We're not saying which one we have more of. The valuation of a golf club would be based on commodities like wood and iron, which are two different sources of noise. We're going to set it up in such a way that every source of noise #emph[could], but doesn't #emph[have to], impact your stock.

The value of Nintendo doesn't care about fluctuations in the wood commodity. The coefficient of that source of noise would be 0.

The drift $alpha$ is applied to the stock, and then we will create the cov matrix based on the sources of noise which is applied to the stock.

$d S_i\(t\)= alpha_i\(t\)S_i\(t\)d t + S_i\(t\)sum_(j = 1)^d sigma_(i j)\(t\)d W_j\(t\)\,i = 1\,dots.h\,m$ Are these Brownian motions independent? We can find their covariance by

$"Cov"\(B_i\,B_k\)= bb(E)\[B_i B_k\]- bb(E)\[B_i\]bb(E)\[B_k\]$

We know that these are Brownian motions, so their expectation is 0.

$= bb(E)\[B_i B_k\]$

Since we don't know how they're related, the best way to approach this is via Ito decomposition.

$d\(B_i B_k\)= B_i d B_i + B_k d B_i + d B_i d B_k$

Definition of risk-neutral: $tilde(bb(P))$ and $bb(P)$ have to be equivalent.

And every single discounted stock price $D\(t\)S_i\(t\)$ must be a martingale.

When you rearrange this, you get

$alpha_i - R = sum_(j = 1)^d sigma_(i j) Theta_j$

And this is a system of $m$ equations with $d$ unknowns (dimensions).

==== Fundamental Theorem
<fundamental-theorem>
The expectation of an indicator is the same as the probability measure of the function being indicated.

Because prices are unique, you can only have a unique risk-neutral probability measure on them.
