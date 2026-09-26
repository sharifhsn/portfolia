/*
title = 'Exotic Options'
date = 2024-12-12
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Exotic Options', 'Barrier Options']
*/

=== Lecture Notes
<lecture-notes>
==== Exotic Options
<exotic-options>
This is the last lecture we have for this class. Next week will be a review session.

Exam will be #strong[online]. December 21,

We're going to be pricing exotic options. We are focusing on two types.

==== Barrier Options
<barrier-options>
Barrier options can be in vs out.

Let's say we have a stock process that starts at $S_0$ and evolves, where we generate a path via Brownian motion. In the past, we have only been concerned with the strike price, which is the line that determines whether an option will be exercised. We're going to institute a new variable $B$. The relationship of the barrier is to the stock price is governed by up vs down. If the barrier is lower, it's down. And whether it's a knock in instrument, then your option starts worthless. It will remain worthless unless your stock #strong[touches] the barrier. Then it could potentially be exercised at time of maturity. But it's worthless until it's out. That's Frankestien's monster that comes alive.

Down and out would be a normal person and an electric fence. You walk into it and you die.

==== Lookback Options
<lookback-options>
Lookback options look at the largest price in the lifetime subtracted by the smallest price in the lifetime. This is always going to be exercised, although it might not be worth anything. In a sense, there is no optionality present, although the value is the same as that of an option.

We're going to need to do a little bit more background math.

We're going to be really interested in the maximum our stock price achieves, for both barrier and lookback options.

For a BM W(t), define $M\(t\)= max_(0 lt.eq u med l e q t) W\(u\)$

The joint distribution of a Brownian motion and its maximum is

$f_(M\(t\)\,W\(t\))\(m\,w\)= frac(2\(Z m - w\), t sqrt(2 pi t)) e^(- frac(1, 2 t)\(2 m - w\)^2)$

We have a lot of tools in our toolbox which allows us to get the individual distribution of the maximum.

It's not going to be done by integrating through W.

I'm going to define two new processes.

We need to come up with these distribituions

As a point of consideration:

If I wanted to look at the maximum value of my stock price, knowing that my stock price grows via

$S\(t\)= S\(0\)exp {\( alpha - sigma^2 / 2 \) t + sigma W \( t \)}$

achieves its maximum for

$max_(0 lt.eq mu lt.eq t)$ This may not be the same as when the Brownian motion is largest. So we need more work! How to get the maximum of a Brownian motion with dirft. And that's the point of creating this $hat(W)$ which incorporates the drift term.

The risk-neutral probability measure

$hat(W) = tilde(W)\(t\)+ alpha t$

That would be thai Brownian motion with drift

I could also write this as

$= tilde(W)\(t\)+ integral_0^t alpha d u$

If I was to create a process $accent(T h e t a, ̃)\(u\)= alpha$, wouldn't this now be

$= tilde(W)\(t\)+ integral_0^t tilde(Theta)\(u\)d u$

And that is the Girsanov process!

If I define my Radon Nikodym derivative

$tilde(Z)\(t\)= exp {- integral_0^t tilde(Theta) \( u \) d tilde(W) \( u \) - 1 / 2 integral_0^t tilde(Theta)^2 \( u \) d u}$

I would get

$= e^(- alpha tilde(W)\(t\)- 1 / 2 alpha^2 t)$

Using $hat(W)$ here

The source note switches notation to $hat(W)$ here without recording the complete expression.

Under $hat(bb(P))$, $hat(W)\(t\)$ is a Brownian motion.

So I know that they have the joint distribution with a closed form.

So how do we go from risk-neutral distribution to normal?

Lemma 5.2.1 says

$tilde(bb(E))\[Y\]= bb(E)\[Y Z\(t\)\]$

This also implies

$hat(bb(E))\[Y\]= tilde(bb(E))\[Y tilde(Z)\(t\)\]$

Then under my risk-neutral probability measure,

something something lemma 5.2.5

Markovs,

martingales,

geometric Brownian motion,

it's all in the lookback option.

The only time you get speed and accuracy is with the closed-form solution.

Final homework is due in a few days.

Make sure you look over all of the material.

You can go to the review session at the ENGAGE on Monday night.

Whatever questions you have are answered on Monday and Thursday.
