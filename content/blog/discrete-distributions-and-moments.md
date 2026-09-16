+++
title = 'Discrete Distributions and Moments'
date = 2024-09-23
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Discrete Distributions', 'Moments']
+++
For a discrete random variable, the probability mass function gives the mass at each possible value:

$$p_X(x)=\mathbb P(X=x),\qquad \sum_x p_X(x)=1.$$

The CDF is a staircase formed by adding those masses. The notes use a die and the waiting time for a six to show how a geometric distribution arises: if \(X\) is the first roll on which a fair die shows six, then \(\mathbb P(X=n)=(5/6)^{n-1}(1/6)\).

Moments are sums in the discrete case. Absolute integrability gives

$$\mathbb E[X]=\sum_x x\,p_X(x),$$

and variance measures the squared distance from the mean, \(\operatorname{Var}(X)=\mathbb E[X^2]-\mathbb E[X]^2\). Linearity of expectation is the main calculation shortcut: it does not require independence.
