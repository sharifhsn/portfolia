+++
title = 'Stochastic Integrals'
date = 2024-10-03
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Stochastic Integrals', 'Ito Integral']
+++

## Week 4

### Lecture Notes

We left off last week talking about first passage time. We said that the cdf was

Last thing before Stochastic Calculus we should talk about **maximum to date**. This will be beneficial in the latter half of the semester. This allows us to work with barrier options and other exotic financial instruments.

I define a process \(M(t) = \max_{0 \leq u \leq t} W(w_0)\)

This process takes the largest position of my Brownian motion. Is this Markov? In order for this to be the case, the only thing we need to calculate future valuations of my process is simply knowing the most recent value of my process. We could have a different Brownian motion that reaches the same peaks, but ends up being much lower at the end. In that green path, it would be much less likely for our maximum to date to change, because it’s much further from its current maximum than the blue path.

But we could create a multidimensional process that is Markov that incorporates both the Brownian motion and the maximum to date: \((W(t), M(t))\), which is 2-D Markov. Just knowing the maximum gives us no idea, we need both.

An interesting thing happens when we’re working with these maximums.

\(M(t) \geq m \iff \tau_m \leq t\) for \(m > 0\)

Why? Remember that \(\tau_m\) is first passage time. I know that I’ve reached level \(m\) before time \(t\), which means that the Brownian motion reached a maximum of *at least* \(m\), which means the maximum at time \(t\) must be greater than or equal to that.

We can rewrite our reflection equality with the maximum to date with this property.

\(\mathbb{P}(M(t) \geq m, W(t) \leq w) = \mathbb{P}(W(t) \geq 2m - w)\)

This is simply the reflection equality replacing one with the other.

If this is true, we can use this to get the joint distribution between Brownian motion and its maximum. Assume the joint distribution exists: \(f_{M(t), W(t)} (m, w)\)

If this is my joint distribution with respect to these dummy variables, I could rewrite the probability measures in my reflection equality:

\(\int_{-\infty}^w \int_m^\infty f_{M(t), W(t)} (x, y) dx dy = \int_{2m - w}^\infty \frac{1}{\sqrt{2\pi t}} e^{\frac{-z^2}{2t}} dz\)

Now I can take the derivative of both sides with respect to \(m\)

\(-\int_{-\infty}^w f_{M(t), W(t)} (m, y) dy = - \frac{1}{\sqrt{2\pi t}} e^{\frac{-(2m - w)^2}{2t}} (2)\)

We can take the derivative now with respect to \(w\) (and get rid of negatives)

\(f_{M(t), W(t)} (m, w) = \frac{2}{\sqrt{2\pi t}} e^{\frac{-(2m - w)^2}{wt}}\left(\frac{-2(2m - w)(-1)}{2t}\right)\)

This ends up being

\(= \frac{2(2m-w)}{t\sqrt{2\pi t}}e^{-(2m-w)^2/(2t)}\)

This is the *joint density* of \((M(t), W(t)\)

We also have the conditional distribution given that Brownian motion is normal, so we can take the joint over the marginal:

\(f_{M(t)|W(t)}(m|w) = \frac{2(wm - w)}{t} e^{-\frac{(2m - w)^2}{2t}}\)

We will not worry about this too much until later. This process is mostly useful because it’s an example of an adaptive stochastic process which isn’t Markov, although most are.

#### Stochastic Calculus (Integrands)

Now it’s the big kahuna.

What does this mean:
\(\int_0^T \Delta(t) dW(t) = ?\)

In order for this to be understood, \(\Delta(t)\) needs to be an adapted stochastic process.

Let’s go back to Riemann. The Riemann sum integrals mean you take some function where we chop up the x into little pieces. We take observations of the function at each \(x\). What we’re going to do in this course is still this. It’s just that we’re also going to be working with a Brownian motion. Instead of getting a \(\Delta x\), we could get our \(\Delta W(t)\). You take the heights from the result of the adapted stochastic process, but the change comes from the stochastic process. However, every Brownian motion has a different result, it’s random. This means that the stochastic integral itself is a random variable. Why do we care? Let’s start with a specific, motivated example.

A **simple process** is one that given a partition, \(\Delta(t)\) is a constant.

The random walk is a simple process.

Given a partition of \(x\), you take one value that you hold at every partition piece which changes randomly.

If we put ourselves under the constraint that \(\Delta(t)\) is a simple adapted process.

We’re going to construct a hypothetical. We have a stock. The value of the stock is given by Brownian motion \(W(t)\). \(\Delta(t)\) is the position I hold in the stock, with these rules: At the beginning of the day, I take the position of the stock and hold it for the rest of the day, until the next day. I have no idea what position I’m going to hold tomorrow.

Let’s start at day 1

\(I(t) = \Delta(t_0) (W(t) - W(t_0))\)

Hanging out here in Day 1 \(t_1 \leq t < t_2\) I’ve made

\(I(t) = \Delta(t_1)(W(t) - W(t_1)) + \Delta(t_0) (W(t_1) - W(t_0))\)

from the previous day as well.

Check on Day 3

\(I(t) = \Delta(t_2) (W(t) - W(t_2)) + \Delta(t_1)(W(t) - W(t_1)) + \Delta(t_0) (W(t_1) - W(t_0))\)

For Day K \(t_k \leq t < t_{k+1}\) we have made since we started investing

\(I(t) = \Delta(t_k) (W(t) - W(t_k)) + \sum_{i=0}^{k - 1} \Delta(t_i)(W(t_{i+1}) - W(t_i))\)

This essentially is the size of my position which is multiplied by

I want to look at thai integral

\(\int_{t_j}^{t_{j+1}} \Delta(u) dW(u)\)

If I know that my \(\Delta\) is a simple process, it’s going to take a value at the beginning of my time increment and hold that value for the entire time.

\(= \int_{t_j}^{t_{j+1}} \Delta(t_j) dW(u)\)

How does my \(\Delta(t_j)\) change as I move? It doesn’t, so I can pull it out

\(= \Delta(t_j) \int_{t_j}^{t_{j+1}}dW(u)\)

which by the fundamental theorem of calculus is

\(= \Delta(t_j) (W(t_{j+1}) - W(t_j))\)

Therefore, I can rewrite the sum in my return calculation as this integral.

If I make these substitutions, I have that

\(I(t) = \int_{t_K}^t \Delta(u) dW(u) + \sum_{i=0}^{k-1} \int_{t_i}^{t_{i+1}} \Delta(u) dW(u)\)

But obviously the summation of an integral is still an integral.

\(= \int_0^t \Delta(u) dW(u)\)

What does it mean to integrate a process other than Brownian motion? We shall see.

We can wave our hands a bit about the trading of a stock. You could trade at the beginning of the day and at lunch, or every minute. Not the best idea but you could do that. This time works with a partition. This is now our **Ito integral**. What makes it an Ito integral is that our partition pieces are from \(t_k\) to \(t_{k+1}\), where they include the left and take that value, and exclude the right. We are always taking the left Riemann integral. I can’t decide at lunch what price I bought the stock at in the morning. I can only make those choices based on the information I had at that time. That’s why adapted processes are a big deal and everything needs to be measurable. If you trade with unavailable information, that is insider trading, very illegal. So that’s why we have to use Ito integrals.

Interestingly, these Ito integrals are martingales.

#### Proof that Ito Integral is a Martingale

Prove that \(I(t)\) is a martingale.

Here’s our situation. We have an arbitrary partition of our time, for which there exists some \(k\) such that \(t\) belongs to that partition piece \(t \in [t_k, t_{k+1}]\). To prove that this is a martingale, I need to prove for that \(s \leq t\),

\(\mathbb{E}[I(t)| \mathcal{F}(s)] = I(s)\)

This has to work whether \(s\) is in the same time piece or in an earlier one, so there are two different cases to account for.

##### Case 1: \(\exists l < k \text{ s.t. } s \in [t_l, t_{l+1}]\)

It could be in the one at the start or the one just before.

I’m going to be able to say that

\(I(t) = \sum_j^{l-1} \Delta(t_j) (W(t_{j+1}) - W(t_j))+ \Delta(t_l) (W(t_{l+1}) - W(t_l)) + \sum_{j=l+1}^{k-1} \Delta(t_j) (W(t_{j+1}) - W(t_j)) + \Delta(t_k) (W(t) - W(t_k))\)

All days before \(l\), day \(l\), and all days from \(l\) to \(k\) p to how far we are into day \(k\)

Because this is a sum, we can split this up by linearity of expectations:

\(\mathbb{E}[A|\mathcal{F}(s)] = \mathbb{E}[\sum_{j=0}^{l-1} \Delta (t_j) (W(t_{j+1}) - W(t_j)) | \mathcal{F}(s)]\)

We will use the properties of expectations here. I would say at this point that linearity is already used, but let’s try something else. What is the latest time index referred to in this summation? It’s \(l\). But here’s the thing. Because \(s \in [t_l, t_{l+1}]\), then \(s \geq t_l\). So everything is known, so we can take out everything and leave 1.

\(= A\)

Let’s try \(B\)

\(\mathbb{E}[B|\mathcal{F}(s)] = \mathbb{E}[\Delta(t_l) (W(t_{l+1}) - W(t_l) | \mathcal{F}(s)]\)

\(= \Delta(t_l) \mathbb{E}[W(t_{l+1}) - W(t_l) | \mathcal{F}(s)]\)

Let’s brute force this with linearity, and then do the elegant solution later

\(= \Delta(t_l) \left[ \mathbb{E}[W(t_{l+1}) | \mathcal{F}(s)] - \mathbb{E}[W(t_l) | \mathcal{F}(s)]\right]\)

Generally in order to break up these problems we try to add a 0 to break it up into an independent piece and a measurable piece.

\(\mathbb{E}[W(t_{l+1}) - W(s) + W(s)|\mathcal{F}(s)]\)

We know future increments are independent. Therefore, we can use linearity to split them, independence to drop the first condition, and measurability to take out what’s known from the second part.

We could have solved this with a single step if we remember that Brownian motion is a martingale.

Now let’s consider \(C\)

\(\mathbb{E}[\Delta(t_j) (W(t_{j+1}) - W(t_j)) | \mathcal{F}(s)]\)

We know that the Brownian motion part is independent, but the delta isn’t. And none of this is measurable. We can use iterated conditioning, though. For \(\mathcal{F}(s) \subseteq \mathcal{F}(t)\)

\(\mathbb{E}[\mathbb{E}[X|\mathcal{F}(t)] | \mathcal{F}(s)] = \mathbb{E}[X|\mathcal{F}(s)]\)

I can do this by using the property of filtrations.

\(= \mathbb{E}[\mathbb{E}[\Delta(t_j) (W(t_{j+1} ) - W(t_j)) | \mathcal{F}(t_j)] | \mathcal{F}(s)]\)

We have a hard time picking this time, because it’s true for a lot of them. We know that it’s time \(t\) or later. My adapted process is measurable with respect to time \(t_j\) or later. So we can use \(t_j\). We can take out what’s known now.

\(= \mathbb{E}[\Delta(t_j) \mathbb{E}[W(t_{j+1}) - W(t_j) | \mathcal{F}(t_j)] | \mathcal{F}(s)]\)

We know that the stochastic process is independent and that it’s a martingale, so we can get rid of that whole thing and call it 0.

\(= 0\)

So the conditional expectation of \(C\) is 0.

Finally, let’s consider \(D\).

\(\mathbb{E}[D|\mathcal{F}(s)] = \mathbb{E}[\Delta(t_k) (W(t) - W(t_k)) | \mathcal{F}(s)]\)

We can use the same exact proof for \(C\) that uses iterated conditioning for \(t_k\).

We have just proven that we can get rid of C and D, so our final expectation is

\(\mathbb{E}[I(s)] = \sum_{j=0}^{l-1} \Delta(t_j) (W(t_{j+1}) - W(t_j)) + \Delta (t_l) (W(s) - W(t_l))\)

We need to touch all of our spinning plates to understand why we’re doing. When \(s\) occurs on day \(l\). If we think about this intuitively, this value is the same as \(I(s)\) because it is all the spinning plates going up to \(l - 1\) plus the time into \(l\) that comes to \(s\). That means

\(= I(s)\)

So it’s a martingale

##### Case 2 \(s < t; s, t \in [t_k, t_{k+1})\)

We are trying to figure out

\(\mathbb{E}[I(t) | \mathcal{F}(s)]=\)

Knowing that \(s\) and \(t\) occur on the same day, we don’t need all those pieces. So this is simply

\(= \mathbb{E}\left[ \sum_{j=0}^{k-1} \Delta (t_j) (W(t_{j+1}) - W(t_j)) + \Delta (t_k) (W(t) - W(t_k))|\mathcal{F}(s)\right]\)

What is the relationship of \(s\) to time \(t_k\)? It’s greater than or equal to.

In this summation, all of these pieces are measurable because \(s\) is greater than \(k\).

\(= \sum_{j=0}^{k-1} \Delta (t_j) (W(t_{j+1}) - W(t_j)) + \mathbb{E}[\Delta(t_k)(W(t) - W(t_k)) | \mathcal{F}(s)]\)

By taking out what is known, we can get

\(= \sum_{j=0}^{k-1} \Delta (t_j) (W(t_{j+1}) - W(t_j)) + \Delta(t_k)\mathbb{E}[W(t) - W(t_k)|\mathcal{F}(s)]\)

This is not a future increment. The time is smack dab in the middle of the increment. In this case, you should add a 0, which allows you to take out what is known and show independence.

\(= \sum_{j=0}^{k-1} \Delta (t_j) (W(t_{j+1}) - W(t_j)) + \Delta(t_k)(W(s) - W(t_k))\)

which is just

\(= I(s)\)

Thus, we prove that the Ito integral is a martingale for all cases.

The fact that the Ito integral is a martingale is a lifesaver later int eh course. That means that \(I(0) = 0\)

#### Ito Isometry

We will now look at the expectation of \(I^2\)

\(\mathbb{E}[I^2(t)] = \mathbb{E}\left[\int_0^t \Delta^2(u)du\right]\)

This gives me the variance of the Ito integral. Let’s prove that this is the case.

Let’s do a slight modification of \(I(t)\) for the purpose of these proofs.

\(D_j = \begin{cases} W(t_{j+1}) - W(t_j), & \text{for } j \in \{0, 1, \ldots k- 1\} \\ W(t) - W(t_k), & \text{for } j=k \end{cases}\)

Which we do so that we can define

\(I(t) = \sum_{j=0}^k \Delta(t_j) D_j\)

\(I^2(t) = \left(\sum_{j=0}^k \Delta(t_j)D_j\right)\left(\sum_{j=0}^k \Delta(t_j)D_j\right)\)



I’m also going to observe at this point.

Let’s think a little about how matrices work. We could envision a matrix like this:

\(= \sum_{j=0}^k \Delta^2(t_j)D_j^2 + 2\sum_{0 \leq i < j \leq k} \Delta (t_i) \Delta(t_j) D_i D_j\)

Let’s think about filtrations

\(\mathcal{F}(t_j): \Delta(t_i)\Delta(t_j)D_i\) is measurable

\(D_j\) is a future value and therefore is independent

We must have independence between random variables if one of them is measurable by a \(\sigma\)-algebra and the other is independent of that \(\sigma\)-algebra.

\(\mathbb{E}[I^w(t)] = \mathbb{E}[\sum_{j=0}^k \Delta^2(t_j)D_j^2] + 2\mathbb{E}\left[\sum_{0 \leq i < j \leq k} \Delta(t_i) \Delta(t_j) D_i D_j \right]\)

We can use linearity of expectations here

\(= \sum_{j=0}^k \mathbb{E}[\Delta^2(t_j)] \mathbb{E}[D_j^2] + 2\sum_{0 \leq i < j \leq k} \mathbb{E}[\Delta (t_i) \Delta(t_j) D_i] \mathbb{E}[D_j]\)

Since \(D_j\) is Brownian motion, the expected value is 0 which makes that entire sum 0, and the expectation of \(D_j^2\) is the variance, which is known to be \(t\)

\(= \sum_{j=0}^k \mathbb{E}[\Delta^2(t_j)] (t_{j+1} - t_j)\)

Let’s take it the other way with linearity

\(= \mathbb{E} \left[ \sum_{j=0}^k \Delta^2 (t_j) (t_{j+1} - t_j)\right]\)

What do you call it when you add up all the area of those rectangles? This is the definition of a Riemann integral\! This is nearly

\(= \mathbb{E}\left[\int_0^t \Delta^2 (u)du\right]\)

Which is the variance of any Ito integral.

All we know about \(\Delta\) is that it’s an adapted stochastic process, so we can’t simplify it further. But we will get one numeric value for the variance. We can further prove that this is the quadratic variation for an Ito integral.

\([I, I](t) = \int_0^t \Delta^2(u)du\)

This is similar to the isometry except that it’s not the expectation. This is because variation can be a random variable. Why do these look so similar then? Let’s prove it.

Let’s say I have a partition defined as

\(\Pi = \{t_0, t_1, t_2, \ldots, t_{k+1}\}\)

\(\Pi_i = \{s_0 = t_i, s_1, s_2, s_3, \ldots, s_{n+1} = t_{i+1}\}\)

Essentially, let’s create a new sub-partition for each partition piece.

\([I, I](t) = \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{m-1} (I(t_{j+1}) - I(t_j))^2\)

I want to note that the difference in the sum, assuming that we are in a single time partition piece, means that

\(= \lim_{i=0}^{k+1} \lim_{\|\Pi\| \rightarrow 0} \sum_{j=0}^{n-1}(I(s_{j+1}) - I(s_j))^2\)

variation over entire partition is sum of variation over each sub-partition.

Let’s look just at the difference in the sum. If we expand this squared part and eliminate it, we can show the required cancellation (**Open question:** work through the algebra explicitly).

We know that \(\Delta(t_i)\) is going to take one value and hold it because it is a simple process.

This limit is the very definition of the quadratic variation of Brownian motion over that time piece, so we can simplify it to time.

\(= \sum_{i=0}^{k-1} \Delta^2(t_i) (t_{i+1}-t_i)\)

which because it’s a simple process is

\(= \int_0^t \Delta^2(u)du\)

Keep in mind that there are no expectations because we are looking for variation not variance

#### Square Integrability

Very important consideration\! Our Ito integrals are only going to exist if this process \(\Delta(t)\) is such that the variance is finite, since infinite variance is not a well-defined concept. This is known as the **square-integrability condition**.

Once that is satisfied, we can define \(\Delta_n(t)\) as a sequence of simple processes which together converge to a non-simple process \(\Delta(t)\) in this way

\(\lim_{n \rightarrow \infty} \mathbb{E}\left[\int_0^T |\Delta_n(t) - \Delta(t)|^2 dt \right] = 0\)

Then I can define my Ito integral as

\(\int_0^t \Delta(u)dW(u) = \lim_{n \rightarrow \infty} \int_0^t \Delta_n(u)dW(u)\)

If you can pull all this off, you get these properties:

1. Continuity. The integral is continuous. Brownian motion is continuous, and the integral over the short interval \[s,t\] goes to zero as \(t\) approaches \(s\). Thus a discontinuity in the adapted integrand does not create a jump in the integral.
2. Adaptivity: every piece is measurable
3. Linearity: these are all just summations, so you can apply all linearity properties
4. Martingale (proven)
5. Ito isometry (proven)
6. Quadratic variation (proven)

The first stochastic integral:

\(\int_0^t W(u)dW(u)\)

essentially

\(\int x dx\)

but it does something a little weird, not just the reverse power rule.

The result of this integral is entirely due to the fact that quadratic variation is nonzero.

Next week we will prove this.
