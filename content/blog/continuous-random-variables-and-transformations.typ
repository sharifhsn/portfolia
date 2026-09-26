/*
title = 'Continuous Random Variables and Transformations'
date = 2024-10-14
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Continuous Distributions', 'Change of Variables']
*/

=== Lecture Notes
<lecture-notes>
Recall for a discrete random variable. The moment formula is

$bb(E)\[X\]= sum_(x in X\(Omega\)) x bb(P)\(X = x\)$

The moment for a continuous rv is the integral

$bb(E)\[X\]= integral_(- oo)^oo x f\(x\)d x$

All the possibilities are the real line here.

Most of today's class will deal with integrals. We are going to calculate a lot of these, just like a single variable calculus class. We will also learn multivariable calculus for multiple variables.

Generalization of expectation for any function is definition 5.9 (skip technical assumptions)

$bb(E)\[h\(X\)\]= integral_(- oo)^oo h\(x\)f\(x\)d x$

You would just compute the antiderivative of $h\(x\)$ and then evaluate the integral by subtracting the top from bottom. For an indicator variable, it is 0 to 1 not -infinity to infinity.

Now I want to go further, I want to know the full distribution, not just the expectation, of $h\(X\)$

This is given by theorem 5.10 which tells us how to determine the probability density function. The PDF of $Y = h\(X\)$ is given by

$f_Y\(y\)= frac(1, h'\(h^(- 1)\(y\)\)) f\(h^(- 1)\)\(y\)I_({ y in h\(D\)})$

Here, $f\(h^(- 1)\)$ denotes the composition of f on inverse h. First I apply the inverse h, then I apply the f.~Sometimes you use the notation $f compose h^(- 1)$

How do you prove this? We will sketch. We will make the assumption that $h$ is non-decreasing.

$bb(P)\(Y lt.eq y\)= bb(P)\(h\(X\)lt.eq y\)= bb(P)\(X lt.eq h^(- 1)\(y\)\)$

We can do the inverse because it's non-decreasing.

This is true, so we can write this probability as the integral of the PDF of X

$= integral_(- oo)^(h^(- 1)\(y\)) f\(x\)d x$

If I want to say the PDF of the random variable $Y$, then it gets the $Y$ subscript; without the subscript, it's for $X$.

Now we will do a change of variables

$x = h^(- 1)\(z\)$

We know that $x$ is inside the integral, so we will write the equivalence that when it is in between those two values, it is equivalent to the event that $z$ is in between $- oo$ and $y$.

This is important because we will change the integration range:

$= integral_(- oo)^y f\(h^(- 1)\(z\)\)d h^(- 1)\(z\)$

You can move this part to the front

$= integral_(- oo)^y f\(h^(- 1)\(z\)\)dot.op\|\(h^(- 1)\)'\(z\)\|d z$

We will see that

$f_Y\(y\)= frac(d, d y) bb(P)\(Y lt.eq y\)$

Now if we take the derivative of this integral, then we get

$frac(d, d y) integral_(- oo)^y f\(h^(- 1)\(z\)\)\|\(h^(- 1)\)'\(z\)\|d z$

We get something like the fundamental theorem of calculus here, or part of it, or Leibniz rule. you have the following result: $frac(d, d x) (integral_(- oo)^x f \( u \) d u) = f\(x\)$

This identity is learned in calculus.

So, we can show that everything inside doesn't depend on $y$, so we can just evaluate the integral with it.

$= f\(h^(- 1)\(y\)\)\|\(h^(- 1)\)'\(y\)\|$

Then we will use this result, from a second theorem of calculus called the implicit function theorem. This is more real analysis, here's a simple example.

$h^(- 1)\(h\(y\)\)= y$

Now the idea is we want to do differentiation on both sides.

$frac(d, d y)\(h^(- 1)\(h\(y\)\)= frac(d, d y)\(y\)$

Because we have this equality, the derivative preserves the equality (maybe not integration because of range). Applying the chain rule, we get

$\(h^(- 1)\)'\(h\(y\)\)= frac(1, h'\(y\))$

And then we do a change of variable.

$y = h^(- 1)\(u\)$

y is just a dummy variable, so we can apply this here, to finally show that

$= f\(h^(- 1)\(y\)\)lr(|frac(1, h'\(h^(- 1)\(y\)\))|)$ Interesting corollary 5.11 that if X has pdf f and we have a Y which is aX + b, then pdf of Y is

$f_Y\(y\)= frac(1, \|a\|) f (frac(y - b, a))$

This is a special case when the $h\(x\)$ is $a X + b$, can be shown by differentiation. All you need to find is $h'\(x\)$ and $h^(- 1)\(y\)$

We can essentially think of $Y$ as a linear combination of a different random variable whose pdf is known, and then we can derive the pdf from the existing pdf f.

==== 5.4.1
<section>
We are concerned with a uniform random variable defined continuously on $\[a\,b\]$ on $bb(R)$

Definition 5.13 says that the pdf of this is

$f\(x\)= frac(1, b - a)\,x in\[a\,b\]$

We will use the notation to indicate uniform distribution

$x tilde.op U\[a\,b\]$

Let's do something non-trivial. Proposition 5.15 says that if we have $X tilde.op U\[a\,b\]$, then

$bb(E)\[X\]= frac(a + b, 2)$

$bb(V)\[X\]= frac(\(b - a\)^2, 12)$

How do we prove? We can create the integral based on the definition

We have from algebra that

$b^3 - a^3 =\(b - a\)\(a^2 + a b + b^2\)$

which we can use to prove the variance.

We are generally solving for

$frac(1, b - a) integral_a^b f\(x\)d x$

and that's how we solve for expectation, for $f\(x\)$ being $x$ or $x^2$

We have to turn these types of problems into a pdf, that will be done on the midterm.

What is the cdf for a uniform variable?

By proposition 5.16, it's

$F_X\(t\)= {0 & upright("if ") t < a med frac(t - a, b - a) & upright("if ") t in\[a\,b\]med 1 & upright("if ") t > b$

This is the same as $bb(P)\(X lt.eq t\)$

We can accomplish this case conclusion by the integral

$= integral_a^t frac(1, b - a) I_(\[a\,b\])\(u\)d u$ Very simple proof for this.

Now let's consider a simple example 5.8 where $X tilde.op U\[0\,1\]$, we will compute $bb(P) (1 / 4 lt.eq x lt.eq 3 / 4)$

To solve, this we will solve as an integral

$= integral_(1 / 4)^(3 / 4) f\(x\)d x = integral_(1 / 4)^(3 / 4) 1 d x = 1 / 2$

This is one way to solve this, or you could separate it into cdf up to ¾ and ¼.

==== 5.4.2
<section-1>
The next thing is the exponential distribution, definition 5.17. We introduce the auxiliary parameter $lambda > 0$, then

$f\(x\)= lambda e^(- lambda x)\,med x > 0\,med X tilde.op "Exp"\(lambda\)$

That is what is meant when we are given a distribution. How do we verify that this result is a pdf? Proposition 5.18 says

$integral_(- oo)^oo f\(x\)d x$

The range of integration starts from 0

$= lambda integral_0^oo e^(- lambda x) d x$

Now we can do some calculus

$frac(d, d x) e^(- lambda x) = e^(- lambda x)\(- lambda\)$

$e^(- lambda x) = frac(frac(d, d x) e^(- lambda x), - lambda)$

$e^(- lambda x) d x = d (frac(e^(- lambda x), - lambda))$

Now we can do integration by parts, which is a very important technique for this chapter that we will do over and over again.

If we are interested in integrating

$lambda f\(x\)d g\(x\)= f\(x\)dot.op g\(x\)- lambda g\(x\)- integral g\(x\)d f\(x\)$

And this is the process of integration by parts.

\(We don't actually need integration by parts here, but we will need to do it for the moments)

Now we will show the moments by proposition 5.19

$bb(E)\[X\]= 1 / lambda$

$bb(V)\[X\]= 1 / lambda^2$

We will now try to evaluate this integral

$= lambda integral_0^oo x e^(- lambda x) d x$

And this is where we need integration by parts

$= lambda integral_0^oo x d frac(e^(- lambda x), - lambda)$ First we take the product

$= lambda (x frac(e^(- lambda x), - lambda)\|_(x = 0)^(x = oo) - integral_0^oo frac(e^(- lambda x), - lambda) d x)$

Variance is not easy because you need to integrate twice by parts.

$bb(E)\[X^2\]= integral_0^oo x^2 lambda e^(- lambda x) d x = lambda integral_0^oo x^2 e^(- lambda x) d x = lambda integral_0^oo x^2 d (frac(e^(- lambda x), - lambda))$

We will try now to get rid of that denominator to get

$= - integral_0^oo x^2 d e^(- lambda x)$

Integration by parts:

$- x^2 e^(- lambda x)\|_(x = 0)^(x = oo) - integral_0^oo e^(- lambda x) d x^2$

$= - (0 - integral_0^oo e^(- lambda x) 2 x d x)$

$= 2 integral_0^oo e^(- lambda x) x d x$

And we already have shown this result so it is

$= 2 / lambda^2$

And then after subtracting by the expectation squared you get

$bb(V)\[X\]= 1 / lambda^2$

What is the cdf of the exponential random variable? Proposition 5.20 will tell us that

$F_X\(x\)= 1 - e^(- lambda x)$

Here is the proof, which is just calculation

$F_X\(x\)= integral_0^x f\(u\)d u = integral_0^x lambda e^(- lambda u) d u$

The difference between a CDF and a statistical measure is that we're measuring up to (x), not infinity, but the technique is the same.

$= lambda integral_0^x d (frac(e^(- lambda u), - lambda)) = lambda frac(e^(- lambda u), - lambda)\|_(u = 0)^(u = x)$

There is a memoryless property of the exponential distribution.

$bb(P)\(X > t + s\|X > t\)= bb(P)\(X > s\)\,s\,t gt.eq 0$

I know that my exponential variable is bigger than t. There is some interval between t and t + s which is length s. I know my random variable $X$ is bigger than t + s, given that it is bigger than t. But actually it doesn't really matter what the probability is between t and t + s, there is no memory of the starting point. You only care about the probability after s. (We will not prove this)

Let's take example 5.9, it will be easy to prove the cdf

$f_X\(t\)= 1 / 100 e^(- t / 100)\,lambda = 1 / 100$

Then we get expectation by the formula $1 / lambda$ How do we solve if we are given probability between an interval like

$bb(P)\(0 lt.eq X lt.eq 50\)$

We take the integral between these two points.

$= integral_0^50 1 / 100 e^(- t / 100) d t$

And we can actually do a change of variable here from

$s = t / 100$

Which will give us

$= integral_0^(1 / 2) e^(- s) d s = frac(e^(- s), - 1)\|_(s = 0)^(s = 1 / 2) = frac(e^(- 1 / 2) - 1, - 1) = 1 - e^(- 1 / 2)$

==== 5.4.3
<section-2>
The normal distribution by definition 5.22 has the distribution function

$f\(x\)= 1 / sqrt(2 pi sigma^2) e^(- frac(\(x - mu\)^2, 2 sigma^2))\,x in bb(R)$

denoted by

$X tilde.op N\(mu\,sigma^2\)$ We have to show that the normal distribution is a PDF, which is not very straightforward.

Proposition 5.24

Proposition 5.25 tells us that the expected value and variance are

$bb(E)\[X\]= mu$

$bb(V)\[X\]= sigma^2$

which is very convenient for us. But we will need to formally verify this

We will copy this pdf into the integral

$bb(E)\[X\]= 1 / sqrt(2 pi sigma^2) integral_(- oo)^oo x e^(- frac(\(x - mu\)^2, 2 sigma^2)) d x$

And we are going to do a change of variable

$y = x - mu$

We have the same integration region because they are infinite. We can replace x in this whole function.

$= 1 / sqrt(2 pi sigma^2) integral_(- oo)^oo\(y + mu\)e^(- frac(y^2, 2 sigma^2)) d y$

We will separate the integral into two parts

$= 1 / sqrt(2 pi sigma^2) integral_(- oo)^oo y e^(- frac(y^2, 2 sigma^2)) d y + mu integral_(- oo)^oo e^(- frac(y^2, 2 sigma^2)) d y$

The first integrand is an odd function. This means that $f\(x\)= - f\(- x\)$. Even functions are $f\(x\)= f\(- x\)$. For any integral from -infinity to infinity, we can combine all the negatives and all the positives. And if it is symmetric around 0 with the opposite, which is the meaning of odd, then when they're added it should give you 0.

Then we can recognize that for the second integrand that it must be equal to $mu$ by the fact that the normal distribution area is equal to 1 (assumed).

Now for the variance. By definition, because we know the expectation already, we get

$bb(V)\[X\]= bb(E) [\( X - mu \)^2]$

which by the pdf is

$= 1 / sqrt(2 pi sigma^2) integral_(- oo)^oo\(x - mu\)^2e^(- frac(\(x - mu\)^2, 2 sigma^2)) d x$

Then we can do a change of variable, and then solve via polar coordinates on page 138

$= 1 / sqrt(2 pi sigma^2) integral_(- oo)^oo y^2 e^(- frac(y^2, 2 sigma^2)) d y$

Remark 5.2.7 says that if $X tilde.op N\(0\,1\)$, then $mu + sigma X tilde.op N\(mu\,sigma^2\)$

The inverse operation

$Y tilde.op N\(mu\,sigma^2\)\,frac(Y - mu, sigma) tilde.op N\(0\,1\)$

is known as #strong[standardization].

Proof: if you let

$Y = mu + sigma X = h\(X\)$

Using the corollary 5.11 for linear combination we can prove this.

Useful property of normal distribution. If we have two normal distributions $X$ and $Y$ that are independent, then

$X + Y tilde.op N\(mu_1 + mu_2\,sigma_1^2 + sigma_2^2\)$ We have to do a convolution to solve this, involves integration between the two things.

==== 5.4.14
<section-3>
Last one for today is the gamma distribution.

We need some preparation, in the gamma function.

$Gamma\(x\)= integral_0^oo t^(x - 1) e^(- t) d t$

Proposition 5.30 says the properties of the gamma function. We have the property (a) that

$Gamma\(x + 1\)= x Gamma\(x\)\,x > 0$

and (b) that

$Gamma\(n + 1\)= n !$

and (c), which the source note does not prove,

$Gamma (1 / 2) = sqrt(pi)$

Proof of (a) is that

$= integral_0^oo t^X e^(- t) d t = integral_0^oo t^X (d frac(e^(- t), - 1))$

$t^x frac(e^(- t), - 1)\|_(t = 0)^(t = oo) - integral_0^oo frac(e^(- t), - 1) thin d\(t^x\)$

We can separately calculate $d t^X = x t^(x - 1) d t$ by the power rules.

$= integral_0^oo e^(- t) x t^(x - 1) d t$

$x integral_0^oo t^(x - 1) e^(- t) d t = x Gamma\(x\)$

The technique is to do the integration by parts and factor out certain quantities.

If we want to find out (b), then we can do induction once we find $Gamma\(2\)$

$Gamma\(2\)= integral_0^oo t e^(- t) d t = integral_0^oo t d frac(e^(- t), - 1) = t dot.op frac(e^(- t), - 1)\|_(t = 0)^(t = oo) - integral frac(e^(- t), - 1) d t$

$= integral_0^oo e^(- t) d t$

What about the pdf? Given by definition 5.31

$f_(a\,lambda)\(x\)= frac(lambda^a, Gamma\(a\)) e^(- lambda x) x^(a - 1)$

$X tilde.op Gamma\(a\,lambda\)$

It has a lot of weird special cases.

Proposition 5.32 shows that this is a true density function. We will do integration from 0 to the infinity of this density

$integral_0^oo frac(lambda^a, Gamma\(a\)) e^(- lambda x) x^(a - 1) d x$

$= frac(lambda^a, Gamma\(a\)) integral_0^oo (1 / lambda y)^(a - 1) dot.op e^(- y) 1 / lambda d y$

$= frac(lambda^a, Gamma\(a\)) integral_0^oo 1 / lambda^(a - 1) dot.op 1 / lambda dot.op e^(- y) 1 / lambda d y$

After we cancel out the $lambda$

$= frac(1, Gamma\(a\)) integral_0^oo y^(a - 1) e^(- y) d y$

which is just the definition of gamma

$= frac(Gamma\(a\), Gamma\(a\)) = 1$

Proposition 5.33 says for E and V that

$bb(E)\[X\]= a / lambda$

$bb(V)\[X\]= a / lambda^2$

We know from the definition of expectation and combining similar terms that

$bb(E)\[X\]= integral_0^oo x dot.op frac(lambda^a, Gamma\(a\)) x^(a - 1) e^(- lambda x) d x = frac(lambda^a, Gamma\(a\)) integral_0^oo x^a e^(- lambda x) d x$

Let's do a change of variable to $y = lambda x$ $= frac(lambda^a, Gamma\(a\)) dot.op integral_0^oo (y / lambda)^a dot.op e^(- y) dot.op 1 / lambda d y$

Taking this out, I get

$frac(lambda^a, Gamma\(a\)) dot.op 1 / lambda^a 1 / lambda integral_0^oo y^a e^(- y) d y$

Here we can use the result from before of the definition of gamma to substitute the integral.

$= a / lambda$

$= a / lambda$

To get variance, we have

$bb(E)\[X^2\]= frac(lambda^a, Gamma\(a\)) dot.op integral_0^oo x^(a + 1) e^(- lambda x) d x$

Change of variable…

$= frac(lambda^a, Gamma\(a\)) dot.op integral_0^oo (y / lambda)^(a + 1) e^y d y$

$= frac(a\(a + 1\), lambda^2)$

$bb(V)\[X\]= a / lambda^2$

I can sequentially use the value of a to get this result.

Finally, proposition 5.35 shows us that for $X tilde.op N\(0\,1\)$, then $X^2 tilde.op Gamma\(1 / 2\,1 / 2\)$

Our proof is that

$F_(X^2)\(t\)= bb(P)\(X^2 lt.eq t\)= bb(P)\(- sqrt(t) lt.eq X lt.eq sqrt(t)\)$

$= bb(P)\(X lt.eq sqrt(t)\)- bb(P)\(X lt.eq - sqrt(t)\)$

x is a normal density, so we can write this as

\

now we're going to differentiate on both sides

$f_(X^2)\(t\)= frac(d, d t) F_(X^2)\(t\)$. The source note starts the derivative calculation here; the remaining algebra is not recorded.

These two minus signs cancel out and you get both

And the two will cancel out and you can put this downstairs

Then you can rewrite this exactly as $Gamma\(1 / 2\,1 / 2\)$

$f_(1 / 2\,1 / 2)\(x\)= frac(\(1 / 2\)^(1 / 2), Gamma\(1 / 2\)) dot.op e^(- 1 / 2 x) x^(- 1 / 2)$

And then we can know from our definition that

$frac(1, sqrt(2) thin Gamma\(1 / 2\)) = 1 / sqrt(2 pi)$

Using the progressive values of gamma makes it easier to do calculations with them.
