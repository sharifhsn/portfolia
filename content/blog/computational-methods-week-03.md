+++
title = "Tree Approximation and American Options"
date = 2025-02-11
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Binomial Trees","Option Pricing","American Options","Barrier Options"]
+++

## Textbook \- MF3

## Tree Approximation

We’re not going to use the arbitrage method, we are going to use the forest methods.

### Stochastic Process

You all understand the stochastic process.

Fundamentally, it starts from a point \\(S_0\\), and has these continuous paths that are very weird, because they’re not differentiable. If you blow up the curve, it should smooth out, but actually it stays just as jagged. Therefore we draw an approximation where we draw lines on tiny intervals to approximate the Brownian motion.

The thing is, this is a diffusion process. You kind of know the distribution of the path, the \\(dS_t\\) follows \\(\\mu S_t dt + \\sigma S_t dW_t\\).

This is an exponential of a normal, it’s called **lognormal**. This distribution has a known shape. A whole bunch of paths will end up at the end.

### Discretization

The tree approximation says that the idea that this is continuous is bullshit. So let me do something else. Instead of something that goes all over the place, I’ll start at \\(S_0\\) and approximate the path by discrete intervals. At each step, the distribution should approximate the log-normal thing. It’s the same at each slice.

How is this working if the tree is discrete? But as the Δt shrinks, you will have more and more points, you take the interval to be smaller. Each point will have a certain probability, which will reflect the target distribution.

### Kolmogorov

In probability theory, there’s a big theorem Kolmogorov.

These continuous time processes, as long as you have two, that match in their discrete time distribution. And if the distribution is the same, jointly, you can say it’s the same process.

And that’s why this worked. That’s the idea of any tree construction. You want to make it so that it matches each distribution.

There are two different requirements. It has to match this distribution, and it has to be **recombining**.

Recombining tree will go from one point to two points, the binomial tree. If you don’t recombine, you go from 4 to 8 to 16, n steps will create \\(2^n\\) paths, each distinct. If you do 64 steps, then you use all the bits in your computer. That means your computer will crash. 64 steps is very little, so the alternative is…

Recombining! You need to store the nodes, so it will grow at a polynomial rate, \\(1 + 2 + 3 + 4 + \\cdots\\), which is \\(n(n+1)/2 \\to O(n^2)\\), this is much better than \\(2^n\\).

The number of paths are the same, you just use the same points.

Even though I basically have the number of paths, and I can store them in a computer, I still don’t do anything if I’m pricing path dependent options. There’s a problem: what if this isn’t a Markov process? If it doesn't just depend where I am now, I have to remember where I was before, and that costs 2^n.

So this only works when you’re trying to approximate a Markov process, where you can assume that all information is encoded in the value at the end.

Sidebar: This is a difference between stochastic processes and LLMs. LLMs are just the most horrible things, they do exponential stuff, because the language is finite, not like numbers.

There’s a discussion in the textbook: Florescu’s work is a general diffusion approximation method (6.9)

### The Traditional Tree

We’ve done the u and d before. But is that the only tree? It’s just a single tree. I’m not going to do that tree, because that tree is complicated. There are two trees you can make. There is the process

$$dS_t = \\mu S_t dt + \\sigma S_t dW_t$$

Everything we’re doing is the geometric Brownian motion, we are not approximating any other stochastic processes. You could, but they think we’re stupid, so they only teach you one single tree of one type. Trees are fascinating. You can do whatever you want, but you need to understand how they work in order to use them.

What is the difference between **additive tree** and **multiplicative tree**?

$$dS_t = \\mu S_t dt + \\sigma S_t dW_t$$

But then you need to do Girsanov to use risk-neutral measure

$$dS_t = r S_t dt + \\sigma S_t dW_t^Q$$

But this stochastic process is multiplicative. If you take an approximation and get

$$
S\_{t+\\Delta t} \- S\_t \= \\int\_t^{t \+ \\Delta t} rS\_t dt \+ \\int\_t^{t \+ \\Delta t} \\sigma S\_t dW\_t$$

This is a Riemann integral and  stochastic integral. We can approximate this by taking the left point, the value in t.

If you do the homework, if you use a quadrature rule, we’re using the rectangle here. Here we’re using the stochastic integral approximation, because we know that the expectation of the increment of Brownian motion is 0\.

$$
S\_{t+\\Delta t} \= S\_t(1 + r\\Delta t \+ \\sigma \\Delta W\_t)
$$

The resulting tree that you use to approximate \\(S_t\\) is called multiplicative. That’s why we took S and multiplied it by u or by d. That value is supposed to be that thing in parentheses, or something that converges to it.

What if I don’t care about this, and I want to approximate in the most efficient way possible? If you take \\(R_t\\) to be the logarithm of \\(S_t\\), and apply Itô to \\(R_t\\), you get

$$
dR\_t \= (r- \\tfrac{\\sigma^2}{2}) dt \+ \\sigma dW\_t^Q
$$

And then if you discretize,

$$
R\_{t+\\Delta t} \= R\_t \+ (r \- \\tfrac{\\sigma^2}{2}) \\Delta t \+ \\sigma \\Delta W\_t
$$

And this is direct, not an approximation. The next R\_t is the previous one plus something.

What is the difference?

In the multiplicative case, you go from some S value with some \\(p_u\\) and \\(p_d\\) to \\(S u\\) and \\(S d\\). But, this is equivalent to \\(\\log S\\) to \\(\\log S + \\log u\\) or \\(\\log S + \\log d\\). These two trees are completely equivalent.

This is possible because logarithm is a monotonically increasing function, so it can be a one to one transformation.

We’re going to do additive because we’re not imbeciles, much easier than multiplicative.

The two conditions:

1. The tree needs to be recombining. I can do that as long as I am dealing with a Markov process. That’s why we learn that GBM is a Markov process in 610, because it’s very valuable.
2. We need that calculated approximating derivative value needs to converge to the value calculated using the continuous process. I don’t really care about the continuous process. I’m trying to approximate the option price/premium. As long as it converges to the true value, then I’m fine.

## Convergence

There is a value at time t, a random variable. I quantify the value by looking at the probability I reach every single point, where there’s a probability at each point, a discrete distribution, which should converge to the continuous version.

\\(R_t^d\\) is the random variable obtained using a discrete tree.

Let \\(R_t\\) be the random variable using the continuous time process.

A stochastic process (by the way), there are two things. It depends on the path, and also time. It’s technically a function of two things. For each path, you have times, so you can slice the stochastic process by either the path or the time. What I’m talking about here, it’s at some fixed t, with some random variable coming from the tree and from the stochastic process. We want our tree to converge to the stochastic process.

The payoff should

$$
\\mathbb{E}[e^{-r(T \- t)}\\varphi(R\_T^d)|\\mathcal{F}\_t]
$$

(discount factor doesn’t really matter)

This value should converge to

$$
\\mathbb{E}[e^{-r(T \- t)}\\varphi(R\_T)|\\mathcal{F}\_t]
$$

In the theory of random variables, we have tons of convergences. Any convergence will work.

The weaker type of convergence is convergence in distribution. It says that you have a series of random variables that converge in distribution to a target as long as the distribution of the random variables converges to the distribution of the target. With this tree, that’s what we are aiming to do.

In most trees, you take Δt to go to 0\.

We are going to be doing the additive tree.

From \\(R_0\\), we can go only one. Either you’ll go to \\(R_0 + \\Delta R_u\\) or \\(R_0 + \\Delta R_d\\), with some probability \\(p_u\\) and \\(p_d\\).

Everything is done in terms of Δt.

What about the next step?

Technically, I can use a different probability. But we have a very nice GBM, with a normal distribution in Brownian motion. As long as we have the same size of the interval, they have the same distribution, and we can use the same probability.

$$
R\_0 \+ 2\\Delta R\_u, R\_0 \+ \\Delta R\_u \+ \\Delta R\_d, R\_0 \+ \\Delta R\_u \+ \\Delta R\_d, R\_0 \+ 2\\Delta R\_d
$$

Then you notice that the two middle values can recombine. You don’t need to have any relationship between \\(\\Delta R_u\\) and \\(\\Delta R_d\\), and it doesn’t matter.

The other condition is that it has to converge to the continuous distribution. We are working with the additive case, which is very easy. So we know that

$$
R\_{t+\\Delta t} \- R\_t \\sim N\\left((r \- \\tfrac{\\sigma^2}{2}) \\Delta t, \\sigma^2 \\Delta t\\right)
$$

The tree with this R^d\_t, is an increment with only two values.

It’s a very simple Bernoulli distribution, with a probability to \\(\\Delta R_u\\) and \\(\\Delta R_d\\).

The normal is characterized by mean and variance. So therefore we will advance a general theorem, which was proved in terms of Central Limit Theorem.

There’s a French guy who proved it with binomial distribution. You have a number of trials, and a number of successes, and he looked at average number of successes. As n goes to infinity, the distribution of the average minus p and divided by blah blah converges to the standard normal. And that’s what started the whole Central Limit Theorem, and it was extended to different distributions by Laplace.

If you decrease the time interval and you look at the probabilities, they will be binomial probabilities, exactly the same. But there’s a fundamental reason why this is happening.

Florescu has proven a more general convergence theorem for trees, discusses infinitesimal generator.

I’m going to look at the moments of R\_t^d and set them equal for discrete and continuous, to get our probabilities.

How do we solve for these four unknowns?

### Mean

$$
\\Delta R\_u p\_u \+ \\Delta R\_d p\_d \= (r \- \\tfrac{\\sigma^2}{2}) \\Delta t
$$

### Variance

Pretty ugly, so we won’t equate, we’ll just equate the second moment. We’ll use the property that

$$
\\mathbb{E}[R\_t^2] \= \\mathbb{V}[R\_t] \+ (\\mathbb{E}[R\_t])^2
$$

Therefore

### Probabilities

$$
p\_u \+ p\_d \= 1
$$

## What else?

DeMoivre proved binomial converges to normal. The normal is characterized completely by the mean and variance, so this is all we need. We don’t need to look for anything else.

And actually any number of four parameters solved will give us the tree. There’s an infinite number of trees that solve this.

In practice…

This was actually initiated and proven by finance guys, who all came up with it from complicated arguments.

They solve it for one specific case.

If you take ΔR\_u \= \-ΔR\_d \= ΔR, where you go up and down by the same quantity. Now you will have in this system, three equations with three unknowns, which creates a unique solution.

This is called the **Cox-Ingersoll-Ross** tree, very famous, the first.

You can also take p\_u \= p\_d \= ½. The probabilities are constant, but the values may be different. This is the Trigeorgis tree.

For CIR, expressed multiplicatively, you get

\\(S_t e^{\\Delta R}\\), and \\(S_t e^{-\\Delta R}\\)

And to solve it, there’s no mystery. It’s just a system.

\\(\\sigma\\) and \\(r\\) are given to you, by implied volatility and the interest rate. \\(\\Delta t\\) is your choice, typically expressed by \\(T/n\\).

Sidebar: Technically, some trees are better than others. The one with symmetric values is faster to converge, but in general they have the same order of approximation.

It depends, however, on what you’re approximating.

Let’s approximate the European option. This is simple because the payoff only depends on the terminal value. Given this, you have that the price of the premium is

$$
\\mathbb{E}[e^{-rT} \\varphi(S\_T)|\\mathcal{F}\_0]
$$

There is a simple derivation that makes sense to me, and this is why the tree functions.

~~~text
\= \\mathbb{E}\[e^{-r(T-\\Delta t)} \\mathbb{E}\[e^{-r\\Delta t} \\varphi(S\_T)|\\mathcal{F}\_{T-\\Delta t}\]|\\
~~~

This uses the tower property of conditional expectations. As long as you discount back by something bigger, then you can get it back. Now you can see that this is conditioned on the penultimate step. And you can continue to nest these expectations so that each expectation is conditioned on each step.

What this tells you is basically, you can look at the final value \\(\\varphi(S_T)\\) and come back to the previous step, calculate the expectation there, and go on.

Then I can calculate the European call if I get \\(S_T\\) from \\(R_T\\).

The discount factor is actually irrelevant because either you do it at first, or you do it every step, or at the end, doesn’t matter.

You will need to research and construct this algorithm.

## Algorithm

inputs:

- r: interest rate
- σ: volatility
- S\_0: initial stock price
- T: time to expiration
- K: strike price
- n: number of steps

Then decide what tree you’re going to use, CIR or Trigeorgis

$$
R\_0 \= \\log S\_0
$$

$$
\\Delta t \= T / n
$$

Then you calculate ΔR. The formula is in the book, based on the tree. Same for p\_u and p\_d.

#### What makes us special?

I solve problems that no one else can solve, I know math and coding. Nonstandard pricing comes in, it’s the Stevens student that says I can do it.

Then you calculate the terminal values at the end. There are n + 1 points after n steps. You have to create a vector of values \\(R[0] = R_0 + n\\Delta R\\), and \\(R[1] = R[0] - 2\\Delta R\\)

An algorithm is not something you just wake up and do, you have to think about it on paper, then code it. That’s why we have immigrants.

You’re working with vectors, that have n \+ 1 values, if you step back and take the two values and

There’s no book with this information.

### Sidebar: Nash Equilibrium

If everyone in the room has one objective, and they want to maximize their profit, they all have to interact. The shares are being handed out, you get a mini-market, where they exchange assets to do this. This guy Nash proved that if we all have an objective, there is only one way in which the wealth is distributed that maximizes everyone’s objectives. The theory doesn’t work because it assumes that everyone has the same objective all the time, which is not understanding human beings. If the Nash equilibrium existed, there would be no trading, nobody would desire to have more.

## American Options

Other than some horrible equations, you have to use trees. Monte Carlo doesn’t work, because you would like to exercise at the maximum value, but you don’t know that at the time, only when you get to the end.

If you are in the tree, you will compare with the expected future value. The discount factor needs to be done in the tree here because you will need to know what the discounted expected value is. You do it from the point and you calculate the value. You have two values, and you take whichever one is higher. This is a very useful way of thinking, related to reinforcement learning. This is based on the idea that you take the best action now which maximizes my future expected reward.

Physics is baby shit, with stupid matrix algebra. Finance is way harder.

You can also use trees to approximate Heston or SABR.

There’s one thing to mention.

## Call vs Put

There’s an argument in the book about put call parity.

The American call and the European call are the same exact number. This is a mathematical thing because of the stochastic process we do, which is continuous.

There was no place in the tree when you stepped back when it was optimal to exercise.

But in the put, there are places in which it is appropriate to exercise, which creates a larger number than European put option.

Dividends are also a different question, or if the stochastic process jumps, which creates value for the American call.

Pretty much every path-dependent option can be done through this trick. The fundamental thing is the expected value of the future, conditioned on the particular node you’re in, which is what you’re storing.

HW1 is not about trees, HW2 is about trees.

I’m going to ask you to price a barrier option.

### Barrier Option

There are two types, the IN and the OUT type.

IN option (can be call or put), is worthless unless the stock price hits the barrier. At that point, the option activates. An UP and IN call option, means the barrier is up from the starting price, IN means that once the barrier is reached, then the option is activated, and it’s a call option, which has its own strike price.

The OUT option starts as a regular option, which becomes worthless if the barrier is hit.

Let’s say you go the Bank of America and say you want to buy options. Instead of having a fixed rate on my house, I want to buy variable rates. Then BofA looks at instruments created by a quant, which gives the rate. That’s an option that’s provided by a specialist.

Options are issued by the owner of a stock. You can write covered options if you own the stock. You can write an option if your broker allows it, or if you won the call. You can provide naked calls, where you don’t have the actual share. I have 100 shares up for bidding. I could, using the money I bought from an option, buy another option, and close my contract no matter what.

Let’s say I hold onto my option until expiry, and receive my money, and then my share is gone. The broker will settle the contract.

The other thing you should look at is, if you look at this data, you should explain the value of the options. There’s something called open interest (openint) and volume. Volume is the number of contracts being transacted, typically per trading day. Open interest is how many contracts are actually open. The number of contracts open is usually very small compared to transacted. The same contract is being bought and sold, 50 issuances traded a thousand times.

This is relevant because it applies here. Basically, sometimes you don’t want to have the contract becomes active. There’s no risk of the option cannot be exercised. Barrier options are typically used for fixed income instruments. The barrier technically here depends on the underlying, which for fixed income is the rate, which is floating. For that, you want to have protection because you don’t want to pay more than e.g. 5%, but you don’t want to activate that unless the thing goes crazy. That’s when you put the barrier in place.

\\(S_0\\) the contract is either going to be a call, with \\(S_T - K\\) or a put with \\(K - S_T\\)

This is not very relevant because the option will become active no matter what.

But the barrier matters.

DOWN, UP, IN, and OUT are the four parameters, with four possibilities.

There is a relationship between this.

Let’s say the barrier \\(= B\\). Let’s talk about a CALL UP and IN. This option only becomes valuable when the barrier is hit from below. YOu can model this with an indicator

$$\\mathbb{I}\_{\\{S\_t \> B\\}}(S\_T-K)\_+$$

What about UP and OUT? If this is happening, then I get zero, otherwise you get the payoff

$$
\\mathbb{I}\_{\\{S\_t \\leq B\\}} (S\_T \- K)\_+
$$

But these two sets are complementary to each other. If you add this using probability theory, you will see that these sum up to 1\.

So if you take a call that’s up and in, and a call that’s up and out, you will get a regular call.

That means that you don’t have to calculate both of the barrier options, you only need to calculate the regular call and the one that you figure this out.

The reason this matters is because the OUT is way easier to price than the IN. The reason is because we are using a tree. If you look at a path in the tree, this is complicated because you have to keep track of the paths. The difficulty is with the point which is under the barrier, but it could be reached by crossing the barrier. If it’s IN, then it becomes valuable. So you have to look at all the paths that cross the barrier, so complicated.

But with the OUT, if it passes the barrier, then you set to zero, and don’t count them at all.
