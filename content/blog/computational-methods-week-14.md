+++
title = "Copulas and Portfolio Risk"
date = 2025-04-29
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Copulas","Value at Risk","Expected Shortfall"]
+++

Ending early today because the Pacers are playing tonight

## Copulas

Why do we need this?

First let’s talk about:

Generally speaking, the **Basel 2**, Basel 3, and current Basel 3.5, all these rules and regulations require that banks assess two things. Any unit that owns funds that don’t belong to them (banks, basically), they need to assess risk. What exactly does that mean?

The class 535, 635, and 636 are all about this. 636 will be offered this fall.

At the core, regulators don’t understand any of it. What they want to know is, if the economy goes to crap, how much will you lose? So how do you come up with this number?

There’s two basic numbers: **VaR**, or Value at Risk, and **ES** Expected Shortfall

One of my former students is head of globalr isk at Barclays, and every day he has to come up with these numbers. Basically he aggregates the positions of every desk at Barclays. Derivatives, asset management, whatever. Each has a risk associated with it. VaR is supposed to be a quantile. Imagine you have a distribution for the value of your assets tomorrow. It’s actually in 10 days that Basel demands.Obviously, I know the value of assets today, by marking to market. I project in ten days what are the possible things that could happen to all my divisions. My derivatives desk has a distribution, another desk has another one, so I have a whole bunch of random variables. Now I need to combine them. I have tons of distributions, how do I put them together?

For example, 10% of my bank is invested in derivatives. So I should take the risk from that and multiply by 10%, right? Wrong. Because things don’t move independently. We could do such aggregation only then. If the derivatives desk goes down because Trump said something dumb, th equities desk will also go down, and so will bonds. Things are related.

That’s the purpose of copulas. These are very much used in risk management.

VaR can only be calculated for a 1D r.v. You need to have a typical marginal distribution. Let’s say you get this distribution, of values with probabilities. Let’s say I look at the value where the probability is 0.01. If I look at the value I have now, and subtract the value there, that resulting value is the loss. The amount of money I will lose if this thing happens, which is worst case scenario, with a 1% chance of happening. This particular one is VaR\_99. You can obviously calculate different percentiles.

### Expected Shortfall

If you are in this region, you are going to lose money. If my estimation is correct, then this thing is going to happen. If I look at the next 100 days, and do this distribution every single day, then I expect to see one of these events every 100 days.

But if it does happen, exactly how much money will I use? I don’t know which point I’m in, just the region. So to determine that value, you calculate ES.

ES is nothing more than

$$\\mathbb{E}\[\\text{Loss}|X \< \\text{VaR}\]$$

Basically it’s just the expected value of the random variable when it’s less than VaR.

This is important, there’s an entire area of risk management dedicated to this. The trader cannot take risks because the risk manager won’t let them, because of this stuff. You can’t take crazy risks.

### Marginal vs Joint Distribution

So what is the problem? This is calculated on a daily thing. A natural thing to do is to look back 100 days, have a historical look at each desk. That gives me distributions that are reasonable for each of those rvs. If I have a 1D rv, with 100 observations, I can make a pretty accurate histogram.

For a 2D rv, I suddenly need a lot more observations. And for more, it’s impossible.

So although you can estimate the distribution of the marginals very easily, you can’t do that for the joint. You would need mountains of data, which is not possible. And the problem is if you go too far in the past, you end up with irrelevant data that is nonstationary.

The question is, can we do that?

You can do this in one case, and only one case. And that’s if X\_1 … X\_d are independent. Then the joint distribution is the product of the marginals. This holds for both PDF and CDF.

However, irl, nothing is independent. In the 1940s, there’s an old theorem by **Sklar**:

*Let X\_1…X\_d random variables with CDFs F\_1…F\_d.* (These are one dimensional CDFs)

*Let* $$F(x\_1, \\ldots x\_d) \= \\mathbb{P}(X \\leq x\_1, \\ldots, x\_d \\leq x\_d)$$

There exists a function C which follows $$\\mathbb{R}^d \\rightarrow \[0, 1\]$$

That this function

$$C(F\_1(x\_1), F\_2(x\_2), \\ldots F\_d(x\_d) \= F(x\_1, \\ldots x\_d)$$

In the case of independent rvs, then it’s just the product. But maybe we have to do something further.

Then if you have the joint pdf f\_1(x\_1 … x\_d), then you also have a similar

$$f(x\_1, \\ldots, x\_d) \= c(F\_1(x\_1), \\ldots F\_d(x\_d)) f\_1(x\_1) \\ldots f\_d(x\_d)$$

And this is just how derivatives work, this is the chain rule, where

$$c \= \\frac{d}{dx\_1} \\frac{d}{dx\_2} \\ldots \\frac{d}{dx\_d} C$$

There’s a second property that C is unique on \[0, 1\]^d. Basically, the function c connects the marginals, which are probabilities \[0, 1\]. So you limit yourself to the space of distributions, which are the $$\\mathbb{R} \\rightarrow \[0, 1\]$$, then we are unique.

This is pretty powerful.

## Issues with Copulas

There is a non obvious issue: **time stationarity**.

This is not even mentioned in most texts. When you estimate this, you need to estimate the marginals. You need a mountain of data to have these two things. You calculate the copula which connects them. Let’s say you have 2001-2006 and estimate the copula during that period. In order to make forecasts about the relationship in the future, you’re assuming that the relationship stays the same. This is the reason for the 2008 financial crisis. The CDOs are estimated assuming the functions doesn’t change, which is pretty stupid. Things don’t seem correlated right now, but they were, even though the historical data didn’t show it.

The second big issue: what EXACTLY is this copula?

We know this function exists, but we don’t know how to get to it. It’s like God.

We know God exists, but if we go by Christian religion it’s this god, if it’s Islam it’s that god, etc.



## Copula Families

I’ll say that a copula function, sorta, looks like this. The only quantity I know is that it’s defined from \[0, 1\] to \[0, 1\]. So if I have a function that does this, I should be okay.

If you take 1D CDF, then what does it do? This is a function $$F: \\mathbb{R} \\rightarrow \[0, 1\]$$. It takes a random variable, and gives it a probability.

What about $$F^{-1}$$, the quantile function? This is defined $$F^{-1}: \[0, 1\] \\rightarrow \\mathbb{R}$$

All copulas are based on this. They use the cdf and the inverse. The most popular one, we have already seen. The simplest one is called

## Gaussian Copula

The whole thing is that the function needs to associate $$\\mathbb{R}^d \\rightarrow \[0, 1\]$$ We have the multivariate normal function $$\\Phi\_\\Sigma$$ CDF.with mean 0 and covariance matrix Σ. The cov matrix is positive, semidefinite, and symmetric.

$$\\Phi\_\\Sigma (u\_1 \\ldots u\_d) \= \\int\_{-\\infty}^{x\_1} \\int\_{-\\infty}^{x\_d} \\frac{1}{\\sqrt{(2\\pi)^d \\text{det} \\Sigma}}e^{-\\tfrac{1}{2}u^T \\Sigma^{-1}u} du\_1, \\ldots du\_d$$

u is a line vector

This has to be between 0 and 1\.

But this is defined for R.

So I’m going to write the gaussian copulas as

$$C^{\\text{Gaussian}} (x\_1 \\ldots x\_d) \= \\Phi\_\\Sigma (\\Phi^{-1}(x\_1), \\ldots , \\Phi^{-1}(x\_d))$$



This is really complicated. The Fs are the xs, you plug in the marginals, and that gives you the copula function. The important concepts are the multivariate Gaussian with given sigma, the Φ-1 inverse cdf, and you plug in the cdfs of the marginals. You look at your data, obtain the marginals, and obtain the joint. And fit the function to the joint. The only thing to estimate here is Σ.

## Student t Copula

There is another thing called the Student t copula. Remember the Cholesky decomposition? It’s basically used for this. You use the data, you use the numbers you get, and calculate the joint distribution. The correlated numbers you plug into the copulas, and you get the thing correlated. Fancy way of doing the homework.

It’s an extension that uses the fact that

$$t \= \\frac{Normal}{\\Chi^2}$$

You obtain χ^2 by squaring the normal.

This is useful.

Gaussian copula is nice and easy to work with.

## Archimedean Copulas

This is an entire class. We have Gaussian, and student t which inherits from Gaussian processes. (By the way, if you want to know more about Gaussian processes, take Florescu’s class).

The whole point is that you’re going with cdfs, and inverse cdfs. Remember a copula goes from \[0,1\]^d to \[0,1\]. It is defined like this

$$C(u\_1, \\ldots u\_d) \= \\Psi^{-1}(\\Psi(u\_1) \+ \\ldots \+ \\ldots \\Psi(u\_d))$$

where

$$\\Psi: \[0, 1\] \\rightarrow \[0, \\infty)$$

and

$$\\Psi(1) \= 0$$

This Ψ function is kinda like inverse cdf.

Importantly, Ψ^-1 is monotonic. And it follows that

Ψ^-1(0) \= 1

Ψ goes from \[0, 1\] to ∞, and the inverse goes the other way.

And there’s a property that Ψ^-1 starts at 1, and keeps going down over to ∞.

## Product Copula

You take the

$$\\Psi(u) \= \-\\ln u$$

$$-\\ln u \= y$$

$$u \= e^{-y}$$

So that’s the inverse

$$\\Psi^{-1}(y) \= e^{-y}$$

Remember this starts at 1 at x \= 0, then decreases towards ∞.

The archimedean copula function is the sum of Ψ. So what is the copula in this case?

$$C(u\_1, \\ldots u\_d) \= \\Psi^{-1}(\\Psi(u\_1) \+ \\ldots \+ \\Psi(u\_d))$$

$$= e^{-(-\\ln u\_1 \- \\ln u\_2 \- \\ldots \- \\ln u\_d)} \= e^{\\ln(u\_1 \\ldots u\_d)}$$

which ends up being

$$= u\_1 u\_2 \\ldots u\_d$$

You take each cdf and multiply them, which is numbers between 0 and 1\.

It’s kind of useless because it doesn’t have a parameter, so you can’t fit it.

## Clayton

These are the most used ones

$$\\Psi(u) \= \\frac{1}{\\theta} (u^{-\\theta} \- 1)$$

Basically you construct these, by picking something. Someone came up with a function such that the inverse looks like this, then they pick θ such that they have a parameter to fit something, where Ψ(1) \= 0\.

They actually are simple, and then they just fit the properties. SOmoene tried it, now everyone uses it.

The inverse is

$$\\Psi^{-1} \= (\\theta y \+ 1)^{-\\tfrac{1}{\\theta}} $$

$$C^{\\text{Clayton}} (u\_1 \\ldots u\_d) \= (\\theta(\\Psi(u\_1) \+ \\ldots \+ \\Psi(u\_d)) \+ 1)^{\\tfrac{1}{\\theta}}$$

Then just plug in the Ψ term.

$$= (\\theta(\\sum\_{i=1}^d \\frac{1}{\\theta}(u\_i^{-\\theta} \- 1)) \+ 1)^{\\tfrac{1}{\\theta}}$$

$$ \= (\\sum\_{i=1}^d u\_i^{-\\theta} \- d \+ 1)^{\\tfrac{1}{\\theta}}$$

This formula IS NOT ONLINE, only for bivariate copula. All the formulas online are bivariate

I have four more pages of crap for Frank and Gumbel. But…

## Frank

This is a generator

$$\\Psi(u) \= \-\\log(\\frac{e^{-\\theta u} \- 1}{e^{-\\theta} \- 1})$$

## Gumbel

$$\\Psi(u) \= (-\\log u)^\\theta$$

And if you understand the principles, you can come upw ith your own. you can notice that you have logs everywhere, because it’s very nice because when you exponentiate it disappears. But it could be something like cosine\! The only requirement is that the inverse function is convex.

The theta is the parameter fit. The way you fit theta, the relationship is

$$C(F\_1(x\_1), \\ldots F\_d(x\_d)) \= F(x\_1 \\ldots x\_d)$$

You’re just inventing something to fit the copula, something close.

It’s a high barrier of entry because the formulas seem complicated.

## Why Do We Care

We need to estimate the wealth and know the risks, and come up with a number.

But how do we actually use this stuff?

I used to do a lecture on generating random variables. Now I don’t. If you’re interested in more detail, read the Handbook of Probability. Chapter 6 proves this. If you take a random vairalbe and plug it into a cdf, it generates a uniform random variable.

This tells you how to generate any rv you want.

All you have to do is the inverse cdf method.

If $$U \\sim \\text{Uniform}(0, 1)$$,

and you can get the inverse cdf

$$F^{-1}(U)$$ has the same distribution as X.

If you can calculate the CDF, and the inverse CDF, you can generate random uniform, plug it into it, and then you get a random.

The problem is the normal CDF, because the normal CDF is not invertible. But a lot of other rvs work.

The problem is that it only works for 1D rvs. That’s why this copula is pretty useful.

Recall that the joint distribution cdf is equivalent to the copula of the marginal cdfs. The methodology will work for the marginal cdfs, so you can apply the copulas to get to the joint cdf.

### Algorithm

First you estimate C.

1: First you generate many uniforms iid u\_1… u\_d

2: For each such point, you calculate the C(u\_1, … u\_d) for all generated u\_is.

3: Calculate marginals densities

4: I now have all these probabilities that I generate x\_1… x\_d.

My x\_i cdf can be used to generate numbers, I have d distributions, I have a number between 0 and 1, and extract the corresponding x\_i, which gives me a generate number. That will calculate not only VaR but also ES with respect to these distributions.

There could be an easier version of this, which is what Marina will do. This is just how I would do it.
