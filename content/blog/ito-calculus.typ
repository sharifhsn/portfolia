/*
title = 'Itô Calculus'
date = 2024-10-10
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Ito Lemma', 'Geometric Brownian Motion']
*/

== Week 5
<week-5>
=== Lecture Notes
<lecture-notes>
==== Baby's First Stochastic Integral
<babys-first-stochastic-integral>
This is seemingly one of the simplest integrals you could do.

$integral_0^t W\(u\)d W\(u\)$

If we're going to do this integral, how we're going to do that is to create a process $Delta_n\(u\)arrow.r W\(u\)$ that converges so that this integral equals

$= lim_(n arrow.r oo) integral_0^t Delta_n\(u\)d W\(u\)$

We essentially want this integral to converge to the integral of a Brownian motion.

We're going to define

We're going to assume wer'e cutting up our timespan $\[0\,t\]$ into $n$ equal sized pieces.

What we're doing here is that if we have this path of a Brownian motion, we will create time partitions where we are cutting it up into equal spaces. And our process takes the value of the motion at time 0 until time 1, then resets to time 1, then time 2, so it turns it into a random walk. As $n$ gets larger and larger, this converges to Brownian motion pointwise, no place for discontinuities to hide.

I can now express this integral as

The widths come from the change in Brownian motion.

We'll denote $W_j = W (frac(j t, n))$ for convenience, so this becomes

$= sum_(j = 0)^(n - 1) W_j\(W_(j + 1) - W_j\)$

We're going to look at the expansion of this squaredd

$1 / 2 sum_(j = 0)^(n - 1)\(W_(j + 1) - W_j\)^2= 1 / 2 sum_(j = 0)^(n - 1) W_(j + 1)^2 - sum_(j = 0)^(n - 1) W_j W_(j + 1) + 1 / 2 sum_(j = 0)^(n - 1) W_j^2$

The 1/2 will become relevant later

Now, first thing I'm going to observe is that I could take this first term and rewrite it as

$sum_(k = 1)^n W_k^2$

I'm doing a reindex and starting at $k$. What would this be when $k = 0$? 0. So this will be the same thing as

$= sum_(k = 0)^n W_k^2 = W_n^2 + sum_(j = 0)^(N - 1) W_j^2$

The expansion of this is

$= 1 / 2 W_n^2 + sum_(j = 0)^(n - 1)\(W_j^2 - W_j W_(j + 1)\)$

Well, this is

$= 1 / 2 W_n^2 + sum_(j = 0)^(n - 1) W_j\(W_j - W_(j + 1)\)$

This term here is very close to where we left off in the original expansion. I can move this to the other side, which takes out the -1, which makes them correspond.

We have just proven that

$sum_(j = 0)^(n - 1) W_j\(W_(j + 1) - W_j\)= 1 / 2 W_n^2 - 1 / 2 sum_(j = 0)^(n - 1)\(W_(j + 1) - W_j\)^2$

After substituting that back in, I now have that

$integral_0^t W\(u\)d W\(u\)= lim_(n arrow.r oo) (1 / 2 W_n^2 - 1 / 2 sum_(j = 0)^(n - 1) \( W_(j + 1) - W_j \)^2)$

What is $W_n$?

This doesn't depend on $n$. If you look very carefully at the summation of the difference of squares, that's quadratic variation, so $t$

$= 1 / 2 W^2\(t\)- t / 2$

The quadratic variation is the precise property which makes stochastic integral different

This is the correct answer if we use the left-hand endpoints i.e.~if this is an adaptive process.

Right hand endpoint also

Stratonyvich integral if we use midpoint, so that's intuitive. Why don't we use it? It's not adaptive/measurable, it requires you to evaluate the value of the expression halfway through the integral. That would be the equivalent of choosing your trading position at the middle of the day for the entire day. That's impossible. So we have to use Ito integrals.

==== Differential Form
<differential-form>
If we were dealing with regular calculus, and you asked me to find the differential of a function, I would look at it and use the chain rule. But Brownian motion isn't differentiable.

$d f\(W\(t\)\)= f'\(W\(t\)\)W'\(t\)d t = f'\(W\(t\)\)d W\(t\)$

We're still not going to have it correct because of quadratic variation. We actually have

$d f\(W\(t\)\)= f'\(W\(t\)\)d W\(t\)+ 1 / 2 f''\(W\(t\)\)d t$

If we look at the integral form and we look at both sides,

By the theorem of calculus, integral of differential should be difference between bounds. So we must prove this.

We're going to use the Taylor series to come up with some expansions. This is going to be

$f\(x\)= sum_(k = 0)^oo frac(f^(\(k\))\(a\)\(x - a\)^k, k !)$

writing out the first few terms, this is

$= f\(a\)+ f'\(a\)\(x - 1\)+ 1 / 2 f''\(a\)\(x - a\)^2+ 1 / 6 f'''\(a\)\(x - a\)^3dots.h$

So, I have that $f\(x\)- f\(a\)$ equals all of this stuff

This is true for any function that we can do the Taylor approximation on. We're going to keep this in mind and then I want to talk about #strong[telescoping sums]. For a sequence ${ X_i }_(i in { 1\,dots.h\,n })$ what can you tell me about this/

$sum_(i = 0)^(n - 1)\(X_(i + 1) - X_i\)= X_1 - X_0 + X_2 - X_1 + X_3 - X_2 + dots.h + X_(n - 1) - X_(n - 2) + X_n - X_(n - 1)$

Well this is going to cancel out in between so we end up just getting the difference between the endpoints.

$= X_n - X_0$

We now have most of our pieces.

I'm going to say that for a given partition $Pi$, I'm going to let $x = W\(t_(j + 1)\)$, $a = W\(t_j\)$. I'm going to rewrite this Taylro series expansions with these variables. I now have

$f\(W\(t_(j + 1)\)\)- f\(W\(t_j\)\)= f'\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)+ 1 / 2 f''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^2+ 1 / 6 f'''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^3+ dots.h$

Then, I am now going to take (and remember, if I can do it to both sides I can do anything) I am going to add both of these sides up

$sum_(j = 0)^(n - 1) (f \( W \( t_(j + 1) \) \) - f \( W \( t_j \) \)) = sum_(j = 0)^(n - 1) (f' \( W \( t_j \) \) \( W \( t_(j + 1) \) - W \( t_j \) \) + 1 / 2 f'' \( W \( t_j \) \) \( W \( t_(j + 1) \) - W \( t_j \) \)^2 + 1 / 6 f''' \( W \( t_j \) \) \( W \( t_(j + 1) \) - W \( t_j \) \)^3 + dots.h)$

The left is just our telescoping summation. We have various summations on the other side.

$f\(W\(t\)\)- f\(W\(0\)\)= sum_(j = 0)^(n - 1) f'\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)+ 1 / 2 sum_(j = 0)^(n - 1) f''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^2+ 1 / 6 sum_(j = 0)^(n - 1) f''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^3+ dots.h$

Because this is for an arbitrary partition, let's look at the limit as the norm of partition goes to 0. Nothing happens on the left side, because there's no index involved there. So we'll leave it untouched.

$f\(W\(t\)\)- f\(W\(0\)\)= lim_(parallel Pi parallel arrow.r 0) sum_(j = 0)^(n - 1) f'\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)+ 1 / 2 lim_(parallel Pi parallel arrow.r 0) sum_(j = 0)^(n - 1) f''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^2+ lim_(parallel Pi parallel arrow.r 0) 1 / 6 sum_(j = 0)^(n - 1) f''\(W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)^3+ dots.h$

We're writing this all down because we will need to refer back to this later! Now, let's look and see how this limit affects this. As we're dealing with the limit of the norm of this partition going to 0, this change in Brownian motion is going to converge to $d W\(u\)$ the differential. That is the definition of the differential. That means that this term inside the exponent is just the differential. So we get the first term as $d W\(u\)$, then the second term as $d u$ because that's what we determined. And after we multiply it one more time, it will be 0, because that's also proven. So we can throw out all terms after the second order. This gives us one Ito integral and one Riemann integral. What we have here is

$= integral_0^t f'\(W\(u\)\)d W\(u\)+ 1 / 2 integral_0^t f''\(W\(u\)\)d u$ At this point, everybody should know that the 1/2 appears because of the Taylor expansion. Everybody makes the mistake and forgets it, so you need to be extra vigilant on homework and tests for this.

==== Ito Formula
<ito-formula>
That leads us to being able to prove Theorem 4.4.1 the Ito formula for Brownian motion:

Let $f\(t\,x\)$ be a function for which the partial derivatives etc.

$f\(T\,W\(T\)\)= f\(0\,W\(0\)\)dots.h$

I would strongly suggest that you use a different form of the Ito formula.

$f\(a\,b\)$ is some function such that $f_a$, $f_b$, and $f_(b b b b)$ exist.

$f\(t\,W\(t\)\)= f\(0\,W\(0\)\)+ integral_0^t f_a\(u\,W\(u\)\)d u + integral_0^t f_b\(u\,W\(u\)\)d W\(u\)+ 1 / 2 integral_0^t f_(b b)\(u\,W\(u\)\)d\[W\,W\]d u$

This lets us remember where all the pieces are coming from. We can see that $f$ is only considered with respect to these dummy variables.

Where does this formula come from? The two dimensional Taylor series expansion!

For some function, centered around the point $\(a_0\,b_0\)$

$f\(a\,b\)- f\(a_0\,b_0\)= f_a\(a_0\,b_0\)\(a - a_0\)+ f_b\(a_0\,b_0\)\(b - b_0\)$

These are all the first order derivatives. Then we get

$+ 1 / 2 f_(a a)\(a_0\,b_0\)\(a - a_0\)^2+ 1 / 2 f_(a b)\(a_0\,b_0\)\(a - a_0\)\(b - b_0\)+ 1 / 2 f_(b a)\(a_0\,b_0\)\(b - b_0\)\(a - a_0\)+ 1 / 2 f_(b b)\(a_0\,b_0\)\(b - b_0\)^2+ 1 / 6 + dots.h$

into the second and third order and so on.

We will let $a_0 = t_j$, $a = t_(j + 1)$, $b_0 = W\(t_j\)$, $b = W\(t_(j + 1)\)$

We're going to do the same sum to telescoping sum trick here.

$f\(t\,W\(t\)\)- f\(0\,0\)= sum_(j = 0)^(n - 1) f_a\(t_j\,W\(t_j\)\)\(t_(j + 1) - t_j\)+ sum_(j = 0)^(n - 1) f_b\(t_j\,W\(t_j\)\)\(W\(t_(j + 1)\)- W\(t_j\)\)+ 1 / 2 sum_(j = 0)^(n - 1) f_(a a)\(t_j\,W\(t_j\)\)\(t_(j + 1) - t_j\)^2+ sum_(j = 0)^(n - 1) f_(a b)\(t_j\,W\(t_j\)\)\(t_(j + 1) - t_j\)\(W\(t_(j + 1) - W\(t_j\)\)+ 1 / 2 sum_(j = 0)^(n - 1) f_(b b)\(t_j\,W\(t_j\)\)\(t_(j + 1) - t_j\)\(W\(t_(j + 1)\)- W\(t_j\)\)$

assume that fab and fba are the same

The differential notation makes the limit transparent: $d u$ is first-order time, $d W\(u\)$ is the Brownian increment, $d u$ times any differential is 0, and $\(d W\(u\)\)^2= d u$ through quadratic variation. The only nonzero second-order term is therefore the quadratic-variation term. That is how we get the Itô formula.

Using this formula, we can now try and solve a simple exercise. The only stochastic part of the Ito formula is in the $f_b$ part. So let's try and move everything to the other side of the expression.

$integral_0^t f_b\(u\,W\(u\)\)d W\(u\)= f\(t\,W\(t\)\)- f\(0\,W\(0\)\)- integral_0^t f_a\(u\,W\(u\)\)d u - 1 / 2 integral_0^t f_(b b)\(u\,W\(u\)\)d u$

So, if I was given the problem, what is

$integral_0^t W\(u\)d W\(u\)$

That seems to suggest that

$f_b\(u\,W\(u\)\)= W\(u\)$

What would be $f_b\(a\,b\)$? I don't want to work with my functions with stochastic crap, I want to use well-defined dummy variables?

$f_b\(a\,b\)= b$

If I do this substitution, then this is what i results in.

Then what is

$f_(b b)\(a\,b\)$? 1.

I am going to do this the hardest possible way right now, to demonstrate how it's done.

$f\(a\,b\)= b^2 / 2 + g\(a\)+ C$

with $g$ being some arbitrary function, which has to be true because of all these derivatives. NOTE: this $f_b$ is the notation for a partial derivative with respect to $b$.

We will prove that $g\(a\)$ and $C$ must be 0, so we don't have to worry about them later.

$f_a\(a\,b\)= g'\(a\)$

With these choices, I'm going to be able to say that this

$integral_0^t W\(u\)d W\(u\)= frac(W^2\(t\), 2) + g\(t\)+ C - frac(W^2\(0\), 2) - g\(0\)- C - integral_0^t g'\(u\)d u - 1 / 2 integral_0^t d u$

This is just plugging are previous values in the formula. We can cancel out the constant, so it will be 0 in the future.

What is the integral of $g$? It would just be $g\(t\)- g\(0\)$. So it didn't matter at all what function we used, so we'll just use 0 in the future. What's left over is

$= frac(W^2\(t\), 2) - t / 2$

which is the same exact answer.

==== Another Baby
<another-baby>
$integral_0^t u d W\(u\)$

We know that the partial derivative $f_b\(u\,W\(u\)\)= u$, so $f_b\(a\,b\)= a$, $f_(b b) = 0$.

So what is $f$? $f = a b$. We know that $f_a = b$.

Professor recommendation: do everything with $a$ and $b$, which is very handy. You don't get messed up about the connections between $t$ and $W\(t\)$. This becomes

$= t W\(t\)- integral_0^t W\(u\)d u$

because everything else is 0. This is the fast way of doing it, just calculate the partial derivatives and solve through dummy variables until you can't anymore.

Can you integrate Brownian motion? That value represents the area under Brownian motion. Knowing that every time Brownian motion is generated, it has a different value every time, you have to represent it as an integral, there's no simplification because you can't know more. Lonon will troll the students by putting Riemann integrals on exams and homework. Students always try to throw away all the other math when they learn stochastic calculus.

==== Ito Processes
<ito-processes>
One benefit of these stochastic integrals is that we can create the #strong[Ito process]. Our only requirement is that our processes have to be adapted.

$X\(t\)= X\(0\)+ integral_0^t Delta\(u\)d W\(u\)+ integral_0^t Theta\(u\)d u$

We can show that the quadratic variation of this process is the same as the quadratic variation of the integral

$\[X\,X\]\(t\)= integral_0^t Delta^2\(u\)d u$

Now let's talk about the differential of a stochastic process.

$d X\(t\)= lim_(delta arrow.r 0^(+))\(X\(t + delta\)- X\(t\)\)$

$= lim_(delta arrow.r 0^(+)) (integral_t^(t + delta) Delta \( u \) d W \( u \) + integral_t^(t + delta) Theta \( u \) d u)$

When we're talking about integrals over these tiny increments, it's something different.

$lim_(delta arrow.r 0^(+))\(Delta\(t\)\(W\(t + delta\)- W\(t\)\)+ Theta\(t\)\(t + delta - t\)\)$

These limits are the same. This means that when you take the limit, you get

$= Delta\(t\)d W\(t\)+ Theta\(t\)d t$

We can now take the differential of any integral really quickly. This is a really simple trick.

What if we squared it?

$\(d X\(t\)\)^2=\(Delta\(t\)d W\(t\)+ Theta\(t\)d t\)^2$

Let's expand the square

$= Delta^2\(t\)\(d W\(t\)\)^2+ 2 Delta\(t\)Theta\(t\)d t d W\(t\)+ Theta^2\(t\)\(d t\)^2$ Let's simplify almost all of this. We know that all the dt squared and dtdW(t) are 0

$= Delta^2\(t\)d t$

This is an approach that will work for a continuous process. An Ito process has to be a continuous process. It's a nonrandom variable plus an Ito integral plus a Riemann integral. We can use this approach: Since I know that

$\(d X\(t\)\)^2= d\[X\,X\]\(t\)$

That means that

$integral_0^t\(d X\(u\)\)^2=\[X\,X\]\(t\)$

IF $X$ IS CONTINUOUS#strong[.]

This is the quick proof.

We can now define an Ito integral with respect to an Ito process.

$integral_0^t Gamma\(u\)d X\(u\)= integral_0^t Gamma\(u\)Delta\(u\)d W\(u\)+ integral_0^t Gamma\(u\)Theta\(u\)d u$

Your stock process would follow some stochastic process, and this reprseents a trading strategy

We can now find, where $Delta$ is a simple process that dictates how we choose stocks,

$integral_0^t Delta\(w\)d S\(w\)$

We can vary it based on the stock price. We can actually use this Ito formula to take differentials as well as integrals. With the expression $f\(t\,W\(t\)\)$, if we assume

$d f\(t\,W\(t\)\)= f_a\(t\,W\(t\)\)d t + f_b\(t\,W\(t\)\)d W\(t\)+ 1 / 2 f_(b b)\(t\,W\(t\)\)\(d W\(t\)\)^2$

If I said this function was geometric Brownian motion

$f\(t\,W\(t\)\)= S\(0\)e^(\(alpha - sigma^2 / 2\)t + sigma W\(t\))$

For simplicity, we'll replace with a and b

$f\(a\,b\)= S\(0\)e^(\(alpha - sigma^2 / 2\)a + sigma b)$

Then what are our partials? $f_a =\(alpha - sigma^2 / 2\)f\(a\,b\)$

$f_b = sigma f\(a\,b\)$

$f_(b b) = sigma^2 f\(a\,b\)$

#strong[Open question:] look more into partial derivatives and why this is true.

This means that

$d S\(t\)=\(alpha - sigma^2 / 2\)S\(t\)d t + sigma S\(t\)d W\(t\)+ 1 / 2 sigma^2 S\(t\)d t$

Those terms cancel, which means this whole thing is

$= alpha S\(t\)d t + sigma S\(t\)d W\(t\)$

or, written slightly differently,

$frac(d S\(t\), S\(t\)) = alpha d t + sigma d W\(t\)$

Now we can see why we're looking at GBM. When Black-Scholes were looking for a way to model the stock prices. They looked at this instantaneous drift $alpha$ and the $sigma$ that is the diffusion. The problem is that this is nonsense because you can have negative stocks in that model. So now they look at proportional changes in the stock processes, which is sort of like instantaneous return. This is what this dynamic is showing us. We have drift and diffusion.

That means that our original integral for choosing stocks is

$integral_0^t Delta\(u\)d S\(u\)= integral_0^t Delta\(u\)alpha S\(u\)d u + integral_0^t Delta\(u\)sigma\(u\)$

Our process is coming from deterministic drift and random diffusion. That also finally gets us to theorem 4.4.6, which is the best version of this formula, the Ito formula for an Ito process.

The source starts the general Itô-process formula here but leaves it unfinished (#strong[Open question:] finish the displayed formula from the slides).

The first argument corresponds to the first differential $d u$, and then the second one is done once than twice, which is what goes into the quadratic variation.

Why is this true? Let's go back to the two dimensional Taylor series.

If we use $X$ the Ito process instead of $W$ Brownian motion, you end up with the same combinations. $d u d X\(u\)$. We can create a general rule that $d t$/$d u$ multiplied by any other differential is 0. REMEMBER THIS.

The only difference is that the quadratic variation of the Ito process, which is $Delta^2\(u\)d u$

This also can be expressed in differential form, which loses a few details.

==== Generalized GBM
<generalized-gbm>
You can also have generalized Geometric Brownian Motion, which is different from regular GBM. We can now say that $alpha$ and $sigma$ are no longer inputs, they are stochastic processes in themselves. They are still adapted, but they are stochastic.

IF I define

$S\(t\)= S\(0\)exp (integral_0^t \( alpha \( u \) - frac(sigma^2\(u\), 2) \) d u + integral_0^t sigma \( u \) d W \( u \))$

I can't do the differential hre normally because I don't have everything substitutable, we don't have W(t) really. We can't write this as a function of $t$ and $W\(t\)$

But I can define a new stochastic process

$X\(t\)= integral_0^t\(alpha\(u\)- frac(sigma^2\(u\), 2)\)d u + integral_0^t sigma\(u\)d W\(u\)$

Can I write $S\(t\)$ now as an Ito process?

$S\(t\)= S\(0\)e^(X\(t\)) = f\(t\,X\(t\)\)$

My Ito formula is going to tell me that

$d S\(t\)= f_a\(t\,X\(t\)\)d t + f_b\(t\,X\(t\)\)d X\(t\)+ 1 / 2 f_(b b)\(t\,X\(t\)\)\(d X\(t\)\)^2$

This helps me know what I'm missing to find this differential.

$f\(a\,b\)= S\(0\)e^b$

Therefore, $f_a = 0$, $f_b = f$, $f_(b b) = f$

$d X\(t\)=\(alpha\(t\)- frac(sigma^2\(t\), 2)\)d t + sigma\(t\)d W\(t\)$

$\(d X\(t\)\)^2= sigma^2\(t\)d t$

This is because… I don't know he didn't explain 🙁

$d S\(t\)= 0 d t + S\(t\)d X\(t\)+ 1 / 2 S\(t\)\(d X\(t\)\)^2$

$= S\(t\)\(alpha\(t\)- frac(sigma^2\(t\), 2)\)d t + S\(t\)sigma\(t\)d W\(t\)+ 1 / 2 S\(t\)sigma^2\(t\)d t$ All of that is $S\(t\)d X\(t\)$

We can cancel out the $sigma^2$ portion and create

$= S\(t\)alpha\(t\)d t + S\(t\)sigma\(t\)d W\(t\)$

This is the same as GBM, but we need to derive this by using the Ito process.

The Ito formula for Ito processes works for everything, which makes it the best one, 4.4.6.

An interesting result of theorem 4.4.9 is that

$I\(t\)= integral_0^t Delta\(s\)d W\(s\)$

The random variable is normally distributed. Let's prove that.

The key to this proof is that I'm going to first define

$X\(t\)= u I\(t\)- u^2 / 2 integral_0^t Delta^2\(s\)d s$.

What is $bb(E) [e^(X\(t\))] = ?$

Let's look at the differential, the #strong[Ito decomposition]. This makes it much more clear if this is an Ito process.

$d (e^(X\(t\))) = e^(X\(t\)) d X\(t\)+ 1 / 2 e^(X\(t\))\(d X\(t\)\)^2$

But what we don't have well defined is $d X\(t\)$. But that shouldn't be too bad.

$d X\(t\)= u d I\(t\)- u^2 / 2 Delta^2\(t\)d t$

I know what is given to us by 4.4.9

$= u Delta\(t\)d W\(t\)- u^2 / 2 Delta^2\(t\)d t$

$d (e^(X\(t\))) = e^(X\(t\)) u Delta\(t\)d W\(t\)- e^(X\(t\)) u^2 / 2 Delta^2\(t\)d t + 1 / 2 e^(X\(t\)) u^2 Delta^2\(t\)d t$

REMEMBER THAT $\(d X\(t\)\)^2$ is $Delta^2 d t$

Canceling out $e$ terms, we get

$= e^(X\(t\)) u Delta\(t\)d W\(t\)$

Integrating both sides, we get

$e^(X\(t\)) = e^(X\(0\)) + integral_0^t e^(X\(s\)) u Delta\(s\)d W\(s\)$

I can see an interesting thing here. This formula must be a martingale, because it's a constant plus a martingale. All Ito integrals with respect to Brownian motion are martingales.

$= 1 + integral_0^t e^(X\(s\)) dots.h$

The expected value is the same as when it's conditioned on zero information, which is 1.

$bb(E) [exp (u I \( t \) - u^2 / 2 integral_0^t Delta^2 \( s \) d s)] = 1$

$Delta$ is explicitly nonrandom, so $I\(t\)$ is the only stochastic part of it.

That means you actually have

$bb(E) [e^(u I\(t\))] = exp dots.h$

That's how you get a moment generating function, for a normal random variable, for mean 0 and variance given by this integral.

==== Vasicek
<vasicek>
We don't only use stochastic processes for stock prices. There are many random things in finance, like interest rates. There are different models for this. This is given by this stochastic differential equation:

$d R\(t\)-\(alpha - beta R\(t\)\)d t + sigma d W\(t\)$

It ahsa closed form solution, which we can prove.

This Vasicek model has a mean reverting component. We can see this by looking at the behavior of this process if the current value of interest rate $R\(t\)< alpha / beta$, then $\(alpha - beta R\(t\)\)> 0$. If our interest rate falls below this level, our drift term becomes strictly positive. We're going to have a general upward drift if this happens. But what if it goes below that? We get pulled back down. What happens if we hit it perfectly? We still have noise in our model from $sigma d W\(t\)$, so we will never have an equilibrium.

Closed form solution:

$R\(t\)= R\(0\)e^(- beta t) + alpha / beta\(1 - e^(- beta t)\)+ sigma e^(- beta t) integral_0^t e^(beta u) d W\(u\)$

We'll pick the Ito process

$X\(t\)= integral_0^t e^(beta u) d W\(u\)$

Because this will give us

$R\(t\)= f\(t\,X\(t\)\)$

We need to find $d X\(t\)$

$d X\(t\)= e^(beta t) d W\(t\)$ We'll substitute with $a a n d$b\$

$f\(a\,b\)= R\(0\)e^(- beta a) + alpha / beta\(1 - e^(- beta a)\)+ sigma e^(- beta a) b$

What's our partials? $f_a = - beta R\(0\)e^(- beta a) + alpha e^(- beta a) - beta sigma e^(- beta a) b$

$f_b = sigma e^(- beta a)$

$f_(b b) = 0$

If we run our Ito formula:

$d R\(t\)=\(- beta R\(0\)e^(- beta t) + alpha e^(- beta t) - beta sigma e^(- beta t) X\(t\)\)d t + sigma e^(- beta t) d X\(t\)+ 1 / 2\(0\)\(d X\(t\)\)^2$

Let's factor out this $- beta$ and cancel out $d X\(t\)\)$ when we factor it in.

$= - beta\(R\(0\)e^(- beta t) - alpha / beta e^(- beta t) + sigma e^(- beta t) X\(t\)\)d t + sigma d W\(t\)\)$

We are very close to being $R\(t\)$. The only difference is $alpha / beta$ So we'll add and subtract it.

$= - beta (- alpha / beta + R \( 0 \) e^(- beta t) + alpha / beta - alpha / beta e^(- beta t) + sigma e^(- beta t) X \( t \)) d t + sigma d W\(t\)$

When we cancel out the denominator with $beta$, we get

$=\(alpha - beta R\(t\)\)d t + sigma d W\(t\)$

This is very nice because we can get the expected value of $R\(t\)$ more easily.

$bb(E)\[R\(t\)\]= bb(E) [R \( 0 \) e^(- beta t) + alpha / beta (1 - e^(- beta t)) + sigma e^(- beta t) integral_0^t e^(beta t) d W \( s \)]$

#strong[Whenever you're calculating expectations, you need to figure out what's random, because the expectation of a constant is itself.]

The only random thing is the Ito integral, which is a martingale, so we get

$= R\(0\)e^(- beta t) + alpha / beta (1 - e^(- beta t))$

What would be the long-term rate?

$lim_(t arrow.r oo) bb(E)\[R\(t\)\]= alpha / beta$

This term is called the long-term interest rate, what it's mean reverting to.

This seems like a pretty interesting process. Ito process, closed form solution, but it's got a big flaw. The only thing that's random is the integral.

If you add a constant to a normal distribution, it's still normal. We just agreed that this process is normally distributed, which means that there's a nonzero probability that the interest rate could be negative. Depending on what you're modeling, like risk-free interest rates in a functioning economy, this could be really bad.

Some very intelligent people saw this problem and fixed it.

==== Cox-Ingersoll-Ross
<cox-ingersoll-ross>
The CIR interest rate model adds in one thing: a square root. In order for the interest rate to go negative, it has to go to 0. This model causes noise to disappear as interest rates go to 0, so upward drift increases.

$d R\(t\)=\(alpha - beta R\(t\)\)d t + sigma sqrt(R\(t\)) d W\(t\)$

Unfortunately, there is no obvious closed-form solution. Fortunately, we're built different. We would look at

$d (e^(beta t) R \( t \)) = d f\(t\,R\(t\)\)$

where the dummy function is

$f\(a\,b\)= e^(beta a) b$

$f_a = beta f$

$f_b = e^(beta a)$

$f_(b b) = 0$

So the differential becomes

$= beta e^(beta t) R\(t\)d t + e^(beta t) d R\(t\)$

$= beta e^(beta t) R\(t\)d t + e^(beta t)\(alpha - beta R\(t\)\)d t + e^(beta t) sigma sqrt(R\(t\)) d W\(t\)$

We see what happens is that the terms get canceled because we chose this specific differential.

$= alpha e^(beta t) d t + sigma sqrt(R\(t\)) e^(beta t) d W\(t\)$

I can integrate both sides and get

$e^(beta t) R\(t\)- e^(beta\(0\)) R\(0\)= integral_0^t alpha e^(beta u) thin d u + integral_0^t sigma sqrt(R\(u\)) e^(beta u) thin d W\(u\)$

I can kind of get $R\(t\)$ by itself but not all the way because I can't get rid of the square root. There is no fancy thing I can look at to make this thing behave. But I will still have

$R\(t\)= R\(0\)e^(- beta t) + alpha / beta\(1 - e^(- beta t)\)+ e^(- beta t) integral_0^t sigma sqrt(R\(t\)) e^(beta u) d W\(u\)$

Which means I can get the expectation, which would not necessarily be given by the original expression.

If I tried doing that with the original, I depend on $R\(u\)$. But in my new form, the only $R\(u\)$ is contained in the stochastic integral which we know has expectation 0.
