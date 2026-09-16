+++
title = "Probability Measures and Bayes' Rule"
date = 2024-09-09
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Conditional Probability', 'Bayes Rule']
+++
A probability measure \(\mathbb P\) assigns a number in \([0,1]\) to every event in \(\mathcal F\). The notes begin with \(\mathbb P(\Omega)=1\) and countable additivity for disjoint events:

$$\mathbb P\left(\bigcup_{n=1}^{\infty}A_n\right)=\sum_{n=1}^{\infty}\mathbb P(A_n).$$

From those axioms follow the familiar rules for complements, inclusion, and finite unions. Conditioning then changes the measure after new information arrives. For \(\mathbb P(B)>0\),

$$\mathbb P(A\mid B)=\frac{\mathbb P(A\cap B)}{\mathbb P(B)}.$$

The total-probability and Bayes formulas update a partition of the sample space when an observation occurs. The notes emphasize that Bayes' rule is a bookkeeping identity for the same joint event, not a new probability model. Independence is the special case in which \(\mathbb P(A\cap B)=\mathbb P(A)\mathbb P(B)\).
