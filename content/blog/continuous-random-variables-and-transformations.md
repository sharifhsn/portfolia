+++
title = 'Continuous Random Variables and Transformations'
date = 2024-10-14
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Continuous Distributions', 'Change of Variables']
+++

### Lecture Notes

Recall for a discrete random variable. The moment formula is

\(\mathbb{E}[X] = \sum_{x \in X(\Omega)} x \mathbb{P}(X=x)\)

The moment for a continuous rv is the integral

\(\mathbb{E}[X] = \int_{-\infty}^\infty x f(x) dx\)

All the possibilities are the real line here.

Most of today’s class will deal with integrals. We are going to calculate a lot of these, just like a single variable calculus class. We will also learn multivariable calculus for multiple variables.

Generalization of expectation for any function is definition 5.9 (skip technical assumptions)

\(\mathbb{E}[h(X)] = \int_{-\infty}^\infty h(x) f(x)dx\)

You would just compute the antiderivative of \(h(x)\) and then evaluate the integral by subtracting the top from bottom. For an indicator variable, it is 0 to 1 not -infinity to infinity.

Now I want to go further, I want to know the full distribution, not just the expectation, of \(h(X)\)

This is given by theorem 5.10 which tells us how to determine the probability density function. The PDF of \(Y = h(X)\) is given by

\(f_Y(y) = \frac{1}{h'(h^{-1}(y))} f(h^{-1}) (y) I_{\{y \in h(D)\}}\)

Here, \(f(h^{-1})\) denotes the composition of f on inverse h. First I apply the inverse h, then I apply the f. Sometimes you use the notation \(f \circ h^{-1}\)

How do you prove this? We will sketch. We will make the assumption that \(h\) is non-decreasing.

\(\mathbb{P}(Y \leq y) = \mathbb{P}(h(X) \leq y) = \mathbb{P}(X \leq h^{-1}(y))\)

We can do the inverse because it’s non-decreasing.

This is true, so we can write this probability as the integral of the PDF of X

\(= \int_{-\infty}^{h^{-1}(y)} f(x)dx\)

If I want to say the PDF of the random variable \(Y\), then it gets the \(Y\) subscript; without the subscript, it’s for \(X\).

Now we will do a change of variables

\(x = h^{-1}(z)\)

We know that \(x\) is inside the integral, so we will write the equivalence that when it is in between those two values, it is equivalent to the event that \(z\) is in between \(-\infty\) and \(y\).

This is important because we will change the integration range:

\(= \int_{-\infty}^y f(h^{-1}(z)) dh^{-1}(z)\)

You can move this part to the front

\(= \int_{-\infty}^y f(h^{-1}(z)) \cdot |(h^{-1})' (z)|dz\)

We will see that

\(f_Y(y) = \frac{d}{dy} \mathbb{P}(Y \leq y)\)

Now if we take the derivative of this integral, then we get

\(\frac{d}{dy} \int_{-\infty}^y f(h^{-1}(z)) |(h^{-1})'(z)|dz\)

We get something like the fundamental theorem of calculus here, or part of it, or Leibniz rule. you have the following result:
\(\frac{d}{dx}\left(\int_{-\infty}^x f(u) du\right) = f(x)\)

This identity is learned in calculus.

So, we can show that everything inside doesn’t depend on \(y\), so we can just evaluate the integral with it.

\(= f(h^{-1}(y)) |(h^{-1})' (y)|\)

Then we will use this result, from a second theorem of calculus called the implicit function theorem. This is more real analysis, here’s a simple example.

\(h^{-1}(h(y)) = y\)

Now the idea is we want to do differentiation on both sides.

\(\frac{d}{dy}(h^{-1}(h(y)) = \frac{d}{dy}(y)\)

Because we have this equality, the derivative preserves the equality (maybe not integration because of range). Applying the chain rule, we get

\((h^{-1})'(h(y)) = \frac{1}{h'(y)}\)

And then we do a change of variable.

\(y = h^{-1}(u)\)

y is just a dummy variable, so we can apply this here, to finally show that

\(= f(h^{-1}(y)) \left|\frac{1}{h'(h^{-1}(y))}\right|\)
Interesting corollary 5.11 that if X has pdf f and we have a Y which is aX + b, then pdf of Y is

\(f_Y(y) = \frac{1}{|a|} f\left(\frac{y-b}{a}\right)\)

This is a special case when the \(h(x)\) is \(aX + b\), can be shown by differentiation. All you need to find is \(h'(x)\) and \(h^{-1}(y)\)

We can essentially think of \(Y\) as a linear combination of a different random variable whose pdf is known, and then we can derive the pdf from the existing pdf f.

#### 5.4.1

We are concerned with a uniform random variable defined continuously on \([a, b]\) on \(\mathbb{R}\)

Definition 5.13 says that the pdf of this is

\(f(x) = \frac{1}{b-a}, x \in [a, b]\)

We will use the notation to indicate uniform distribution

\(x \sim U[a, b]\)

Let’s do something non-trivial. Proposition 5.15 says that if we have \(X \sim U[a, b]\), then

\(\mathbb{E}[X] = \frac{a + b}{2}\)

\(\mathbb{V}[X] = \frac{(b-a)^2}{12}\)

How do we prove? We can create the integral based on the definition

We have from algebra that

\(b^3 - a^3 = (b-a)(a^2 + ab + b^2)\)

which we can use to prove the variance.

We are generally solving for

\(\frac{1}{b - a} \int_a^b f(x)dx\)

and that’s how we solve for expectation, for \(f(x)\) being \(x\) or \(x^2\)

We have to turn these types of problems into a pdf, that will be done on the midterm.



What is the cdf for a uniform variable?

By proposition 5.16, it’s

\(F_X(t) = \begin{cases} 0 & \text{if } t < a \\ \frac{t-a}{b-a} & \text{if } t \in [a, b] \\ 1 & \text{if } t > b \end{cases}\)

This is the same as \(\mathbb{P}(X \leq t)\)

We can accomplish this case conclusion by the integral

\(= \int_a^t \frac{1}{b-a} I_{[a, b]} (u)du\)
Very simple proof for this.

Now let’s consider a simple example 5.8 where \(X\sim U[0,1]\), we will compute \(\mathbb{P}\left(\frac{1}{4} \leq x \leq \frac{3}{4}\right)\)

To solve, this we will solve as an integral

\(= \int_{\tfrac{1}{4}}^{\tfrac{3}{4}} f(x)dx = \int_{\tfrac{1}{4}}^{\tfrac{3}{4}} 1 dx = \frac{1}{2}\)

This is one way to solve this, or you could separate it into cdf up to ¾ and ¼.



#### 5.4.2

The next thing is the exponential distribution, definition 5.17. We introduce the auxiliary parameter \(\lambda > 0\), then

\(f(x) = \lambda e^{-\lambda x}, x > 0, X \sim Exp(\lambda)\)

That is what is meant when we are given a distribution. How do we verify that this result is a pdf? Proposition 5.18 says

\(\int_{-\infty}^\infty f(x) dx\)

The range of integration starts from 0

\(=  \lambda \int_0^\infty e^{-\lambda x}dx\)

Now we can do some calculus

\(\frac{d}{dx} e^{-\lambda x} = e^{-\lambda x} (-\lambda)\)

\(e^{-\lambda x} = \frac{\tfrac{d}{dx}e^{-\lambda x}}{-\lambda}\)

\(e^{-\lambda x} dx = d\left(\frac{e^{-\lambda x}}{-\lambda}\right)\)

Now we can do integration by parts, which is a very important technique for this chapter that we will do over and over again.

If we are interested in integrating

\(\lambda f(x) dg(x) = f(x) \cdot g(x) - \lambda g(x) - \int g(x) df(x)\)

And this is the process of integration by parts.

(We don’t actually need integration by parts here, but we will need to do it for the moments)



Now we will show the moments by proposition 5.19

\(\mathbb{E}[X] = \frac{1}{\lambda}\)

\(\mathbb{V}[X] = \frac{1}{\lambda^2}\)

We will now try to evaluate this integral

\(= \lambda \int_0^\infty x e^{-\lambda x}dx\)

And this is where we need integration by parts

\(= \lambda \int_0^\infty x d\frac{e^{-\lambda x}}{-\lambda}\)
First we take the product

\(= \lambda \left( \left. x \frac{e^{-\lambda x}}{-\lambda} \right|^{x = \infty}_{x = 0} - \int_0^\infty \frac{e^{-\lambda x}}{-\lambda} dx\right)\)



Variance is not easy because you need to integrate twice by parts.



\(\mathbb{E}[X^2] = \int_0^\infty x^2 \lambda e^{-\lambda x}dx = \lambda \int_0^\infty x^2 e^{-\lambda x}dx = \lambda \int_0^\infty x^2 d\left(\frac{e^{-\lambda x}}{-\lambda}\right)\)

We will try now to get rid of that denominator to get

\(= -\int_0^\infty x^2 de^{-\lambda x}\)

Integration by parts:

\(-\left.x^2 e^{-\lambda x}\right|_{x=0}^{x=\infty} - \int_0^\infty e^{-\lambda x} dx^2\)

\(= -\left(0 - \int_0^\infty e^{-\lambda x} 2x dx\right)\)

\(= 2 \int_0^\infty e^{-\lambda x} x dx\)

And we already have shown this result so it is

\(= \frac{2}{\lambda^2}\)

And then after subtracting by the expectation squared you get

\(\mathbb{V}[X] = \frac{1}{\lambda^2}\)

What is the cdf of the exponential random variable? Proposition 5.20 will tell us that

\(F_X(x) = 1 - e^{-\lambda x}\)

Here is the proof, which is just calculation

\(F_X(x) = \int_0^x f(u) du = \int_0^x \lambda e^{-\lambda u} du\)

The difference between a CDF and a statistical measure is that we’re measuring up to (x), not infinity, but the technique is the same.

\(= \lambda \int_0^x d\left(\frac{e^{-\lambda u}}{-\lambda}\right) = \lambda \left. \frac{e^{-\lambda u}}{-\lambda} \right|_{u=0}^{u=x}\)



There is a memoryless property of the exponential distribution.

\(\mathbb{P}(X > t + s|X > t) = \mathbb{P}(X > s) , s,t \geq 0\)

I know that my exponential variable is bigger than t. There is some interval between t and t + s which is length s. I know my random variable \(X\) is bigger than t + s, given that it is bigger than t. But actually it doesn’t really matter what the probability is between t and t + s, there is no memory of the starting point. You only care about the probability after s. (We will not prove this)



Let’s take example 5.9, it will be easy to prove the cdf

\(f_X(t) = \frac{1}{100} e^{-\tfrac{t}{100}}, \lambda = \frac{1}{100}\)

Then we get expectation by the formula \(\frac{1}{\lambda}\)
How do we solve if we are given probability between an interval like

\(\mathbb{P}(0 \leq X \leq 50)\)

We take the integral between these two points.

\(= \int_0^{50} \frac{1}{100} e^{-\tfrac{t}{100}} dt\)

And we can actually do a change of variable here from

\(s = \frac{t}{100}\)

Which will give us

\(= \int_0^{\tfrac{1}{2}} e^{-s} ds = \left. \frac{e^{-s}}{-1} \right|^{s=\tfrac{1}{2}}_{s=0} = \frac{e^{-\tfrac{1}{2}} - 1}{-1} = 1 - e^{-\tfrac{1}{2}}\)



#### 5.4.3

The normal distribution by definition 5.22 has the distribution function

\(f(x) = \frac{1}{\sqrt{2\pi \sigma^2}} e^{-\frac{(x - \mu)^2}{2\sigma^2}}, x \in \mathbb{R}\)

denoted by

\(X \sim N(\mu, \sigma^2)\)
We have to show that the normal distribution is a PDF, which is not very straightforward.

Proposition 5.24

Proposition 5.25 tells us that the expected value and variance are

\(\mathbb{E}[X] = \mu\)

\(\mathbb{V}[X] = \sigma^2\)

which is very convenient for us. But we will need to formally verify this

We will copy this pdf into the integral

\(\mathbb{E}[X] = \frac{1}{\sqrt{2\pi \sigma^2}} \int_{-\infty}^\infty x e^{-\frac{(x - \mu)^2}{2\sigma^2}}dx\)

And we are going to do a change of variable

\(y = x - \mu\)

We have the same integration region because they are infinite. We can replace x in this whole function.

\(= \frac{1}{\sqrt{2\pi \sigma^2}} \int_{-\infty}^\infty (y + \mu) e^{-\frac{y^2}{2\sigma^2}} dy\)

We will separate the integral into two parts

\(= \frac{1}{\sqrt{2\pi \sigma^2}}  \int_{-\infty}^\infty ye^{-\frac{y^2}{2\sigma^2}} dy + \mu  \int_{-\infty}^\infty e^{-\frac{y^2}{2\sigma^2}} dy\)

The first integrand is an odd function. This means that \(f(x) = -f(-x)\). Even functions are \(f(x) = f(-x)\). For any integral from -infinity to infinity, we can combine all the negatives and all the positives. And if it is symmetric around 0 with the opposite, which is the meaning of odd, then when they’re added it should give you 0.

Then we can recognize that for the second integrand that it must be equal to \(\mu\) by the fact that the normal distribution area is equal to 1 (assumed).



Now for the variance. By definition, because we know the expectation already, we get

\(\mathbb{V}[X] = \mathbb{E}\left[(X - \mu)^2\right]\)

which by the pdf is

\(= \frac{1}{\sqrt{2\pi \sigma^2}} \int_{-\infty}^\infty (x - \mu)^2 e^{-\frac{(x-\mu)^2}{2\sigma^2}} dx\)

Then we can do a change of variable, and then solve via polar coordinates on page 138

\(= \frac{1}{\sqrt{2\pi \sigma^2}} \int_{-\infty}^\infty y^2 e^{-\frac{y^2}{2\sigma^2}} dy\)

Remark 5.2.7 says that if \(X \sim N(0, 1)\), then \(\mu + \sigma X \sim N(\mu, \sigma^2)\)

The inverse operation

\(Y \sim N(\mu, \sigma^2), \frac{Y - \mu}{\sigma} \sim N(0, 1)\)

is known as **standardization**.

Proof: if you let

\(Y = \mu + \sigma X = h(X)\)

Using the corollary 5.11 for linear combination we can prove this.



Useful property of normal distribution. If we have two normal distributions \(X\) and \(Y\) that are independent, then

\(X + Y \sim N(\mu_1 + \mu_2, \sigma_1^2 + \sigma_2^2)\)
We have to do a convolution to solve this, involves integration between the two things.



#### 5.4.14

Last one for today is the gamma distribution.

We need some preparation, in the gamma function.

\(\Gamma(x) = \int_0^\infty t^{x-1} e^{-t} dt\)

Proposition 5.30 says the properties of the gamma function. We have the property (a) that

\(\Gamma(x + 1) = x \Gamma(x), x > 0\)

and (b) that

\(\Gamma(n+1) = n!\)

and (c), which the source note does not prove,

\(\Gamma\left(\frac{1}{2}\right) = \sqrt{\pi}\)

Proof of (a) is that

\(= \int_0^\infty t^X e^{-t} dt = \int_0^\infty t^X \left(d \frac{e^{-t}}{-1}\right)\)

\(\left.t^x\frac{e^{-t}}{-1}\right|_{t=0}^{t=\infty} - \int_0^\infty \frac{e^{-t}}{-1}\,d(t^x)\)

We can separately calculate \(dt^X = xt^{x-1}dt\) by the power rules.

\(= \int_0^\infty e^{-t} xt^{x-1} dt\)

\(x \int_0^\infty t^{x - 1}e^{-t} dt = x \Gamma(x)\)



The technique is to do the integration by parts and factor out certain quantities.

If we want to find out (b), then we can do induction once we find \(\Gamma(2)\)

\(\Gamma(2) = \int_0^\infty t e^{-t} dt = \int_0^\infty t d \frac{e^{-t}}{-1} = \left . t \cdot \frac{e^{-t}}{-1} \right|^{t=\infty}_{t=0} - \int \frac{e^{-t}}{-1} dt\)

\(= \int_0^\infty e^{-t} dt\)



What about the pdf? Given by definition 5.31

\(f_{a, \lambda}(x) = \frac{\lambda^a}{\Gamma(a)} e^{-\lambda x}x^{a - 1}\)

\(X \sim \Gamma(a, \lambda)\)

It has a lot of weird special cases.

Proposition 5.32 shows that this is a true density function. We will do integration from 0 to the infinity of this density

\(\int_0^\infty \frac{\lambda^a}{\Gamma(a)} e^{-\lambda x} x^{a - 1} dx\)

\(= \frac{\lambda ^a}{\Gamma(a)} \int_0^\infty \left(\frac{1}{\lambda} y\right)^{a-1} \cdot e^{-y} \frac{1}{\lambda} dy\)

\(= \frac{\lambda ^a}{\Gamma(a)} \int_0^\infty \frac{1}{\lambda^{a-1}} \cdot \frac{1}{\lambda} \cdot e^{-y} \frac{1}{\lambda} dy\)

After we cancel out the \(\lambda\)

\(= \frac{1}{\Gamma(a)} \int_0^\infty y ^{a-1} e^{-y} dy\)

which is just the definition of gamma

\(= \frac{\Gamma(a)}{\Gamma(a)} = 1\)



Proposition 5.33 says for E and V that

\(\mathbb{E}[X] = \frac{a}{\lambda}\)

\(\mathbb{V}[X] = \frac{a}{\lambda^2}\)

We know from the definition of expectation and combining similar terms that

\(\mathbb{E}[X] = \int_0^\infty x \cdot \frac{\lambda^a}{\Gamma(a)} x^{a-1} e^{-\lambda x} dx = \frac{\lambda^a}{\Gamma(a)} \int_0^\infty x^a e^{-\lambda x} dx\)

Let’s do a change of variable to \(y = \lambda x\)
\(= \frac{\lambda^a}{\Gamma(a)} \cdot \int_0^\infty \left(\frac{y}{\lambda}\right)^a \cdot e^{-y} \cdot \frac{1}{\lambda} dy\)

Taking this out, I get

\(\frac{\lambda^a}{\Gamma(a)} \cdot \frac{1}{\lambda^a}\frac{1}{\lambda} \int_0^\infty y^a e^{-y} dy\)

Here we can use the result from before of the definition of gamma to substitute the integral.

\(= \frac{a}{\lambda}\)

\(= \frac{a}{\lambda}\)

To get variance, we have

\(\mathbb{E}[X^2] = \frac{\lambda^a}{\Gamma(a)} \cdot \int_0^\infty x^{a+1}e^{-\lambda x} dx\)

Change of variable…

\(= \frac{\lambda^a}{\Gamma(a)} \cdot \int_0^\infty \left(\frac{y}{\lambda}\right)^{a+1}e^{y} dy\)

\(= \frac{a(a+1)}{\lambda^2}\)

\(\mathbb{V}[X] = \frac{a}{\lambda^2}\)

I can sequentially use the value of a to get this result.



Finally, proposition 5.35 shows us that for \(X \sim N(0, 1)\), then \(X^2 \sim \Gamma(\tfrac{1}{2}, \tfrac{1}{2})\)

Our proof is that

\(F_{X^2}(t) = \mathbb{P}(X^2 \leq t) = \mathbb{P}(-\sqrt{t} \leq X \leq \sqrt{t})\)

\(= \mathbb{P}(X \leq \sqrt{t}) - \mathbb{P}(X \leq -\sqrt{t})\)

x is a normal density, so we can write this as

\

now we’re going to differentiate on both sides

\(f_{X^2}(t) = \frac{d}{dt}F_{X^2}(t)\). The source note starts the derivative calculation here; the remaining algebra is not recorded.

These two minus signs cancel out and you get both



And the two will cancel out and you can put this downstairs



Then you can rewrite this exactly as \(\Gamma(\tfrac{1}{2}, \tfrac{1}{2})\)

\(f_{\tfrac{1}{2}, \tfrac{1}{2}} (x) = \frac{(\tfrac{1}{2})^{\tfrac{1}{2}}}{\Gamma(\tfrac{1}{2})} \cdot e^{-\tfrac{1}{2} x} x^{-\tfrac{1}{2}}\)

And then we can know from our definition that

\(\frac{1}{\sqrt{2}\,\Gamma(\tfrac{1}{2})} = \frac{1}{\sqrt{2\pi}}\)



Using the progressive values of gamma makes it easier to do calculations with them.
