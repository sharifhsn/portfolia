/*
title = "Stochastic Volatility, Jumps, and Fourier Transforms"
date = 2025-03-18
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Stochastic Volatility","Jump Processes","Poisson Process","Fourier Transform"]
*/

Theoretical transformations, very technical

== Stochastic Volatility Models
<stochastic-volatility-models>
How do you solve a Heston model using Fourier transforms?

=== Hull-White
<hull-white>
The very first stochastic volatility model introduced is the Hull-White model.

$ d S_t = r S_t d t + sqrt(y_t) S_t d W_t $

$ d Y_t = mu_Y Y_t d t + sigma_Y Y_t d Z_t $

Has no solution:(

If the Brownian motions are uncorrelated, then there is no leverage effect, because that effect is a correlation between volatility and returns. But just because the Brownian motions are uncorrelated, doesn't mean the processes are uncorrelated, they incorporate each other.

=== Leverage Effect
<leverage-effect>
The leverage effect is the perceived correlation between returns and volatility, and news and returns. The idea is that positive news causes the stock to go up, which makes return go up, and vice versa for negative news.

However, the two effects are not the same. If there is good news the stock goes up, if there's bad news, the stock goes down much more proportionally. This is called the #strong[leverage effect], which is a negative correlation between volatility and returns. Basically, the news increases vol, and as vol increases, returns go down.

You need to have stochastic volatility to have correlation between stochastic and deterministic processes.

I'll mention two more stochastic volatility models.

=== SABR
<sabr>
We discussed SABR earlier, so this is a reminder. It looks like

$ d S_t = r S_t d t + sigma_t S_t^beta d W_t $

This is the most general form of the process, most that you see in practice have $r = 0$ because they are created by physicists who don't like complicated models.

The $sigma$ is the stochastic process, which has the process

$ d sigma_t = alpha sigma_t d Z_t $

The $W$ and $Z$ are two Brownian motions which can be correlated with $rho$.

This is also called the stochastic $alpha$-$beta$-$rho$ model (SABR) for the three parameters and the stochastic volatility.

The authors of this made it so that once you calculate $sigma$, you can plug it into Black-Scholes and reuse all your old code.

=== Constant elasticity of variance (CEV)
<constant-elasticity-of-variance-cev>
Pioneered by Peter Carr (friend of the show) and Madan.

$ d S_t = r S_t d t + sigma S_t^(beta / 2) d W_t $

If you think about this in terms of stochastic models. This $beta$ is strictly less than $2$, and $sigma$ is greater than $0$. You can write this as

$ sigma S_t S_t^(frac(beta - 2, 2)) $

Which means that the last term is the actual stochastic volatility.

That's literally driven by the price evolution. This is inversely proportional to the value of the stock.

If you Itô this with $log S_t$, you get

$ d X_t = (r - frac(sigma^2 S_t^(frac(beta - 2, 2)), 2)) d t + sigma S_t^(frac(beta - 2, 2)) d W_t $

Then the second term is the vol.

So the variance should be the vol squared.

$ bb(V) = sigma^2 S_t^(beta - 2) $

If you compute the derivative the change in the variance with respect to stock.

$ frac(partial bb(V), partial S) = sigma^2\(beta - 2\)S_t^(beta - 3) $

You can rewrite this as

$ sigma^2 S_t^(beta - 2) frac(beta - 2, S_t) $

The point of doing this is to see that these left two terms are the exact same as the variance.

$ frac(partial bb(V), partial S) = bb(V) frac(beta - 2, S_t) $

Which is the same thing as saying

$ frac(partial bb(V), bb(V)) =\(beta - 2\)frac(partial S, S) $

The change in variance is proportional to the change of stock.

The variance move elastically, proportional to the way the stock moves.

And they change inversely, because $beta$ is less than $2$.

And actually, if $beta = 2$, then you get GBM in the formula.

$ d S_t = r S_t d t + sigma S_t d W_t $

Which makes sense because that assumes constant volatility, where

$ frac(partial bb(V), bb(V)) = 0 $

When $beta = 1$, you get CIR

$ d S_t = r S_t d t + sigma sqrt(S_t) d W_t $

Changes in the stock become actually 1:1 with the stock in this case.

== Jump Processes
<jump-processes>
Lonon is an expert on jump processes.

== Poisson Process
<poisson-process>
Basically, $ N in { 0\,1\,dots.h } $

where at time t, $ N_t tilde.op P o i s s o n\(lambda t\) $

$lambda$ quantifies the expected number of values for when $t = 1$.

That's how you scale it.

The question is, how do you simulate this?

There are two ways to do this:

Probability and Stochastic Processes (Florescu) has a lot of information on this.

I suggest you pirate my book because the publishers are thieves.

Method 1:

If $ X_1\,X_2\,X_3\,dots.h\,X_n $ are iid $"Exp"\(1\/lambda\)$

Basically the expected amount over lifetime is $1\/lambda$.

Then we let

$ T_1 = X_1\,T_2 = X_1 + X_2\,T_3 = X_1 + X_2 + X_3\,dots.h $

What I'm doing here is defining the event times for the Poisson process.

At some point t, if you were to plot the process, then you would get a bunch of jumps up to t.

Then

$ N_t = max_n { T_n lt.eq t } $

The only question is if it's included or not, so le'ts be careful.

Actually, it's

$ N_t = inf_n { T_n > t } $

You can understand how to create this!

You simply generate these exponentials from the distributions, and you know the times from the sum.

You give me the process, and the time t.

The jump is of value 1, so it always jumps by 1.

There is a marked Poisson process or compound Poisson process, where instead of moving it by 1, you move it by a random variable, and then you sum those. Once you understand this it's very simple, you just generate a series of random variables and assign them to each T.

How is this useful?

In two lectures, we will learn about Monte Carlo simulations. These typically don't have jumps. But if you add jumps to them, you get a jump process.

You will get your $T_1$, $T_2$, and $T_3$, etc.

You will be going up and down by random quantities at those times.

These jumps:

Trump announces tariffs at each time T, and it goes up and down based on what country he tariffs.

There is some process which is not Jumpy, looks more like a Brownian motion. To introduce the jumps, you simply shift the value by the value of the random variable.

The exponential distribution starts at $1\/lambda$ at $t = 0$ and then goes down, for $"Exp"\(1\/lambda\)$.

Most of the times, you get a small value.

Secret: if you play video games, and play whatever discrete events that happen in time. If you play a gacha game and put coins in there to get the good Pokemon. You keep getting a crappy Pokemon, and suddenly they give you a good one. But now you say it stops because you have it. The time between Pokemons is a random variable. If you generate the Poisson process for this, and if you look at the path, and you think about it logically, if it happens 5 per hour, the jumps should happen evenly. But this is not how it really looks. If you look at the pdf, you're much more likely to have smaller intervals than larger intervals.

Method 2 is based on the following two results.

If we look at interval $\[0\,t\)$, the number of events is distributed as $"Poisson"\(lambda t\)$.

Let's say you have events that happen once a day. Trump issues things once per day. (I'm a Republican so don't pick on me)

If you want to generate how many things this guy says this week, you make a random variable with parameter $t = 7$, $lambda = 1$.

This Poisson random variable.

Given there are $N$ events in the interval $\[0\,t\)$ that I'm generating, the times of the events (and this is proven in the book), are the order statistic from $N$ uniform $\[0\,t\]$ random variables.

That sounds fancy, but basically it says…

An #strong[order statistic]. If you have $n$ random variables iid, and you take them $X_1\,X_2\,dots.h\,X_n$,

the order statistics ordered like

$ X_(\(1\)) lt.eq X_(\(2\)) lt.eq dots.h X_(\(n\)) $

and this is just an ordered list. So the first order statistic is the smallest number. The order statistics have a distribution which depends on the original distribution, and it's actually quite simple to work with them.

Then generate random variable $ N tilde.op "Poisson"\(lambda t\) $

Then generate random $ N tilde.op "Uniform"\[0\,t\] $

Let's say Poisosn happesnt ob e 10.

I generate a variable

Generate the uniform, look at the numbers, then list them smallest to largest.

Let's say it's 1.1. It took Trump 1.1 days to say the first stupid things. Then you have 3, so it took him another day to say something else.

These are the times, then the magnitudes come from them.

`rpois(1, 7)`

for example, gives you 6

N=rpois(1,7)

Now you generate seven uniforms

`runif(N, 0, 7)`

This gives you the times, which are unsorted.

Now you sort them

sort(runif(N,0, 7))

Poisson gives us the number of events, and uniform gives us the actual times of the events.

== Transformation Methods
<transformation-methods>
=== Laplace Transform
<laplace-transform>
This is very familiar to probabilists. This is also called the moment generating function.

If you define X as a random variable with pdf f(x)

Then we define the mgf

$ M_X : bb(R) arrow.r\[0\,oo\) $

$ M_X\(t\)= bb(E)\[e^(t X)\] $

If X has a pdf, then this is also defined as

$ = integral_(- oo)^oo e^(t x) f\(x\)d x $

This was invented by Laplace, but he invented it in physics, for functions that were positive support, from 0 to infinity. So it's a little different. The mgf is called so because if you take the derivative of the function with respect to t, you get the moments. (You need to prove that the derivative commutes with the integral, not that difficult).

$ M'\(t\)= frac(d M_X\(t\), d t) = integral_(- oo)^oo x e^(t x) f\(x\)d x = bb(E)\[X e^(t x)\] $

And then

$ M'\(0\)= bb(E)\[X\] $

The P&SP book will cover this in more detail.

The Laplace transform of f: (0, infinity) to R, looks like

$ L f\(t\)= hat(f)\(t\)= integral_0^oo e^(t x) f\(x\)d x $

The only difference is that it's positive.

You can always write mgf as sum of two Laplace transforms.

The Laplace transform has this nice #strong[inversion theorem]. Moving past all the details, you should remember it as:

If f has Laplace transform Lf, then

$ f\(x\)= frac(1, 2 pi i) lim_(T arrow.r oo) integral_(C - i T)^(C + i T) e^(t x) L f\(t\)d t $

This limit exists only for certain Lf(t), and even if it exists it's ugly. So undergrads will look at the table of Laplace transforms. #link("https://web.stanford.edu/~boyd/ee102/laplace-table.pdf")[Table of Laplace Transforms]

Stanford uses t and s, Florescu uses x and t.

This is useful because if you take the derivative of the function, and apply the Laplace transform, it becomes a polynomial. It becomes $t F\(t\)- f\(0\)$.

If you take the nth derivative, you get a bunch of derivatives evaluated at 0. It makes it easier to solve. It's very useful for solving diffeqs.

In practice, this thing has two problems. The specific doesn't exist. With small exceptions, the equation is too complicated to get the value of the function that corresponds to it.

If you're interested in applying this and want to work with Laplace transform, use Mathematica which Dragos buys for Stevens

== Fourier Transform
<fourier-transform>
There is an equivalent to this in probability, which is the #strong[characteristic function], which is more complicated than the transform.

What is the Fourier transform? For f(x):

$ f :\[0\,oo\)arrow.r bb(R) $

$ F\(t\)= integral_(- oo\,oo) e^(- i t x) f\(x\)d x $

The only difference is the introduction of the i thing. In general, you can apply Euler's identity for

$ e^(i a) = cos a + i sin a $

So this becomes

$ F\(t\)= integral_(- oo\,oo) cos\(t x\)f\(x\)d x - i integral_(- oo\,oo) sin\(t x\)f\(x\)d x $

You can calculate this using real integrals. Laplace is actually harder than this.

What is the connection with the characteristic function?

$ phi_x\(t\)= bb(E)\[e^(i t X)\]= integral_(- oo)^oo e^(i t x) f\(x\)d x $

The only difference is that the characteristic doesn't have a minus, which is not a big deal.

The minus doesn't mean anything, really.

What is the connection between the characteristic and the moment? We can calculate moments from characteristic function.

$ phi'_x\(t\)frac(d, d t) phi_X\(t\) $

You have to prove this works, and then take the complex function, which is not that hard.

$ = bb(E)\[\(i X\)e^(i t X)\] $

It's kind of like you go inside and take the derivative as normal.

But if you take this

$ phi'_x\(0\)= i bb(E)\[X\] $

This becomes slightly more complicated, because you get the powers

$ phi''_x\(0\)= i^2 bb(E)\[X^2\] $

And this continues in general.

What is the advantage, why do we do this Fourier transform and not stick to the Laplace transform?

This Fourier transform always exists. And there is also an inverse Fourier transform. It is basically the same idea. You get a diffeq and a simpler equation, and then the inverse gives you the solution.

There is something more that exists here! That is #strong[discrete Fourier transform]. That is the big deal.

Generally speaking, you will run into the same problem. You get this horrible expression from the Fourier transform, and you can't get the pdf from it. Engineers have invented this approximation. You express the original function in terms of cosines and sines, and then you know the transforms and inverse transforms from there.

#link("https://engineering.purdue.edu/~mikedz/ee301/FourierTransformTable.pdf")[Table of Fourier Transform Pairs]

I had an argument a long time ago…

The whole point is, when you do a Fourier transform, you go into the frequency domain of your function. If your function is a sinus, you get one value. If you have a combination of sinuses, then you get a multitude of frequencies. The whole point of the DFT is that you express the function through the bases of sinuses.

#link("https://en.wikipedia.org/wiki/Discrete_Fourier_transform")[Discrete Fourier transform]

There's math here, but nobody actually uses it.

What we do instead, is that we call a package and say this is my function, calculate the DFT, put it into an equation, solve it, calculate IFT, and then just do it that way.

== Applications of Fourier Transform
<applications-of-fourier-transform>
Peter Carr was a guy at Bloomberg, and him and Ionut argued.

He said he was solving stochastic vol formula analytically, Ionut says this is not possible. Carr admits that it's just very fast.

This is used to solve the Heston model.

$ d S_t = S_t\(r d t + sqrt(V_t) d W_t\) $

$ d V_t = K\(theta - V_t\)d t + sigma sqrt(V_t) d Z_t $

$W$ and $Z$ can be correlated with $rho$.

Original Heston model is uncorrelated, there is an extension by Wiggins which is correlated.

The solution is not that complicated.

There is also something called the Feller condition.

In order for this Heston model to be nicely behaved (homogeneous), you should have

$ 2 K theta > sigma^2 $

The problem is, given this model for my stochastic process, which is actually quite realistic, we want to find the price of an option.

t is time now

S is stock price

K is strike price

T is time of maturity

r is risk free rate

NEW: V is the value of this variance process

$ C\(t\,S\,K\,T - t\,r\,V\) $

If you consider the other points observable, then this is a function of C(t, S, V)

We used to solve things as $ t in\[0\,T\] $, $ S in\(0\,i n f t y\) $, $ bb(V) in\(0\,oo\) $

Now we solve this equation with respect to three parameters.

Call option = $ bb(E)^Q\[e^(- r\(T - t\))\(S_T - K\)_(+)\|cal(F)_t\] $

This is the general formula.

You can write this as, by splitting into two different situations, when in the money and out of the money

$ = bb(E)^Q\[e^(- r\(T - t\))\(S_T - K\)_(+)bb(I)_({ S_T > K }) $

Where we disregard the out of the money part because it's worthless.

$ = bb(E)^Q\[e^(- r\(T - t\)) S_T bb(I)_({ S_T - K })\|cal(F)_t\]- K bb(E)^Q\[e^(- r\(T - t\)) bb(I)_({ S_T > K })\] $

Then we can take out the e term because it's just a number,

$ = e^(- r\(T - t\)) bb(E)\[S_T bb(I)_({ S_T - K })\|cal(F)_t\]+ K e^(- r\(T - t\)) dots.h $

Then this first term will be considered $P_1\(t\,S\,V\)$, and the second term is $P_2\(t\,S\,V\)$.

What he said is if you notice the very first property of the Fourier transform is that it is linear.

So both $P_1$ and $P_2$ must solve the Heston PDE.

Then let's apply the Fourier transform to the original Heston PDE.

This is more complicated than just going from t to x as before, because we have three variables. So we do:

$ hat(f)\(phi.alt\,x\,v\) $

So he postulated that

$ hat(f)\(phi.alt\,x\,v\)= e^(C\(tau\,phi.alt\)+ D\(tau\,phi.alt\)v + i phi.alt x) $

This has some theoretical reasoning, but he says that once you plug it in, there is a solution.

== Next Week
<next-week>
Estimating parameters, optimizations.
