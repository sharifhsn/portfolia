+++
title = "Calibration and SDE Parameter Estimation"
date = 2025-04-01
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Calibration","Maximum Likelihood","Stochastic Differential Equations","Parameter Estimation"]
+++

## Plan for Today

Parameter estimation for stochastic differential equations.

## Romania

investments by the West after dictator Ceaușescu failed to invade Czech republic

he stopped imports and increased exports

romania makes the best shoes (dress shoes)

they exported with the best leather, shit leather was for romanian shoes

black market, people stole best shoes off line

they had tons of money, but nothing to buy

we had alcohol, that’s it

85 is some stupid stuff (1984)

## Calibration

You observe some data. Most of the time, you observe the data in time. That is traditional for our domain, and many others.

We say okay, I need to understand the dynamic of this data. In order to do this, we introduce randomness, because the randomness allows you to create data which is different. There is no way in hell you can predict the next data. I can try to predict the trend, and predict the variability around that trend. In our area of finance, it turns out that the stuff is so random, we have to go to these SDEs to understand anything.

In that stochastic equation we have two terms, drift and diffusion. Drift is trend, diffusion is variability.

Once I hypothesize a model, the next step is to find the parameters. For BS, estimate sigma and mu. You can calibrate, or estimate from path of process (more complicated).

Calibration, you look at a derivative. A function of an underlying.

We need financial derivatives. We have seen derivatives like calls and puts. We hypothesize a model, where you come up with a formula for the derivative prices. For example:

$$
C(S, K, T, r, \\text{parameters:}, \\theta_1, \\theta_2, \\theta_3)
$$

Let’s take the Ornsteinn-Uhlbeck model: This is a mean reverting process.

$$
S_t = \\theta_1(\\theta_2 - S_t)dt + \\theta_3 dW_t
$$

This is called the mean reverting Ornstein-Uhlenbeck model. How do you estimate this?

Let’s hypothesize an option on this, with all the known parameters known.

Given this, I’m going to solve a differential equation and get some sort of formula for the solution.

Once you have that, you’re done.

Then you’re basically done, because you have now a massive complex optimization problem.

Let’s say you observe \\(C_1, C_2, \\ldots C_k\\) market option prices.

Then you calibrate the model to these option prices.

So you take

$$
\\min_{\\theta_1, \\theta_2, \\theta_3} \\sum_{i=1}^k (C(S, K_i, T_i, r, \\theta_1, \\theta_2, \\theta_3) - C_i)^2
$$

(keeping in mind which are subscript i, different for each call option)

You can change this. Let’s say you have twenty options, but you’re more interested in fitting out of the money options, you can weight each of them. Let’s say you want the four options like this, then you weight one fifth of each of those options, and one fifth of the rest.

‘

Now in practice, for instance, we talked in the beginning of class about local vol. That’s a calibration method, we calibrate models to the observed values. In practice, if you’re doing real quantitative analysis, you do have these complicate model which have a combination of fitting/calibration, and another method (estimation).

## Estimation

This is a very classical statistical problem.

We have the SDE:

$$
dX_t = f(X_t, \\theta) dt + g(X_t, \\theta) dW_t
$$

Then the O-U model looks like

$$
f(x, \\theta) = \\theta_1 (\\theta_2 - x)
$$

$$
g(x, \\theta) = \\theta_3
$$

Then for CIR,

$$
f(\\theta) = \\theta_1(\\theta_2 - x)
$$

$$
g(x) = \\theta_3 \\sqrt{x}
$$

I want to estimate parameters based on data.

We assume that we have observations

$$
x_1, x_2, \\ldots x_n
$$

at times

$$
t_1, \\ldots, t_n
$$

They could be same distance but it could be any times you want to observe this process.

So how do you estimate the vector of parameters.

In theory, you do this by **Maximum Likelihood Estimation (MLE)**. There’s also method of moments, and Bayesian methods

Bayesian requires specific distributions, kind of complicated.

Method of moments is kind of like calibration to observed moments.

MLE is theoretically the most powerful one.

How does it work?

It’s really simple:

It works with the density of these observations.

If you’re observing the values of the process at \\(t_1, \\ldots t_n\\)

You can form the joint density: \\(f(x_1, x_2 \\ldots x_n | \\theta)\\)

This result depends on the vector of parameters, where θ is given.

The method of maximum likelihood says that I’m actually observing x\_1, x\_n. The probability of observing those things should be the highest in those numbers.

So let’s form a function

$$
L(\\theta) = f(x_1, \\ldots x_n |\\theta)
$$

In this expression, I’m going to plug in al lof the observations I know, and make this function of a function of the parameters, which I don’t know.

Typically you take the log which is called the score function.

$$
\\log L(\\theta) = l(\\theta)
$$

Computer scientists came up with it, they sell better than mathematicians.

If we know the joint density, then we can solve this problem. The problem is that we don’t know the joint density. It’s a really complicated expression.

How do we do this?

**The first trick**: we need

$$
f(x_1, \\ldots x_n |\\theta) = f(x_n | x_1 \\ldots x_{n-1}, \\theta)f(x_1, \\ldots x_{n-1}|\\theta)
$$

Joint divided by marginal.

You can continue this up until the very first one.

$$
= f(x_n|x_{n-1}, x_{n-2} \\ldots x_1, \\theta) f(x_{n-1}|x_{n-2} x_{n-1} \\ldots x_1 \\theta) \\ldots f(x_2|x_1, \\theta) f(x_1 | \\theta)
$$

Remember there should be theta all over the place.

These are all functions on one variable.

These are all solutions to my stochastic process.

Since x solves an SDE, then x is Markov.

Which means that it’s the same as

$$
x_n | x_{n-1}, \\theta
$$

All I need is the previous value. So this is the generalized function.

$$
x_{n-1} | x_{n-2}, \\theta
$$

etc.

So then the likelihood function is the product

$$
L(\\theta) = \\prod_{i=2}^n f(x_i | x_{i-1}, \\theta) f(x_1 | \\theta)
$$

This is actually not the same function. There’s another thing to be aware of. This is a **homogeneous process**.

Distribution does not depend on the time you are collecting it, only depends on the difference of the times.

If you’re looking at a non-homogeneous process, the distribution of today, tomorrow, and the next day are not the same as a year from today, next day from that, next day from that.

Stationary is always the same, homogeneous

A non homogeneous process would have a distribution of \\(X_1, X_2, X_3\\) vs \\(X_{100}, X_{200}, X_{300}\\), this is always going to be very different.

\\(X_{101}, X_{201}, X_{301}\\). For a non homogeneous process, these are also different. But for a homogeneous process, this will be the same as long as the time interval is the same, ANY TIME INTERVAL.

By the way, this is a joint distribution.

So let’s write this distribution,

If you’re modeling returns, you get

$$
R_t = \\log S_t
$$

and

$$
R_{t+\\Delta t} - R_t = (\\mu - \\frac{\\sigma^2}{2}) \\Delta t + \\sigma \\Delta W_t
$$

And

$$
\\log S_{t+\\Delta t} = \\log S_t + (\\mu - \\frac{\\sigma^2}{2}) \\Delta t + \\sigma \\Delta W_t
$$

The only randomness comes from Brownian motion, which has N(0, Δt)

I know the distribution of this thing, so

$$
\\log S_{t + \\Delta t} | S_ t \\sim N(\\log S_t + (\\mu - \\frac{\\sigma^2}{2} \\Delta t, \\sigma^2 \\Delta t)
$$

This is a constant that I add to it, so the only thing that happens is the mean changes when I add to the normal.

Now that I know this, I can write down the density.

obviously, the logarithm of this thing is normal.

Which means S is e to this thing.

It’s just easier to write in the context of the logarithm

$$
f(\\log S_{t+\\Delta t} | \\log S_t, \\theta) = \\frac{1}{2\\pi \\sigma^2 \\Delta t} e^{-\\frac{X - \\log S_t - (\\mu - \\tfrac{\\sigma^2}{2})\\Delta t)^2}{2\\sigma^2 \\Delta t}}
$$

This is just the PDE of the normal

And notice that there’s no t, just Δt. So the only thing that matters is S\_t and Δt.

That’s what homogeneous means.

What we know is:

## The Feller Process

This is any Ito process, any SDE, which is written like

$$
dX_t = f(X_t, \\theta) dt + g(X_t, \\theta) dW_t
$$

Any process where’s the coefficients here don’t depend on time, only the stochastic process and the parameter.

The big deal is, any Feller process is homogeneous.

It turns out that as long as the coefficients don’t depend on time, the solutions don’t depend on time.

I make all these parentheses because it’s kind of crucial for us.

It’s not enough for us to have an equal distance between times, you need to have a homogeneous process. If you have daily, then they’re different, 100 different functions for 100 different days. Now I just have one function, which I plug in at different points in time.

The following is NON-homogeneous.

$$
dX_t = f(X_t, t, \\theta) dt + g(X_t, t, \\theta) dW_t
$$

I had a friend that was Russian and pronounce it gomogeneous.

That normal density is the derivation as well.

If we come back to it, it’s the same as

$$
p(y, x, \\Delta t | \\theta)
$$

This is the transition probability from \\(X = \\log S_t\\) to \\(Y = \\log S_{t+\\Delta t}\\)

Notice I don’t care what Δt is, it could be a different one.

$$
= \\frac{1}{\\sqrt{2\\pi \\sigma \\Delta t}} e^{-\\tfrac{(y - x - \\nu \\Delta t)^2}{\\text{not done}}}
$$

This does work for GBM

We can write down explicitly what it is.

This function si solved, I write down the transition, I write the likelihood function, I take the logarithm.

The joint distribution is a product. The logarithm is a sum of these functions, it’s just easier to deal with sums.

In general, for other models than GBM, it is impossible to write an exact formula.

So what do you do?

A guy from Princeton in (1999, 2000\) named Ait Sahalia got famous for doing this.

He came up with the idea of **Pseudo MLE**, also the **Approximate Likelihood Method**.

There is a package that does this, which does not quote this.

[https://www.princeton.edu/\~yacine/mle.pdf](https://www.princeton.edu/~yacine/mle.pdf)

Reminder: there is a transition from X to Y in times Δt which depends on θ.

We will replace p(y, x, Δt | θ) which we call pθ with a density hθ which depends maybe on some other parameters.

We choose hθ in the following way:

- has to be simple

a constant is too simple, so it has to be related to this pθ, so:

- hθ has to have the same moments as pθ

This is a transition distribution in Y.

The moments mean expected value of powers. We have this mgf. We know if two variables have same mgf, they have the same distribution. You can have two variables with several moments equal, but not the same distribution. This property only holds for ALL moments.

So this wouldn’t be possible. I’m going to pick some hθ so we have *a few* moments the same, maybe 1, 2, 3\.

The method in Ait Sahalia, we will discretize SDE using Euler method.

We will approximate the integral with the LHS value times the increment, same as quadrature.

We will cover Monte Carlo next week.

$$
X_{t+\\Delta t} - X_t = \\int_t^{t + \\Delta t} f(X_t) dt + \\int_t^{t + \\Delta t} g(X_t) dW_t
$$

We’re skipping θ for laziness, but exists in every function.

This is the same as

$$
= f(X_t) \\Delta t + g(X_t) \\Delta W_t
$$

*if we approximate using quadrature*.

We know the distribution of Brownian motion as N(0,  Δt)

Euler method says, that given X\_t, I know the distribution\!

So

$$
X_{t+\\Delta t} | X_t = X_t + f(X_t) \\Delta t + g(X_t) \\Delta W_t
$$

And its distribution is

$$
X_{t+\\Delta t} | X_t \\sim N(X_t + f(X_t) \\Delta t, g^2 (X_t) \\Delta t)
$$

This is not the distribution, because we have an approximation on the integral with quadrature.

Then we can approximate pθ as

$$
h(\\Delta t, x, y) = \\frac{1}{\\sqrt{2\\pi g^2 (x) \\Delta t}} e^{-\\frac{-(y- x - f(x) \\Delta t)^2}{2g^2(x) \\Delta t}}
$$

And if you give me f and g, and the parameters, I can technically write this down, very easily.

It is simply multiplied like before. The x and y will be replaced by observations.

How do you estimate analytically. You take the logarithm, which takes everything out and simplifies it.

You get a bunch of the gs and the fs squared, but it’s just sums. If this would be linear, it would be simply applying an average. But nobody said this is linear. f and g can be complicated, so you would solve them with a nonlinear optimizer.

## Sim Diff Procedure

First, let’s see two things.

The O-U model: How do you solve it? Because it is solvable.

Reminder:

$$
dX_t = \\alpha(\\mu - X_t) dt + \\sigma dW_t
$$

This is just notation for the stochastic integral, blah blah.

The thing about this process, I can write it like

$$
dX_t + \\alpha X_t dt = \\alpha \\mu dt + \\sigma dW_t
$$

By the way, if there is no mean reverting here, it’s just called O-U. With mean reverting, it’s called mean reverting O-U. The alpha mu dt thing is gone in that case.

This is the real trick, which comes from differential equations.

If you look at the LHS, you should remember something. You remember integrating factors, the way to solve first order diffeqs.

And in fact that is a first order.

What do you do with integrating factor? I don’t remember, I remember it existed, but it’s complicated, with some weird formula.

But I do remember that if I take the derivative of \\(e^{\\alpha t}\\), then I’ll get \\(\\alpha e^{\\alpha t}\\)

That’s a powerful feature, to make a constant appear out of nowhere.

And we can also see another constant that appeared out of nowhere. So if we multiply everything here by that, you kind of get the derivative of the product to appear.

$$
e^{\\alpha t} dX_t + X_t \\alpha e^{\\alpha t} dt = \\mu \\alpha e^{\\alpha t} dt + \\sigma e^{\\alpha t} dW_t
$$

Now this is a stochastics process, so it’s a little different from the regular product rule.

This process becomes

$$
d(e^{\\alpha t} X_t)
$$

I claim that. But how do you show this? What is the differential of two stochastic processes. That’s the Ito product rule. Which is the regular product rule plus the quadratic variation between the two terms.

When you take the quadratic variation between stochastic process and a deterministic process, that ends up being zero. So actually we can get rid of the quadratic variation part, so it ends up being the same as the regular product rule.

$$
= \\mu d(e^{\\alpha t}) + \\sigma e^{\\alpha t} dW_t
$$

The next step is to integrate, from 0 to t.

$$
e^{\\alpha t} X_t - X_0 = \\mu (e^{\\alpha t} - 1) + \\int_0^t \\sigma e^{\\alpha s} dW_s
$$

Notice this is an explicit solution.

$$
X_t = e^{-\\alpha t} X_0 + \\mu (1 - e^{-\\alpha t}) + \\int_0^t \\sigma e^{\\alpha (s-t)} dW_s
$$

Just rearranging to get this here. We can’t really touch the dW stuff

And this is random, because it has a stochastic integral.

Another trick.

Even for this simple expression, it is complicated to measure μ, α, or σ, because the stochastic integral is present. You can do the numerical thing and hope for the best.

I learned this trick when I was in Romania. If you have this equation

$$
X_t - X_0 = \\int_0^t \\alpha(\\mu - X_s) ds + \\int_0^t g(X_s) dW_s
$$

I have some horrible expression like this, which I write as g, as complicated as you want.

So what is the expected value of this? I get scared, because it’s so ugly.

Because I have to know the pdf, and integrate x \* pdf, which is horrible.

But actually, there’s a simple way to do this.

It’s all based on the fact that stochastic integrals are martingales. Being martingales, they have the same expectation at any moment in time. And the process is equal to 0 at 0, so that whole thing ends up becoming 0\. The trick is to apply expectation everywhere.

$$
\\mathbb{E}[X_t] - \\mathbb{E}[X_0] = \\mathbb{E}\\left[\\int_0^t \\alpha(\\mu - X_s) ds\\right] + 0
$$

The next step is to realize is that this is two integrals, which will commute as long as the thing inside is finite. And it has to be finite.

$$
= \\int_0^t \\alpha (\\mu - \\mathbb{E}[X_s]) ds
$$

And now this is an expectation, which is a number, it just depends on the time. We’ll define a function for this.

$$
\\mathbb{E}[X_t] = u(t)
$$

So we’re really solving this equation:

$$
u(t) - u(0) = \\int_0^t \\alpha (\\mu - u(s)) ds
$$

But this is now a deterministic equation which you can solve as diffeq using Calculus III.

You take the derivatives, which makes it simpler, because it mimics what we just did.

$$
du(t) = \\alpha(\\mu - u(t)) dt
$$

This the same equation we did a moment ago

$$
du(t) + \\alpha u(t) dt = \\alpha \\mu dt
$$

And this is a first order diffeq, where we can use the same e thing.

$$
d(e^{\\alpha t} u(t)) = \\alpha ue^{\\alpha t} dt
$$

And now RHS integrates really easily, same as before

$$
e^{\\alpha t} u(t) - u(0) = \\mu (e^{\\alpha t} - 1)
$$

$$
u(t) = u(0) e^{-\\alpha t} + \\mu (1 - e^{-\\alpha t})
$$

And actually we didn’t need to do all of this, because on the previous slide, we had the solution.

If we applied expectation directly to the Ito product rule we did, it would give the same formula, which is just more generalized.

$$
\\mathbb{E}[X_t] = \\mathbb{E}[X_0]e^{-\\alpha t} + \\mu (1 - e^{-\\alpha t})
$$

And you can observe the long term behavior, that it goes to μ.

That’s the theory. How do we estimate the stuff?

## Code

I wrote this before coming to class, which is why I was late. This is part of a package called Sim.DiffProc, which you need to install. For some nonstandard packages, you need Rtools, looks like you don’t need it.

Now they have a very nice

Sim.DiffProc is not that good.

Simulation of Diffusion Processes.

They have a nice documentation for it.

They can do more things than this.

Here:

## What You Should Remember

MLE Method

Approximation of Joint distribution with little pieces

Feller processes and what they are

This is stuff that actually shows your advantage over students from competing programs. They don’t do anything like this.
