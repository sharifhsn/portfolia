+++
title = 'Stochastic Calculus Review'
date = 2024-10-31
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Review', 'Pricing']
+++

#### Content Review

Problem Set 5

\(Y(t) = e^{tW(t)}\)

Find the differential

\(dY(t)\)

Recognize that this is some function that looks like f(a, b), like

\(f(a, b) = e^{ab}\)

where a is a deterministic component and b is a stochastic component.

Then solve your partials

\(f_a = be^{ab}\)
\(f_b = ae^{ab}\)

\(f_{bb} = a^2 e^{ab}\)

then using the Ito formula, this is

\(dY(t) = W(t) e^{tW(t)} dt + te^{tW(t)} dW(t) + \frac{1}{2}t^2 e^{tW(t)}dt\)



Question on why we’re able to get away with this?
\(\mathbb{E}[e^{\sigma W(t)}] = e^{\tfrac{1}{2}\sigma^2t}\)

This is because of a result, confirmed in the result, that

\(X \sim N(a, b^2)\) implies \(\mathbb{E}[e^{uX}]\)

Which is the moment generating function with respect to the dummy variable u, is

\(= e^{au + \tfrac{1}{2}b^2u^2}\)

We’re using this off-label. So if we plug it into this we can do this. What if sigma is adapted to time? Can we use this result? Not necessarily. Being an adapted process means that you’re measurable with respect to filtration at that time. But if \(\Delta t\) is a random process, then this is a totally different problem.



\(\frac{dS(t)}{S(t)} = \mu dt + \sigma dW(t)\)

Can you take the integral from both sides? You can, but it causes some issues.

\(\int_0^t \frac{dS(u)}{S(u)} = \alpha t + \sigma W(t)\)

Doesn’t really give you a closed form approximation.



From the derivation of Black Scholes

Expectation of the discount factor, S\_t - K, then you have an indicator function.

Indicator is transformed, where does that came from

\(\mathbb{E}\left[e^{-rT} (S(T) - K) \mathbb{I}_{\{d* < W(T)\}} \right]\)

We can substitute

What is random? W(t). What it’s distribution? normal over real line.

Then take the infinite integral.



Question from sample midterm:
\(I(t) = \int_0^t \Delta(u) dW(u)\)

Find \(\mathbb{E}[I^4(t)]\)

And \(\Delta(u)\) is \(3u\)

There are a couple ways to do this\! There’s the way with the hint, and other ways.
Any time you’re doing an expected value of a non-well-defined process, like an Ito process raised to a power, look at the Ito decomposition instead of the process as a whole.

\(d(I^4(t)) = 4I^3(t)dI(t) + 6I^2(t)(dI(t))^2\)

And then

\(dI(t) = 3tdW(t)\)

based on what we already know…

\((dI(t))^2 = 9t^2 dt\)
based on what we know

\(I^4(t) = \int_0^t 4I^3(u) \Delta(u) dW(u) + \int_0^t 6I^2(u)(9u^2) du\)

When I take the expectation, I can see that an Ito integral with respect to a martingale is a martingale, so the first term is gone.

\(\mathbb{E}[I^4(t)] = \int_0^t 54 u^2 \mathbb{E}[I^2(u)] du\)



Could you be more clever about this?

This is an Ito integral of a deterministic integrand, so it has to be normally distributed. The fourth moment of any normal variable is three times the variance.

This would give you the answer. But if it was like in the homework problem where you want to do I^6, you would have to do it in the Ito decomposition way.



An Ito decomposition results in A nonrandom initial constant, a Riemann integral (du), and an Ito integral (dW(t)).



Understand that this formula is

Generalized geometric Brownian motion.



If you recognize that if you have a process that can be rewritten as e^Ito process, do we need to do our partials? If you can reliably get the correct answer without doing that, you can, but it’s better to do the partials.



Itos’ formula:

\(f(t, X(t)) = f(0, X(0)) + \int_0^t f_a(u, X(u)) du + \int_0^t f_b(u, X(u))dX(u) + \frac{1}{2}\int_0^t f_{bb} (u, X(u)) (dX(u))^2\)

X(t) is an Ito process

u is your index

Brownian motion is definitely an Ito process. In order to be an Ito process, you need to be able to be expressed as the nonrandom constant + Riemann + stochastic.



Quadratic variation of a process

\(X(t) = 3 - \int_0^t W(u)du + \int_0^t u dW(u)\)

Quickest way to find this is recognizing that this is an Ito process.

Quadratic variation of an Ito process is

\(\int_0^t \Delta^2 (u) du\)
REMEMBER THIS

How do we get the expected value of an Ito integral squared? The Ito isometry.



If I have the expression

If I tell you \(u = 2\) and \(t = 4\),

\(\int_0^t W(t)u^2\,dW(u)\)

THAT IS NOT AN ADAPTED PROCESS.

## Week 9

### General Probability Theory

Ω is the **sample space** of all possible outcomes ω.

A **σ-algebra** is the set of all sets generated from a starting set of outcomes, their complements, and the unions of all complements. Conceptually, it represents an addressable subset in a potentially uncountably infinite sample space. The σ-algebra is represented by \(\mathcal{F}\).

The **probability measure** \(\mathbb{P}\) distributes values of probability on every set in the σ-algebra \(\mathcal{F}\), which must add up to 1 across Ω.

The **Borel set** is the σ-algebra generated by the set of all closed intervals on the real number line. Conceptually, it represents an addressable subset of real numbers.

A **random variable** is a mapping from outcomes ω to a Borel subset. This could be a single number or an interval.

The **distribution measure** of a random variable X is the probability measure that X is in each Borel subset. This is computed by finding the *preimage* of a Borel subset, which is an event in the sample space, and finding the probability measure of that event.

Two different random variables could have the same distribution measure, and the same random variable could have two different distribution measures under two different probability measures.

The **expectation** of a random variable is the average result of the random variable. This can be computed in many ways. For a discrete random variable, you can directly compute the result of each outcome mapped through the random variable, multiply them by the probability of the outcome, and sum them. For a continuous random variable, you must use an integral.

\(\mathbb{E}[X] = \int_\Omega X(\omega) d\mathbb{P}(\omega)\)

(Definition 1.3.3)

Expectations have the property of linearity.

### Information and Conditioning

We can model the information we have regarding an uncertain outcome with σ-algebras.

If we know which set of outcomes that the outcome must belong to based on the current information, we can generate a σ-algebra from that set of outcomes.

A **filtration** is a sequence of such σ-algebras that represent the information available over time until time *t*.

Filtrations always increase in information over time.

The filtration at time *t* represents all the information at time *t*, and it is used for conditioning. We can say that a random variable is **measurable** with respect to a filtration if the information in the filtration can be used to determine the value of the random variable.

For any two sets, **independence** is generally defined by

\(\mathbb{P}(A \cap B) = \mathbb{P}(A) \cdot \mathbb{P}(B)\)

Two σ-algebras are independent if this is true for all sets in each σ-algebra.

Two random variables are independent if the σ-algebras generated from them are independent.

Any functions on independent random variables will also result in independent random variables.

Not gonna bother with joint densities and crap.

A **conditional expectation** allows us to use information from a filtration to estimate the expectation of a random variable without it being completely measurable. In shorthand, we might use a random variable as a condition to indicate that the filtration is the σ-algebra generated by the random variable.

Conditional expectations have the following properties (Theorem 2.3.2)

- Linearity
- Taking out what is known: if a random variable X is measurable with respect to the condition, it can be taken out.
  \(\mathbb{E}[XY|\mathcal{G}] = X\mathbb{E}[Y|\mathcal{G}]\)
- Iterated conditioning: if we have a σ-algebra H with *less* information, we can subsume the σ-algebra G with *more* information into it.
  \(\mathbb{E}[\mathbb{E}[X|\mathcal{G}]|\mathcal{H}] = \mathbb{E}[X|\mathcal{H}]\)
- Independence: if a random variable X is independent of the condition, the condition is irrelevant.
  \(\mathbb{E}[X|\mathcal{G}] = \mathbb{E}[X]\)

A **stochastic process** is a collection of random variables indexed at time *t*.

An **adapted stochastic process** is a stochastic process where each random variable is measurable by the filtration at time *t*. Conceptually, it is a process which only depends on information available at each time *t*.

A **martingale** is an adapted stochastic process which is expected to remain the same value at all times. Formally, (Definition 2.3.5)

\(\mathbb{E}[M(t)|\mathcal{F}(s)] = M(s)\) for all \(0 \leq s \leq t \leq T\)

Submartingales and supermartingales observe this property for \>= and \<=, respectively.

A **Markov** is an adapted stochastic process where we can determine the expectation of the process using only the previous value. In other words, all of the information (filtration) up to time *s* is encoded in the value. Formally (2.3.6)

\(\mathbb{E}[f(X(t))|\mathcal{F}(s)] = g(X(s))\)

### Brownian Motion

The **symmetric random walk** is an adapted stochastic process which moves up and down by 1 by the flip of a coin at each time step. It has the property that each of its increments are independent. The expectation of the increment is 0, and its variance is Δt. The walk has the martingale property, which can be shown by splitting the current value into an increment, which is independent, and the previous value, which is measurable.

The **scaled symmetric random walk** approximates the Brownian motion.

\(W^{(n)}(t) = \frac{1}{\sqrt{n}} M_{nt}\)

as n approaches ∞.

I’m going to skip a lot of stuff relating to random walks, assuming that it won’t be relevant.

**Brownian motion** W(t) has the following properties:

- Independent increments
- Normally distributed increments
- Expectation of increments is 0
- Variance of increments is Δt
- Martingale

The **first-order variation** of a function is the definite integral from time 0 to T of the absolute value of its derivative. It can also be computed by partitioning time T into partition Π. As ||Π|| (the norm of Π, aka size of its largest increment) approaches 0, we’re interested in summing the absolute value of each of these increments. Essentially we’re measuring how much change there is in the function.

The **quadratic variation** is computed in the same way, but with the increments being squared. Formally (3.4.1)

\([f, f](T) = \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1}[f(t_{j+1}) - f(t_j)]^2\)

Typically, quadratic variation is 0 for any differentiable function. The quadratic variation of Brownian motion \[W, W\](T) is T. Conceptually, we can understand this as Brownian motion accumulating quadratic variation at rate one per unit time.

The differential of time *dt* multiplied by any other differential is 0. The differential of Brownian motion *dW(t)* multiplied by itself is *dt*. This relates to quadratic variation because

\(d[W,W](t) = dW(t)dW(t) = dt\)

**Geometric Brownian motion** is an application of Brownian motion to stock prices. The process is described by

\(S(t) = S(0) \exp \left\{\sigma W(t) + \biggl(\alpha - \frac{1}{2}\sigma^2 \biggr) t\right\}\)

And log returns in this process are described by

\(\log \frac{S(t_{j+1})}{S(t_j)} = \sigma(W(t_{j+1}) - W(t_j)) + \left(\alpha - \frac{1}{2}\sigma^2 \right) (t_{j+1} - t_j)\)

Skipping first passage time distribution, reflection principle, maximum to date

### Stochastic Calculus

The purpose of stochastic calculus is to integrate an adapted stochastic process on a Brownian motion.

\(\int_0^T \Delta (t) dW(t)\)
This Δ describes our position in an asset at time *t*, which is dependent on the change in price. This integral is the value of the portfolio at time T. The change in price is a stochastic process based on Brownian motion, which means that we cannot integrate with a Riemann/Lebesgue integral.

In order to construct the **Itô integral**, we add up increments of W(t) and multiply them by the stock position Δ(t) at that time. The discrete analogy is that of W(t) as stock price and the time intervals being trading dates. The value of the portfolio is therefore the sum of the product of: the change in stock price each day, and the position held in stock on that day. Taking this discrete analogy continuously creates the integral.

The Itô integral is described as follows:

\(I(t) = \int_0^t \Delta(u) dW(u)\)

The Itô integral is a martingale. This is proved here.







## Final Methods
