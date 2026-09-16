+++
title = 'Random Variables and CDFs'
date = 2024-09-16
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Random Variables', 'CDFs']
+++
The FE-540 notes define a random variable as a measurable function from the original sample space to the real line. Measurability means that inverse images of Borel sets are events in \(\mathcal F\), so probabilities can be assigned to statements such as \(X\leq x\).

The distribution of \(X\) is the push-forward probability measure \(\mathbb P_X=\mathbb P\circ X^{-1}\). Its cumulative distribution function is

$$F_X(x)=\mathbb P(X\leq x).$$

A CDF is increasing, right-continuous, and tends to 0 and 1 at the two ends of the real line. Interval probabilities follow from differences, \(\mathbb P(x<X\leq y)=F_X(y)-F_X(x)\). For a discrete variable, jumps record point masses; for a continuous variable, the same CDF is represented by integrating a density.
