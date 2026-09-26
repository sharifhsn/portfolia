+++
title = "Dependence and Copulas"
date = 2025-04-17
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Credit"]
tags = ["Credit","Dependence","Copulas"]
+++

## Dependence cases

Relevant variables for these credits

**Page 4**

Let’s look at, let’s say, minimum dependence:

In what situation might we have such minimum dependence?

The k where we have the lowest probability that we have both names defaulting.

Both of these credits have an idiosyncratic component and a market exposure z.

So one way we can achieve minimum dependence is to have an opposite exposure to z.

If we have a large negative exposure to \\(z\\), we’ll say \\(\\beta\\) is large. For credit j, we can change the exposure to market variable z, and instead of having a large negative number, it becomes a large positive numbers, and we lower the probability of default.

For minimum dependence, if we take it in the **limit**, for \\(\\beta_i=-\\beta_j\\)

In the limit, we can take \\(\\beta_i=1\\), \\(\\beta_j=-1\\)

One has 100% exposure to z, the other has negative exposure to z, and both of them have zero idiosyncratic component.

So correlation is inverse, \\(\\rho=-1\\).

In this case, such probability is dependent on the survival probability of the names, \((1 - Q_i(T) - Q_j(T))_+\)

The joint probability of default is zero as long as \\(Q_i(T)+Q_j(T)>1\\)

Independence means correlation is 0\. And to do that, we have to remove market exposure. So in the limit, we take

\\(\\beta_i=\\beta_j=0\\), which means the correlation is zero, it’s entirely idiosyncratic.

Maximum Dependence is when \\(\\beta_i=\\beta_j=1\\), maximum market exposure. It’s the minimum of either \\(1-Q_i(T)\\), \\(1-Q_j(T)\\).

If you want to illustrate this,

**Slide 5**
