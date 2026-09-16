+++
title = "Stochastic Volatility, Jumps, and Fourier Transforms"
date = 2025-03-18
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Stochastic Volatility","Jump Processes","Poisson Process","Fourier Transform"]
+++

Theoretical transformations, very technical

## Stochastic Volatility Models

How do you solve a Heston model using Fourier transforms?

### Hull-White

The very first stochastic volatility model introduced is the Hull-White model.

$$dS\_t \= rS\_t dt \+ \\sqrt{y\_t} S\_t dW\_t$$

$$dY\_t \= \\mu\_Y Y\_t dt \+ \\sigma\_Y Y\_t dZ\_t$$

Has no solution:(

If the Brownian motions are uncorrelated, then there is no leverage effect, because that effect is a correlation between volatility and returns. But just because the Brownian motions are uncorrelated, doesn’t mean the processes are uncorrelated, they incorporate each other.

### Leverage Effect

The leverage effect is the perceived correlation between returns and volatility, and news and returns. The idea is that positive news causes the stock to go up, which makes return go up, and vice versa for negative news.

However, the two effects are not the same. If there is good news the stock goes up, if there’s bad news, the stock goes down much more proportionally. This is called the **leverage effect**, which is a negative correlation between volatility and returns. Basically, the news increases vol, and as vol increases, returns go down.

You need to have stochastic volatility to have correlation between stochastic and deterministic processes.

I’ll mention two more stochastic volatility models.

### SABR

We discussed SABR earlier, so this is a reminder. It looks like

$$dS\_t \= rS\_t dt \+ \\sigma\_t S\_t^\\beta dW\_t$$

This is the most general form of the process, most that you see in practice have r \= 0 because they are created by physicists who don’t like complicated models.

The sigma is the stochastic process, which has the process

$$d\\sigma\_t \= \\alpha \\sigma\_t dZ\_t$$

The W and Z are two Brownian motions which can be correlated with rho.

This is also called the stochastic alpha beta rho model (SABR) for the three parameters and the stochastic volatility.

The authors of this made it so that once you calculate sigma, you can plug it into Black-Scholes and reuse all your old code.

### Constant elasticity of variance (CEV)

Pioneered by Peter Carr (friend of the show) and Madan.

$$dS\_t \= rS\_t dt \+ \\sigma S\_t^{\\frac{\\beta}{2}} dW\_t$$

If you think about this in terms of stochastic models. This beta is strictly less than 2, and sigma is greater than 0\. You ca write this as

$$\\sigma S\_t S\_t^{\\frac{\\beta \- 2}{2}}$$

Which means that the last term is the actual stochastic volatility.

That’s literally driven by the price evolution. This is inversely proportional to the value of the stock.

If you Ito this with log S\_t, you get

$$dX\_t \= \\left(r-\\frac{\\sigma^2 S\_t^{\\frac{\\beta-2}{2}}}{2}\\right) dt \+ \\sigma S\_t^{\\frac{\\beta-2}{2}} dW\_t$$

Then the second term is the vol.

So the variance should be the vol squared.

$$\\mathbb{V} \= \\sigma^2 S\_t^{\\beta \- 2}$$

If you compute the derivative the change in the variance with respect to stock.

$$\\frac{\\partial \\mathbb{V}}{\\partial S} \= \\sigma^2 (\\beta \- 2\) S\_t^{\\beta \- 3}$$

You can rewrite this as

$$\\sigma^2 S\_t^{\\beta \- 2} \\frac{\\beta \- 2}{S\_t}$$

The point of doing this is to see that these left two terms are the exact same as the variance.

$$\\frac{\\partial \\mathbb{V}}{\\partial S} \= \\mathbb{V} \\frac{\\beta \- 2}{S\_t}$$

Which is the same thing as saying

$$\\frac{\\partial \\mathbb{V}}{\\mathbb{V}} \= (\\beta \- 2)\\frac{\\partial S}{S}$$

The change in variance is proportional to the change of stock.

The variance move elastically, proportional to the way the stock moves.

And they change inversely, because beta is less than 2\.

And actually, if beta \= 2, then you get GBM in the formula.

$$dS\_t \= rS\_t dt \+ \\sigma S\_t dW\_t$$

Which makes sense because that assumes constant volatility, where

$$\\frac{\\partial \\mathbb{V}}{\\mathbb{V}} \= 0$$

When beta \= 1, you get CIR

$$dS\_t \= rS\_t dt \+ \\sigma \\sqrt{S\_t} dW\_t$$

Changes in the stock become actually 1:1 with the stock in this case.

## Jump Processes

Lonon is an expert on jump processes.

## Poisson Process

Basically, $$N \\in \\{0, 1, \\ldots \\}$$

where at time t, $$N\_t \\sim Poisson(\\lambda t)$$

Lambda quantifies the expected number of values for when t \= 1\.

That’s how you scale it.

The question is, how do you simulate this?

There are two ways to do this:

Probability and Stochastic Processes (Florescu) has a lot of information on this.

I suggest you pirate my book because the publishers are thieves.

Method 1:

If $$X\_1, X\_2, X\_3, \\ldots X\_n$$ are iid Exp(1/lambda)

Basically the expected amount over lifetime is 1/lambda.

Then we let

$$T\_1 \= X\_1, T\_2 \= X\_1 \+ X\_2, T\_3 \= X\_1 \+ X\_2 \+ X\_3, \\ldots$$

What I’m doing here is defining the event times for the Poisson process.

At some point t, if you were to plot the process, then you would get a bunch of jumps up to t.

Then

$$N\_t \= \\max\_n \\{T\_n \\leq t\\}$$

The only question is if it’s included or not, so le’ts be careful.

Actually, it’s

$$N\_t \= \\inf\_n \\{T\_n \> t\\}$$

You can understand how to create this\!

You simply generate these exponentials from the distributions, and you know the times from the sum.

You give me the process, and the time t.

The jump is of value 1, so it always jumps by 1\.

There is a marked Poisson process or compound Poisson process, where instead of moving it by 1, you move it by a random variable, and then you sum those. Once you understand this it’s very simple, you just generate a series of random variables and assign them to each T.

How is this useful?

In two lectures, we will learn about Monte Carlo simulations. These typically don’t have jumps. But if you add jumps to them, you get a jump process.

You will get your T\_1, T\_2, and T\_3 etc.

You will be going up and down by random quantities at those times.

These jumps:

Trump announces tariffs at each time T, and it goes up and down based on what country he tariffs.

There is some process which is not Jumpy, looks more like a Brownian motion. To introduce the jumps, you simply shift the value by the value of the random variable.

The exponential distribution starts at 1/lambda at t \= 0 and then goes down. for Exp(1/lambda)

Most of the times, you get a small value.

Secret: if you play video games, and play whatever discrete events that happen in time. If you play a gacha game and put coins in there to get the good Pokemon. You keep getting a crappy Pokemon, and suddenly they give you a good one. But now you say it stops because you have it. The time between Pokemons is a random variable. If you generate the Poisson process for this, and if you look at the path, and you think about it logically, if it happens 5 per hour, the jumps should happen evenly. But this is not how it really looks. If you look at the pdf, you’re much more likely to have smaller intervals than larger intervals.

Method 2 is based on the following two results.

If we look at interval \[0, t), the number of events is distributed as Poisson(lambda t)

Let’s say you have events that happen once a day. Trump issues things once per day. (I’m a Republican so don’t pick on me)

If you want to generate how many things this guy says this week, you make a random variable with parameter t \= 7, lambda \= 1\.

This Poisson random variable.

Given there are N events in the interval \[0, t) that I’m generating, the times of the events (and this is proven in the book), are the order statistic from N uniform \[0, t\] random variables.

That sounds fancy, but basically it says…

An **order statistic**. If you have n random variables iid, and you take them X\_1, X\_2, X\_n,

the order statistics ordered like

$$X\_{(1)} \\leq X\_{(2)} \\leq … X\_{(n)}$$

and this is just an ordered list. So the first order statistic is the smallest number. The order statistics have a distribution which depends on the original distribution, and it’s actually quite simple to work with them.

Then generate random variable $$N \\sim Poisson(\\lambda t)$$

Then generate random $$N \\sim Uniform\[0, t\]$$

Let’s say Poisosn happesnt ob e 10\.

I generate a variable

Generate the uniform, look at the numbers, then list them smallest to largest.

Let’s say it’s 1.1. It took Trump 1.1 days to say the first stupid things. Then you have 3, so it took him another day to say something else.

These are the times, then the magnitudes come from them.

rpois(1, 7\)

for example, gives you 6

N=rpois(1,7)

Now you generate seven uniforms

runif(N, 0, 7\)

This gives you the times, which are unsorted.

Now you sort them

sort(runif(N,0, 7))

Poisson gives us the number of events, and uniform gives us the actual times of the events.

## Transformation Methods

### Laplace Transform

This is very familiar to probabilists. This is also called the moment generating function.

If you define X as a random variable with pdf f(x)

Then we define the mgf

$$M\_X: \\mathbb{R} \\rightarrow \[0, \\infty)$$

$$M\_X(t) \= \\mathbb{E}\[e^{tX}\]$$

If X has a pdf, then this is also defined as

$$= \\int\_{-\\infty}^\\infty e^{tx} f(x) dx$$

This was invented by Laplace, but he invented it in physics, for functions that were positive support, from 0 to infinity. So it’s a little different. The mgf is called so because if you take the derivative of the function with respect to t, you get the moments. (You need to prove that the derivative commutes with the integral, not that difficult).

$$M’(t) \= \\frac{dM\_X(t)}{dt} \= \\int\_{-\\infty}^\\infty xe^{tx} f(x) dx \= \\mathbb{E}\[Xe^{tx}\]$$

And then

$$M’(0) \= \\mathbb{E}\[X\]$$

The P\&SP book will cover this in more detail.

The Laplace transform of f: (0, infinity) to R, looks like

$$Lf(t) \= \\hat{f}(t) \= \\int\_0^\\infty e^{tx} f(x) dx$$

The only difference is that it’s positive.

You can always write mgf as sum of two Laplace transforms.

The Laplace transform has this nice **inversion theorem**. Moving past all the details, you should remember it as:

If f has Laplace transform Lf, then

$$f(x) \= \\frac{1}{2\\pi i} \\lim\_{T \\rightarrow \\infty} \\int\_{C \- iT}^{C \+ iT} e^{tx} Lf(t) dt$$

This limit exists only for certain Lf(t), and even if it exists it’s ugly. So undergrads will look at the table of Laplace transforms. [Table of Laplace Transforms](https://web.stanford.edu/~boyd/ee102/laplace-table.pdf)

Stanford uses t and s, Florescu uses x and t.

This is useful because if you take the derivative of the function, and apply the Laplace transform, it becomes a polynomial. It becomes tF(t) \- f(0)

If you take the nth derivative, you get a bunch of derivatives evaluated at 0\. It makes it easier to solve. It’s very useful for solving diffeqs.

In practice, this thing has two problems. The specific doesn’t exist. With small exceptions, the equation is too complicated to get the value of the function that corresponds to it.

If you’re interested in applyin this and want to work with Laplace transform, use Mathematica which Dragos buys for Stevens

## Fourier Transform

There is an equivalent to this in probability, which is the **characteristic function**, which is more complicated than the transform.

What is the Fourier transform? For f(x):

$$f: \[0, \\infty) \\rightarrow \\mathbb{R}$$

$$F(t) \= \\int\_{-\\infty, \\infty} e^{-itx} f(x) dx$$

The only difference is the introduction of the i thing. In general, you can apply Euler’s identity for

$$e^{ia} \= \\cos a \+ i \\sin a$$

So this becomes

$$F(t) \= \\int\_{-\\infty, \\infty} \\cos(tx) f(x) dx \- i \\int\_{-\\infty, \\infty} \\sin(tx) f(x) dx$$

You can calculate this using real integrals. Laplace is actually harder than this.

What is the connection with the characteristic function?

$$\\varphi\_x(t) \= \\mathbb{E}\[e^{itX}\] \= \\int\_{-\\infty}^\\infty e^{itx} f(x) dx$$

The only difference is that the characteristic doesn’t have a minus, which is not a big deal.

The minus doesn’t mean anything, really.

What is the connection between the characteristic and the moment?
We can calculate moments from characteristic function.

$$\\varphi\_x’(t)\\frac{d}{dt} \\varphi\_X(t)$$

You have to prove this works, and then take the complex function, which is not that hard.

$$= \\mathbb{E}\[(iX) e^{itX}\]$$

It’s kind of like you go inside and take the derivative as normal.

But if you take this

$$\\varphi\_x’(0) \= i\\mathbb{E}\[X\]$$

This becomes slightly more complicated, because you get the powers

$$\\varphi\_x’’(0) \= i^2 \\mathbb{E}\[X^2\]$$

And this continues in general.

What is the advantage, why do we do this Fourier transform and not stick to the Laplace transform?

This Fourier transform always exists. And there is also an inverse Fourier transform. It is basically the same idea. You get a diffeq and a simpler equation, and then the inverse gives you the solution.

There is something more that exists here\! That is **discrete Fourier transform**. That is the big deal.

Generally speaking, you will run into the same problem. You get this horrible expression from the Fourier transform, and you can’t get the pdf from it. Engineers have invented this approximation. You express the original function in terms of cosines and sines, and then you know the transforms and inverse transforms from there.

[Table of Fourier Transform Pairs](https://engineering.purdue.edu/~mikedz/ee301/FourierTransformTable.pdf)

I had an argument a long time ago…

The whole point is, when you do a Fourier transform, you go into the frequency domain of your function. If your function is a sinus, you get one value. If you have a combination of sinuses, then you get a multitude of frequencies. The whole point of the DFT is that you express the function through the bases of sinuses.

[Discrete Fourier transform](https://en.wikipedia.org/wiki/Discrete_Fourier_transform)

There’s math here, but nobody actually uses it.

What we do instead, is that we call a package and say this is my function, calculate the DFT, put it into an equation, solve it, calculate IFT, and then just do it that way.

## Applications of Fourier Transform

Peter Carr was a guy at Bloomberg, and him and Ionut argued.

He said he was solving stochastic vol formula analytically, Ionut says this is not possible. Carr admits that it’s just very fast.

This is used to solve the Heston model.

$$dS\_t \= S\_t(r dt \+ \\sqrt{V\_t} dW\_t)$$

$$dV\_t \= K(\\theta \- V\_t) dt \+ \\sigma \\sqrt{V\_t} dZ\_t$$

W and Z can be correlated with rho.

Original Heston model is uncorrelated, there is an extension by Wiggins which is correlated.

The solution is not that complicated.

There is also something called the Feller condition.

In order for this Heston model to be nicely behaved (homogenous), you should have

$$2K\\theta \> \\sigma^2$$

The problem is, given this model for my stochastic process, which is actually quite realistic, we want to find the price of an option.

t is time now

S is stock price

K is strike price

T is time of maturity

r is risk free rate

NEW: V is the value of this variance process

$$C(t, S, K, T \- t, r, V)$$

If you consider the other points observable, then this is a function of C(t, S, V)

We used to solve things as $$ t \\in \[0, T\]$$, $$S \\in (0, infty)$$, $$\\mathbb{V} \\in (0, \\infty)$$

Now we solve this equation with respect to three parameters.

Call option \= $$\\mathbb{E}^Q \[e^{-r(T \- t)} (S\_T \- K)\_+ | \\mathcal{F}\_t\]$$

This is the general formula.

You can write this as, by splitting into two different situations, when in the money and out of the money

$$=\\mathbb{E}^Q\[e^{-r(T-t)}(S\_T \- K)\_+ \\mathbb{I}\_{\\{S\_T \> K\\}}$$

Where we disregard the out of the money part because it’s worthless.

$$= \\mathbb{E}^Q \[e^{-r(T-t)} S\_T \\mathbb{I}\_{\\{S\_T \- K\\}}|\\mathcal{F}\_t\] \- K\\mathbb{E}^Q\[e^{-r(T-t)} \\mathbb{I}\_{\\{S\_T \> K\\}}\]$$

Then we can take out the e term because it’s just a number,

$$= e^{-r(T-t)} \\mathbb{E}\[S\_T \\mathbb{I}\_{\\{S\_T \- K\\}} | \\mathcal{F}\_t\] \+ Ke^{-r(T-t)}\\ldots$$

Then this first term will be considered P1(t, S, V), and the second term is P2(t, S, V).

What he said is if you notice the very first property of the Fourier transform is that it is linear.

So both P1 and P2 must solve the Heston PDE.

Then let’s apply the Fourier transform to the original Heston PDE.

This is more complicated than just going from t to x as before, because we have three variables. So we do:

$$\\hat{f}(\\phi, x, v)$$

So he postulated that

$$\\hat{f}(\\phi, x, v) \= e^{C(\\tau, \\phi) \+ D(\\tau, \\phi)v+i\\phi x}$$

This has some theoretical reasoning, but he says that once you plug it in, there is a solution.

## Next Week

Estimating parameters, optimizations.
