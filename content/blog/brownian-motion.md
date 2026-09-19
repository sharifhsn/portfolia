+++
title = 'Brownian Motion'
date = 2024-09-26
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Brownian Motion', 'Quadratic Variation']
+++

## Week 3

### Reading - Brownian Motion (Shreve 3)

The most important properties of Brownian motion are that it is a martingale (the expected value of the process is 0) and it accumulates quadratic variation at a rate of one per unit time.

#### Scaled Random Walk

The symmetric random walk is given by a fair coin which goes up 1 on heads and down 1 on tails. The increments are independent from each other. The expected value is zero. Because the increments are independence, we can show that the symmetric random walk is a martingale.

#### Brownian Motion

A Brownian motion is a continuous function where the increments at time $t$ are independent and each of the increments is normally distributed with expectation 0 (martingale) and variance \(t_{i+1} - t_i\). The difference between this and the scaled walk is that the scaled walk is linear between each time step, but Brownian motion is never linear. You can think of it as an infinitely scaled walk.

The \(\omega\) in this case is the path of the Brownian motion.

We can say with respect to information, it accumulates, and the path at any time can be described by the current filtration, which is what sets the path must fall into by probability measure.

### Lecture Notes

Where we left off last week, we were talking about the quadratic variation of Brownian motion where we could prove that it was \(t\) almost surely.

\([W, W](t) = t\)

What are the implications of this? We could think of this as a function of time. The quadratic variation grows as a function of time with value \(t\). This Brownian motion is the limit of the scaled symmetric random walk. This process is jagged everywhere. If you were to zoom in on this process, it would appear just as jagged because it’s constantly moving up and down. If there’s no place where it’s smooth, there’s no place where it’s differentiable. Does that mean there’s no way to talk about derivatives? We will now only concern ourselves with differentials, not derivatives. Minor nit in English: differentiable actually means the derivative exists, not the differential.

Let’s say we have a stochastic process \(X(t)\)? We will define the **differential** of this process \(dX(t)\)

\(dX(t) = \lim_{\delta \rightarrow 0^+} (X(t + \delta) - X(t))\)

This is the instantaneous *change*, not the instantaneous *rate of change* (the derivative).

This will exist for any function, smooth or not.

We are defining the differential of Brownian motion as \(dW(t)\). Let’s point out something that comes about from looking at these differentials. We established last week that the quadratic variation is just time. BUt let’s think about the differential of the quadratic variation of time. It is a random variable indexed by time i.e. a stochastic process, so we can take the differential of it.

\(d[W, W](t) = \lim_{\delta \rightarrow 0^+} ([W, W](t + \delta) - [W, W](t))\)

I’m looking at this second order variation up until time t + delta, then time t, so I just end up with the change between t and t + delta

\(= \lim_{\delta \rightarrow 0^+}(t + \delta - t)\)

\(=\lim_{\delta \rightarrow 0^+}(\delta)\)

You could call that 0, but it’s not really a 0 as far as differentials are concerned. This is change of time, i.e. \(dt\).

This is sort of equivalent to saying that you have a partition consisting of just the points

\(\Pi = \{t, t + \delta\}\)

and if you want to do quadratic variation over this region, it would be

\(\lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1} (W(t_{j+1}) - W(t_j))^2\)

(formula for second order variation) but if delta goes to 0, the norm must go to 0, right?

I could have just said it’s the limit

\(= \lim_{\delta \rightarrow 0^+} (W(t + \delta) - W(t))^2\)

The endpoint minus the beginning point, squared.

But this is just the differential Brownian motion squared

\(= (dW(t))^2\)

We have a consequence of quadratic variation of Brownian motion being \(t\), we can express \((dW(t))^2 = dt\). And this gives us a very necessary substitution when we are doing actual stochastic calculus. The reason for that is the nonzero quadratic variation of Brownian motion.



In addition to quadratic variation, we are potentially interested in **cross variation**, which is related to quadratic variation in the same way that covariance is related to variance. It’s defined as

for processes \(X(t)\) and \(Y(t)\), the cross variation is

\([X, Y](t) = \lim_{||\Pi|| \rightarrow 0} \sum_{j=0}^{n-1} (X(t_{j+1}) - X(t_j)) (Y(t_{j+1}) - Y(t_j))\)

If I let \(X(t))\) be Brownian motion \(W(t)\) and \(Y(t)\) equal to time, I could get the cross variation of Brownian motion and time in this manner.

\(= \lim_{||\Pi|| \rightarrow 0} \sum_{j=0}^{n-1} (W(t_{j+1}) - W(t_j)) (t_{j+1} - t_j)\)

I’m going to pull out the biggest piece of my Brownian motion and say

\(\leq \lim_{||\Pi|| \rightarrow 0} \max_{0 \leq k \leq n - 1} |W(t_{k+1}) - W(t_k)| \sum_{j=0}^{n-1} (t_{j+1} - t_j)\)

I could apply the limit to each of those pieces separately. But I don’t have to apply the limit because this sum is just \(t\).

This limit comes directly from the fact that Brownian motion is continuous. There’s no place for discontinuity. Because of that, the limit must be 0.

So we can confirm that the cross variation between a continuous stochastic process, and a continuous differentiable stochastic process must be 0, because the differentiability leads it to being 0.

I know that this cross variation is less than equal to that expression. That gives me the upper bound on cross variation. I also know that

\([W, t](t) \geq \lim_{||Pi|| \rightarrow 0} -\max_{0 \leq k \leq n - 1} |W(t_{k+1}) - W(t_k)| \sum_{j=0}^{n-1} (t_{j+1} - t_j)\)

I can make the same exact argument, which means it must be 0. We’re not actually using the norm of the partition here, we’re just looking for the biggest piece, which must be 0 because the change in Brownian motion goes to 0.

\(d[X, Y](t) = dX(t) dY(t)\)

But, since I know that the cross variation between time and Brownian motion is 0, I know that that value must be 0. Even more, because I know that the quadratic variation of any continuous differentiable process is 0, I know that the quadratic variation of \(dt\) is 0, so \((dt)^2\) is 0.

Next slides will have hand waving:

Joint normal distribution

Technically, if you took a rigorous probability theory class, you learned about the joint normal distribution. Looking at normal variables that are not independent of each other. In that sense, we define the joint normal distribution through a vector fo the means and a matrix of the covariances. We bring this up to stress the idea that if we have increments that are independent and normally distributed, the variables are jointly normally distributed. If we wanted to look at \(Cov(W(s), W(t))\) where \(s < t\):

\(\mathbb{E}[W(s) W(t)] - \mathbb{E}[W(s)] \mathbb{E}[W(t)]\)

We know that \(W(s)\) is the segment to time \(s\), so the expectation must be 0 because all of these are 0. So it just becomes

\(\mathbb{E}[W(s) W(t)\)

They overlap, so they’re definitely not independent. How do we figure this out? Let’s add a zero.

\(= \mathbb{E}[W(s) W(t) - W^2(s) + W^2(s)]\)

using linearity of expected values

\(= \mathbb{E}[W(s) W(t) - W^2(s)] + \mathbb{E}[W^2(s)]\)

we can write this as

\(= \mathbb{E}[W(s) (W(t) - W(s))] + \mathbb{E}[W^2(s)]\)

and write this as

\(= \mathbb{E}[W(s)] \mathbb{E}[W(t) - W(s)] + \mathbb{E}[W^2(s)]\)

because that expectation is 0, that means that we’re just looking at the second moment, which is the variance of s, which is just s

\(= s\)

It turns out that the covariance of \(W(s)\) and \(W(t)\) is just \(s\), the smaller time.

If I were to create jointly normally distributed variables, with the covariance structure of just the minimums of the time and means equal to 0, this is an identical declaration of Brownian motion. You could also use joint moment generating functions (but this is too complicated for us to go over right now).

We will only be using definition 3.3.1 for Brownian motion. You MUST understand this by heart.

#### Filtration

Once we have a Brownian motion, now we can define a filtration on that probability space. It’s a collection of \(\sigma\)-algebras, the previous sets are included in the next set. The Brownian motion \(W(t)\) must be \(\mathcal{F}(t)\)-measurable, which means we can use the information at time \(t\) to know that Brownian motion, and the increment after \(W(t)\) is totally independent of the filtration. We can have a stochastic process \(\delta(t)\) that is *adapted* to the filtration if the variable is \(\mathcal{F}(t)\). All the stochastic processes we are considering are adapted. We can only consider past data because we live in the real world, so we will use information at that time.

Brownian motion is a martingale. The argument is the same for the symmetric random walk being a martingale.

It also turns out that Brownian motion will be Markov (consider this later).

Arguably, the most famous stock market model in the world is **geometric Brownian motion**. This is what the Black-Scholes model is based on.

\(S(t) = S(0) e^{(\alpha - \tfrac{1}{2} \sigma^2)t + \sigma W(t)}\)

What’s interesting is if we look at this formula, we can break down log returns in this manner.

You can think of it as having an initial stock price which is multiplied by an exponential function which gives you an incremental change. It could grow or shrink, but it never goes to 0. The \(\alpha - \sigma^2/2\) this is a drift. If it’s a positive term then the drift will increase. \(\sigma W(t)\) is the uncertainty in the stock price, known as volatility. The \(\sigma\) determines how much impact the noise has. If \(\sigma\) is small, then the noise has a small impact. If it’s large, it has a large impact. This makes it very important, but it’s very difficult to observe. You could look at long-term behavior and get an idea of the drift, if we wanted to calibrate our alphas (?), but we can’t observe \(\sigma\). We can try through historical volatility, implied volatility, local volatility, and realized volatility.

Realized volatility says we observe the stock sufficiently often. Ideally as often as possible, hopefully tick data. If we have stock prices \(S(t_0), S(t_1), \ldots S(t_m)\)

I could create the log return of any of my stock prices:

\(\log\left(\frac{S(t_{j+1})}{S(t_j)}\right) = (\alpha - \tfrac{1}{2}\sigma^2)(t_{j+1}-t_j) + \sigma\left(W(t_{j+1})-W(t_j)\right)\)


Let’s say we have a vector of our log returns.

\(\sum_{j=0}^{m-1} (\log{(\frac{S(t_{j+1})}{S(t_j)})})^2 = \sum_{j=0}^{m-1} [(\alpha - \tfrac{1}{2} \sigma^2)^2 (t_{j+1} - t_j)^2 + 2(\alpha - \tfrac{1}{2} \sigma^2) \sigma (t_{j+1} - t_j)(W(t_{j+1}) - W(t_j)) + \sigma^2 (W(t_{j+1}) - W(t_j))^2]\)

Here’s where the statement of “often” comes into play. I could apply the summation separately, the drift becomes constant and it gets pulled out, and then you get the quadratic variation of time, which makes that first element 0

The second element is approximately the cross variation of Brownian motion and time, which is also approximately 0 (determined earlier), so you only end up with the last piece, which becomes the quadratic variation of Brownian motion, observed until time \(T\) which becomes \(T\).

So, in essence, we get that the realized volatility is approximately equal to

\(\sigma_{RV} \approx \sqrt{\frac{1}{T_2 - T_1} \sum_{j=0}^{n-1} (\log{(\frac{S(t_{j+1})}{S(t_j)})})^2}\)

Implied volatility comes about from a later formula for pricing European options model.

We have a strike price, and all the stuff associated with option price, so we could find the volatility implied by the option price that exists.

#### Markov Property

One way we can think of the Markov property is that for an adapted stochastic process if the conditional probability distribution for future states dependent on everything that has happened up to that point of time is the same as for future states, *just using the most recent number*, that process is Markov.

We are able to prove that Brownian motion is Markov.

This might seem like a cheap, semantic argument, but he believes this argument has merit.

My problem is, for some function \(f\), we’re going to look at

\(\mathbb{E}[f(W(t)) | \mathcal{F}(s)]\)

there’s very little we can say about martingales because we don’t know anything about \(f\) other than that it’s a function. We can’t talk about growth or decline or anything. Let’s think about how we could manipulate this.

In the past, you’ve seen the trick of adding the zero. That doesn’t work here because it’s wrapped in a function.

Let’s go to an “entirely different” problem now. Hypothetically, let’s say you have a dummy variable \(X\), like from algebra, some number you don’t know, a placeholder, *not* a random variable.

\(\mathbb{E}[f(W(t) - W(s) + x) | \mathcal{F}(s)]\)

The only thing that is random is the increment of bBrownian motion. What do I know about the relation of Brownian motion to a filtration? It’s independent. IBecause this is independent, we can drop the condition:

\(= \mathbb{E}[f(W(t) - W(s) + x]\)

even more obviously, the only random thing is the increment. It’s a normally distributed variable, using the definition of expectation it is

\(= \int_{-\infty}{\infty} f(w + x) \frac{1}{\sqrt{2\pi(t-s)}}e^\frac{-w^2}{2(t - s)}dw\)

\(= g(x)\)

This is basically a function because \(w\) gets integrated out

For every function \(f\), there is a \(g\).

What would be \(g(7)\)?

\(f(7) = \mathbb{E}[f(W(t) - W(s) + 7) | \mathcal{F}(s)]\)

This works with any dummy variable you put in.

What if you use \(W(s)\)?

\(g(W(s)) = \mathbb{E}[f(W(t)) | \mathcal{F}(s)]\)

Markov is just saying that you have this function conditioned on the information \(\mathcal{F}\). This is a common type of proof in this class: we prove it for everything so it becomes true for one thing.

#### Transition Density

You can express this as a **transition density**. There is a way to manipulate this through that process instead of this.

#### Stopping Time

A stopping time \(\tau\) is a random variable that takes the value \([0, \infty]\) and satisfies that \(\mathbb{E}[\tau | \mathcal{F}(t)] = t\), then \(\mathbb{E}[\tau | \mathcal{F}(u)] = t\) for \(u > t\)

In other words it’s a random variable that if there’s enough information that I’m stopping at time \(t\), no future information can change that I’m stopping at time \(t\).

An American option is the perfect example. You’re watching an instrument’s price, and you are tempted to exercise because the price is above the strike price. After, you see this amazing rally after you exercise, and you want to exercise now. There was enough information at the time you exercised that made you feel like you should have exercised. Nothing that happens after can change that fact.

Fact: A martingale stopped at a stopping time is a martingale.

#### Exponential Martingale

The process \(Z(t)\) is

\(Z(t) = e^{\sigma W(t) - \tfrac{1}{2}\sigma^2t}\)

I need to show that the expectation of the function will always be the same.

\(\mathbb{E}[Z(t) | \mathcal{F}(s)]\)

\(= \mathbb{E}[ e^{\sigma W(t) - \tfrac{1}{2}\sigma^2t} | \mathcal{F}(s)]\)

We are not going to have much luck with that zeroing out method, because this exponential function is not linear. It’s not like Brownian motion even, the increments may not be independent.

Let’s try multiplying by 1\!

\(= \mathbb{E}[Z(t) \times \frac{Z(s)}{Z(s)} | \mathcal{F}(s)]\)

this is okay because \(Z(s)\) can’t be 0. Never do that, only if you’re a physicist.

Rewrite as

\(= \mathbb{E}[Z(s) \times \frac{Z(t)}{Z(s)} | \mathcal{F}(s)]\)

\(= \mathbb{E}[e^{\sigma(W(t) - W(s)) - \tfrac{1}{2}\sigma^2(t-s)} Z(s) | \mathcal{F}(s)]\)

Now that we have an increment of Brownian motion \(W(t) - W(s)\), we can make statements about that. It’s independent of the filtration. Let’s pull the measurable piece out

\(= Z(s)e^{-\tfrac{1}{2}\sigma^2(t-s)} \mathbb{E}[e^{\sigma(W(t)-W(s))} | \mathcal{F}(s)\)

Because of independence, we can disregard our condition:

\(= Z(s)e^{-\tfrac{1}{2}\sigma^2(t-s)} \mathbb{E}[e^{\sigma(W(t)-W(s))}\)

THis is why we had the homework problem on the moment-generating function. This is effectively a moment-generating function. For any value like this, the expectation is \(Z(s)\), which makes it a martingale.



#### First Passage Time

There are some interesting behaviors to Brwonian motion

A random variable that tells me the first time that my Brownian motion reaches a certain level \(m\):
\(\tau_m = \min\{t \geq 0 ; W(t) = m\}\)

This variable is a stopping time. Whatever happens after that is not of concern to me. Knowing that a martingale that stopped is a martingale, we can talk about our exponential process introducing a martingale.

We know that

\(\mathbb{E}[Z(\tau_m)] = \mathbb{E}[Z(\tau_m) | \mathcal{F}(0)]\)

which must be 0 because it’s conditioned on first information.

This is a martingale, so it’s for any amount of time. Let’s test that:

\(\lim_{t \rightarrow \infty} \mathbb{e}[Z(t \wedge \tau_m)] = 1\)

\(\lim_{t \rightarrow \infty} \mathbb{E}\left[e^{\sigma W(t \wedge \tau_m) - \tfrac{1}{2} \sigma^2 (t \wedge \tau_m)}\right]\)

limit is a linear operator, so you can swap the order and separate them to solve both

\(\lim_{t \rightarrow \infty} e^{-\tfrac{1}{2}\sigma^2(t \wedge \tau_m)}\)

If we’re talking about the first time we reach a given level, our Brownian motion could go negative forever, nothing says it has to turn positive. The path of Brownian motion could never reach the level I need it to. The only way to express that this never happens is that my stopping time is infinity.

This adds a wrinkle to this expression because we need to express it as two different possibilities

We could also write this as

All of this was necessary to do the right limit.

There are two cases. If we consider finite \(\tau_m\), then we can disregard (t) and say that it’s equal to (e^{\sigma m}).

My process will always be less than \(e^\sigma m\) if \(\tau_m\) is infinite because instead we disregard \(\tau_m\) and look at \(t\), because that means the stopping point is never reached.

So we can say that the expected value of all of this is equal to 1.

Now this is true for any value of \(\sigma\). Usually we make the restriction that \(\sigma\) is positive. Let’s consider

We know that the probability measure of this is 1 in the case when \(\tau_m < \infty\), which means that we always expect to reach these values in finite time. But the expected amount of time to reach any of these levels is infinite.

Now we will look at \(\alpha = \tfrac{1}{2}\sigma^2\)

This will allow us to express

\(\mathbb{E}[e^{-\alpha \tau_m}] = e^{-|m|\sqrt{2\alpha}}\)

This is the Laplace transform (we will not need to know this).

An interesting thing is, given this expression, and I took the derivative of both sides with respect to \(\alpha\), I would get

\(\mathbb{E}[\tau_m e^{-\alpha \tau_m}] = \frac{|m|\sqrt{2}}{2} \alpha^{-\tfrac{1}{2}} e^{-|m| \sqrt{2\alpha}}\)

If we look at alpha going to 0, we get

\(\lim_{\alpha \rightarrow 0^+} \mathbb{E}[\tau_m e^{-\alpha \tau_m}] = \lim_{\alpha \rightarrow 0^+} \frac{|m|\sqrt{2}}{2} \alpha^{-\tfrac{1}{2}} e^{-|m| \sqrt{2\alpha}}\)

\(= \infty\)

So even though \(\tau_m\) is finite almost surely, its expectation goes to infinity.

At this point, we have our first passage time random variable \(\tau_m\) and we know a couple things about it. It’s finite almost surely, expected value infinity, only takes positive value. I’d like to find its exact distribution through its pdf. We will use the **reflection equality**.

\(\mathbb{P}(\tau_m \leq t, W(t) < w) = \mathbb{P}(W(t) > Z_m - w)\)

The probability that I reached level \(m\) before time \(t\) and my Brownian motion ended below level \(w\) is the same as the probability as it ended above \(2m - w\)

Let’s let \(w = m\). This becomes

\(\mathbb{P}(\tau_m \leq t, W(t) < m) = \mathbb{P}(W(t) > m)\)

The probability that I reach level \(m\) and \(t\) time and end up beneath \(m\) is the same that I end up above \(m\).

In general,

\(\mathbb{P}(A \cap B) + \mathbb{P}(A \cap B^c) = \mathbb{P}(A)\)

I have that

\(\mathbb{P}(\tau_m \leq t) = 2 \mathbb{P}(W(t) > m)\)

But we know that probability\! Because it’s normally distributed.

\(= 2\int_m^\infty \frac{1}{\sqrt{2\pi t}}e^{-x^2/(2t)}\,dx\)

If we do this u substitution \(u = \tfrac{x}{\sqrt{t}}\), that’s

\(= 2 \int_{\tfrac{m}{\sqrt{t}}}^\infty \frac{1}{\sqrt{2 \pi}} e^{\frac{-u^2}{2}}du\)

But this is the cdf, we want the pdf

In order to get the derivative of an interval like so,

\(\frac{d}{dx} \int_{g(x)}^{h(x)} f(y) dy = f(h(x)) h'(x) - f(g(x)) g'(x)\)

so in this context, it becomes

\(\frac{d}{dt} \mathbb{P}(\tau_m \leq t) = 0 + \frac{1}{\sqrt{2 \pi}} e^{\frac{-m^2}{2t}} \frac{m}{2}t^{-\tfrac{3}{2}}\)

That is the resulting CDF/density relationship. **Open question:** retrieve the exact displayed equation from the slides.
