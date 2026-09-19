+++
title = 'Poisson Processes'
date = 2024-11-28
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Poisson Processes', 'Jump Diffusion']
+++

### Lecture Notes

in-class final will be decided by Thanksgiving

#### Poisson Processes

All of the stuff we learned about stochastic calculus has been organized around the Ito process, which is continuous. We’re going to learn about how we can apply these ideas to other processes.

What exactly is a Poisson process?

If τ be a random variable with this pdf

\(f_\tau(t) = \begin{cases} \lambda e^{-\lambda t} & t \geq 0 \\ 0 & t < 0 \end{cases}\)

This is the exponential process with the cdf



This is a memoryless random variable. Think of a light bulb. If the lifetime of a lightbulb is memoryless, I’m saying that if I screw in a light bulb today, and the probability that the lightbulb would last for more than a year is the same. All we have to know is that it hasn’t died yet. How we can prove this is true is with cdfs?

If I know that

\(\mathbb{P}(\tau \leq t) = q - e^{-\lambda t}\)

Then

\(\mathbb{P}(\tau > t) = e^{-\lambda t}\)

by definition. Then what is the probability that

\(\mathbb{P}(\tau > t + s | \tau > s)\)

to answer that, we would simply use conditional probabilities. This would be the same as

\(= \frac{\mathbb{P}((\tau > t + s) \cap (\tau > s))}{\mathbb{P}(\tau > s)}\)

But because this is a strict subset on top,

\(= \frac{\mathbb{P}(\tau > t + s)}{\mathbb{P}(\tau > s)}\)

\(= \frac{e^{-\lambda(t+s)}}{e^{-\lambda s}}\)

\(= e^{-\lambda t}\)

If I’m trying to model a stock process that has discontinuitied, it would be really inconvenient if I had to go back and find a jump to understand my process. We want the Markov property, so the process needs to be Markov no matter what happened in the past: including a jump. Therefore, the process should be totally memoryless, so there is *no* information encoded in it that we can condition into.



We’re going to use our process to model the time in between events.

For our list of jump times \(\tau\), we can define



This counting process is memoryless because it’s built off of exponential random variables which are memoryless.

It’s a counting process, so we’re only dealing with nonnegative numbers.

We need something that can go to infinity because there could b infinite.

We’re going to have independent increments just like Brownian motion. All of these are stationary and independent.

For these increments:
\(\mathbb{E}[N(t) - N(s)] = \lambda(t-s)\)

\(\mathbb{V}[N(t) - N(s)] = \lambda(t-s)\)



Starting with this idea that

\(\mathbb{P}(N(t) - N(s) = k) = \frac{(\lambda(t-s))^ke^{-\lambda(t-s)}}{k!}\)

If I was tasked with determining what is the expected value, what would I do? The same for any discrete random variable:

\(\mathbb{E}[N(t)-N(s)] = \sum_{k=0}^\infty k \mathbb{P}(N(t)-N(s)=k) = \sum_{k=0}^\infty k\frac{(\lambda(t-s))^k e^{-\lambda(t-s)}}{k!}\)

I can potentially cancel a k, but that would be dividing by zero.

But this is 0 when \(k = 0\), so we can just remove that term.

\(= \sum_{k=1}^{\infty} k\frac{(\lambda(t-s))^k e^{-\lambda(t-s)}}{k!}\)

So now I can kill that k

\(=\sum_{k=1}^\infty \frac{(\lambda(t-s))^k e^{-\lambda(t-s)}}{(k-1)!}\)

We can do a reindex and say

\(l = k - 1\)

\(= \sum_{l=0}^{\infty} \frac{(\lambda(t-s))^{l+1}e^{-\lambda(t-s)}}{l!}\)

This is really close to fitting the power series

\(e^x = \sum_{k=0}^\infty \frac{x^k}{k!}\)

What would keep from taking advantage of that here? I can factor out the e part that’s a constant. Now that I have one two many ls, I can take one out.

\(= \lambda(t-s)e^{-\lambda(t-s)} \sum_{l=0}^\infty \frac{(\lambda(t-s))^l}{l!}\)

Then by the power series form, this is

\(= \lambda(t-s)e^{-\lambda(t-s)} e^{\lambda(t-s)} = \lambda(t-s)\)

Therefore this is proven.



How could I get the variance?

Let’s build on our knowledge of the expectation:

\(\mathbb{E}[(N(t) - N(s))^2] = \sum_{k=0}^\infty \frac{k^2(\lambda(t-s))^ke^{-\lambda(t-s)}}{k!}\)

If it’s squared, then we can use the same steps to take out zero through reindexing

\(= \sum_{l=0}^\infty \frac{(l + 1)(\lambda(t-s))^{l+1} e^{-\lambda(t-s)}}{l!}\)

So I’m going to factor out one of those λ(t-s) and distribute l + 1

\(= \lambda(t-s) \left[ \sum_{l=0}^\infty \frac{l(\lambda(t-s))^l e^{-\lambda(t-s)}}{l!} + \sum_{l=0}^\infty \frac{(\lambda(t-s))^l e^{-\lambda(t-s)}}{l!}\right]\)

The first term is just the expectation. The second is interesting. It’s the sum of the probabilities of all of the outcomes of the Poisson distribution, so it must be 1 based on the definition of a density.

\(= \lambda^2(t-s)^2 + \lambda(t-s)\)



What would be the moment generating function with dummy variable u?

\(\gamma_{N(t)}(u) = \mathbb{E}[e^{uN(t)}]\)

To calculate this expected value, this is the summation

\(= \sum_{k=0}^{\infty} \frac{e^{uk}(\lambda t)^k e^{-\lambda t}}{k!}\)

We’re going to repeat some of the tricks from earlier.



#### Martingale Property

Poisson being a counting process, this is not a martingale. It only increases. But what we can do is create a new process

\(M(t) = N(t) - \lambda t\)

This creates a **compensated Poisson process**

In order to prove this a martingale, we will see

\(\mathbb{E}[M(t)|\mathcal{F}(s)] = \mathbb{E}[N(t)|\mathcal{F}(s)] - \lambda t\)

\(= \mathbb{E}[N(t) - N(s)|\mathcal{F}(s)] + N(s) - \lambda t\)

But because of the memoryless nature, we can take out what’s independent.

\(= N(s) - \lambda s = M(s)\)



#### Compound Process

We can’t just say the process could go up by 1. That’s not interesting to us. What we do here is make a compound Poisson process which uses N(t) to determine how many events have happened until t. Then it draws the sizes of those events from another distribution that we are going to say are iid called {Y\_i} with expectation β.

\(Q(t) = \sum_{i=1}^{N(t)} Y_i\)

We have a result called Wald’s Equation, which states that

\(\mathbb{E}[\sum_{i=1}^{n(T)} Y_i] = \mathbb{E}[N(t)] \mathbb{E}[Y_i]\)

Let’s say I have lootboxes in my video game. The number of boxes I get is also random. But the number of boxes I get is independent of how much is in each individual box. Those are independent distributions. If I expect 5 items in a box, and on average I expect to get 10 boxes, then I expect to get 50 items. That’s what this equation is saying. We can also show this by iterated conditioning, but this is easier

Then the stock price will evolve like so

\(S(t) = S(0)\exp\left\{(r-\lambda k - \tfrac{\sigma^2}{2})t + \sigma W(t)\right\}\)

Then the log returns would be normally distributed if GBM was reality.

You could do a Q-Q plot (quantile quantile) You figure out what point of data in your plot would be in which quantile, and then do that for another data.

We have leptokurtosis in our real weights which make this not a straight line (heavy tails).

There are strategies to deal with this:

- Regime Switching: You assume that your stock follows four or five, or even more geometric Brownian motion. There are some periods where you’re in low or high volatility, and then you combine those, which explains some of leptokurtosis
- Stochastic Volatility: This is a different stock model like the Heston stock market model, which is that instead of \(\sigma(t)\) being multiplied by the stock price, it’s multiplied by a different stochastic process with a different Brownian motion
- Fractional Brownian Motion: Brownian motion which doesn’t have independent increments.

Thomas Lonon’s PhD was on jump diffusion, so he wants to talk about that\!

#### Jump Diffusion

Using our compound Poisson process, we can created a compensated compound process

\(Q(t) - \beta \lambda(t)\)

And this is a martingale.



We will require that every process has independent increments for now.



We’re now going to define the stochastic integral

where X has jumps and is not a

\(X(t) = X(0) + I(t) + R(t) + J(t)\)

where J(t) is an adapted, right-continuous process with J(0) = 0 and (J(t) = \lim_{s\downarrow t}J(s)\).

Also known as **cadlag**, continuous from the right, and limit exists from the left, from the French. This is very important to adapted processes.

\(\int_0^t \phi(s)dX(s) = \int_0^t \phi(s) \Gamma(s) dW(s) + \int_0^t \phi (s) \Theta(s) ds + \sum_{0 < s \leq t} \phi(s) \Delta J(s)\)

Well how do you calculate this \(\Delta J(s)\)?

It’s \(J(s) - J(s_-)\)

This will give the magnitude of the jump at time s, and 0 everywhere else.

We will still need the square-integrability to hold true, in order for this stochastic integral to be a martingale, even though it has jumps.

#### Quadratic Variation

How do we prove quadratic variation? We go back to norms of partitions.

\([X, X](t) = \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1}(X(t_{j+1}) - X(t_j))^2\)

And this ends up being 0, because the uncountably infinite number of zeros from the continuous part of the process destroys the countable number of nonzero terms in the jump part of the process.



Ito formula for a Jump Process

\(f(X(t)) = f(0, X(0)) + \int_0^t f'(X(s)) dX^c(s) + \frac{1}{2}\int_0^t f''(X(s))dX^c(s)dX^c(s) + \sum_{0 < s \leq T} [f(X(s)) - f(X(s_-))]\)

This is the same as the Ito decomposition for the continuous aprt of the process plus the jumps.

We’re going to prove that our Brownian motion and our Poisson process are independent, with the Ito formula.

Let u1 and u2 be our dummy variables:

\(Y(t) = e^{u_1W(t) + u_2N(t) - \tfrac{1}{2}u_1^2 t - \lambda t(e^{u_2}-1)}\)

The continuous part is time and the Brownian motion, \(t\) and \(W(t)\). The jump part is the jumps, given by \(N(t)\).

We can prove that these are independent by showing that the expectation of their joint moment generating function is the same as the product of their individual moment generating functions.

#### Two Dimensional Ito Formula

For two dimensional jump processes, you have the integrals for both.

We can get an Ito product rule for Ito processes.

\(X_1(t)X_2(t) = X_1(0)X_2(0) + \int_0^t X_2(s_-)\,dX_1(s) + \int_0^t X_1(s_-)\,dX_2(s) + \text{jump cross-terms}\)

We need this to prove the **Doleans-Dade exponential**

\(Z^X(t) = e^{X^c(t) - \tfrac{1}{2}[X^c, X^c](t)} \product_{0 < s \leq t} (1 + \Delta X(s))\)

We claim that this process is the solution to the SDE

\(dZ^X(t) = Z^X(t-)dX(t)\)

With the initial condition

We will need this result to establish our risk-neutral probability measure.

How do we get the differential for a jump process?





We can change the intensity of a Poisson process through the risk-neutral probability measure \(\tilde{\mathbb{P}}\)
The uniqueness of the risk-neutral measure comes into doubt when you’re looking for a unique solution. You don’t have a complete market, so you calibrate the market to the existing market.

This is in contrast to GBM which always has a unique solution.

#### Diffusion

Let’s look again at these parameters:

\(S(t) = S(0)\exp\left\{(r-\lambda k - \tfrac{\sigma^2}{2})t + \sigma W(t)\right\}\)

#### Theorem 11.5.1

For

\(H(t) = \log S(t)\)

\(S(t) = S(0) + \int_0^t S(u) dH^c(u) + \frac{1}{2}\int_0^t S(u)(dH^c(u))^2 + \sum_{0 < u \leq t} (S(u) - S(u_-))\)

We know some of these things

\(= S(0) + \int_0^t S(u)(r - \lambda k - \tfrac{\sigma^2}{2})du + \int_0^t S(u) \sigma d\tilde{W}(u) + \frac{1}{2}\int_0^t S(u) \sigma^2 du\)

And the rest of this stuff…

\(+  \sum_{0 < u \leq t} (S(u) - S(u_-))\)

We can say that the σ² portions cancel out, so for a jump at time u,

\(S(u) = S(0) e^{(r - \lambda k - \tfrac{\sigma^2}{2})u + \sigma W(u) + \sum_{i=0}^{N(u_-)} X_i + X_{N(u)}}\)

Then for the jump increment,

\(S(u) - S(u_-) = S(u_-) (e^{X_{N(u)}} - 1) \Delta N(u)\)

Let’s look at the discount process

\(D(t) = e^{-rt}\)
\(D(t) S(t) = S(0) + \int_0^t - \lambda k D(u)S(u) du + \int_0^t \sigma S(u) D(u) d \tilde{W}(u) + \sum_{0 < u \leq t} D(u) S(u_-) (e^{X_{N(u)}} - 1)\Delta N(u)\)


