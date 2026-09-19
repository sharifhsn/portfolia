+++
title = 'Discrete Distributions and Moments'
date = 2024-09-23
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Discrete Distributions', 'Moments']
+++

## Week 4

### Lecture Notes

We will be covering discrete random variables this week.

A discrete random variable is one whose image \(X(\Omega)\) is a finite/countable subset of \(\mathbb{R}\).

First thing we introduce is the probability mass function (pmf).

It is basically the probability measure assigned to a single value: \(P_X(\{x\}) = P(X=x)\)

Because of the law of total probability, the probability of all outcomes must sum to 1:

\(\sum_{x \in X(\Omega)} P(X=x) = 1.\)

Next thing is the cumulative distribution function (cdf).

Usually use the capital F to denote this: \(F(t) = P(X \leq t) = \sum_{x \in X(\Omega) \cap x \leq t} P(X=x)\)

A simple example for a discrete random variable is that if you roll a die, the outcome of the die will give you a discrete random variable. If I’m interested in \(F(3) = P(X \leq 3) = P(X=1) + P(X=2) + P(X=3)\)

Another example:

We denote \(X\) as the number of times we roll the die until we get the outcome 6. If we’re lucky and roll the die once to get a 6, what’s the probability? For a fair die it’s \(\tfrac{1}{6}\). For the second roll, \(P(X=2) = \tfrac{5}{6} \times \tfrac{1}{6} = \tfrac{5}{36}\): the first roll is not 6 and the second roll is 6.

The outcome of the first roll does not affect the second roll.

More difficult one, \(P(X=3)\)

\(P(X=3) = \frac{5}{6} \times \frac{5}{6} \times \frac{1}{6}\)

You can prove by induction that the formula is

\(P(X=n) = \left(\frac{5}{6}\right)^{n-1} \times \frac{1}{6}, 1 \leq n\)

This is a simple example.

I want to say a property of the cdf:

If you have \(X: \Omega \rightarrow \mathbb{R}\) is a discrete r.v., \(cdf F(t)\) is piecewise constant and has finite/countable jumps.

If you think about cdf, it’s a probability that lies from 0 to 1.

The graph of discrete cdf is exclusive coming from the right side, so the hole is on the bottom of the jump, not the top. We accumulate in a discrete ways, which makes it like a staircase. Each piece corresponds to a constant value, and there are finite jumps.

For simplicity, we will denote the following notations:

\(X(\Omega = \{a_1, a_2, a_3, \ldots \}\)

\(p_i = P(X=a_i), i=1\)

#### Moments

Moments are expectations, expectations are kind of like intervals in calculus. Here we are talking about discrete random variables, so our integration is basically a summation. In the next class we are going to talk about continuous, where the integral is an integral. Integrals is approximated by the Riemann sum, and there are many techniques for evaluating them. But right now we are sticking to summations.

Let’s define the expectation, by definition 4.7.

If you have a discrete r.v. \(X\), we say \(X\) is integrable if

\(\sum_{x \in X(\Omega)} |x| \cdot P(X=x) < \infty\)

If you map this to what you learned in calculus, this is **absolute integrability**. You know that if you are absolutely integrable, you are regular integrable. Why absolute value? This \(x\) can take positive or negative values. If this holds, we can define expectation as

\(\mathbb{E}[X] = \sum_{x \in X(\Omega)} x P(X=x)\)

In order to help you understand this from a discrete random variable notation, you can put this in a table format.

\(X = \begin{cases} \text{outcome} & \text{probability} \\ a_1 & p_1 \\ a_2 & p_2 \end{cases}\)

This will be a handy tool when doing calculations.

This summation is purely rigorous.

We need the non-absolute value sum to be less, because the probability cannot be negative. I’m not just saying that the expectation is finite. I’m saying that the expectation is bounded by something finite. \(X < \infty\) is very different from \(X < Y < \infty\). The second one means that the value is bounded away from infinity, where \(Y\) is the ceiling. The first one means you can approach infinity. This is important for mathematical analysis.

Proposition 4.8 says a property of the expectation is that expectation is linear. If you learn functional analysis (calculus on functions), you understand that expectation is a linear operator. The statement is this: \(\mathbb{e}[aX + bY] = aE[X] + bE[Y]\) where \(a\) and \(b\) are constants in \(\mathbb{R}\).

How do we prove this?

We want to first establish that \(\mathbb{E}[aX] = a\mathbb{E}[X]\)

There are two cases. When \(a = 0\), this is trivial because \(X\) becomes 0. How do you prove for \(a \neq 0\)?

We will define \(Z = aX\). From the definition of a discrete random variable, its image set must be a countable subset of \(\mathbb{R}\). Therefore, \(Z\) is a discrete random variable. This implies that \(Z(\Omega)\) is countable. This is important because anything countable can be represented as a sum. \(\pi\) is uncountable and cannot be represented by a summation.

\(\mathbb{E}[|Z|] = \sum_{x \in X(\Omega)} |ax| P(Z=ax)\)

by the simple definition of expectation.

\(= \sum_{x \in X(\Omega)} |ax| P(aX = ax)\)

I’m going to factor out the \(a\), which we can do because we know \(a \neq 0\)

\(= |a| \sum_{x \in X(\Omega)} |x| \cdot P(X=x)\)

Based on our definition 4.7, we can say that this is less than infinity.

Then we can formally write down \(Z\) without absolute value, since it’s bounded finitely.

\(\mathbb{E}[Z] = \sum_{x \in X(\Omega)} ax P(Z=ax) = a\sum_{x \in X(\Omega)} xP(X=x) = a\cdot \mathbb{E}[X]\)

This might seem silly, but we need to be rigorous in math when proving things.

Now we want to prove \(\mathbb{E}[aX + bY] = \mathbb{E}[aX] + \mathbb{E}[aY]\)

The proof is too long, has too much rigor, uses some techniques of interchanging the summation signs.

Second part of proposition is that if \(X \geq 0\), then \(\mathbb{E}[X] \geq 0\). If the random variable is greater than 0, then the expectation is greater than 0. The simple proof is that

\(\mathbb{E}[X] = \sum_{x \in X(\Omega)} x P(X=x) \geq 0\)

If \(X > Y\), then \(\mathbb{E}[X] \geq \mathbb{E}[Y]\), where we can show that the difference is positive

Theorem 4.9 the transfer formula says that for \(X\) discrete r.v., where \(\varphi: \mathbb{R} \rightarrow \mathbb{R}\) is a measurable function, then \(\varphi(X)\) is a r.v. and is integrable iff

\(\sum_{x \in X(\Omega)} |\varphi(x)| P(X=x) < \infty\)

In this case I can formally write down the expectation to be the sum

\(\mathbb{E}[\varphi(X)] = \sum_{x \in X(\Omega)} \varphi(x) P(X=x)\)

#### Examples

Here are some examples:

If we have a discrete r.v.

\(X = \begin{cases} 1 & 0.2 \\ 2 & 0.3 \\ 3 & 0.5 \end{cases}, \mathbb{E}[X] = ?\)

You multiply horizontally and add them all up.

Represented in the cases format,

\(\mathbb{E}[X] = \sum_{i=1}^\infty a_i p_i\)

For a measurable function \(\varphi\),

\(\mathbb{E}[\varphi(X)] = \sum_{i=1}^\infty \varphi(a_i) p_i\)

You only change the outcome, not the probability.

In this example,

\(\mathbb{E}[X] = 1 \times 0.2 + 2 \times 0.3 + 3 \times 0.5 = 2.3\).

What if we take \(\mathbb{E}[X^2]\)?

The square is a measurable function, so we can consider \(\varphi(X) = X^2\)

\(\mathbb{E}[\varphi(X)] = 1^2 \times 0.2 + 2^2 \times 0.3 + 3^2 \times 0.5 = 5.9\)

We can go a little crazier and talk about \(\varphi = \sin{X}\)

In all our examples, all of our functions are measurable. In terms of mathematical analysis, you might be interested in functions that are not measurable. But we don’t have to worry about that in our class.

#### Variance

The variance of a r.v. is defined to be

\(\mathbb{V}(X) = \mathbb{E}\left[(X - \mathbb{E}[X])^2\right]\)

There is an intuitive explanation for this definition. How do you measure the variability if numbers in a set? What you do is take the expected value of the numbers in the set.

Let’s say we have a sequence \((x_1, x_2, \ldots, x_n)\)

\(\mathbb{E}[X] = x_1 \cdot \frac{1}{n} + x_2 \frac{1}{n} + \ldots + x_n \frac{1}{n}\)

We want to measure the distance from each data point to the middle point. The distance of each variable to that middle point is what we are counting. We square them because the difference might be positive or negative, so it makes them all 0.

What happens if we don’t square it?

\(\mathbb{E}[X - \mathbb{E}[X]] = \mathbb{E}[X] - \mathbb{E}[X] = 0\)

If you do some simple arithmetics, you can see the simple binomial expansion as

\((a+b)^2 = a^2 + 2ab + b^2\)

and if we apply this to our variance, we get

\(\mathbb{V}[X] = \mathbb{E}[X^2 - 2X\mathbb{E}[X] + (\mathbb{E}[X])^2]\)

expected value of an expected value is the same thing because it’s just a constant

\(= \mathbb{E}[X^2] - 2\mathbb{E}[X] \mathbb{E}[X] + (\mathbb{E}[X])^2\)

\(= \mathbb{E}[X^2] - (\mathbb{E}[X])^2 \geq 0\)

This is Jensen’s inequality, which shows the convexity of variance.

There are two operations, we take square, then expectation, and for the other, we take expectation first, then square. And this difference must be greater than or equal to 0.

Eventually, everything becomes calculus.

Definition 4.12 is of standard deviation, or std dev.

\(\sigma(X) = \sqrt{\mathbb{V}(X)} = \sqrt{\mathbb{E}[X^2] - (\mathbb{E}[X])^2}\)

This identity is very important:

\(\mathbb{E}[X^2] = \mathbb{V}(X) + (\mathbb{E}[X])^2\)

This is very convenient for our calculations. Let’s think about calculating the variance for the cases format. Assuming this format, we can represent

\(\mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2\)

\(= \sum_{i=1}^\infty a_i^2 p_i - \left(\sum_{i=1}^\infty a_i p_i \right)^2\)

That’s it. This is the formula to use on homework. USEFUL

This has all been theoretical, abstract concepts. From now on we are going to talk about examples of discrete random variables.

We are going to go through several classes of random variables.

#### Discrete Uniform Distribution

The discrete uniform distribution has all the values being the same.

\(X(\Omega) = \{x_1, x_2, \ldots, x_n \}\)
and pmf is given by

\(p_i = P(X=x_i) = \frac{1}{n}, \forall i \in \{1, 2, \ldots, n\}\)

we denote this as

\(X \sim DU(n)\)
If you roll a fair die, the outcome of a die is a discrete uniform distribution. What is our cdf?

\(F(t) = \begin{cases} 0 & \text{if } t < 1 \\ \tfrac{i}{6} & \text{if } i \leq t \leq i + 1, i=1,2,3,4,5 \\ 1 & \text{if } t \geq 6 \end{cases}\)
Let’s look at expected value (in general, not just for fair die)

\(\mathbb{E}[X] = \sum_{i=1}^n i \cdot \frac{1}{n}\)

Let’s make this clear that the image set is \(X(\Omega) = \{1, 2, 3, \ldots, n\}\)

Then we can determine the high school mathematics by taking the variable outside.

\(= \frac{1}{n}(1 + 2 + 3 + \ldots + n)\)

\(= \frac{1}{n} \frac{n(n+1)}{2}\)

\(= \frac{n+1}{2}\)

Now let’s look at the variance.

\(\mathbb{E}[X^2] = \sum_{i=1}^n i^2 \cdot \frac{1}{n} = \frac{1}{n}\sum_{i=1}^n i^2\)

By the same summation property

\(= \frac{1}{n}(1^2 + 2^2 + \ldots + n^2) = \frac{1}{n} \frac{n(n+1)(2n+1)}{6} = \frac{(n+1)(2n+1)}{6}\)

To get the full variance we have

\(\mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2 = \frac{(n+1)(2n+1)}{6} - \frac{(n+1)^2}{4}\)

\(= \frac{2(n+1)(2n+1) - 3(n+1)^2}{12}\)

\(= \frac{1}{12}(4n^2 + 6n + 2 - 3n^2 - 6n - 3)\)

\(= \frac{1}{12}(n^2 - 1)\)

#### Bernoulli Distribution

\(X = \begin{cases} 1 & p \\ 0 & 1 - p \end{cases}\)
We will denote \(X ~ \text{ Bernoulli}(p)\).

The most obvious example is flipping a coin. Our expectation is very simple.

\(\mathbb{p} = \frac{1}{2}\)

\(\mathbb{E}[X] = 1 \times p + 0 \times (1-p) = p\)

For variance, it is

\(\mathbb{E}[X^2] = 1^2 \times p + 0^2 \times (1 - p) = p\)

\(\mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2 = p - p^2 = p(1 - p)\)

#### Binomial Distribution

This can be thought of as the sum of independent Bernoulli random variables. We will consider our pmf as

\(P(X=k) = \begin{cases} {n \choose k} p^k (1-p)^{n-k} & \text{if } k \in \{0,1,2,\ldots,n\} \\ 0 & \text{otherwise} \end{cases}\)

Denote \(X \sim \text{ Binom}(n, p)\)

\({n \choose k}\) is the combinatorial number, selecting \(k\) items out of \(n\) without caring about order

The formula is

\({n \choose k} = \frac{n!}{k!(n-k)!}\)

The factorial is

\(n! = n(n-1)(n-2) \ldots 2 \times 1\)

There is a property of the factorial that

\(\frac{n!}{(n-1)!} = n\)

which comes from the definition of the factorial.

We will consider more generally that

\(\frac{n!}{(n-k)!} = n(n-1)(n-2)\ldots(n-k+1)\)

This fact will become more important.

The binomial expansion formula is that

\((a + b)^n = \sum_{k=0}^n {n \choose k} a^k b^{n-k}\)

We will use this in many places.

The expectation of the binomial distribution

\(\mathbb{E}[X] = np\)

Let’s prove this.

\(\mathbb{E}[X] = \sum_{k=0}^n kP(X=k) = \sum_{k=0}^n k \cdot {n \choose k} p^k (1-p)^{n-k}\)

We will use the technique of factoring out what we want to prove, and then showing that the rest is equal to 1. This is a common and powerful technique. By definition of choose,

\(= \sum_{k=1}^n k\cdot \frac{n!}{k!(n-k)!} p^k (1-p)^{n-k}\)

Now we can factor out \(np\)

\(= np \sum_{k=1}^n k \cdot \frac{(n-1)!}{k!(n-k)!} \cdot p^{k-1} (1-p)^{n-k}\)

We can simplify out that \(k\) and rewrite our \(n - k\) for future rearranging and rewrite our  for future rearranging

\(= np \sum_{k=1}^n  \frac{(n-1)!}{(k-1)!((n-1) - (k-1))!} \cdot p^{k-1} (1-p)^{(n - 1) - (k - 1)}\)

Next technique will be the change of variables in summations. Wherever I see \(k-1\), I will change it to a dummy variable.

\(= np \sum_{k'=0}^{n-1} \frac{(n-1)!}{(k')!(n-1 - k')!} p^{k'} (1-p)^{(n-1) - k'}\)

We’re almost there, now we can rewrite as a choose

\(= np \sum_{k'=0}^{n-1} {n - 1 \choose k'} p^{k'} (1-p)^{(n-1) - k'}\)

We can now use the binomial expansion formula here.

\(= np(p + 1 - p)^{n-1}\)

\(= np\)

For variance we will use a slightly different formulation.

We will consider \(\mathbb{E}[X(X-1)]\), which is equivalent to \(\mathbb{E}[X^2] - \mathbb{E}[X]\), because I want to cancel the factorial in a certain way., which is equivalent to , because I want to cancel the factorial in a certain way.

\(\mathbb{E}[X(X-1)] = \sum_{k=0}^n k(k-1) {n \choose k} p^k (1-p)^{n-k}\)

I can safely start from 2 because of this minus 1 I’m using. Now let’s do some cancellations/substitutions.

\(\sum_{k=2}^n k(k-1) \frac{n!}{k!(n-k)!} p^k (1-p)^{n-k}\)

Now we can divide \(k\) into its factorial.

\(\sum_{k=2}^n \frac{n!}{(k-2)!(n-k)!} p^k (1-p)^{n-k}\)

Let me take out the thing I want to prove, and use the \(n - k\) technique. technique.

\(= n(n-1)p^2 \sum_{k=2}^n \frac{(n-2)!}{(k-2)!((n-2) - (k-2))!} p^{k-2} (1-p)^{(n-2) - (k-2)}\)

Using the \(k'\) technique for \(k - 2\).

\(= n(n-1)p^2 \sum_{k'=0}^{n-2} \frac{(n-2)!}{k'!(n-2 - k')!} p^{k'} (1-p)^{(n-2) - k'}\)

By the binomial expansion formula this is

\(= n(n-1)p^2 (p + 1 - p)^{n-2}\)

\(= n(n-1)p^2\)

Plugging this back into variance, we can show that

\(\mathbb{V}(X) = \mathbb{E}[X(X-1)] + \mathbb{E}[X] - (\mathbb{E}[X])^2\)

\(= n(n-1)p^2 + np - n^2p^2\)

\(= n^2p^2 - np^2 + np - n^2p^2\)

\(= np(1 - p)\)

You have to cancel a few things, use a change of variable, and group the sum into the binomial expansion formula. Those are the main techniques.

Stochastic calculus is less tedious but more conceptually difficult.

We have proposition 4.22: if \(X \in \text{Bin}(n,p)\), \(Y \sim \text{Bin}(m,p)\), and \(X\) and \(Y\) are independent, then their sum is binomial:

\(X+Y \sim \text{Bin}(n+m, p)\)

#### Geometric Distribution

The distribution has no cap, can go to infinity.

\(P(X=k) = (1 - p)^{k-1} \cdot p, k = 1,2,3, \ldots\)

We can verify that this is in fact a probability distribution. We want to prove that

\(\sum_{k=1}^\infty P(X=k) \sum_{k=1}^\infty (1-p)^{k-1} p = p \sum_{k=1}^\infty (1-p)^{k-1}\)

We can expand this summation to

\(= p (1 + (1-p) + (1-p)^2 + \ldots)\)

Based on the geometric formula, we can show that

\(= p \frac{1}{1 - (1 - p)}\)

\(= 1\)

We will show some lemmas here, some results.

The power series is

\(\sum_{n=0}^\infty x^n = \frac{1}{1-x}, \forall 0 < x < 1\)

This is calculus:

\(\sum_{n=1}^\infty n x^{n-1} = \frac{d}{dx} \left( \frac{1}{1-x}\right) = \frac{1}{(1-x)^2}\)

We can also show

\(\sum_{n=2}^\infty n (n-1) x^{n-2} = \frac{0 - 1 \times 2 (1- x)(-1)}{(1-x)^4} = \frac{2}{(1-x)^3}\)

We can start calculating the expected value now, this is from proposition 4.26

\(\mathbb{E}[X] = \sum_{n=0}^\infty P(X>n)\)

\(P(X > n) = \sum_{k=n+1}^\infty P(X=k) = \sum_{k=n+1}^\infty p(1-p)^{k-1} = p(1-p)^n \sum_{k=n+1}^\infty (1-p)^{k-n-1}\)

I want to make this formula into my power series. Let \(k' = k-n-1\). Then\n\n\(P(X>n) = p(1-p)^n \sum_{k'=0}^{\infty}(1-p)^{k'} = p(1-p)^n\frac{1}{1-(1-p)} = (1-p)^n\).

\(P(X>n) = p(1-p)^n \sum_{k'=0}^{\infty}(1-p)^{k'} = p(1-p)^n\frac{1}{1-(1-p)} = (1-p)^n\).

\(p(1-p)^n \frac{1}{1 - (1 - p)}\)

\(= (1 - p)^n\)

Then we have expected value as the infinite sum of this

\(\mathbb{E}[X] = \sum_{n=0}^\infty (1-p)^n = \frac{1}{1- (1 - p)} = \frac{1}{p}\)



For variance, we will use the same intermediate value of \(\mathbb{E}[X(X-1)]\)

\(\mathbb{E}[X(X-1)] = \sum_{k=2}^\infty k(k-1) \cdot p (1 - p)^{k-1}\)

Take out what we want

\(= p (1-p) \sum_{k=2}^\infty k(k-1) (1-p)^{k-2}\)

This follows from our third power series lemma

\(= p(1-p) \frac{2}{p^3}\)

\(= \frac{2(1-p)}{p^2}\)

So for our variance, we get

\(\mathbb{V}[X] = \frac{2(1-p)}{p^2} + \frac{1}{p} - \frac{1}{p^2}\)

\(= \frac{2 - 2p + p - 1}{p^2}\)

\(= \frac{1 - p}{p^2}\)

Poisson will be beginning of next class
