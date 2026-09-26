/*
title = 'Risk-Neutral Measures'
date = 2024-11-07
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Risk-Neutral Pricing', 'Girsanov']
*/

=== Lecture Notes
<lecture-notes>
==== Motivation - Sports Betting
<motivation---sports-betting>
Let's go into the world of sports gambling. Hypothetically, we're going to have two teams competing, Team A and Team B. Objectively, Team A is the better team. Let's say in the real world odds, they are 4:1, meaning that Team A is 4x as likely to win as Team B. That means that

$bb(P)\(upright("Team A wins")\)= 4 / 5$

$bb(P)\(upright("Team B wins")\)= 1 / 5$

If I use these odds for betting, let's say I have a \$10 stake on Team A. If Team A wins, I will receive my original stake + a quarter of the original stake, or \$12.50. If I bet on Team B, then if Team B wins, I will receive the original stake + four times the original stake, or \$50.

A bookie is collecting bets. He rounds up 40 people to bet on the game. Half bet on Team A, and half bet on Team B. Assuming that the stake is \$10, they have collected \$400.

If Team A wins, then the \$400 collected will be paid out to the 20 individuals for the value they should get

$400 - 20 times\$12.50 =\$150$

The bookie will make \$150 if A wins. If B wins, then

$400 - 20 times\$50 = -\$600$ The bookie will lose \$650 if B wins.

Let this amount be $X$. What is $bb(E)\[X\]$?

$bb(E)\[X\]= 4 / 5\(\$150\)+ 1 / 5\(-\$600\)$

$= 0$ This would be what would happen if the bookie was doing this out of the goodness of their heart. What if they took 1% of the winnings (still generous)? That's calculated out of the winnings, so 50 cents for A winning, and \$8 for B winning.

This is in expectation. What if B wins four games in a row? You're out \$4000, minus this small amount.

The bookie is much more likely to notice that A and B are equally bet. They don't care about who wins, just how people are betting. People are betting evenly on the two teams. So if the bookie gives 1:1 odds instead of 4:1, the new numbers are:

if A wins, the bettor receives \$10 + \$10(1/1) = \$20. And the same for B.

If A wins,

$400 - 20\(20\)= 0$

And the same for B, so expected value is 0. But if we take a little off the top, which is calculated off the difference between total received and original stake for each person and then scaled to the number of people.

The preferred approach for bookies is to do this because this way, you'll always make money.

This is the motivation for risk-neutral pricing.

==== Risk-Neutral Measure
<risk-neutral-measure>
We are going to define a new $tilde(bb(P))$ which is a probability measure defined as

$tilde(bb(P))\(A\)= integral_A Z\(omega\)d bb(P)\(omega\)$

on the original probability space, where $Z$ is a nonnegative random variable.

In order for this to be a valid probability measure, we have to define

$tilde(bb(P))\(Omega\)= integral_Omega Z\(omega\)d bb(P)\(omega\)= bb(E)\[Z\]= 1$

I could have two probability measures on a fair coin and unfair coin.

For every random variable $Z$ that satisfies these properties, we can use this to define a new probability measure on the same event space ($Omega$) and sample space ($cal(F)$).

The expectation under the new probability measure is the same as multiplying with Z

$tilde(bb(E))\[X\]= bb(E)\[X Z\]$

==== Equivalent Measures
<equivalent-measures>
What's of particular importance is that we are going to have equivalent probability measures.

When you create this random variable Z, you can create any probability measure. But it might not be equivalent. Let's draw a distinction between identical and equivalent probability measures.

If for all $omega in Omega$

$bb(P)\(omega\)= tilde(bb(P))\(omega\)$

then these are #emph[identical] probability measures.

If for any set $A in cal(F)$ such that $bb(P)\(A\)= 0 arrow.r tilde(bb(P))\(A\)= 0$

and if for any set $A in cal(F)$, $tilde(bb(P))\(A\)= 0 arrow.r bb(P)\(A\)= 0$

Equivalence means that they agree on what can't happen, they agree on what has measure 0. We care about this when we start pricing instruments. Under real world probability measurements, it's impossible for a stock to triple in five days, we can't have that happen in our risk-neutral artificial world.

We can then define

$Z = frac(d tilde(bb(P)), d bb(P))$

Using this #strong[Radon-Nikodym derivative], we can confirm these results from earlier. For $X$ nonnegative RV, then

$tilde(bb(E))\[X\]= integral_Omega X\(omega\)d tilde(bb(P))\(omega\)$

This is the more theoretical construct where $omega$ could be anything. Because we're not going to just get numerical values, it's hard to write a numerical representation of that space. IF we're dealing with the real number line, this becomes

$integral_(- oo)^oo X f_X\(x\)d x$

To deal with this expected value, I will multiply it by

$frac(d bb(P)\(omega\), d bb(P)\(omega\))$

which becomes

$= integral_Omega X\(omega\)Z\(omega\)d bb(P)\(omega\)$

which simplifies to

$= bb(E)\[X Z\]$

which we are trying to prove.

==== Adapted Stochastic Process
<adapted-stochastic-process>
$Z\(t\)= bb(E)\[Z\|cal(F)\(t\)\]$

This is an adapted stochastic process because it depends on information at time t.

What is

$Z\(0\)= ?$

It would just be 1 because there's nothing to condition on so it's just the expectation.

What about if it's at time T, maturity? Then Z is measurable with respect to all that information, which is Z, the Radon-Nikodym derivative.

So $Z\(t\)$ is a stochastic process that begins at 1 and goes to the Radon-Nikodym derivative.

Is it a martingale? We can use iterated conditioning to figure out that #emph[yes], it is.

What if we add another RV into the mix? $bb(E)\[Y Z\(t\)\]= bb(E)\[Y bb(E)\[Z\|cal(F)\(t\)\]\|cal(F)\(0\)\]$

What do I know about Y? It's measurable with respect to $cal(F)\(t\)$, so we can put what's known back in, in the same way we can take it out.

$= bb(E)\[bb(E)\[Y Z\|cal(F)\(t\)\]\|cal(F)\(0\)\]$

Iterated conditioning shows that this is

$= bb(E)\[Y Z\]$

Side note: why are we doing this? In math, you have theorems, corollaries and lemmas. Theorems are widely used, versatile and powerful results. Corollaries are results proved using just one theorem. Lemmas are little disposable proofs that are used to prove one thing that you will use somewhere later. Sometimes these lemmas become famous, like Ito's lemma. We are building towards Girsanov.

The partial averaging theorem states

$integral_A bb(E)\[X\|cal(G)\]\(omega\)d bb(P)\(omega\)= integral_A X\(omega\)d bb(P)\(omega\)$

For the problem we're looking at, this will become

$integral_A Y\(omega\)d tilde(bb(P))\(omega\)= integral_A tilde(bb(E))\[Y\|cal(F)\(t\)\]\(omega\)d tilde(bb(P))\(omega\)$

What this theorem is telling me that I want to prove that the expectation of Y conditioned on information up to s is all that.

If I can confirm this is true, then I can prove this lemma.

If I'm integrating the left hand expression, it should be the same as the right hand expression.

We're going to disassemble the toaster and then fix the broken wire inside, then reassemble the toaster.

Rewrite

$integral_A frac(1, Z\(s\)) bb(E)\[Y Z\(t\)\|cal(F)\(s\)\]d tilde(bb(P))\(omega\)$

as

$integral_Omega frac(1, Z\(s\)) bb(E)\[Y Z\(t\)\|cal(F)\(s\)\]bb(I)_({ A }) d tilde(bb(P))\(omega\)$

And that's the definition of the expected value, and we can bring indicator inside because it's nonrandom

$= tilde(bb(E)) [frac(1, Z\(s\)) bb(E) \[ bb(I)_({ A }) Y Z \( t \) \| cal(F) \( s \) \]]$

We can use the lemma about the transformation of expectation into a different expectation using Z.

$tilde(bb(E))\[X\]= bb(E)\[X Z\(s\)\]$

To get that

$= bb(E) [bb(E) \[ bb(I)_({ A }) Y Z \( t \) \| cal(F) \( s \) \]]$

We did all that to take out the tilde. So we can use iterated conditioning to get

$= bb(E)\[bb(I)_({ A }) Y Z\(t\)\]$

$= tilde(bb(E))\[bb(I)_({ A }) Y\]$ Which we can work backwards to prove the original.

Let $X\(t\)$ an Ito process.

$X\(t\)= X\(0\)+ integral_0^t Delta\(u\)d W\(u\)+ integral_0^t Theta\(u\)d u$

Let's discuss the conditions for when an Ito process is a martingale.

$bb(E)\[X\(t\)\|cal(F)\(s\)\]= bb(E) [X \( 0 \) + integral_0^t Delta \( u \) d W \( u \) + integral_0^t Theta \( u \) d u \| cal(F) \( s \)]$

We know that an Ito integral with respect to a martingale is a martingale. I know that the expected value of it will be 0. But the conditioned expectation up until time s will be that integral. We have the result for the stochastic part, but not the Riemann part.

$= X\(0\)+ integral_0^s Delta\(u\)d W\(u\)+ bb(E) [integral_0^t Theta \( u \) d u \| cal(F) \( s \)]$

Let's rewrite that as a combination of integrals

$= X\(0\)+ integral_0^s Delta\(u\)d W\(u\)+ bb(E) [integral_0^s Theta \( u \) d u + integral_s^t Theta \( u \) d u \| cal(F) \( s \)]$

And I know that the s part is known.

$= X\(0\)+ integral_0^s Delta\(u\)d W\(u\)+ integral_0^s Theta\(u\)d u + bb(E) [integral_s^t Theta \( u \) d u \| cal(F) \( s \)]$

which we can finally rewrite, using our original, as

$= X\(s\)+ bb(E) [integral_s^t Theta \( u \) d u \| cal(F) \( s \)]$

I can't adjust this in any way. But we want to know whether it's a martingale. So in order for us to conclude this, then that last term has to be 0. Are there restrictions that we can place on $Theta\(u\)$ to make sure that this is a martingale regardless of s and t? It has to always be 0. So we can get rid of it.

$X\(t\)= X\(0\)+ integral_0^t Delta\(u\)d W\(u\)$

and

$d X\(t\)= Delta\(t\)d W\(t\)$ We stumbled over another way to get a martingale. If we take the differential of our process and there's dt terms, then it can't be a martingale because $Theta\(t\)$ is not 0.

==== Girsanov
<girsanov>
The Big One.

What this theorem states, is that if I start with a Brownian motion, and some adapted process $Theta\(t\)$ that is square integrable. Using #emph[any], we can define a new Z(t)

$Z\(t\)= exp (- integral_0^t Theta \( u \) d W \( u \) - 1 / 2 integral_0^t Theta^2 \( u \) d u)$

And define a new stochastic process which is the Brownian motion plus the integral of the process

$tilde(W)\(t\)= W\(t\)+ integral_0^t Theta\(u\)d u$

Then that stochastic process is a Brownian motion.

And this is all for the goal of finding risk-neutral probability measures.

First, let's prove that the expected value of Z is 1.

$Z\(t\)= exp (- integral_0^t Theta \( u \) d W \( u \) - 1 / 2 integral_0^t Theta^2 \( u \) d u)$

Let's find the differential to see if it's a martingale.

$d Z\(t\)= Z\(t\)d Y\(t\)+ 1 / 2 Z\(t\)\(d Y\(t\)\)^2$

$= - Z\(t\)Theta\(t\)d W\(t\)- 1 / 2 Z\(t\)Theta^2\(t\)d t + 1 / 2 Z\(t\)Theta^2\(t\)d t$

$= - Z\(t\)Theta\(t\)d W\(t\)$

Because all of the dt combinations cancel out, this is a martingale.

We will use the Lévy theorem to prove that $tilde(W)\(t\)$ is a Brownian motion. It needs to be a martingale, continuous paths, starts at 0, and quadratic variation is t.

The only one of these should change because of a probability measure. So we only need to show that Brownian motion is a martingale.

Now we can finally use the partial averaging proof

$tilde(bb(E))\[tilde(W)\(t\)\|cal(F)\(s\)\]= frac(1, Z\(s\)) bb(E)\[tilde(W)\(t\)Z\(t\)\|cal(F)\(s\)\]$

This is the direct result of that lemma. The only thing standing in our way to finishing this proof is establishing that this is a martingale under $bb(P)$.

Is $tilde(W)\(t\)Z\(t\)$ a $bb(P)$-martingale? What's the differential? By the product rule, it's

$d\(tilde(W)\(t\)Z\(t\)\)= tilde(W)\(t\)d Z\(t\)+ Z\(t\)d tilde(W)\(t\)+ d tilde(W)\(t\)d Z\(t\)$

Well we already proved this result for the various differentials, so it's

$= - tilde(W)\(t\)Theta\(t\)Z\(t\)d W\(t\)+ Z\(t\)d W\(t\)+ Z\(t\)Theta\(t\)d t +\(d W\(t\)+ Theta\(t\)d t\)\(- Theta\(t\)Z\(t\)d W\(t\)\)$

That last term gets multiplied out, dt \* anything is 0, becomes the negative to that third term, so we only get dW(t), so it's a martingale.

This completes our proof.

==== Discount Process
<discount-process>
