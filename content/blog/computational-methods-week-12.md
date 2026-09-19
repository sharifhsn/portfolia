+++
title = "Euler–Milstein and Monte Carlo Extensions"
date = 2025-04-15
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Euler–Milstein","Monte Carlo","Control Variates","Correlated Processes"]
+++

## Euler Milstein

We will expand on the variance reduction techniques, we will repeat a couple things from last week.

But before we do that, we should talk about **Euler Milstein** or Euler Maruyama.

\[People keep talking. It hurts Florescu because he has a disease called ADHD.\]

This is a better approximation. I’m going to show you this because it involves applying Itô’s formula a bunch.

Here is the stochastic process we can approximate. Euler works for any stochastic process, but Milstein has to be homogeneous, like so:

$$dX\_t \= \\alpha(X\_t) dt \+ \\beta(X\_t) dW\_t$$

These coefficients are not functions of time, so they are homogeneous.

The idea is to use Itô for bothα and β. They are functions of stochastic process X\_t. Therefore I can use Itô for both.

I get

$$d\\alpha(X\_t) \= \\alpha’ (X\_t) dX\_t \+ \\frac{1}{2} \\alpha’’ (X\_t)(dX\_t)^2$$

This is Itô, so we are lacking the dt, that term would screw up our calculations.

Now we substitute X\_t here, so we get

The dX^2 gets eliminated

$$= \\alpha’(X\_t) \\alpha(X\_t) dt \+ \\alpha’(X\_t) \\beta(X\_t) dW\_t \+ \\frac{1}{2} \\alpha’’(X\_t) \\beta^2(X\_t) dt$$

If I just group these terms and drop X\_t all over the place to make it easier to write:

$$=(\\alpha’ \\alpha \+ \\frac{1}{2}\\alpha’’ \\beta^2)dt \+ \\alpha’ \\beta dW\_t$$

Now, if we do the same calculation/derivation for the β, then we basically get something very similar. We’re not going to go through the entire calculation. You can derive this yourself,

$$d\\beta(X\_t) \= (\\ldots) dt \+ \\ldots \+ dW\_t$$

Writing in integral from,

Now we substitute α and β from the same formula. So there are two integrals:

~~~text
X\_{t+\\Delta t} \- X\_t \= \\int\_t^{t+\\Delta t}
~~~

When we substitute, we will get four terms, two terms for α and β each.

We will get terms such as

$$dsdu \\sim O(\\Delta t^2)$$

We will change the letters to make sure they’re right, based on what our dummy variables are

$$dsdW\_u \\approx dudW\_s \\sim O(\\Delta t^{\\tfrac{3}{2}})$$

Because ds is order Δt, and dW\_t is order √Δt

Then there is

$$dW\_u dW\_s \\sim O(\\Delta t)$$

For the reason just discussed.

Once I substitute everything, I will neglect the first two orders, and will be left with terms with just du and ds

$$du$$

$$ds$$

The existing equation then simplifies a lot

$$X\_{t+\\Delta t} \= X\_t \+ \\alpha (X\_t) \\Delta t \+ \\beta (X\_t) \\Delta W\_t \+ \\int\_t^{t+\\Delta t}\\int\_t^u \\beta\_s’ \\beta\_s dW\_s dW\_u $$

And there’s another integral term you can see here.

You need to take the increments of Brownian motion and such, but then you can show that the integral term is equal to the

$$= \\beta\_t’ \\beta\_t \\frac{1}{2}(\\Delta W\_t \- \\Delta t)$$

This gives the Euler Milstein scheme.

The X\_t+Δt is what you’re approximating. The first part is the regular Euler, and then the integrals are the Milstein part.

If the model $$dX\_t \= \\alpha(X\_t) dt \+ \\beta(X\_t) dW\_t$$, then the Euler Milstein scheme is

$$X\_{t+\\Delta t} \= X\_t \+ \\alpha(X\_t) \\Delta t+ \\beta(X\_t) \\Delta W\_t \+ \\frac{1}{2}\\beta’(X\_t) \\beta(X\_t) (\\Delta W\_t^2 \- \\Delta t)$$

And by W you introduce a normal variable multiplied by $$Z \\sim N(0, 1)$$. The ΔW is created by $$Z\\sqrt{\\Delta t}$$. The other one is $$(Z^2 \- 1)\\Delta t$$ when the thing factors. For the same increment, you put it in two places, not just one places.

However, there is a possible issue, which might be the derivative. If the β function, the volatility part, if it’s complicated, how do you calculate the derivative? That might be hard. There’s another way to deal with this, a scheme called Runge-Kutta, a generalization where you calculate the euler part, and plug it into the beta, then you calculate the finite difference as an approximation of the derivative.

One more thing to mention. Which I shouldn’t, because it’s from the homework. Let’s have an example.

We have a process

$$dY\_t \= \\kappa(\\bar{y} \- Y\_t) dt \+ \\sigma \\sqrt{y\_t} dW\_t$$

This is the CIR process.

In this process, I have my

$$\\alpha(x) \= \\kappa(\\bar{Y} \- x)$$

Then you have beta

$$\\beta(x) = \\sigma \\sqrt{x}$$

If we now substitute in this formula, we have to calculate the derivative.

$$\\beta’(x) \= \\frac{\\sigma}{2\\sqrt{x}}$$

Now if we do Euler Milstein:

$$Y\_{t+\\Delta t} \= Y\_t \+ \\kappa(\\bar{Y} \- Y\_t) \\Delta t \+ \\sigma \\sqrt{Y\_t} \\Delta W\_t \+ \\text{ milstein correction: } \\sigma \\sqrt{Y\_t} \\frac{\\sigma}{2\\sqrt{Y\_t}} (\\Delta W\_t^2 \- \\Delta t)$$

Here, the two sqrtY\_t cancels, so it becomes sig^2/2.

The other thing to show is that if you look for example, this process.

$$dX\_ \= e^{X\_t} \\cos X\_t dt \+ 0.7dW\_t$$

Here, you have this constant

$$\\beta(X\_t) \= 0.7$$

So

$$\\beta’(X\_t) \= 0$$

Therefore there is no Euler-Milstein correction, because it relies on multiplication by the derivative. Like for example in GBM.

## Variance Reduction Redux

More of the idea to use on HW 4\.

One additional note will be given on antithetic variate.

We discussed the CLT and the basis of the whole thing, and the variance being smaller gives you better estimates.

However, this is more complicated than that.

**The better method is not always the one with smaller variability of the sample paths.**

We also need to consider the time to generate paths. If you have a Monte Carlo technique with less variability, but it takes one minute to generate a path, then it could be that another method with much higher variability that can generate 1 per second, is better, just by raw brute force. The paper mentioned is really good, the basis of the Monte Carlo book, which expands on the paper. Boyle is a Canadian professor from University of Waterloo, in 1997 they met, he did a summer school. He was drunk all the time in the morning lectures. Glasserman is a friend of the show as well. Third guy Brodie sucks.

If method 1 has variance σ\_1^2, and b\_1, they have a term called “work”, which could be time, but could be other stuff, b\_1 is the work to generate one replication of the final parameter, the one you’re trying to estimate, then we need to look at

$$\\sigma\_1^2 b\_1 \< \\sigma\_2^2 b\_2$$

He has a better expression, but I’m showing the simple thing. Why multiplication? There’s a reason

If you look at this perspective, and if you rewrite this as

$$\\frac{\\sigma\_1^2}{\\sigma\_2^2} \< \\frac{b\_2}{b\_1}$$

That’s when you would prefer one method over another.

**Antithetic note**:

Reminder: The way it works is you create one normal for one path, and use the negative of that normal for another path.

For antithetic variates, one replicate is $$\\frac{c\_i \+ c\_i^a}{2} \= \\bar{C\_i}$$

The actual estimate is the average of the 2\. This is not necessarily important for the final pricing, because if you take the general average, it doesn’t matter, but it’s important for the variance estimate, for confidence intervals.

This is because these paths are not independent, they’re very related. So you would use something like

$$\\text{Variance} \= \\frac{1}{n-1} \\sum\_{i-1}^n (\\bar{C\_i} \- \\bar{C})^2$$

This is important because each sequence of n is independent.

You might think I should iterate over 2n elements instead of n. and do both the regular and antithetic.

But this one will show less than it really is.

## Control Variates for the Asian Option

Glasserman’s explanation is better than mine, I will follow him.

The one with delta hedging and Asian option. There’s nothing wrong with delta hedging or Asian option, it’s just that it needs to be explained where it’s coming from.

The control variate for Monte Carlo, what it does, it should be called “use what you know”. You know, for example, that the option that delta hedges, you’re using the concept that if you do this very fast, the two values should be the same.

Similarly, for the Asian option, we’re using what we know.

$$P\_A$$ is the price of an Asian option based on Arithmetic average, which is what is encountered in practice.

$$P\_G$$ is geometric.

This P\_G has a formula, and for any variation on Asian options it’s very easy to get a geometric formula.

We’ll say we have a formula, if you give me characteristics and μ and σ, you get an exact number.

With this, let

$$\\hat{P\_A}$$ be the value calculated using a single path.

It doesn’t matter what you use, just one single path, where you calculate the value of the Asian option based on this average of all these paths.

And we’ll do the same for geometric

$$\\hat{P\_G}$$

We don’t need this for geometric because we have the formula.

**We are using the same path for both of these**.

I do know that

$$\\mathbb{E}\[\\hat{P\_A}\] \= P\_A$$

On expectation, I get the true vlau eof my option.

I also know

$$\\mathbb{E}\[\\hat{P\_G}\] \= P\_G$$

If we subtract, we get

$$P\_A \- P\_G \= \\mathbb{E}\[\\hat{P\_A} \- \\hat{P\_G}\]$$

This gives you a very natural kind of estimate.

$$P\_A \= P\_G \+ \\mathbb{E}\[\\hat{P\_A} \- \\hat{P\_G}\]$$

We can create a Monte Carlo path using this control variate:

$$\\hat{P\_A}^{cv} \= \\hat{P\_A} \- \\hat{P\_G} \+ P\_G$$

If I create a new path and average this, then it should give me on average this difference

You can write it like this

$$= \\hat{P\_A} \+ (P\_G \- \\hat{P\_G})$$

That parentheses statement is the control variate. I have my original path with Euler Milstein, then I control it.

For every path, I obtain the difference between the true value and the value of geometric from that particular path.
But is this better than just using $$\\hat{P\_A}$$?

If we want, we can calculate the variance. So the variance should be less. And remember that $$P\_G$$ is just a number, a constant with no variance.

$$\\mathbb{V}\[\\hat{P\_A}^{cv}\] \= \\mathbb{V}\[\\hat{P\_A}\] \+ \\mathbb{V}\[\\hat{P\_G}\] \- 2 \\text{Cov}(\\hat{P\_A}, \\hat{P\_G})$$

Everything after the first term should be negative to give me a better variance. The covariance should be greater than the variance. It’s only worth it if the covariance is large.

This brings the next idea. This is the original term plus this term. I can control the size of the difference, which puts a β on the coefficient. That β allows me to make the thing smaller. This is all specific to the Asian option, where there is this arithmetic and geometric thing. But there is no assumption about the stochastic model.

β means I’m going to parameterize this:

$$\\hat{P\_A}^\\beta \= \\hat{P\_A} \+ \\beta(P\_G \- \\hat{P\_G})$$

I can play around with β in such a way that the resulting variance is the smallest. What is that? We can do the same exact calculation, and minimize the result with respect to β.

$$\\mathbb{V}\[\\hat{P\_A}^\\beta\] \=  \\mathbb{V}\[\\hat{P\_A}\] \+ \\beta^2 \\mathbb{V}\[\\hat{P\_G}\] \- 2 \\beta \\text{Cov}(\\hat{P\_A}, \\hat{P\_G})$$

This is a quadratic expression. It’s a parabola, so the smallest value is in the vertex. The position of the vertex is obtain for

$$\\beta\_{\\text{min}} \= \-\\frac{b}{2a}$$

Where the varG is a, and the cov stuff is b.

$$= \-\\frac{-2\\text{Cov}(\\hat{P\_A}, \\hat{P\_G})}{2\\mathbb{V}\[\\hat{P\_G}\]}$$

This cancels to:

$$= \\frac{\\text{Cov}(\\hat{P\_A}, \\hat{P\_G})}{\\mathbb{V}\[\\hat{P\_G}\]}$$

If you have two variables, the regression is the covariance divided by the variance, so this is the formula for market beta/regression.

So if we regress $$\\hat{P\_A} \= \\alpha \+ \\beta \\hat{P\_G} \+ \\epsilon$$, the β is the β.

Last week, we learned this was true, but now we know how to get it.

**This control variate thing is basically**

$$\\hat{P\_A}^\\beta \= \\hat{P\_A} \+ \\hat{\\beta} (P\_G \- \\hat{P\_G})$$

Now we have another problem.

This is kinda screwed up. Because you’re using the same paths to estimate β, and the same path to estimate the value of the option. That introduces a bias, and this is calculated in the Glasserman paper.

Typically you have n paths, and you set n\_1 paths out to do regression. Then you use n \- n\_1 paths for calculation.

The advantage here is to do a proper regression, you don’t need a lot of observations, 100 would be plenty. But for Monte Carlo, you need hundreds of thousands.

Hopefully this is more clear, and what I hope you get is that he used the particular relationship that exists in the Asian option, to reason through the whole thing.

I’m going to make another expansion to this. We can introduce more control\!\!

It’s not really necessary because this existing control variate already gives a good estimate, but this shows you can introduce as many control as you like\!

Under risk-neutral equivalent martingale measure, we have

$$S\_0 \= \\mathbb{E}^Q\[S\_T e^{-rT}\]$$

If you take the stock price as a martingale, and discount it back, you should get S\_0. Nothing new.

This brings up another way to control.

We use the following, with β\_1 being our original control variate.

$$\\hat{P\_A}^{cv} \= \\hat{P\_A} \+ \\beta\_1(P\_G \- \\hat{P\_G}) \+ \\beta\_2 (S\_0 \- \\hat{S\_T} e^{-rT})$$

Now you have the path, you know what S\_T is, and S\_0 is a constant.

You have the same kind of regression of

$$\\hat{P\_A} \= \\alpha \+ \\beta\_1 \\hat{P\_G} \+ \\beta\_2 \\hat{S\_T} \+ \\epsilon$$

The constants don’t matter because you’re doing a regression, it just changes the y-intercept, doesn’t impact the β.

Technically, it’s σ√t, which is the confidence interval size, the diffusion size. It’s an estimate, work could refer to other things.

## Moment Matching Method

This is simple to use, so I’ll mention it, even though it’s useless.

If we have $$Z\_1, \\ldots Z\_n \\sim N(0, 1)$$

They should have theoretical mean 0, but the sample mean is not 0\.

The idea is to modify the sample to match the theoretical moments.

The reason I actually have never taught this method is because it’s kinda stupid, as a statistician.

Also, from the raw power of this method, it doesn’t do better than straight Monte Carlo. It does better when you pair it with control variate, where the power comes from the control variate.

In the example here, the random variables don’t have mean 0, so instead use $$Z\_1 \- \\bar{Z}, Z\_2 \- \\bar{Z}, \\ldots$$

These now all have mean 0, but now they’re correlated. So it creates problems when estimating stdev, it becomes bad, very tricky for estimating confidence intervals.

In the example, let’s say I’m going to price a European option based on GBM. When you do GBM, you don’t have to do all the intermediate steps, you can do all in one step. Because the terminal value

$$\\tilde{S\_T}(i) \= S\_0 e^{(r-\\tfrac{\\sigma^2}{2})T \+ \\sigma \\sqrt{T} \\tilde{Z}\_i}$$

After you modify the normal variable with the thing I said.

This is fine for European options, but it won’t work for path-dependent options.

Confidence intervals are hard to obtain.

This is the first order moment matching. You can also do second order moment matching. Say we want to create $$N(\\mu\_Z, \\sigma\_Z^2)$$ I’m trying to create numbers that are normal with this particular target. The usual thing to do here is

$$Z\_i \\sim N(0, 1\) \\rightarrow \\sigma\_Z Z\_i \+ \\u Z$$

Multiply to create the desired distribution.

But the numbers in the sample will have their own sample mean and stdev. So you have to modify this as

$$\\tilde{Z\_i} \= \\frac{\\sigma\_Z}{S\_Z}(Z\_i \- \\bar{Z}) \+ \\mu\_Z$$

Each number is modified by these two numbers S\_Z and Zbar, where S\_Z is the sample stdev.

$$S\_Z \= \\sqrt{\\frac{1}{n-1}\\sum (Z\_i \- \\bar{Z})^2}$$

For the random variables in the sample, they will have the desired distribution.

Like I said, this is a method from the 90s. I never liked it because it’s slower. All these modifications…

And in order to estimate the sample mu and stdev, I have to do all of the simulations first, then calculate the samples, then plug them back, so it’s SLOWER than doing it all at once.

And generally, from my experience, improvement is marginal, it’s not particularly useful.

Is the sample calculated in one path or all paths? It depends. In this example, you need all the paths. But you can do it for one path if you like.

Computationally, when you have numbers that you’re observing, if I have to estimate an average or variance of a certain number of them, theoretically, I can do this.

The idea of the GPU is that you have a lot of matrices and you do these calculations really fast. There is a memory of GPU and a memory of CPU. You want to keep everything in GPU memory as much as possible. The problem is that this method aggregates the paths, and does it again, which is impossible with a GPU.

## Additional Stuff

Stratified sampling is not the best explained here. It is a statistics technique, check any statistics book they will explain better there.

Importance sampling, same deal. I have a chapter in my book about importance sampling which is way better.

**Conditional MC**: very well explained in the paper

Low discrepancy sequences. (Quasi-Monte Carlo techniques). It’s not explained well in the paper, but you can look it up and read better papers.

Briefly:

when you start generating one dimensional random variables, we’ll say for a uniform distribution, we can use testers to see if the numbers are actually uniform.

Then you can generate pairs, two at a time (X\_1, X\_2) and plot them. You should definitely do this experiment with a random number generator. It would not look uniform at all. Human mind when you say uniform, thinks that it’s perfectly spread out. The point of the quasi generator is to spread out on purpose, to get a perfect uniform distribution. It’s okay as an exhaustive search method. But if you need more points, you have to quadruple them to have the same spread everywhere. The more detail you want, the finer quasi becomes, and it gets a lot slower.

But there are circumstances in which this is useful, and people in engineering that don’t understand randomness like this thing.

**Chapter 5** is about estimating American options using Monte Carlo simulations.

## subjective probability

George Calhoun sent an article to me in Nature

Trump’s election is a subjectiv eprobabiolity, it matters what people’s perceptions are.

A stock, TSLA. It’s been going down, so you’r wondering if it should keep going down or should it stabilize? And we don’t know because the stock is not the value of the company, it reflects the perception of people about the company.

It’s the same as poker. Game theory is so close to probability.

When people lose concentration, they react poorly.

## Generating Correlated Processes

If you have multiple stock processes that you want to generate that are correlated, how do you do that?

Each asset looks like

$$dX\_t^i \= f(X\_t^i) dt \+ g(X\_t^i) dW\_t^i$$

Each is a separate stochastic process, but they don’t move their own way at random.

This Brownian motion is correlated.

If we take the notation $$X\_t$$ the vector of components, and same for f(x). This is the simpler case. You can have a more complicated thing. Each function could depend on all the other ones, it doesn’t have to be driven by just one variable.

g(x) is a matrix dxd size, where dW is dx1, the vector of Brownian motion.

When you do the Monte Carlo simulation, the Brownian motion is what you’re interested in simulating.

We will assume that these are correlated. With this notation, we have

$$dX\_t \= f(X\_t) dt \+ g(X\_t) dW\_t$$

It’s more complicated because it’s a collection of multiple integrals on dW, but we will write like this for conciseness.

We have the covariance matrix

$$\\text{Cov}(\\Delta W\_t) \= \\Sigma \\Delta t$$

This is Brownian motion. So what exactly is the covariance matrix? The components are the covariances of each of the components.

$$\\begin{bmatrix} 1 & \\rho\_{12} & \\rho\_{13} & \\rho\_{1d} \\\\ \\\\ \\\\ \\\\ \\end{bmatrix}$$

Symmetric and positive definite matrix\!

Positive is vector times matrix times vector transpose, which is a 1x1 number. Positive definite means that for a vector u, this is always greater than 0\. This is very important because you can take a vector multiply with vector which will give us the variance, which will be always positive.

For example, take Heston

$$dS\_t \= rS\_t dt \+ \\sqrt{Y\_t} S\_t dW\_t^1$$

$$dY\_t \= \\alpha(\\bar{Y} \- Y\_t) dt \+ \\sigma \\sqrt{Y\_t} dW^2\_t$$

If I want to simulate this, which is part of homework, how would you do this?

Generate two random numbers which are correlated with ρ.

For two, it’s very simple.

We need $$X\_1, X\_2 \\sim N(0, 1)$$, such that $$\\text{Corr}(X\_1, X\_2) \= \\rho$$

Then we can multiply by √Δt and everything will work.

We will start with uncorrelated Z\_1, Z\_2 N(0, 1\)
I’ll take X\_1 \= Z\_1.

Then, I’ll take X\_2 \= ρZ\_1. We can do this because the variance of Z\_1 is 1, and covariance of Z\_1 and Z\_2 \= 0;

The combination has to have variance of 1, and if we’re combining linear combinations, then it’s normal.

So total value is

$$X\_2 \= \\rho Z\_1 \+ \\sqrt{1-\\rho^2} Z\_2$$

If you understand the principle, what do I do when I want to do three? X\_1, X\_2, X\_3

Take the same idea

$$X\_1 \= Z\_1$$

$$X\_2 \= \\rho\_{12} Z\_1 \+ \\sqrt{1-\\rho\_{12}^2} Z\_2????$$

$$X\_3 \= \\rho\_{13}Z\_1????$$

It becomes tricky. So is there a method to do this?

There is\! You should know where this is coming from

We have a vector X which is a lot of Xs. We are interested in covariance, which is distinct from correlation. Our covariance matrix will be one diagonal, where we multiply by √Δt. The values on the diagonal of the matrix are the variance, and the rest are covariance.

So how do I generate a vector with this covariance structure? Here is the idea.

If X is a random vector, (more details you could talk about in 540\) with mean μ, componentwise for each element in vector, then

$$\\text{Cov}(X) \= \\mathbb{E}\[(X-\\mu) (X-\\mu)^T\]$$

Take Y \= AX. A is a matrix, but it can be ANY DIMENSION nxd. We can transform 4 components into 15 components with different linear combinations.

The basis of the whole method is this:

$$\\text{Cov}(Y) \= \\mathbb{E}\[(Y \- \\mu\_Y) Y \- \\mu\_y)^T\]$$

And we know that the expectation of Y from linear combination si

$$\\mathbb{E}\[Y\] \= A \\mathbb{E}\[X\]$$

Because of this, we get

$$= \\mathbb{E}\[(AX \- A\\mu\_X)(AX \- A\\mu\_X)^T\]$$

And you can factor this. Remember that the order is very important.

$$= \\mathbb{E}\[A(X \- \\mu\_X)(AX \- A\\mu\_X)^T\]$$

And we can also do this in the transpose

$$= \\mathbb{E}\[A(X \- \\mu\_X)(X \- \\mu\_X)^T A^T\]$$

And the inner product is the covariance matrix\! So it ends up being this

$$= A \\Sigma A^T$$

**CHOLESKY DECOMPOSITION**

Take the Z vector if iid normals, which are N(0, I\_d). On the diagonal, you have 1 correlation.

Find a matrix A such that $$AA^T \= \\Sigma$$, the desired covariance.

The reason why you do this is because you have A, and you multiply it, and you get the thing you need.

Cholesky uses eigenvalues and eigenvectors, but it does exactly this.

## Covariance vs Correlation

How do you get from the covariance matrix to correlation?

$$\\rho\_{ij} \= \\frac{\\sigma\_{ij}}{\\sigma\_i \\sigma\_j}$$

How do you go from this method to other methods and vice versa?

In terms of matrix operations, it’s not complicated.

If D is the diagonal matrix of the variances (just the diagonal), then the correlation matrix is this. Inverse is regular inverse because it’s just a diagonal.

$$= \\sqrt{D}^{-1} \\times \\Sigma (\\sqrt{D}^{-1})^T$$

And the transpose is actually the same thing.

And you do non-inverse to get from correlation to covariance.

Not commutative, so be careful.

## Markov Chain Monte Carlo

Left unsaid
