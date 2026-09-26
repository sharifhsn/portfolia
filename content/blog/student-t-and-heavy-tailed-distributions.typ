/*
title = "Student's t and Heavy-Tailed Distributions"
date = 2024-10-28
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Student t', 'Heavy Tails']
*/

==== Student T-distribution
<student-t-distribution>
Definition 5.4.6 says that the pdf is

$f\(x\)= frac(Gamma\(frac(\(n + 1\), 2)\), sqrt(pi n) Gamma\(n / 2\)) (1 + x^2 / n)^(- frac(n + 1, 2))$

then X is a Student t-distribution with degrees of freedom $t_n$.

Proposition 5.48 will tell us all the moments, which are not easy to prove.

$bb(E)\[X\]= 0$ if $n > 1$, and

$bb(V)\[X\]= frac(n, n - 2)$ if $n > 2$

This distribution has a heavier tail than normal, but not as heavy as the next

==== Heavy Tailed Distribution
<heavy-tailed-distribution>
Definition 5.4.9 tells us the Pareto distribution which describes the power law in natural sciences. Income of people follows a heavy tail, there are always people earning a lot of money. Benford law erlates to cryptography, Zipf law relates to economics.

$f\(x\)= frac(a b^a, x^(a + 1)) I_(\[b\,oo\])\(x\)$

I'm only looking at the value above b which is a positive quantity, it's decaying at a power of a + 1. A larger a means lighter tails.

Proposition 5.50 says that if we integrate this, you get 1, so this is a density function.

Proposition 5.51 tells us the moments:

$bb(E)\[X\]= frac(a b, a - 1)$

$bb(V)\[X\]= frac(a b^2, \(a - 1\)^2\(a - 2\))$

There is a link between the Pareto and exponential distribution. This is proposition 5.53.

If you have a exponential distribution

$Z tilde.op "Exp"\(a\)$, then for a $b > 0$, then

$X = b dot.op e^Z$ is a Pareto distribution $P\(a\,b\)$.

Theorem 5.10

==== Log-Normal Distribution
<log-normal-distribution>
Definition 5.54. The Black-Scholes model follows this distribution.

It's called log normal because the log of it is normal

$f\(x\)= frac(1, x sigma sqrt(2 pi)) e^(- frac(\(ln x - mu\)^2, 2 sigma^2)) I_(\(0\,oo\))\(x\)$

then $X tilde.op "LogNormal"\(mu\,sigma^2\)$

We can also describe the cdf of the distribution:

$F_X\(t\)= bb(P)\(X lt.eq t\)= Phi (frac(ln t - mu, sigma))$

where $Phi$ is the cdf of the normal distribution.

Proposition 5.55 will tell us the density proof, will be on final

Proposition 5.56 tells us the moments:

$bb(E)\[X\]= e^(mu + 1 / 2 sigma^2)$

$bb(V)\[X\]=\(e^(sigma^2) - 1\)e^(t mu + sigma^2)$

==== Laplace Distribution
<laplace-distribution>
Definition 5.59

$f\(x\)= theta / 2 e^(- theta\|x\|)$

Something is different is that it's the absolute value of $x$, and this applies to the whole real line.

Proposition 5.60 proves the density is 1

Proposition 5.61 tells us the moments

$bb(E)\[X\]= 0$

the proof:

$bb(E)\[X\]= theta / 2 integral_(- oo)^oo x e^(- theta\|x\|) d x$

Because this is an odd function, we can say that the expectation must be 0.

$bb(V)\[X\]= 1 / theta$

==== Double Exponential Distribution
<double-exponential-distribution>
5.4.10

$f\(x\)= {p alpha_1 e^(- alpha_1 x)\, & x > 0 med\(1 - p\)alpha_2 e^(alpha_2 x)\, & x lt.eq 0$

If x is positive, it's exponential, if it's negative, it follows a different exponential distribution

==== Examples
<examples>
These come from the second textbook G, where homework is.

===== 5.1
<section>
the pdf

$f\(x\)= frac(2, pi\(1 + x^2\)) bb(I)_(\[0\,oo\))\(x\)$

show that it's a density function and that the expected value does not exist

We need to solve for the integral over the range to be 1.

$integral_0^oo frac(2, pi\(1 + x^2\)) d x = 2 / pi integral_0^oo frac(1, 1 + x^2) d x$

And that's just arctan

Then you get one by solving for arctan.

For expectation, the proof is done by u-substitution for x^2 + 1, and then you can show that the expectation is infinite, which means it doesn't exist.

===== 5.2
<section-1>
If $X tilde.op "Unif"\[0\,1\]$, show that $X^2 tilde.op "Beta"\(1 / 2\,1\)$

We will use theorem 5.10 for solving for pdf in order to get $X^2$ from the uniform. We can use $x^2$ as our function because under the interval $\[0\,1\]$ it's monotonic increasing.

We need to find the inverse of our function, and the derivative of our function. That's

$h^(- 1)\(y\)= sqrt(y)$

$h'\(x\)= 2 x$

$frac(1, 2 sqrt(y))$

Now we have to prove that this is the density function for beta.

We can substitute the numbers given to us in the beta formula, and then use the gamma decomposition to give us actual numbers.

===== 5.3
<section-2>
We want to show that $Y = X^2$ has the density function The density function is the derivative of the cdf, so if you want to show the pdf

===== 4.7
<section-3>
cdf of a discrete random variable

$F\(x\)= {0 & x < 0 med x\/4 & 0 lt.eq x < 1 med 1\/2 & 1 lt.eq x < 2 med 1\/12 x + 1\/2 & 2 lt.eq x < 3 med 1 & x gt.eq 3$

How do you compute the probabilities?

$bb(P)\(X < 2\)= 1 / 2$ We can directly compute this easily. What about

$bb(P)\(X = 2\)= bb(P)\(X lt.eq 2\)- bb(P)\(X < 2\)$

This is because it's a cdf and you're getting rid of all that came before which is actually under a different function. Same for

$bb(P)\(1 lt.eq X < 3\)= bb(P)\(X < 3\)- bb(P)\(X < 1\)$

What about the greater than? We can use the complement.

$bb(P)\(x > 3 / 2\)= 1 - bb(P)\(x lt.eq 3 / 2\)$

So if you're doing equal, you get rid of everything up to that point. For a point in an interval this is actually 0 which makes sense because the probability of any individual point is usually 0.

$bb(P)\(x = 5 / 2\)= bb(P)\(x lt.eq t / 2\)- bb(P)\(X < 5 / 2\)= 0$

===== 4.8
<section-4>
If we flip a coin twice, and X is the number of tails, what is the cdf of X?

Let's calculate

$F\(t\)= bb(P)\(X lt.eq t\)= {0 & t < 0 med bb(P)\(x = 0\) & 0 lt.eq t < 1 med bb(P)\(x = 0 union x = 1\) & 1 lt.eq t < 2 med 1 & t gt.eq 2$

===== 4.10
<section-5>
if we consider cdf of X

$F\(t\)= {0 & t < 0 med 1 / 2 t^2 & 0 lt.eq t < 1 med k\(4 t - t^2\) & 1 lt.eq t < 2 med 1 & t gt.eq 2$

In order to consider the independence of two sets

$A = { 1 / 2 lt.eq x lt.eq 3 / 2 }$

$B = { 1 lt.eq x }$

We want the probability of the intersection of those sets to be the same as the product of their probabilities. In this case, they are not, so they are not independent.

===== 5.18
<section-6>
Deck of 52 cards. Draw the cards with replacement until an ace is drawn. Calculate the probability that at least 10 draws are needed to get the first ace.

If you see "until the first" it means, "until the first success event", which means the #strong[geometric distribution].

This is the $X tilde.op G e o\(1 / 13\)$

Then we can get the pmf as

$bb(P)\(X = n\)= (12 / 13)^(n - 1) 1 / 13$ How do you do at least ten draws?

$bb(P)\(X gt.eq 10\)= sum_(n = 10)^oo (12 / 13)^(n - 1) 1 / 13$

$= 1 / 13 sum_(n = 10)^oo$

We will do a change of variable of $k = n - 10$

$= 1 / 13 sum_(k = 0)^oo (12 / 13)^(k + 9)$

$= 1 / 13 (12 / 13)^9 sum_(k = 0)^oo (12 / 13)^k$

VERY IMPORTANT FORMULA FOUND HERE:

$sum_(n = 0)^oo p^n = frac(1, 1 - p)$

We will use this to solve geometric distributions.

Now let's look at continuous time

===== 6.8
<section-7>
Typical example: we are given the density and are asked to solve for the moments.

$f\(x\)= 27 / 490\(e x^2 - 2 x\)\,2 / 3 < x < 3$

$bb(E)\[X\]= integral_(- 2 / 3)^3 x dot.op 27 / 490\(3 x^2 - 2 x\)thin d x$

We can solve this integral which should give us the answer 283/120. Left as exercise to reader.

===== 7.7
<section-8>
Check notes…

===== 6.3
<section-9>
$f\(x\)= 2 / x^2\,1 < x < 2$

Find the distribution and pdf of $Y = X^2$

same as the uniform question.

There are many ways to solve this. Theorem 5.10 is one way to solve it. You can also start from the basic principle of how cumulative distribution works

$G\(t\)= bb(P)\(Y lt.eq t\)= bb(P)\(X^2 lt.eq t\)= bb(P)\(- sqrt(t) lt.eq x lt.eq sqrt(t)\)= bb(P)\(x lt.eq sqrt(t)\)= bb(P)\(x lt.eq sqrt(t)\)- bb(P)\(X lt.eq - sqrt(t)$

The last probability we canceled so we are only concerned with the middle probability,

$bb(P)\(1 lt.eq X lt.eq sqrt(t)\)$

We have to integrate to get this

$= integral_1^(sqrt(t)) 2 / x^2 d x = - 2 / x\|_(x = 1)^(x = sqrt(t)) = - 2 / sqrt(t) + 2$

Then we can find that $G\(t\)$ is substituted this.

Then we can find the density function, which is known to be the derivative of the cdf from earlier:

$g\(t\)= G'\(t\)$

That's it from the examples.
