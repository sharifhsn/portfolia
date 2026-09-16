+++
title = 'Joint and Conditional Distributions'
date = 2024-11-11
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Conditional Distributions', 'Covariance']
+++
The final FE-540 notes work with a joint law rather than treating each variable in isolation. A conditional density is obtained by normalizing the joint density with the relevant marginal:

$$f_{X\mid Y}(x\mid y)=\frac{f_{X,Y}(x,y)}{f_Y(y)}.$$

This makes conditional expectation a function of the information being observed. Covariance records co-movement, \(\operatorname{Cov}(X,Y)=\mathbb E[(X-\mathbb E X)(Y-\mathbb E Y)]\), while conditional versions let the same idea change as information arrives.

The notes' worked examples are a useful reminder to state the support first, integrate over the correct region, and check that the resulting conditional density integrates to one.
