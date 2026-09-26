/*
title = 'Gamma, Beta, and Chi-Squared Distributions'
date = 2024-10-21
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Gamma Distribution', 'Beta Distribution']
*/

== Week 8
<week-8>
=== Lecture Notes
<lecture-notes>
==== Chi-Squared
<chi-squared>
Definition 5.36 says that X is a Chi squared distribution whose pdf is described by

$f\(x\)= frac(1, 2^(n\/2) Gamma\(n / 2\)) x^(n / 2 - 1) e^(- x / 2)$

where $X tilde.op X_n^2$

This is actually linked to the gamma distribution

$X tilde.op X_n^2$, then $X tilde.op Gamma\(n / 2\,1 / 2\)$

There is also a remark which says that the gamma distribution has an additive property. And if you inverse a gamma distribution, you get the inverse gamma distribution.

==== Beta Distribution
<beta-distribution>
Described by 5.4.5

Gamma distribution is defined under the gamma function. We will need a two variable beta function. The intermediate function is defined as

$upright(B)\(a\,b\):= integral_0^1 x^(a - 1)\(1 - x\)^(b - 1)thin d x$

The integral is univariate. There's an apparent symmetry. If we do a change of variable of $y = 1 - x$ then

$upright(B)\(b\,a\)= integral_0^1 x^(b - 1) y^(a - 1) thin d x$

and

$= integral_1^0\(1 - y\)^(b - 1)y^(a - 1)\(- d y\)$

Which when you cancel out the negative, they end up being equal. And in fact it can be shown that

$upright(B)\(a\,b\)= upright(B)\(b\,a\)$

and a more useful result proposition 5.39, which is that

$upright(B)\(a\,b\)= frac(Gamma\(a\)Gamma\(b\), Gamma\(a + b\))$

this will be very useful later. Proving this is very tedious calculus.

We can now introduce the beta distribution through definition 5.40. If $x$ has the following pdf

$f_(a\,b)\(x\)= frac(x^(a - 1)\(1 - x\)^(b - a), upright(B)\(a\,b\)) I_(\[0\,1\])\(x\)$

then it's in the beta distribution.

Proposition 5.41 says that the integral is 1.

Proposition 5.42 tells us the expected value and variance.

$bb(E)\[X\]= frac(a, a + b)$

$bb(V)\[X\]= frac(a b, \(a + b\)^2\(a + b + 1\))$ To prove this, we take the definition of the expectation

$bb(E)\[X\]= integral_0^1 x f_(a\,b)\(x\)d x$

$= frac(1, upright(B)\(a\,b\)) integral_0^1 x^a\(1 - x\)^(b - 1)thin d x$

We can then adjust the $a$ to make it agree with the beta function

$= frac(upright(B)\(a + 1\,b\), upright(B)\(a\,b\))$

Now I can adjust it to be the gamma function instead.

$= frac(Gamma\(a + b\), Gamma\(a\)Gamma\(b\)) dot.op frac(Gamma\(a + 1\)Gamma\(b\), Gamma\(a + b + 1\))$

We can cancel out some things, and then utilize the property of the gamma function that $Gamma\(n + 1\)= n Gamma\(n\)$

$frac(a, a + b)$

Then for variance, skipping some steps, we can show that

$bb(E)\[X^2\]= frac(1, upright(B)\(a\,b\)) integral_0^1 x^(a + 1)\(1 - x\)^(b - 1)thin d x$

Using a similar method, we can rewrite this as

$= frac(upright(B)\(a + 2\,b\), upright(B)\(a\,b\))$

Now we have from gamma

$= frac(Gamma\(a + 2\)Gamma\(b\), Gamma\(a + b + 2\)) dot.op frac(Gamma\(a + b\), Gamma\(a\)Gamma\(b\))$

canceling and substituting with our values, it's

$= frac(\(a + 1\)a, \(a + b + 1\)\(a + b\))$

Then to calculate variance, we get

$= frac(\(a + 1\)a, \(a + b + 1\)\(a + b\)) - frac(a^2, \(a + b\)^2)$

which will simplify into our answer
