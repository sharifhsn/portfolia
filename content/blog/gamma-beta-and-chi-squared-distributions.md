+++
title = 'Gamma, Beta, and Chi-Squared Distributions'
date = 2024-10-21
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Gamma Distribution', 'Beta Distribution']
+++
The FE-540 distribution notes connect several continuous families through the gamma function. The chi-squared family is a gamma distribution with parameters \(n/2\) and \(1/2\), which makes its moments and additivity properties easier to remember.

The beta function normalizes densities on \([0,1]\):

$$\mathrm B(a,b)=\int_0^1x^{a-1}(1-x)^{b-1}\,dx
 =\frac{\Gamma(a)\Gamma(b)}{\Gamma(a+b)}.$$

For \(X\sim\operatorname{Beta}(a,b)\), the notes derive \(\mathbb E[X]=a/(a+b)\) and \(\operatorname{Var}(X)=ab/((a+b)^2(a+b+1))\). These identities are useful because they turn repeated integrals into parameter substitutions.
