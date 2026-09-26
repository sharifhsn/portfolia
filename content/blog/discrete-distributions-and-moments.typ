/*
title = 'Discrete Distributions and Moments'
date = 2024-09-23
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Discrete Distributions', 'Moments']
*/

== Week 4
<week-4>
=== Lecture Notes
<lecture-notes>
We will be covering discrete random variables this week.

A discrete random variable is one whose image $X\(Omega\)$ is a finite/countable subset of $bb(R)$.

First thing we introduce is the probability mass function (pmf).

It is basically the probability measure assigned to a single value: $P_X\({ x }\)= P\(X = x\)$

Because of the law of total probability, the probability of all outcomes must sum to 1:

$sum_(x in X\(Omega\)) P\(X = x\)= 1 .$

Next thing is the cumulative distribution function (cdf).

Usually use the capital F to denote this: $F\(t\)= P\(X lt.eq t\)= sum_(x in X\(Omega\)inter x lt.eq t) P\(X = x\)$

A simple example for a discrete random variable is that if you roll a die, the outcome of the die will give you a discrete random variable. If I'm interested in $F\(3\)= P\(X lt.eq 3\)= P\(X = 1\)+ P\(X = 2\)+ P\(X = 3\)$

Another example:

We denote $X$ as the number of times we roll the die until we get the outcome 6. If we're lucky and roll the die once to get a 6, what's the probability? For a fair die it's $1 / 6$. For the second roll, $P\(X = 2\)= 5 / 6 times 1 / 6 = 5 / 36$: the first roll is not 6 and the second roll is 6.

The outcome of the first roll does not affect the second roll.

More difficult one, $P\(X = 3\)$

$P\(X = 3\)= 5 / 6 times 5 / 6 times 1 / 6$

You can prove by induction that the formula is

$P\(X = n\)= (5 / 6)^(n - 1) times 1 / 6\,1 lt.eq n$

This is a simple example.

I want to say a property of the cdf:

If you have $X : Omega arrow.r bb(R)$ is a discrete r.v., the cdf $F\(t\)$ is piecewise constant and has finite/countable jumps.

If you think about cdf, it's a probability that lies from 0 to 1.

The graph of discrete cdf is exclusive coming from the right side, so the hole is on the bottom of the jump, not the top. We accumulate in a discrete ways, which makes it like a staircase. Each piece corresponds to a constant value, and there are finite jumps.

For simplicity, we will denote the following notations:

$X\(Omega\)= { a_1\,a_2\,a_3\,dots.h }$

$p_i = P\(X = a_i\)\,i = 1$

==== Moments
<moments>
Moments are expectations, expectations are kind of like intervals in calculus. Here we are talking about discrete random variables, so our integration is basically a summation. In the next class we are going to talk about continuous, where the integral is an integral. Integrals is approximated by the Riemann sum, and there are many techniques for evaluating them. But right now we are sticking to summations.

Let's define the expectation, by definition 4.7.

If you have a discrete r.v. $X$, we say $X$ is integrable if

$sum_(x in X\(Omega\))\|x\|dot.op P\(X = x\)< oo$

If you map this to what you learned in calculus, this is #strong[absolute integrability]. You know that if you are absolutely integrable, you are regular integrable. Why absolute value? This $x$ can take positive or negative values. If this holds, we can define expectation as

$bb(E)\[X\]= sum_(x in X\(Omega\)) x P\(X = x\)$

In order to help you understand this from a discrete random variable notation, you can put this in a table format.

$X = {upright("outcome") & upright("probability") med a_1 & p_1 med a_2 & p_2$

This will be a handy tool when doing calculations.

This summation is purely rigorous.

We need the non-absolute value sum to be less, because the probability cannot be negative. I'm not just saying that the expectation is finite. I'm saying that the expectation is bounded by something finite. $X < oo$ is very different from $X < Y < oo$. The second one means that the value is bounded away from infinity, where $Y$ is the ceiling. The first one means you can approach infinity. This is important for mathematical analysis.

Proposition 4.8 says a property of the expectation is that expectation is linear. If you learn functional analysis (calculus on functions), you understand that expectation is a linear operator. The statement is this: $bb(e)\[a X + b Y\]= a E\[X\]+ b E\[Y\]$ where $a$ and $b$ are constants in $bb(R)$.

How do we prove this?

We want to first establish that $bb(E)\[a X\]= a bb(E)\[X\]$

There are two cases. When $a = 0$, this is trivial because $X$ becomes 0. How do you prove for $a eq.not 0$?

We will define $Z = a X$. From the definition of a discrete random variable, its image set must be a countable subset of $bb(R)$. Therefore, $Z$ is a discrete random variable. This implies that $Z\(Omega\)$ is countable. This is important because anything countable can be represented as a sum. $pi$ is uncountable and cannot be represented by a summation.

$bb(E)\[\|Z\|\]= sum_(x in X\(Omega\))\|a x\|P\(Z = a x\)$

by the simple definition of expectation.

$= sum_(x in X\(Omega\))\|a x\|P\(a X = a x\)$

I'm going to factor out the $a$, which we can do because we know $a eq.not 0$

$=\|a\|sum_(x in X\(Omega\))\|x\|dot.op P\(X = x\)$

Based on our definition 4.7, we can say that this is less than infinity.

Then we can formally write down $Z$ without absolute value, since it's bounded finitely.

$bb(E)\[Z\]= sum_(x in X\(Omega\)) a x P\(Z = a x\)= a sum_(x in X\(Omega\)) x P\(X = x\)= a dot.op bb(E)\[X\]$

This might seem silly, but we need to be rigorous in math when proving things.

Now we want to prove $bb(E)\[a X + b Y\]= bb(E)\[a X\]+ bb(E)\[a Y\]$

The proof is too long, has too much rigor, uses some techniques of interchanging the summation signs.

Second part of proposition is that if $X gt.eq 0$, then $bb(E)\[X\]gt.eq 0$. If the random variable is greater than 0, then the expectation is greater than 0. The simple proof is that

$bb(E)\[X\]= sum_(x in X\(Omega\)) x P\(X = x\)gt.eq 0$

If $X > Y$, then $bb(E)\[X\]gt.eq bb(E)\[Y\]$, where we can show that the difference is positive

Theorem 4.9 the transfer formula says that for $X$ discrete r.v., where $phi : bb(R) arrow.r bb(R)$ is a measurable function, then $phi\(X\)$ is a r.v. and is integrable iff

$sum_(x in X\(Omega\))\|phi\(x\)\|P\(X = x\)< oo$

In this case I can formally write down the expectation to be the sum

$bb(E)\[phi\(X\)\]= sum_(x in X\(Omega\)) phi\(x\)P\(X = x\)$

==== Examples
<examples>
Here are some examples:

If we have a discrete r.v.

$X = {1 & 0.2 med 2 & 0.3 med 3 & 0.5\,bb(E)\[X\]= ?$

You multiply horizontally and add them all up.

Represented in the cases format,

$bb(E)\[X\]= sum_(i = 1)^oo a_i p_i$

For a measurable function $phi$,

$bb(E)\[phi\(X\)\]= sum_(i = 1)^oo phi\(a_i\)p_i$

You only change the outcome, not the probability.

In this example,

$bb(E)\[X\]= 1 times 0.2 + 2 times 0.3 + 3 times 0.5 = 2.3$.

What if we take $bb(E)\[X^2\]$?

The square is a measurable function, so we can consider $phi\(X\)= X^2$

$bb(E)\[phi\(X\)\]= 1^2 times 0.2 + 2^2 times 0.3 + 3^2 times 0.5 = 5.9$

We can go a little crazier and talk about $phi = sin X$

In all our examples, all of our functions are measurable. In terms of mathematical analysis, you might be interested in functions that are not measurable. But we don't have to worry about that in our class.

==== Variance
<variance>
The variance of a r.v. is defined to be

$bb(V)\(X\)= bb(E) [\( X - bb(E) \[ X \] \)^2]$

There is an intuitive explanation for this definition. How do you measure the variability if numbers in a set? What you do is take the expected value of the numbers in the set.

Let's say we have a sequence $\(x_1\,x_2\,dots.h\,x_n\)$

$bb(E)\[X\]= x_1 dot.op 1 / n + x_2 1 / n + dots.h + x_n 1 / n$

We want to measure the distance from each data point to the middle point. The distance of each variable to that middle point is what we are counting. We square them because the difference might be positive or negative, so it makes them all 0.

What happens if we don't square it?

$bb(E)\[X - bb(E)\[X\]\]= bb(E)\[X\]- bb(E)\[X\]= 0$

If you do some simple arithmetics, you can see the simple binomial expansion as

$\(a + b\)^2= a^2 + 2 a b + b^2$

and if we apply this to our variance, we get

$bb(V)\[X\]= bb(E)\[X^2 - 2 X bb(E)\[X\]+\(bb(E)\[X\]\)^2\]$

expected value of an expected value is the same thing because it's just a constant

$= bb(E)\[X^2\]- 2 bb(E)\[X\]bb(E)\[X\]+\(bb(E)\[X\]\)^2$

$= bb(E)\[X^2\]-\(bb(E)\[X\]\)^2gt.eq 0$

This is Jensen's inequality, which shows the convexity of variance.

There are two operations, we take square, then expectation, and for the other, we take expectation first, then square. And this difference must be greater than or equal to 0.

Eventually, everything becomes calculus.

Definition 4.12 is of standard deviation, or std dev.

$sigma\(X\)= sqrt(bb(V)\(X\)) = sqrt(bb(E)\[X^2\]-\(bb(E)\[X\]\)^2)$

This identity is very important:

$bb(E)\[X^2\]= bb(V)\(X\)+\(bb(E)\[X\]\)^2$

This is very convenient for our calculations. Let's think about calculating the variance for the cases format. Assuming this format, we can represent

$bb(V)\[X\]= bb(E)\[X^2\]-\(bb(E)\[X\]\)^2$

$= sum_(i = 1)^oo a_i^2 p_i - (sum_(i = 1)^oo a_i p_i)^2$

That's it. This is the formula to use on homework. USEFUL

This has all been theoretical, abstract concepts. From now on we are going to talk about examples of discrete random variables.

We are going to go through several classes of random variables.

==== Discrete Uniform Distribution
<discrete-uniform-distribution>
The discrete uniform distribution has all the values being the same.

$X\(Omega\)= { x_1\,x_2\,dots.h\,x_n }$ and pmf is given by

$p_i = P\(X = x_i\)= 1 / n\,forall i in { 1\,2\,dots.h\,n }$

we denote this as

$X tilde.op D U\(n\)$ If you roll a fair die, the outcome of a die is a discrete uniform distribution. What is our cdf?

$F\(t\)= {0 & upright("if ") t < 1 med i / 6 & upright("if ") i lt.eq t lt.eq i + 1\,i = 1\,2\,3\,4\,5 med 1 & upright("if ") t gt.eq 6$ Let's look at expected value (in general, not just for fair die)

$bb(E)\[X\]= sum_(i = 1)^n i dot.op 1 / n$

Let's make this clear that the image set is $X\(Omega\)= { 1\,2\,3\,dots.h\,n }$

Then we can determine the high school mathematics by taking the variable outside.

$= 1 / n\(1 + 2 + 3 + dots.h + n\)$

$= 1 / n frac(n\(n + 1\), 2)$

$= frac(n + 1, 2)$

Now let's look at the variance.

$bb(E)\[X^2\]= sum_(i = 1)^n i^2 dot.op 1 / n = 1 / n sum_(i = 1)^n i^2$

By the same summation property

$= 1 / n\(1^2 + 2^2 + dots.h + n^2\)= 1 / n frac(n\(n + 1\)\(2 n + 1\), 6) = frac(\(n + 1\)\(2 n + 1\), 6)$

To get the full variance we have

$bb(V)\[X\]= bb(E)\[X^2\]-\(bb(E)\[X\]\)^2= frac(\(n + 1\)\(2 n + 1\), 6) - frac(\(n + 1\)^2, 4)$

$= frac(2\(n + 1\)\(2 n + 1\)- 3\(n + 1\)^2, 12)$

$= 1 / 12\(4 n^2 + 6 n + 2 - 3 n^2 - 6 n - 3\)$

$= 1 / 12\(n^2 - 1\)$

==== Bernoulli Distribution
<bernoulli-distribution>
$X = {1 & p med 0 & 1 - p$ We will denote $X med upright(" Bernoulli")\(p\)$.

The most obvious example is flipping a coin. Our expectation is very simple.

$bb(p) = 1 / 2$

$bb(E)\[X\]= 1 times p + 0 times\(1 - p\)= p$

For variance, it is

$bb(E)\[X^2\]= 1^2 times p + 0^2 times\(1 - p\)= p$

$bb(V)\[X\]= bb(E)\[X^2\]-\(bb(E)\[X\]\)^2= p - p^2 = p\(1 - p\)$

==== Binomial Distribution
<binomial-distribution>
This can be thought of as the sum of independent Bernoulli random variables. We will consider our pmf as

$P\(X = k\)= {binom(n, k) p^k\(1 - p\)^(n - k) & upright("if ") k in { 0\,1\,2\,dots.h\,n } med 0 & upright("otherwise")$

Denote $X tilde.op upright(" Binom")\(n\,p\)$

$binom(n, k)$ is the combinatorial number, selecting $k$ items out of $n$ without caring about order

The formula is

$binom(n, k) = frac(n !, k !\(n - k\)!)$

The factorial is

$n ! = n\(n - 1\)\(n - 2\)dots.h 2 times 1$

There is a property of the factorial that

$frac(n !, \(n - 1\)!) = n$

which comes from the definition of the factorial.

We will consider more generally that

$frac(n !, \(n - k\)!) = n\(n - 1\)\(n - 2\)dots.h\(n - k + 1\)$

This fact will become more important.

The binomial expansion formula is that

$\(a + b\)^n= sum_(k = 0)^n binom(n, k) a^k b^(n - k)$

We will use this in many places.

The expectation of the binomial distribution

$bb(E)\[X\]= n p$

Let's prove this.

$bb(E)\[X\]= sum_(k = 0)^n k P\(X = k\)= sum_(k = 0)^n k dot.op binom(n, k) p^k\(1 - p\)^(n - k)$

We will use the technique of factoring out what we want to prove, and then showing that the rest is equal to 1. This is a common and powerful technique. By definition of choose,

$= sum_(k = 1)^n k dot.op frac(n !, k !\(n - k\)!) p^k\(1 - p\)^(n - k)$

Now we can factor out $n p$

$= n p sum_(k = 1)^n k dot.op frac(\(n - 1\)!, k !\(n - k\)!) dot.op p^(k - 1)\(1 - p\)^(n - k)$

We can simplify out that $k$ and rewrite our $n - k$ for future rearranging and rewrite our for future rearranging

$= n p sum_(k = 1)^n frac(\(n - 1\)!, \(k - 1\)!\(\(n - 1\)-\(k - 1\)\)!) dot.op p^(k - 1)\(1 - p\)^(\(n - 1\)-\(k - 1\))$

Next technique will be the change of variables in summations. Wherever I see $k - 1$, I will change it to a dummy variable.

$= n p sum_(k' = 0)^(n - 1) frac(\(n - 1\)!, \(k'\)!\(n - 1 - k'\)!) p^(k')\(1 - p\)^(\(n - 1\)- k')$

We're almost there, now we can rewrite as a choose

$= n p sum_(k' = 0)^(n - 1) binom(n - 1, k') p^(k')\(1 - p\)^(\(n - 1\)- k')$

We can now use the binomial expansion formula here.

$= n p\(p + 1 - p\)^(n - 1)$

$= n p$

For variance we will use a slightly different formulation.

We will consider $bb(E)\[X\(X - 1\)\]$, which is equivalent to $bb(E)\[X^2\]- bb(E)\[X\]$, because I want to cancel the factorial in a certain way., which is equivalent to , because I want to cancel the factorial in a certain way.

$bb(E)\[X\(X - 1\)\]= sum_(k = 0)^n k\(k - 1\)binom(n, k) p^k\(1 - p\)^(n - k)$

I can safely start from 2 because of this minus 1 I'm using. Now let's do some cancellations/substitutions.

$sum_(k = 2)^n k\(k - 1\)frac(n !, k !\(n - k\)!) p^k\(1 - p\)^(n - k)$

Now we can divide $k$ into its factorial.

$sum_(k = 2)^n frac(n !, \(k - 2\)!\(n - k\)!) p^k\(1 - p\)^(n - k)$

Let me take out the thing I want to prove, and use the $n - k$ technique. technique.

$= n\(n - 1\)p^2 sum_(k = 2)^n frac(\(n - 2\)!, \(k - 2\)!\(\(n - 2\)-\(k - 2\)\)!) p^(k - 2)\(1 - p\)^(\(n - 2\)-\(k - 2\))$

Using the $k'$ technique for $k - 2$.

$= n\(n - 1\)p^2 sum_(k' = 0)^(n - 2) frac(\(n - 2\)!, k' !\(n - 2 - k'\)!) p^(k')\(1 - p\)^(\(n - 2\)- k')$

By the binomial expansion formula this is

$= n\(n - 1\)p^2\(p + 1 - p\)^(n - 2)$

$= n\(n - 1\)p^2$

Plugging this back into variance, we can show that

$bb(V)\(X\)= bb(E)\[X\(X - 1\)\]+ bb(E)\[X\]-\(bb(E)\[X\]\)^2$

$= n\(n - 1\)p^2 + n p - n^2 p^2$

$= n^2 p^2 - n p^2 + n p - n^2 p^2$

$= n p\(1 - p\)$

You have to cancel a few things, use a change of variable, and group the sum into the binomial expansion formula. Those are the main techniques.

Stochastic calculus is less tedious but more conceptually difficult.

We have proposition 4.22: if $X in upright("Bin")\(n\,p\)$, $Y tilde.op upright("Bin")\(m\,p\)$, and $X$ and $Y$ are independent, then their sum is binomial:

$X + Y tilde.op upright("Bin")\(n + m\,p\)$

==== Geometric Distribution
<geometric-distribution>
The distribution has no cap, can go to infinity.

$P\(X = k\)=\(1 - p\)^(k - 1)dot.op p\,k = 1\,2\,3\,dots.h$

We can verify that this is in fact a probability distribution. We want to prove that

$sum_(k = 1)^oo P\(X = k\)sum_(k = 1)^oo\(1 - p\)^(k - 1)p = p sum_(k = 1)^oo\(1 - p\)^(k - 1)$

We can expand this summation to

$= p\(1 +\(1 - p\)+\(1 - p\)^2+ dots.h\)$

Based on the geometric formula, we can show that

$= p frac(1, 1 -\(1 - p\))$

$= 1$

We will show some lemmas here, some results.

The power series is

$sum_(n = 0)^oo x^n = frac(1, 1 - x)\,forall 0 < x < 1$

This is calculus:

$sum_(n = 1)^oo n x^(n - 1) = frac(d, d x) (frac(1, 1 - x)) = frac(1, \(1 - x\)^2)$

We can also show

$sum_(n = 2)^oo n\(n - 1\)x^(n - 2) = frac(0 - 1 times 2\(1 - x\)\(- 1\), \(1 - x\)^4) = frac(2, \(1 - x\)^3)$

We can start calculating the expected value now, this is from proposition 4.26

$bb(E)\[X\]= sum_(n = 0)^oo P\(X > n\)$

$P(X > n) = sum_(k = n + 1)^oo P(X = k) = sum_(k = n + 1)^oo p (1 - p)^(k - 1) = p (1 - p)^n times sum_(k = n + 1)^oo (1 - p)^(k - n - 1)$

I want to make this formula into my power series. Let $k' = k - n - 1$. Then $P(X > n) = p (1 - p)^n times sum_(k' = 0)^oo (1 - p)^(k') = p (1 - p)^n times frac(1, 1 - (1 - p)) = (1 - p)^n$.

$P(X > n) = p (1 - p)^n times sum_(k' = 0)^oo (1 - p)^(k') = p (1 - p)^n times frac(1, 1 - (1 - p)) = (1 - p)^n$.

$p (1 - p)^n times frac(1, 1 - (1 - p))$

$= (1 - p)^n$

Then we have expected value as the infinite sum of this

$bb(E)\[X\]= sum_(n = 0)^oo\(1 - p\)^n= frac(1, 1 -\(1 - p\)) = 1 / p$

For variance, we will use the same intermediate value of $bb(E)\[X\(X - 1\)\]$

$bb(E)\[X\(X - 1\)\]= sum_(k = 2)^oo k\(k - 1\)dot.op p\(1 - p\)^(k - 1)$

Take out what we want

$= p\(1 - p\)sum_(k = 2)^oo k\(k - 1\)\(1 - p\)^(k - 2)$

This follows from our third power series lemma

$= p\(1 - p\)2 / p^3$

$= frac(2\(1 - p\), p^2)$

So for our variance, we get

$bb(V)\[X\]= frac(2\(1 - p\), p^2) + 1 / p - 1 / p^2$

$= frac(2 - 2 p + p - 1, p^2)$

$= frac(1 - p, p^2)$

Poisson will be beginning of next class
