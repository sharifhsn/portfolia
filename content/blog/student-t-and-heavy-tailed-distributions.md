+++
title = "Student's t and Heavy-Tailed Distributions"
date = 2024-10-28
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Student t', 'Heavy Tails']
+++

#### Student T-distribution

Definition 5.4.6 says that the pdf is

\(f(x) = \frac{\Gamma(\tfrac{(n+1)}{2})}{\sqrt{\pi n} \Gamma(\tfrac{n}{2})} \left(1 + \frac{x^2}{n}\right)^{-\tfrac{n+1}{2}}\)

then X is a Student t-distribution with degrees of freedom \(t_n\).

Proposition 5.48 will tell us all the moments, which are not easy to prove.

\(\mathbb{E}[X] = 0\) if n \> 1, and

\(\mathbb{V}[X] = \frac{n}{n-2}\) if n \> 2

This distribution has a heavier tail than normal, but not as heavy as the next

#### Heavy Tailed Distribution

Definition 5.4.9 tells us the Pareto distribution which describes the power law in natural sciences. Income of people follows a heavy tail, there are always people earning a lot of money. Benford law erlates to cryptography, Zipf law relates to economics.

\(f(x) = \frac{ab^a}{x^{a+1}}I_{[b, \infty]}(x)\)

I’m only looking at the value above b which is a positive quantity, it’s decaying at a power of a + 1. A larger a means lighter tails.

Proposition 5.50 says that if we integrate this, you get 1, so this is a density function.

Proposition 5.51 tells us the moments:

\(\mathbb{E}[X] = \frac{ab}{a-1}\)

\(\mathbb{V}[X] = \frac{ab^2}{(a-1)^2(a-2)}\)

There is a link between the Pareto and exponential distribution. This is proposition 5.53.

If you have a exponential distribution

\(Z \sim Exp(a)\), then for a \(b > 0\), then

\(X = b \cdot e^Z\) is a Pareto distribution \(P(a, b)\).

Theorem 5.10

#### Log-Normal Distribution

Definition 5.54. The Black-Scholes model follows this distribution.

It’s called log normal because the log of it is normal

\(f(x) = \frac{1}{x\sigma \sqrt{2\pi}} e^{-\frac{(\ln x - \mu)^2}{2\sigma^2}}I_{(0, \infty)} (x)\)

then \(X \sim Log N(\mu, \sigma^2)\)

We can also describe the cdf of the distribution:

\(F_X(t) = \mathbb{P}(X \leq t) =  \Phi\left(\frac{\ln t - \mu}{\sigma}\right)\)

where \(\Phi\) is the cdf of the normal distribution.

Proposition 5.55 will tell us the density proof, will be on final

Proposition 5.56 tells us the moments:

\(\mathbb{E}[X] = e^{\mu + \tfrac{1}{2}\sigma^2}\)

\(\mathbb{V}[X] = (e^{\sigma^2} - 1)e^{t\mu + \sigma^2}\)

#### Laplace Distribution

Definition 5.59

\(f(x) = \frac{\theta}{2} e^{-\theta |x|}\)

Something is different is that it’s the absolute value of \(x\), and this applies to the whole real line.

Proposition 5.60 proves the density is 1

Proposition 5.61 tells us the moments

\(\mathbb{E}[X] = 0\)

the proof:

\(\mathbb{E}[X] = \frac{\theta}{2} \int_{-\infty}^\infty xe^{-\theta |x|}dx\)

Because this is an odd function, we can say that the expectation must be 0.

\(\mathbb{V}[X] = \frac{1}{\theta}\)

#### Double Exponential Distribution

5.4.10

\(f(x) = \begin{cases} p\alpha_1 e^{-\alpha_1 x}, & x > 0 \\ (1-p)\alpha_2 e^{\alpha_2 x}, & x \leq 0 \end{cases}\)

If x is positive, it’s exponential, if it’s negative, it follows a different exponential distribution

#### Examples

These come from the second textbook G, where homework is.

##### 5.1

the pdf

\(f(x) = \frac{2}{\pi(1+x^2)} \mathbb{I}_{[0, \infty)} (x)\)

show that it’s a density function and that the expected value does not exist

We need to solve for the integral over the range to be 1.

\(\int_0^\infty \frac{2}{\pi(1+x^2)} dx = \frac{2}{\pi} \int_0^\infty \frac{1}{1+x^2}dx\)

And that’s just arctan

Then you get one by solving for arctan.

For expectation, the proof is done by u-substitution for x^2 + 1, and then you can show that the expectation is infinite, which means it doesn’t exist.

##### 5.2

If \(X \sim Uni[0, 1]\), show that \(X^2 \sim Beta(\tfrac{1}{2}, 1)\)

We will use theorem 5.10 for solving for pdf in order to get \(X^2\) from the uniform. We can use x^2 as our function because under the interval \[0, 1\] it’s monotonic increasing.

We need to find the inverse of our function, and the derivative of our function. That’s

\(h^{-1}(y) = \sqrt{y}\)

\(h'(x) = 2x\)

\(\frac{1}{2\sqrt{y}}\)

Now we have to prove that this is the density function for beta.

We can substitute the numbers given to us in the beta formula, and then use the gamma decomposition to give us actual numbers.

##### 5.3

We want to show that \(Y=X^2\) has the density function
The density function is the derivative of the cdf, so if you want to show the pdf

##### 4.7

cdf of a discrete random variable

\(F(x) = \begin{cases} 0 & x < 0 \\ x/4 & 0 \leq x < 1 \\ 1/2 & 1 \leq x < 2 \\ 1/12 x + 1/2 & 2 \leq x < 3 \\ 1 & x \geq 3 \end{cases}\)

How do you compute the probabilities?

\(\mathbb{P}(X < 2) = \tfrac{1}{2}\)
We can directly compute this easily. What about

\(\mathbb{P}(X = 2) = \mathbb{P}(X \leq 2) - \mathbb{P}(X < 2)\)

This is because it’s a cdf and you’re getting rid of all that came before which is actually under a different function. Same for

\(\mathbb{P}(1 \leq X < 3) = \mathbb{P}(X < 3) - \mathbb{P}(X < 1)\)

What about the greater than? We can use the complement.

\(\mathbb{P}(x > \tfrac{3}{2}) = 1 - \mathbb{P}(x \leq \tfrac{3}{2})\)

So if you’re doing equal, you get rid of everything up to that point. For a point in an interval this is actually 0 which makes sense because the probability of any individual point is usually 0.

\(\mathbb{P}(x= \tfrac{5}{2}) = \mathbb{P}(x \leq \tfrac{t}{2}) - \mathbb{P}(X < \tfrac{5}{2}) = 0\)

##### 4.8

If we flip a coin twice, and X is the number of tails, what is the cdf of X?

Let’s calculate

\(F(t) = \mathbb{P}(X \leq t) = \begin{cases} 0 & t < 0 \\ \mathbb{P}(x = 0) & 0 \leq t < 1 \\ \mathbb{P}(x=0 \cup x=1) & 1 \leq t < 2 \\ 1 & t \geq 2 \end{cases}\)

##### 4.10

if we consider cdf of X



\(F(t) = \begin{cases} 0 & t < 0 \\ \tfrac{1}{2}t^2 & 0 \leq t < 1 \\ k(4t - t^2) & 1 \leq t < 2 \\ 1 & t \geq 2 \end{cases}\)

In order to consider the independence of two sets

\(A = \{\tfrac{1}{2} \leq x \leq \tfrac{3}{2}\}\)

\(B = \{ 1 \leq x\}\)

We want the probability of the intersection of those sets to be the same as the product of their probabilities. In this case, they are not, so they are not independent.

##### 5.18

Deck of 52 cards. Draw the cards with replacement until an ace is drawn. Calculate the probability that at least 10 draws are needed to get the first ace.

If you see “until the first” it means, “until the first success event”, which means the **geometric distribution**.

This is the \(X \sim Geo(\tfrac{1}{13})\)

Then we can get the pmf as

\(\mathbb{P}(X=n) = \left(\frac{12}{13}\right)^{n-1} \frac{1}{13}\)
How do you do at least ten draws?

\(\mathbb{P}(X \geq 10) = \sum_{n=10}^\infty \left(\frac{12}{13}\right)^{n-1} \frac{1}{13}\)

\(= \frac{1}{13} \sum_{n=10}^\infty\)

We will do a change of variable of \(k = n - 10\)

\(= \frac{1}{13} \sum_{k=0}^\infty \left(\frac{12}{13}\right)^{k+9}\)

\(= \frac{1}{13}\left(\frac{12}{13}\right)^9 \sum_{k=0}^\infty \left(\frac{12}{13}\right)^k\)

VERY IMPORTANT FORMULA FOUND HERE:

\(\sum_{n=0}^\infty p^n = \frac{1}{1-p}\)

We will use this to solve geometric distributions.



Now let’s look at continuous time

##### 6.8

Typical example: we are given the density and are asked to solve for the moments.

\(f(x) = \frac{27}{490} (ex^2 - 2x), \frac{2}{3} < x < 3\)

\(\mathbb{E}[X] = \int_{-\tfrac{2}{3}}^\3 x \cdot \frac{27}{490} (3x^2 - 2x) dx\)

We can solve this integral which should give us the answer 283/120. Left as exercise to reader.

##### 7.7

Check notes…

##### 6.3

\(f(x) = \frac{2}{x^2}, 1 < x< 2\)

Find the distribution and pdf of \(Y = X^2\)

same as the uniform question.

There are many ways to solve this. Theorem 5.10 is one way to solve it. You can also start from the basic principle of how cumulative distribution works

\(G(t) = \mathbb{P}(Y \leq t) = \mathbb{P}(X^2 \leq t) = \mathbb{P}(-\sqrt{t} \leq x \leq \sqrt{t}) = \mathbb{P}(x \leq \sqrt{t}) = \mathbb{P}(x \leq \sqrt{t}) - \mathbb{P}(X \leq - \sqrt{t}\)

The last probability we canceled so we are only concerned with the middle probability,

\(\mathbb{P}(1 \leq X \leq \sqrt{t})\)

We have to integrate to get this

\(= \int_1^{\sqrt{t}} \frac{2}{x^2} dx =\left. -\frac{2}{x} \right|^{x=\sqrt{t}}_{x=1} = -\frac{2}{\sqrt{t}} + 2\)

Then we can find that \(G(t)\) is substituted this.

Then we can find the density function, which is known to be the derivative of the cdf from earlier:

\(g(t) = G'(t)\)



That’s it from the examples.
