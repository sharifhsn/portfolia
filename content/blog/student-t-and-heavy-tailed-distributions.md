+++
title = "Student's t and Heavy-Tailed Distributions"
date = 2024-10-28
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Student t', 'Heavy Tails']
+++
After the gamma and beta families, the FE-540 notes turn to Student's \(t\) distribution and other shapes used when observations are more extreme than a Gaussian model suggests. Student's \(t\) can be built from a standard normal variable divided by the square root of an independent chi-squared variable scaled by its degrees of freedom.

The notes also compare Pareto, log-normal, and Laplace distributions. The point is not just to collect names: the tail behavior controls whether moments exist and how sensitive an estimate is to a few unusually large observations. A distribution with a finite mean can still have a very unstable variance, while a log-normal or Pareto tail can make sample averages converge slowly.

Writing down the support and checking the normalizing constant are the reliable first steps before calculating a moment.
