/*
title = 'Random Variables and CDFs'
date = 2024-09-16
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Random Variables', 'CDFs']
*/

== Week 3
<week-3>
=== Reading - Random Variables Generalities (FT 3)
<reading---random-variables-generalities-ft-3>
==== Definition
<definition>
We can consider a mapping between all of the sets in the $sigma$-algebra of one measurable space $\(Omega\,cal(F)\)$ to another sample space $Omega_1$, where the mapping is measurable each set has a mapping. A #strong[random variable] is a measurable function $X : Omega arrow.r bb(R)$ where the target sample space is the Borel set. Random variables are capital letters and their values are lowercase letters.

The sum, product, or composition of measurable functions are measurable functions, so those are still random variables.

We consider the #emph[preimage] of $X$ to be $X^(- 1)\(A\)$, which is not precisely the inverse function. It's the set in the $sigma$-algebra in the input sample space which generated the set $A$.

==== Distribution
<distribution>
The distribution of a random variable is itself a random variable, denoted by $bb(P)_X = bb(P) compose X^(- 1)\(bb(R)\)$. This variable is defined on the Borel set as a probability on the measurable space. We can consider the probability space of the distribution to be $\(bb(R)\,bb(B)\(bb(R)\)\,bb(P) X\)$ i.e.~the sample space is all real numbers, the function mapping is the Borel subset (every interval and combination of such), and the distribution is the probability measure.

If we have a sequence of disjoint sets in the Borel subset of $bb(R)$, then the distribution of $X$ ($bb(P)\(X\)$) on the unions of those sequences is the same as the sum of the probability measure on each individual set.

We will consider the notation ${ X in A }$ to mean that there's an outcome $omega$ in sample space $Omega$ $X$ which maps to the set $A$ in $cal(B)\(bb(R)\)$

==== Cumulative Distribution Function
<cumulative-distribution-function>
Formally, the cdf of a random variable is $F\(x\)= bb(P)\({ omega : X\(omega\)lt.eq x }\)$ or the probability measure of the outcomes where the mapping to the real numbers is less than a specified number x.

This function has the properties that it is increasing, right continuous, and it approaches 0 and 1 from left and right, respectively.

The #strong[infinimum $inf$] is the largest element smaller than every element of a set (aka it's the element just to the left of the set in the order) and the #strong[supremum $sup$] is the element to the right.

If we consider the variable.

For every cdf that exists, there exists a random variable that has that cdf.

A #strong[Borel function] is a measurable function that maps from $bb(R)$ into $bb(R)$.

=== Lecture Notes
<lecture-notes>
==== CDF
<cdf>
$F : bb(R) arrow.r\[0\,1\]$ with $F\(x\):= P_X\(\(- oo\,x\]\)= P_X\(B\)$, where $B =\(- oo\,x\]$

These are equivalent ways of writing a cdf. This counts the accumulated probability less than or equal to x.

More interestingly, the cdf has these properties: increasing

The increasing property is fairly intuitive. Rigorously, you can show that for $y gt.eq x$, $\(- oo\,x\]subset.eq\(- oo\,y\]$. The interval from x to y must be 0 or greater, so then the cdf to y must be greater than the cdf to x.

You can also show that it's right continuous, proof is beyond the scope, involves monotone class

$lim_(h arrow.br 0) F\(x + h\)= F\(x\)$ for any x in the domain.

Let's examine the first quadrant of an equation. We have $x$ . If we imagine the difference between that and $x + h$, in a continuous function this is well-defined. But we might have a discontinuous function. This cannot be a cumulative distribution function. This is a complicated statement.

$lim_(x arrow.r - oo) F\(x\)= 0\,#h(2em) lim_(x arrow.r oo) F\(x\)= 1$

We can prove this by showing that

$lim_(x arrow.r - oo) F\(x\)= 0 = lim_(x arrow.r - oo) P_X\(\(- oo\,x\]\)= P_X\(nothing\)= 0$

Why is this empty set? Because if you have the interval $\(- oo\,oo\]$, left open interval says I don't have it, right says I do, because they conflict then there must be an empty set.

$lim_(x arrow.r oo) F\(x\)= 1 = P_X\(\(- oo\,oo\]\)= P_X\(bb(R)\)= 1$

This just becomes the probability measure of the sample space which is definitionally 1.

Most of the focus in this course will be calculation and not proof. But if you understand the proof, it will guide you in calculations.

Lemma 3.11: If we have $F\(X\)$ as the cdf, then

$bb(P)\(X gt.eq x\)= 1 - bb(P)\(X lt.eq x\)$

This is known as the survival function. If you survive over sixty years, then you get your retirement money. This assumes that $bb(P)\(X = x\)= 0$ which is true if $X$ is a continuous random variable.

Proof is ${ X > x } union { X lt.eq x } = bb(R) = Omega$

#strong[Important identity:]

$bb(P)\(x < X lt.eq y\)= F\(y\)- F\(x\)$

This proof comes from the set inequality: ${ X lt.eq x } union { x < X lt.eq y } = { X lt.eq y }$

And then if we take the probability measure of all of these then we see that the right side is the cdf of y, left side is cdf of x disjoint with the other part so you can add them by earlier definition

Also known

$bb(P)\(X = x\)= F\(x\)- F\(x -\)$ this is us taking the left limit where

$F\(x -\):= lim_(y arrow.tr x) F\(y\)= lim_(h arrow.br 0) F\(x - h\)$

consequences of this? If this $F\(x\)$ is left-continuous, it means that the limit is equal, which means this whole thing is equal to 0. However, it's not left-continuous, then $bb(P)\(X = x\)> 0$ strictly larger than 0. This looks like when the dot is on the right and the open circle is on the left. This is allowed, and it happens when $X$ is a discrete random variable. Binomial, Poisson, Geometric random variables are all discrete.

==== Numerical
<numerical>
Roll a die, probability that number is smaller than five. (strictly less than on an exam)

$bb(P)\(X < 5\)= bb(P)\(X lt.eq 4\)= F\(4\)= bb(P)\({ X = 1 } union { X = 2 } union { X = 3 } union { X = 4 }\)$

$= bb(P)\(X = 1\)+ bb(P)\(X = 2\)+ bb(P)\(X = 3\)+ bb(P)\(X = 4\)$

$= 1 / 6 + 1 / 6 + 1 / 6 + 1 / 6$

$= 2 / 3$

alternatively, I could do the same with 5 and 6 and use the 1 - property. Two random variables are independent if

$bb(P)\(X in A\,Y in B\)= bb(P)\(X in A\)times bb(P)\(Y in B\)$

or put another way

$= bb(P)\({ X in A } inter { Y in B }\)$

Intuitively, this means that the outcome of $X$ does not affect the outcome of $Y$.

For any $x\,y in bb(R)$, where $x\,y$ are independent

$bb(P)\(X lt.eq x\,Y lt.eq y\)= bb(P)\(X lt.eq x\)times bb(P)\(Y lt.eq y\)$

are mutually independent if

$bb(P) (inter.big_(i = 1)^n { x_i in B_i }) = product_(i = 1)^n bb(P)\(X_i in B_i\)$

They are also pairwise independent in this case.

For an arbitrary family of random variables where we have some index set $I$ for $X_i$, they are mutually independent if every finite subfamily is independent. That means any finite subset of the indices will cause this to be the case. This is not very useful as a way to prove independence because there are so many cases to prove, this is just a definition.

Let's say we roll a fair die twice and we have $X$ represent the maximum of both rolls. The first question we're interested in calculating the image of $Omega$ through $X$ and the distribution of $X$.

$Omega = {omega = \( j_1 \, j_2 \) \, j_1 \, j_2 in { 1 \, 2 \, 3 \, 4 \, 5 \, 6 }}$

total of 36 elements

the probability of observing any particular outcome is $1 / 36$ because it's fair. This $X$ is clearly a mapping from the sample space to the set of six numbers. If we calculate probabilities:

$bb(P)\(X = 1\)= bb(P)_X\(omega =\(1\,1\)\)= 1 / 36$

$bb(P)\(X = 2\)= bb(P)_X\(omega =\(1\,2\)\)+ bb(P)_X\(omega =\(2\,1\)\)+ bb(P)_X\(omega =\(2\,2\)\)= 3 / 36$

$bb(P)\(X = 3\)= bb(P) (union.big_(k = 1)^3 { omega = \( 3 \, k } union union.big_(k = 1)^2 { omega = \( k \, 3 \) }) = 5 / 36$

This is 3 then 2 because you don't want to double count the same number.

$bb(P)\(X = 4\)= bb(P) (union.big_(k = 1)^4 { omega = \( 4 \, k } union union.big_(k = 1)^3 { omega = \( k \, 4 \) }) = 7 / 36$

$bb(P)\(X = 5\)= bb(P) (union.big_(k = 1)^5 { omega = \( 5 \, k } union union.big_(k = 1)^4 { omega = \( k \, 5 \) }) = 9 / 36$

$bb(P)\(X = 6\)= bb(P) (union.big_(k = 1)^6 { omega = \( 6 \, k } union union.big_(k = 1)^5 { omega = \( k \, 6 \) }) = 11 / 36$

Now let's get the cdf $F\(X\)$. Let's consider each instance of $F\(b\)= bb(P)\(X lt.eq b\)$

Obviously, this has to be 0 for less than 1 because that's not an outcome. For the rest of them, you add up the probabilities (because they're disjoint).

Another example.

You are given

$bb(P)\(0 lt.eq X lt.eq 1\)= 8 / 12$

$bb(P)\(0 lt.eq X lt.eq 2\)= 7 / 12$

$bb(P)\(0 lt.eq X lt.eq 3\)= 10 / 12$

$bb(P)\(X = 3\)= bb(P)\(X gt.eq 4\)$

We want to know the probability for up to 3.

We can solve for $bb(P)\(X = 0\)= 3 / 12$

We also want to show this inequality $X\(omega\)lt.eq Y\(omega\)\,forall omega in Omega$

You want to show that $F_X\(a\)gt.eq F_Y\(a\)\,a in bb(R)$

Hint: $F\(X\(a\)= bb(P)\(X lt.eq a\)? bb(P)\(y lt.eq a\)= F_Y\(a\)$

More interesting example 3.4

cdf

you have to find the conditions on a, b, c, d, that $F$ satisfies the properties of a cdf.

We have the property

$lim_(x arrow.r oo) F\(x\)= 1 = d$

Because that's if $t gt.eq 3$.

a gives you the same solution of 0.
