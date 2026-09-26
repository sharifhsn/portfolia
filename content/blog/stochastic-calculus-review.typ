/*
title = 'Stochastic Calculus Review'
date = 2024-10-31
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Review', 'Pricing']
*/

==== Content Review
<content-review>
Problem Set 5

$Y\(t\)= e^(t W\(t\))$

Find the differential

$d Y\(t\)$

Recognize that this is some function that looks like $f\(a\,b\)$, like

$f\(a\,b\)= e^(a b)$

where $a$ is a deterministic component and $b$ is a stochastic component.

Then solve your partials

$f_a = b e^(a b)$ $f_b = a e^(a b)$

$f_(b b) = a^2 e^(a b)$

then using the Ito formula, this is

$d Y\(t\)= W\(t\)e^(t W\(t\)) d t + t e^(t W\(t\)) d W\(t\)+ 1 / 2 t^2 e^(t W\(t\)) d t$

Question on why we're able to get away with this? $bb(E)\[e^(sigma W\(t\))\]= e^(1 / 2 sigma^2 t)$

This is because of a result, confirmed in the result, that

$X tilde.op N\(a\,b^2\)$ implies $bb(E)\[e^(u X)\]$

Which is the moment generating function with respect to the dummy variable $u$, is

$= e^(a u + 1 / 2 b^2 u^2)$

We're using this off-label. So if we plug it into this we can do this. What if $sigma$ is adapted to time? Can we use this result? Not necessarily. Being an adapted process means that you're measurable with respect to filtration at that time. But if $Delta t$ is a random process, then this is a totally different problem.

$frac(d S\(t\), S\(t\)) = mu d t + sigma d W\(t\)$

Can you take the integral from both sides? You can, but it causes some issues.

$integral_0^t frac(d S\(u\), S\(u\)) = alpha t + sigma W\(t\)$

Doesn't really give you a closed form approximation.

From the derivation of Black Scholes

Expectation of the discount factor, $S_t - K$, then you have an indicator function.

Indicator is transformed, where does that came from

$bb(E) [e^(- r T) \( S \( T \) - K \) bb(I)_({ d * < W\(T\)})]$

We can substitute

What is random? $W\(t\)$. What it's distribution? normal over real line.

Then take the infinite integral.

Question from sample midterm: $I\(t\)= integral_0^t Delta\(u\)d W\(u\)$

Find $bb(E)\[I^4\(t\)\]$

And $Delta\(u\)$ is $3 u$

There are a couple ways to do this! There's the way with the hint, and other ways. Any time you're doing an expected value of a non-well-defined process, like an Ito process raised to a power, look at the Ito decomposition instead of the process as a whole.

$d\(I^4\(t\)\)= 4 I^3\(t\)d I\(t\)+ 6 I^2\(t\)\(d I\(t\)\)^2$

And then

$d I\(t\)= 3 t d W\(t\)$

based on what we already know…

$\(d I\(t\)\)^2= 9 t^2 d t$ based on what we know

$I^4\(t\)= integral_0^t 4 I^3\(u\)Delta\(u\)d W\(u\)+ integral_0^t 6 I^2\(u\)\(9 u^2\)d u$

When I take the expectation, I can see that an Ito integral with respect to a martingale is a martingale, so the first term is gone.

$bb(E)\[I^4\(t\)\]= integral_0^t 54 u^2 bb(E)\[I^2\(u\)\]d u$

Could you be more clever about this?

This is an Ito integral of a deterministic integrand, so it has to be normally distributed. The fourth moment of any normal variable is three times the variance.

This would give you the answer. But if it was like in the homework problem where you want to do $I^6$, you would have to do it in the Ito decomposition way.

An Ito decomposition results in A nonrandom initial constant, a Riemann integral $d u$, and an Ito integral $d W\(t\)$.

Understand that this formula is

Generalized geometric Brownian motion.

If you recognize that if you have a process that can be rewritten as e^Ito process, do we need to do our partials? If you can reliably get the correct answer without doing that, you can, but it's better to do the partials.

Itos' formula:

$f\(t\,X\(t\)\)= f\(0\,X\(0\)\)+ integral_0^t f_a\(u\,X\(u\)\)d u + integral_0^t f_b\(u\,X\(u\)\)d X\(u\)+ 1 / 2 integral_0^t f_(b b)\(u\,X\(u\)\)\(d X\(u\)\)^2$

$X\(t\)$ is an Ito process

$u$ is your index

Brownian motion is definitely an Ito process. In order to be an Ito process, you need to be able to be expressed as the nonrandom constant + Riemann + stochastic.

Quadratic variation of a process

$X\(t\)= 3 - integral_0^t W\(u\)d u + integral_0^t u d W\(u\)$

Quickest way to find this is recognizing that this is an Ito process.

Quadratic variation of an Ito process is

$integral_0^t Delta^2\(u\)d u$ REMEMBER THIS

How do we get the expected value of an Ito integral squared? The Ito isometry.

If I have the expression

If I tell you $u = 2$ and $t = 4$,

$integral_0^t W\(t\)u^2 thin d W\(u\)$

THAT IS NOT AN ADAPTED PROCESS.

== Week 9
<week-9>
=== General Probability Theory
<general-probability-theory>
$Omega$ is the #strong[sample space] of all possible outcomes $omega$.

A #strong[$sigma$-algebra] is the set of all sets generated from a starting set of outcomes, their complements, and the unions of all complements. Conceptually, it represents an addressable subset in a potentially uncountably infinite sample space. The $sigma$-algebra is represented by $cal(F)$.

The #strong[probability measure] $bb(P)$ distributes values of probability on every set in the $sigma$-algebra $cal(F)$, which must add up to 1 across $Omega$.

The #strong[Borel set] is the $sigma$-algebra generated by the set of all closed intervals on the real number line. Conceptually, it represents an addressable subset of real numbers.

A #strong[random variable] is a mapping from outcomes $omega$ to a Borel subset. This could be a single number or an interval.

The #strong[distribution measure] of a random variable $X$ is the probability measure that $X$ is in each Borel subset. This is computed by finding the #emph[preimage] of a Borel subset, which is an event in the sample space, and finding the probability measure of that event.

Two different random variables could have the same distribution measure, and the same random variable could have two different distribution measures under two different probability measures.

The #strong[expectation] of a random variable is the average result of the random variable. This can be computed in many ways. For a discrete random variable, you can directly compute the result of each outcome mapped through the random variable, multiply them by the probability of the outcome, and sum them. For a continuous random variable, you must use an integral.

$bb(E)\[X\]= integral_Omega X\(omega\)d bb(P)\(omega\)$

\(Definition 1.3.3)

Expectations have the property of linearity.

=== Information and Conditioning
<information-and-conditioning>
We can model the information we have regarding an uncertain outcome with $sigma$-algebras.

If we know which set of outcomes that the outcome must belong to based on the current information, we can generate a $sigma$-algebra from that set of outcomes.

A #strong[filtration] is a sequence of such $sigma$-algebras that represent the information available over time until time $t$.

Filtrations always increase in information over time.

The filtration at time $t$ represents all the information at time $t$, and it is used for conditioning. We can say that a random variable is #strong[measurable] with respect to a filtration if the information in the filtration can be used to determine the value of the random variable.

For any two sets, #strong[independence] is generally defined by

$bb(P)\(A inter B\)= bb(P)\(A\)dot.op bb(P)\(B\)$

Two $sigma$-algebras are independent if this is true for all sets in each $sigma$-algebra.

Two random variables are independent if the $sigma$-algebras generated from them are independent.

Any functions on independent random variables will also result in independent random variables.

Not gonna bother with joint densities and crap.

A #strong[conditional expectation] allows us to use information from a filtration to estimate the expectation of a random variable without it being completely measurable. In shorthand, we might use a random variable as a condition to indicate that the filtration is the $sigma$-algebra generated by the random variable.

Conditional expectations have the following properties (Theorem 2.3.2)

- Linearity
- Taking out what is known: if a random variable $X$ is measurable with respect to the condition, it can be taken out. $bb(E)\[X Y\|cal(G)\]= X bb(E)\[Y\|cal(G)\]$
- Iterated conditioning: if we have a $sigma$-algebra $H$ with #emph[less] information, we can subsume the $sigma$-algebra $G$ with #emph[more] information into it. $bb(E)\[bb(E)\[X\|cal(G)\]\|cal(H)\]= bb(E)\[X\|cal(H)\]$
- Independence: if a random variable $X$ is independent of the condition, the condition is irrelevant. $bb(E)\[X\|cal(G)\]= bb(E)\[X\]$

A #strong[stochastic process] is a collection of random variables indexed at time $t$.

An #strong[adapted stochastic process] is a stochastic process where each random variable is measurable by the filtration at time $t$. Conceptually, it is a process which only depends on information available at each time $t$.

A #strong[martingale] is an adapted stochastic process which is expected to remain the same value at all times. Formally, (Definition 2.3.5)

$bb(E)\[M\(t\)\|cal(F)\(s\)\]= M\(s\)$ for all $0 lt.eq s lt.eq t lt.eq T$

Submartingales and supermartingales observe this property for $gt.eq$ and $lt.eq$, respectively.

A #strong[Markov] is an adapted stochastic process where we can determine the expectation of the process using only the previous value. In other words, all of the information (filtration) up to time $s$ is encoded in the value. Formally (2.3.6)

$bb(E)\[f\(X\(t\)\)\|cal(F)\(s\)\]= g\(X\(s\)\)$

=== Brownian Motion
<brownian-motion>
The #strong[symmetric random walk] is an adapted stochastic process which moves up and down by 1 by the flip of a coin at each time step. It has the property that each of its increments are independent. The expectation of the increment is 0, and its variance is $Delta t$. The walk has the martingale property, which can be shown by splitting the current value into an increment, which is independent, and the previous value, which is measurable.

The #strong[scaled symmetric random walk] approximates the Brownian motion.

$W^(\(n\))\(t\)= 1 / sqrt(n) M_(n t)$

as $n$ approaches $oo$.

I'm going to skip a lot of stuff relating to random walks, assuming that it won't be relevant.

#strong[Brownian motion] $W\(t\)$ has the following properties:

- Independent increments
- Normally distributed increments
- Expectation of increments is 0
- Variance of increments is $Delta t$
- Martingale

The #strong[first-order variation] of a function is the definite integral from time 0 to $T$ of the absolute value of its derivative. It can also be computed by partitioning time $T$ into partition $Pi$. As $parallel Pi parallel$ (the norm of $Pi$, aka size of its largest increment) approaches 0, we're interested in summing the absolute value of each of these increments. Essentially we're measuring how much change there is in the function.

The #strong[quadratic variation] is computed in the same way, but with the increments being squared. Formally (3.4.1)

$\[f\,f\]\(T\)= lim_(parallel Pi parallel arrow.r 0) sum_(j = 0)^(n - 1)\[f\(t_(j + 1)\)- f\(t_j\)\]^2$

Typically, quadratic variation is 0 for any differentiable function. The quadratic variation of Brownian motion $\[W\,W\]\(T\)$ is $T$. Conceptually, we can understand this as Brownian motion accumulating quadratic variation at rate one per unit time.

The differential of time $d t$ multiplied by any other differential is 0. The differential of Brownian motion $d W\(t\)$ multiplied by itself is $d t$. This relates to quadratic variation because

$d\[W\,W\]\(t\)= d W\(t\)d W\(t\)= d t$

#strong[Geometric Brownian motion] is an application of Brownian motion to stock prices. The process is described by

$S(t) = S(0) exp{sigma W(t) + (alpha - 1 / 2 sigma^2) t}$

And log returns in this process are described by

$log frac(S\(t_(j + 1)\), S\(t_j\)) = sigma\(W\(t_(j + 1)\)- W\(t_j\)\)+ (alpha - 1 / 2 sigma^2)\(t_(j + 1) - t_j\)$

Skipping first passage time distribution, reflection principle, maximum to date

=== Stochastic Calculus
<stochastic-calculus>
The purpose of stochastic calculus is to integrate an adapted stochastic process on a Brownian motion.

$integral_0^T Delta\(t\)d W\(t\)$ This $Delta$ describes our position in an asset at time $t$, which is dependent on the change in price. This integral is the value of the portfolio at time $T$. The change in price is a stochastic process based on Brownian motion, which means that we cannot integrate with a Riemann/Lebesgue integral.

In order to construct the #strong[Itô integral], we add up increments of $W\(t\)$ and multiply them by the stock position $Delta\(t\)$ at that time. The discrete analogy is that of $W\(t\)$ as stock price and the time intervals being trading dates. The value of the portfolio is therefore the sum of the product of: the change in stock price each day, and the position held in stock on that day. Taking this discrete analogy continuously creates the integral.

The Itô integral is described as follows:

$I\(t\)= integral_0^t Delta\(u\)d W\(u\)$

The Itô integral is a martingale. This is proved here.

== Final Methods
<final-methods>
