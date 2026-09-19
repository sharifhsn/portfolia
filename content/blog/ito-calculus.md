+++
title = 'Itô Calculus'
date = 2024-10-10
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Ito Lemma', 'Geometric Brownian Motion']
+++

## Week 5

### Lecture Notes

#### Baby’s First Stochastic Integral

This is seemingly one of the simplest integrals you could do.

\(\int_0^t W(u)dW(u)\)

If we’re going to do this integral, how we’re going to do that is to create a process \(\Delta_n(u) \rightarrow W(u)\) that converges so that this integral equals

\(= \lim_{n \rightarrow \infty} \int_0^t \Delta_n(u) dW(u)\)

We essentially want this integral to converge to the integral of a Brownian motion.

We’re going to define

We’re going to assume wer’e cutting up our timespan \([0, t]\) into \(n\) equal sized pieces.

What we’re doing here is that if we have this path of a Brownian motion, we will create time partitions where we are cutting it up into equal spaces. And our process takes the value of the motion at time 0 until time 1, then resets to time 1, then time 2, so it turns it into a random walk. As \(n\) gets larger and larger, this converges to Brownian motion pointwise, no place for discontinuities to hide.

I can now express this integral as

The widths come from the change in Brownian motion.

We’ll denote \(W_j = W\left(\frac{jt}{n}\right)\) for convenience, so this becomes

\(= \sum_{j=0}^{n-1} W_j(W_{j+1} - W_j)\)

We’re going to look at the expansion of this squaredd

\(\frac{1}{2}\sum_{j=0}^{n-1}(W_{j+1} - W_j)^2 = \frac{1}{2}\sum_{j=0}^{n-1}W_{j+1}^2 - \sum_{j=0}^{n-1} W_jW_{j+1} + \frac{1}{2}\sum_{j=0}^{n-1} W_j^2\)

The 1/2 will become relevant later

Now, first thing I’m going to observe is that I could take this first term and rewrite it as

\(\sum_{k=1}^n W_k^2\)

I’m doing a reindex and starting at \(k\). What would this be when \(k=0\)? 0. So this will be the same thing as

\(= \sum_{k=0}^nW_k^2 = W_n^2 + \sum_{j=0}^{N-1} W_j^2\)

The expansion of this is

\(= \frac{1}{2}W_n^2 + \sum_{j=0}^{n-1}(W_j^2 - W_jW_{j+1})\)

Well, this is

\(= \frac{1}{2}W_n^2 + \sum_{j=0}^{n-1} W_j(W_j - W_{j+1})\)

This term here is very close to where we left off in the original expansion. I can move this to the other side, which takes out the -1, which makes them correspond.

We have just proven that

\(\sum_{j=0}^{n-1} W_j(W_{j+1} - W_j) = \frac{1}{2}W_n^2 - \frac{1}{2}\sum_{j=0}^{n-1}(W_{j+1}- W_j)^2\)

After substituting that back in, I now have that

\(\int_0^t W(u)dW(u) = \lim_{n \rightarrow \infty} \left(\frac{1}{2}W_n^2 - \frac{1}{2}\sum_{j=0}^{n-1}(W_{j+1} - W_j)^2\right)\)

What is \(W_n\)?

This doesn’t depend on \(n\). If you look very carefully at the summation of the difference of squares, that’s quadratic variation, so \(t\)

\(= \frac{1}{2}W^2(t) - \frac{t}{2}\)

The quadratic variation is the precise property which makes stochastic integral different

This is the correct answer if we use the left-hand endpoints i.e. if this is an adaptive process.

Right hand endpoint also

Stratonyvich integral if we use midpoint, so that’s intuitive. Why don’t we use it? It’s not adaptive/measurable, it requires you to evaluate the value of the expression halfway through the integral. That would be the equivalent of choosing your trading position at the middle of the day for the entire day. That’s impossible. So we have to use Ito integrals.

#### Differential Form

If we were dealing with regular calculus, and you asked me to find the differential of a function, I would look at it and use the chain rule. But Brownian motion isn’t differentiable.

\(df(W(t)) = f'(W(t)) W'(t)dt = f'(W(t)) dW(t)\)

We’re still not going to have it correct because of quadratic variation. We actually have

\(df(W(t)) = f'(W(t)) dW(t) + \frac{1}{2}f''(W(t))dt\)

If we look at the integral form and we look at both sides,

By the theorem of calculus, integral of differential should be difference between bounds. So we must prove this.

We’re going to use the Taylor series to come up with some expansions. This is going to be

\(f(x) = \sum_{k=0}^\infty \frac{f^{(k)} (a) (x-a)^k}{k!}\)

writing out the first few terms, this is

\(= f(a) + f'(a)(x-1) + \frac{1}{2}f''(a)(x-a)^2 + \frac{1}{6}f'''(a)(x-a)^3 \ldots\)

So, I have that

\(f(x) - f(a) =\) all of this stuff

This is true for any function that we can do the Taylor approximation on. We’re going to keep this in mind and then I want to talk about **telescoping sums**. For a sequence \(\{X_i\}_{i \in \{1, \ldots, n\}}\) what can you tell me about this/

\(\sum_{i=0}^{n-1}(X_{i+1} - X_i) = X_1 - X_0 + X_2 - X_1 + X_3 - X_2 + \ldots + X_{n-1} - X_{n-2} + X_n - X_{n-1}\)

Well this is going to cancel out in between so we end up just getting the difference between the endpoints.

\(= X_n - X_0\)

We now have most of our pieces.

I’m going to say that for a given partition \(\Pi\), I’m going to let \(x = W(t_{j+1})\), \(a=W(t_j)\). I’m going to rewrite this Taylro series expansions with these variables. I now have

\(f(W(t_{j+1})) - f(W(t_j)) = f'(W(t_j)) (W(t_{j+1}) - W(t_j)) + \frac{1}{2}f''(W(t_j)) (W(t_{j+1}) - W(t_j))^2 + \frac{1}{6}f'''(W(t_j)) (W(t_{j+1}) - W(t_j))^3 + \ldots\)

Then, I am now going to take (and remember, if I can do it to both sides I can do anything) I am going to add both of these sides up

\(\sum_{j=0}^{n-1}\left(f(W(t_{j+1})) - f(W(t_j))\right) = \sum_{j=0}^{n-1}\left(f'(W(t_j)) (W(t_{j+1}) - W(t_j)) + \frac{1}{2}f''(W(t_j)) (W(t_{j+1}) - W(t_j))^2 + \frac{1}{6}f'''(W(t_j)) (W(t_{j+1}) - W(t_j))^3 + \ldots\right)\)

The left is just our telescoping summation. We have various summations on the other side.

\(f(W(t)) - f(W(0)) = \sum_{j=0}^{n-1} f'(W(t_j)) (W(t_{j+1}) - W(t_j)) + \frac{1}{2} \sum_{j=0}^{n-1} f''(W(t_j)) (W(t_{j+1}) - W(t_j))^2 + \frac{1}{6} \sum_{j=0}^{n-1} f''(W(t_j)) (W(t_{j+1}) - W(t_j))^3 + \ldots\)

Because this is for an arbitrary partition, let’s look at the limit as the norm of partition goes to 0. Nothing happens on the left side, because there’s no index involved there. So we’ll leave it untouched.

\(f(W(t)) - f(W(0)) = \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1} f'(W(t_j)) (W(t_{j+1}) - W(t_j)) + \frac{1}{2}  \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1} f''(W(t_j)) (W(t_{j+1}) - W(t_j))^2 +  \lim_{\|\Pi\| \rightarrow 0} \frac{1}{6} \sum_{j=0}^{n-1} f''(W(t_j)) (W(t_{j+1}) - W(t_j))^3 + \ldots\)

We’re writing this all down because we will need to refer back to this later\! Now, let’s look and see how this limit affects this. As we’re dealing with the limit of the norm of this partition going to 0, this change in Brownian motion is going to converge to \(dW(u)\) the differential. That is the definition of the differential. That means that this term inside the exponent is just the differential. So we get the first term as \(dW(u)\), then the second term as \(du\) because that’s what we determined. And after we multiply it one more time, it will be 0, because that’s also proven. So we can throw out all terms after the second order. This gives us one Ito integral and one Riemann integral. What we have here is

\(= \int_0^t f'(W(u))dW(u) + \frac{1}{2}\int_0^t f''(W(u)) du\)
At this point, everybody should know that the 1/2 appears because of the Taylor expansion. Everybody makes the mistake and forgets it, so you need to be extra vigilant on homework and tests for this.

#### Ito Formula

That leads us to being able to prove Theorem 4.4.1 the Ito formula for Brownian motion:

Let \(f(t, x)\) be a function for which the partial derivatives  etc.

\(f(T, W(T)) = f(0, W(0)) \ldots\)

I would strongly suggest that you use a different form of the Ito formula.

\(f(a, b)\) is some function such that \(f_a\), f\_b\(, and\)f\_bbbb exist.

\(f(t, W(t)) = f(0, W(0)) + \int_0^t f_a(u, W(u))du + \int_0^t f_b(u, W(u))dW(u) + \frac{1}{2}\int_0^t f_{bb}(u, W(u)) d[W, W] du\)

This lets us remember where all the pieces are coming from. We can see that \(f\) is only considered with respect to these dummy variables.

Where does this formula come from? The two dimensional Taylor series expansion\!

For some function, centered around the point \((a_0, b_0)\)

\(f(a, b) - f(a_0, b_0) = f_a(a_0, b_0) (a - a_0) + f_b(a_0, b_0)(b - b_0)\)

These are all the first order derivatives. Then we get

\(+ \frac{1}{2}f_{aa}(a_0, b_0) (a - a_0)^2 + \frac{1}{2} f_{ab} (a_0, b_0) (a - a_0)(b - b_0) + \frac{1}{2} f_{ba}(a_0, b_0) (b - b_0) (a - a_0) + \frac{1}{2} f_{bb}(a_0, b_0) (b - b_0)^2 + \frac{1}{6} + \ldots\)

into the second and third order and so on.

We will let \(a_0 = t_j\), \(a = t_{j+1}\), \(b_0 = W(t_j)\), \(b = W(t_{j+1})\)

We’re going to do the same sum to telescoping sum trick here.

\(f(t, W(t)) - f(0, 0) = \sum_{j=0}^{n-1} f_a(t_j, W(t_j))(t_{j+1} - t_j) + \sum_{j=0}^{n-1}f_b(t_j, W(t_j)) (W(t_{j+1}) - W(t_j)) + \frac{1}{2} \sum_{j=0}^{n-1} f_{aa} (t_j, W(t_j)) (t_{j+1} - t_j)^2 +  \sum_{j=0}^{n-1} f_{ab} (t_j, W(t_j)) (t_{j+1} - t_j) (W(t_{j+1} - W(t_j)) + \frac{1}{2}  \sum_{j=0}^{n-1} f_{bb} (t_j, W(t_j)) (t_{j+1} - t_j)(W(t_{j+1}) - W(t_j))\)

assume that fab and fba are the same



The differential notation makes the limit transparent: \(du\) is first-order time, \(dW(u)\) is the Brownian increment, \(du\) times any differential is 0, and \((dW(u))^2 = du\) through quadratic variation. The only nonzero second-order term is therefore the quadratic-variation term. That is how we get the Itô formula.

Using this formula, we can now try and solve a simple exercise. The only stochastic part of the Ito formula is in the \(f_b\) part. So let’s try and move everything to the other side of the expression.

\(\int_0^t f_b(u, W(u)) dW(u) = f(t, W(t)) - f(0, W(0)) - \int_0^t f_a(u, W(u))du - \frac{1}{2}\int_0^t f_{bb}(u, W(u)) du\)

So, if I was given the problem, what is

\(\int_0^t W(u) dW(u)\)

That seems to suggest that

\(f_b(u, W(u)) = W(u)\)

What would be \(f_b(a, b)\)? I don’t want to work with my functions with stochastic crap, I want to use well-defined dummy variables?

\(f_b(a, b) = b\)

If I do this substitution, then this is what i results in.

Then what is

\(f_{bb}(a, b)\)? 1.

I am going to do this the hardest possible way right now, to demonstrate how it’s done.

\(f(a, b) = \frac{b^2}{2} + g(a) + C\)

with \(g\) being some arbitrary function, which has to be true because of all these derivatives. NOTE: this \(f_b\) is the notation for a partial derivative with respect to \(b\).

We will prove that \(g(a)\) and \(C\) must be 0, so we don’t have to worry about them later.

\(f_a(a, b) = g'(a)\)

With these choices, I’m going to be able to say that this

\(\int_0^t W(u) dW(u) = \frac{W^2(t)}{2} + g(t) + C - \frac{W^2(0)}{2} - g(0) - C - \int_0^t g'(u)du - \frac{1}{2} \int_0^t du\)

This is just plugging are previous values in the formula. We can cancel out the constant, so it will be 0 in the future.

What is the integral of \(g\)? It would just be \(g(t) - g(0)\). So it didn’t matter at all what function we used, so we’ll just use 0 in the future. What’s left over is

\(= \frac{W^2(t)}{2} - \frac{t}{2}\)

which is the same exact answer.

#### Another Baby

\(\int_0^t u dW(u)\)

We know that the partial derivative \(f_b(u, W(u)) = u\), so \(f_b(a, b) = a\), \(f_{bb} = 0\).

So what is \(f\)? \(f = ab\). We know that \(f_a = b\).

Professor recommendation: do everything with \(a\) and \(b\), which is very handy. You don’t get messed up about the connections between \(t\) and \(W(t)\). This becomes

\(= tW(t) - \int_0^t W(u)du\)

because everything else is 0. This is the fast way of doing it, just calculate the partial derivatives and solve through dummy variables until you can’t anymore.

Can you integrate Brownian motion? That value represents the area under Brownian motion. Knowing that every time Brownian motion is generated, it has a different value every time, you have to represent it as an integral, there’s no simplification because you can’t know more. Lonon will troll the students by putting Riemann integrals on exams and homework. Students always try to throw away all the other math when they learn stochastic calculus.

#### Ito Processes

One benefit of these stochastic integrals is that we can create the **Ito process**. Our only requirement is that our processes have to be adapted.

\(X(t) = X(0) + \int_0^t \Delta (u) dW(u) + \int_0^t \Theta(u)du\)

We can show that the quadratic variation of this process is the same as the quadratic variation of the integral

\([X, X](t) = \int_0^t \Delta^2(u)du\)

Now let’s talk about the differential of a stochastic process.

\(dX(t) = \lim_{\delta \rightarrow 0^+} (X(t+\delta) - X(t))\)

\(= \lim_{\delta \rightarrow 0^+} \left(\int_t^{t+\delta} \Delta (u) dW(u) + \int_t^{t + \delta} \Theta (u)du\right)\)

When we’re talking about integrals over these tiny increments, it’s something different.

\(\lim_{\delta \rightarrow 0^+} (\Delta(t)(W(t+\delta) - W(t)) + \Theta(t)(t + \delta - t))\)

These limits are the same. This means that when you take the limit, you get

\(= \Delta(t) dW(t) + \Theta (t) dt\)

We can now take the differential of any integral really quickly. This is a really simple trick.

What if we squared it?

\((dX(t))^2 = (\Delta(t) dW(t) + \Theta(t) dt)^2\)

Let’s expand the square

\(= \Delta^2(t) (dW(t))^2 + 2\Delta(t)\Theta(t) dtdW(t) + \Theta^2(t)(dt)^2\)
Let’s simplify almost all of this. We know that all the dt squared and dtdW(t) are 0

\(= \Delta^2(t)dt\)

This is an approach that will work for a continuous process. An Ito process has to be a continuous process. It’s a nonrandom variable plus an Ito integral plus a Riemann integral. We can use this approach: Since I know that

\((dX(t))^2 = d[X, X](t)\)

That means that

\(\int_0^t (dX(u))^2 = [X, X](t)\)

IF \(X\) IS CONTINUOUS**.**

This is the quick proof.

We can now define an Ito integral with respect to an Ito process.

\(\int_0^t \Gamma (u) dX(u) = \int_0^t \Gamma(u) \Delta (u) dW(u) + \int_0^t \Gamma (u) \Theta (u) du\)

Your stock process would follow some stochastic process, and this reprseents a trading strategy

We can now find, where delta is a simple process that dictates how we choose stocks,

\(\int_0^t \Delta(w)dS(w)\)

We can vary it based on the stock price. We can actually use this Ito formula to take differentials as well as integrals. With the expression \(f(t, W(t))\), if we assume

\(df(t, W(t)) = f_a(t, W(t)) dt + f_b (t, W(t)) dW(t) + \frac{1}{2} f_{bb} (t, W(t)) (dW(t))^2\)

If I said this function was geometric Brownian motion

\(f(t, W(t)) = S(0) e^{(\alpha - \tfrac{\sigma^2}{2})t + \sigma W(t)}\)

For simplicity, we’ll replace with a and b

\(f(a, b) = S(0)e^{(\alpha - \tfrac{\sigma^2}{2})a + \sigma b}\)

Then what are our partials?
\(f_a = (\alpha - \frac{\sigma^2}{2})f(a, b)\)

\(f_b = \sigma f(a, b)\)

\(f_{bb} = \sigma^2 f(a, b)\)

**Open question:** look more into partial derivatives and why this is true.

This means that

\(dS(t) = (\alpha - \frac{\sigma^2}{2}) S(t) dt + \sigma S(t) dW(t) + \frac{1}{2} \sigma^2 S(t)dt\)

Those terms cancel, which means this whole thing is

\(= \alpha S(t) dt + \sigma S(t) dW(t)\)

or, written slightly differently,

\(\frac{dS(t)}{S(t)} = \alpha dt + \sigma dW(t)\)

Now we can see why we’re looking at GBM. When Black-Scholes were looking for a way to model the stock prices. They looked at this instantaneous drift alpha and the sigma that is the diffusion. The problem is that this is nonsense because you can have negative stocks in that model. So now they look at proportional changes in the stock processes, which is sort of like instantaneous return. This is what this dynamic is showing us. We have drift and diffusion.

That means that our original integral for choosing stocks is

\(\int_0^t \Delta (u) dS(u) = \int_0^t \Delta(u) \alpha S(u) du + \int_0^t \Delta (u) \sigma(u)\)

Our process is coming from deterministic drift and random diffusion. That also finally gets us to theorem 4.4.6, which is the best version of this formula, the Ito formula for an Ito process.

The source starts the general Itô-process formula here but leaves it unfinished (**Open question:** finish the displayed formula from the slides).

The first argument corresponds to the first differential \(du\), and then the second one is done once than twice, which is what goes into the quadratic variation.

Why is this true? Let’s go back to the two dimensional Taylor series.

If we use \(X\) the Ito process instead of \(W\) Brownian motion, you end up with the same combinations. \(du dX(u)\). We can create a general rule that \(dt\)/\(du\) multiplied by any other differential is 0. REMEMBER THIS.

The only difference is that the quadratic variation of the Ito process, which is \(\Delta^2(u)du\)

This also can be expressed in differential form, which loses a few details.

#### Generalized GBM

You can also have generalized Geometric Brownian Motion, which is different from regular GBM. We can now say that \(\alpha\) and \(\sigma\) are no longer inputs, they are stochastic processes in themselves. They are still adapted, but they are stochastic.

IF I define

\(S(t) = S(0)\exp\left(\int_0^t(\alpha(u) - \frac{\sigma^2(u)}{2})du + \int_0^t \sigma(u)dW(u)\right)\)

I can’t do the differential hre normally because I don’t have everything substitutable, we don’t have W(t) really. We can’t write this as a function of \(t\) and \(W(t)\)

But I can define a new stochastic process

\(X(t) = \int_0^t (\alpha(u) - \frac{\sigma^2(u)}{2})du + \int_0^t \sigma(u) dW(u)\)

Can I write \(S(t)\) now as an Ito process?

\(S(t) = S(0) e^{X(t)} = f(t, X(t))\)

My Ito formula is going to tell me that

\(dS(t) = f_a(t, X(t))dt + f_b(t, X(t)) dX(t) + \frac{1}{2} f_{bb} (t, X(t)) (dX(t))^2\)

This helps me know what I’m missing to find this differential.

\(f(a, b) = S(0)e^b\)

Therefore, \(f_a = 0\), \(f_b = f\), \(f_{bb} = f\)

\(dX(t) = (\alpha(t) - \frac{\sigma^2(t)}{2})dt + \sigma(t) dW(t)\)

\((dX(t))^2 = \sigma^2(t)dt\)

This is because… I don’t know he didn’t explain 🙁

\(dS(t) = 0dt + S(t)dX(t) + \frac{1}{2} S(t) (dX(t))^2\)

\(= S(t)(\alpha(t) - \frac{\sigma^2(t)}{2})dt + S(t) \sigma(t) dW(t) + \frac{1}{2}S(t) \sigma^2(t)dt\)
All of that is \(S(t)dX(t)\)

We can cancel out the \(\sigma^2\) portion and create

\(= S(t) \alpha(t)dt + S(t) \sigma(t)dW(t)\)

This is the same as GBM, but we need to derive this by using the Ito process.

The Ito formula for Ito processes works for everything, which makes it the best one, 4.4.6.

An interesting result of theorem 4.4.9 is that

\(I(t) = \int_0^t \Delta(s)dW(s)\)

The random variable is normally distributed. Let’s prove that.

The key to this proof is that I’m going to first define

\(X(t) = uI(t) - \frac{u^2}{2} \int_0^t \Delta^2(s) ds\).

What is \(\mathbb{E}\left[e^{X(t)}\right] = ?\)

Let’s look at the differential, the **Ito decomposition**. This makes it much more clear if this is an Ito process.

\(d\left(e^{X(t)}\right) = e^{X(t)} dX(t) + \frac{1}{2}e^{X(t)} (dX(t))^2\)

But what we don’t have well defined is \(dX(t)\). But that shouldn’t be too bad.

\(dX(t) = udI(t) - \frac{u^2}{2}\Delta^2(t)dt\)

I know what is given to us by 4.4.9

\(= u\Delta(t)dW(t) - \frac{u^2}{2}\Delta^2(t)dt\)

\(d\left(e^{X(t)}\right) = e^{X(t)} u\Delta(t) dW(t) - e^{X(t)} \frac{u^2}{2} \Delta^2(t) dt + \frac{1}{2} e^{X(t)}u^2\Delta^2(t)dt\)

REMEMBER THAT \((dX(t))^2\) is \(\Delta^2dt\)

Canceling out \(e\) terms, we get

\(= e^{X(t)} u\Delta(t) dW(t)\)

Integrating both sides, we get

\(e^{X(t)} = e^{X(0)} + \int_0^t e^{X(s)} u\Delta(s)dW(s)\)

I can see an interesting thing here. This formula must be a martingale, because it’s a constant plus a martingale. All Ito integrals with respect to Brownian motion are martingales.

\(= 1 + \int_0^t e^{X(s)}\ldots\)

The expected value is the same as when it’s conditioned on zero information, which is 1.

\(\mathbb{E}\left[\exp\left(uI(t) - \frac{u^2}{2} \int_0^t \Delta^2(s) ds\right)\right] = 1\)

\(\Delta\) is explicitly nonrandom, so \(I(t)\) is the only stochastic part of it.

That means you actually have

\(\mathbb{E}\left[e^{uI(t)}\right] = \exp \ldots\)

That’s how you get a moment generating function, for a normal random variable, for mean 0 and variance given by this integral.

#### Vasicek

We don’t only use stochastic processes for stock prices. There are many random things in finance, like interest rates. There are different models for this. This is given by this stochastic differential equation:

\(dR(t) -  (\alpha - \beta R(t)) dt + \sigma dW(t)\)

It ahsa  closed form solution, which we can prove.

This Vasicek model has a mean reverting component. We can see this by looking at the behavior of this process if the current value of interest rate \(R(t) < \tfrac{\alpha}{\beta}\), then \((\alpha - \beta R(t)) > 0\). If our interest rate falls below this level, our drift term becomes strictly positive. We’re going to have a general upward drift if this happens. But what if it goes below that? We get pulled back down. What happens if we hit it perfectly? We still have noise in our model from \(\sigma dW(t)\), so we will never have an equilibrium.

Closed form solution:

\(R(t) = R(0) e^{-\beta t} + \frac{\alpha}{\beta}(1 - e^{-\beta t}) + \sigma e^{-\beta t} \int_0^t e^{\beta u} dW(u)\)

We’ll pick the Ito process

\(X(t) = \int_0^t e^{\beta u}dW(u)\)

Because this will give us

\(R(t) = f(t, X(t))\)

We need to find \(dX(t)\)

\(dX(t) = e^{\beta t} dW(t)\)
We’ll substitute with \(a and\)b$

\(f(a, b) = R(0) e^{-\beta a} + \frac{\alpha}{\beta}(1 - e^{-\beta a}) + \sigma e^{-\beta a} b\)

What’s our partials?
\(f_a = -\beta R(0) e^{-\beta a} + \alpha e^{-\beta a} - \beta \sigma e^{-\beta a} b\)

\(f_b = \sigma e^{-\beta a}\)

\(f_{bb} = 0\)

If we run our Ito formula:

\(dR(t) = (-\beta R(0) e^{-\beta t} + \alpha e^{-\beta t} - \beta \sigma e^{-\beta t} X(t)) dt + \sigma e^{-\beta t} dX(t) + \frac{1}{2} (0) (dX(t))^2\)

Let’s factor out this \(-\beta\) and cancel out \(dX(t))\) when we factor it in.

\(= -\beta (R(0) e^{-\beta t} - \frac{\alpha}{\beta}  e^{-\beta t} + \sigma e^{-\beta t}X(t)) dt + \sigma dW(t))\)

We are very close to being \(R(t)\). The only difference is \(\tfrac{\alpha}{\beta}\) So we’ll add and subtract it.

\(= -\beta\left(-\frac{\alpha}{\beta} + R(0) e^{-\beta t} + \frac{\alpha}{\beta} - \frac{\alpha}{\beta} e^{-\beta t} + \sigma e^{-\beta t} X(t)\right) dt + \sigma dW(t)\)

When we cancel out the denominator with \(\beta\), we get

\(= (\alpha - \beta R(t)) dt + \sigma dW(t)\)

This is very nice because we can get the expected value of \(R(t)\) more easily.

\(\mathbb{E}[R(t)] = \mathbb{E}\left[R(0) e^{-\beta t} + \frac{\alpha}{\beta} \left(1 - e^{-\beta t}\right) + \sigma e^{-\beta t} \int_0^t e^{\beta t} dW(s)\right]\)

**Whenever you’re calculating expectations, you need to figure out what’s random, because the expectation of a constant is itself.**

The only random thing is the Ito integral, which is a martingale, so we get

\(= R(0) e^{-\beta t} + \frac{\alpha}{\beta} \left(1 - e^{-\beta t}\right)\)

What would be the long-term rate?

\(\lim_{t \rightarrow \infty} \mathbb{E}[R(t)] = \frac{\alpha}{\beta}\)

This term is called the long-term interest rate, what it’s mean reverting to.

This seems like a pretty interesting process. Ito process, closed form solution, but it’s got a big flaw. The only thing that’s random is the integral.

If you add a constant to a normal distribution, it’s still normal. We just agreed that this process is normally distributed, which means that there’s a nonzero probability that the interest rate could be negative. Depending on what you’re modeling, like risk-free interest rates in a functioning economy, this could be really bad.

Some very intelligent people saw this problem and fixed it.

#### Cox-Ingersoll-Ross

The CIR interest rate model adds in one thing: a square root. In order for the interest rate to go negative, it has to go to 0. This model causes noise to disappear as interest rates go to 0, so upward drift increases.

\(dR(t) = (\alpha - \beta R(t))dt + \sigma \sqrt{R(t)} dW(t)\)

Unfortunately, there is no obvious closed-form solution. Fortunately, we’re built different. We would look at

\(d\left(e^{\beta t}R(t)\right) = df(t, R(t))\)

where the dummy function is

 \(f(a, b) = e^{\beta a} b\)

\(f_a = \beta f\)

\(f_b = e^{\beta a}\)

\(f_{bb} = 0\)

So the differential becomes

\(= \beta e^{\beta t} R(t)dt + e^{\beta t} dR(t)\)

\(= \beta e^{\beta t} R(t)dt + e^{\beta t}(\alpha - \beta R(t))dt + e^{\beta t} \sigma\sqrt{R(t)} dW(t)\)

We see what happens is that the  terms get canceled because we chose this specific differential.

\(= \alpha e^{\beta t}dt + \sigma \sqrt{R(t)} e^{\beta t} dW(t)\)

I can integrate both sides and get

\(e^{\beta t}R(t) - e^{\beta(0)}R(0) = \int_0^t \alpha e^{\beta u}\,du + \int_0^t \sigma\sqrt{R(u)}e^{\beta u}\,dW(u)\)

I can kind of get \(R(t)\) by itself but not all the way because I can’t get rid of the square root. There is no fancy thing I can look at to make this thing behave. But I will still have

\(R(t) = R(0) e^{-\beta t} + \frac{\alpha}{\beta} (1 - e^{-\beta t}) + e^{-\beta t} \int_0^t \sigma \sqrt{R(t)} e^{\beta u} dW(u)\)

Which means I can get the expectation, which would not necessarily be given by the original expression.

If I tried doing that with the original, I depend on \(R(u)\). But in my new form, the only \(R(u)\) is contained in the stochastic integral which we know has expectation 0.
