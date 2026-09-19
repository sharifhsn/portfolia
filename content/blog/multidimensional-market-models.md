+++
title = 'Multidimensional Market Models'
date = 2024-11-14
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Market Models', 'Girsanov']
+++

## Week 10

### Lecture Notes

#### Midterm Review

#### Multi-Dimensional Girsanov

The Girsanov states that

\(Z(t) = \exp \left(-\int_0^t \Theta(u) dW(u)\)

The norm of a process is the Euclidean Norm:
\(\|\Theta(t)\| = \sqrt{\sum_{j=1}^d \Theta_j^2(t)}\)

And so the square of the norm is just that.



I have my Brownian motion

\(\tilde{W}(t) = W(t) + \int_0^t \Theta(u)du\)

And this is true for each dimension of a Brownian motion.



Once I’m in this fixed space, let’s take a martingale \(M(t)\). There is an adapted dimensional process \(\Gamm(u)\) such that

\(M(t) = M(0) + \int)^t \Gamma(u) dW(u)\)

nonrandom initial constant plus Ito integral

There has to be vector under \(\tilde{\mathbb{P}}\) that satisfies this.

We already proved that any Ito integral with respect to a martingale is a martingale. Importantly, we can see that this is an Ito integral because we are evaluating from the left point, not mid or right point.

#### Multidimensional Market Model

This is a representation of this model. We are going to assume we have \(m\) stocks, and \(d\) different sources of noise. We’re not saying which one we have more of. The valuation of a golf club would be based on commodities like wood and iron, which are two different sources of noise. We’re going to set it up in such a way that every source of noise *could*, but doesn’t *have to*, impact your stock.

The value of Nintendo doesn’t care about fluctuations in the wood commodity. The coefficient of that source of noise would be 0.

The drift α is applied to the stock, and then we will create the cov matrix based on the sources of noise which is applied to the stock.

\(dS_i(t) = \alpha_i(t)S_i(t) dt + S_i(t) \sum_{j=1}^d \sigma_{ij} (t) dW_j(t), i = 1, \ldots, m\)
Are these Brownian motions independent? We can find their covariance by

\(Cov(B_i, B_k) = \mathbb{E}[B_iB_k] - \mathbb{E}[B_k]\mathbb{E}[B_k]\)

We know that these are Brownian motions, so their expectation is 0.

\(= \mathbb{E}[B_iB_k]\)

Since we don’t know how they’re related, the best way to approach this is via Ito decomposition.

\(d(B_iB_k) = B_idB_i + B_kdB_i + dB_idB_k\)


Definition of risk-neutral:
\(\tilde{\mathbb{P}}\) and \(\mathbb{P}\) have to be equivalent.

And every single discounted stock price \(D(t) S_i(t)\) must be a martingale.

When you rearrange this, you get

\(\alpha_i - R = \sum_{j=1}^d \sigma_{ij} \Theta_j\)

And this is a system of \(m\) equations with \(d\) unknowns (dimensions).

#### Fundamental Theorem

The expectation of an indicator is the same as the probability measure of the function being indicated.

Because prices are unique, you can only have a unique risk-neutral probability measure on them.
