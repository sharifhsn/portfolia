+++
title = "Monte Carlo and Variance Reduction"
date = 2025-04-08
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Monte Carlo","Variance Reduction","Control Variates","Asian Options"]
+++

## Monte Carlo Methods

We will cover this stuff in two different lectures. Today is Monte Carlo 1.

The two theorems are the basis of the entire Monte Carlo simulation.

**The Law of Large Numbers** **(LLN)**

This says, very simply, given iid random variables X1, … Xn, mean μ, finite/bounded variance. If the variable has an infinite variance, it cannot converge because it goes all over the place. So that’s the one condition.

Then

There is zero probability I won’t converge.

$$
\\bar{X} = \\frac{\\sum_{i=1}^n X_i}{n}
$$

$$
\\mu = \\mathbb{E}[X]
$$

How does it converge, though? It’s one thing to converge slowly, and another to be fast.

This is governed by the **Central Limit Theorem** **(CLT)** that you also learn about in probability and statistics.

This says that if you have the same situation X1…Xn iid, mean μ variance σ^2 \< ∞. Bounded means I have unknown variable Xi, variance keeps going up, σ \* n. Technically its’ finite, but it keeps going up.

then

\\(\bar{X} \approx N\left(\mu, \frac{\sigma^2}{n}\right)\\)

This itself is kind of nonsensical, so we would say that the distribution of this transformed random variable approaches a normal distribution.

$$
\\frac{\\bar{X} - \\mu}{\\sigma / \\sqrt{n}} \\sim N(0, 1)
$$

But the approximation helps us understand it better:

If you have fifty distributions, and you look at the distribution of those fifty, it will look close to some normal distribution. If you increase it even more, it will shrink the variance, and it will get closer to your object the estimate. And this gives you a numerical measure of how close you are, it allows you to express a *confidence interval*.

At 95% C.I. \\(\\bar{X} \\pm 1.96 \\tfrac{\\sigma}{\\sqrt{n}}\\)

Now technically we don’t know σ. So in practice we use the sample stdev S, which is

$$
S = \sqrt{\frac{1}{n-1} \sum_{i=1}^{n} (X_i - \bar{X})^2}
$$

Then if n is small, we use t\_n-1 instead of N(0, 1\)

But we’re never doing less than 10k simulations so this is irrelevant to us.

n degrees of freedom with greater than 100 n, it goes Normal.

What does this have to do with anything?

This is the key idea.

We’re going to obtain somehow values for my stock in the future. Based on those values in the future, I’m going to estimate the value of my derivative. I estimate one path, and I pretend that’ smy path in the future. If I know that’s the path in the future, I can use the terminal value and current values of the path to calculate the derivative, if I know the values of the path. That’s my observation X1.

Then I’ll do another path, which will be X2. And i’ll obtain all those rvs, and I can estimate μ, the expected value of the derivative. I’m using this formula to estimate an expectation.

It works every time for this purpose because of the LLN.

The question is, how do we calculate these things, with mean μ? The **real problem** needs you to forecast what X\_T is in the future.

**Step 1**, most important step:

Hypothesize a model of evolution from X\_0 to X\_T

I know where I am now, I’m at X\_0.

I want to know what are my assumptions about the world that will lead me from now until T. THis is more complicated, because you need to place all these assumptions. Let’s say I generate a stock price, which we’ve been doing, I want to know what the price of the fixed income of the treasury bond is, which is repaid a year from now. The Treasury is AAA, never default. You know what the price is. Can I calculate the rate of this instrument that is issued for this price right now, then gives me $1 payoff at maturity. But in the Trump era, but we don’t know if it’s safe anymore. So we need to figure out what the risks are. Then you need to play in things that aren’t part of your model? How do you implement this? You can do jumps. Between now and next year, Trump will do something to collapse the market, which will be permanent not temporary. Last week was temporary, nobody cares. But a permanent thing where the economy is severely damaged, that makes it so I might not get this money I’m getting. Then you need to introduce jumps. That requires you to do Monte Carlo with jumps, which is on the homework.

But this Step 1 is the most important part.

If you are financial engineer, you need to be able to understand randomness and how it relates to real life. You need to relate real life to this Monte Carlo simulation. The methodology by itself is very straightforward, but you have to understand how it relates to the real world.

**Step 2**

Once you have the model, you match the model to data. In the simplest example, I look at a model for my stock price, using GBM. GBM has two parameters, drift and variance. I look at historical data and estimate a long term drift and variance. I will use those two parameters to generate data for the future. Then you have to estimate your parameters. Then you also have to identify a way to generate randomness. This is a very vague statement, but what I mean is if I have a model that I hypothesize, the noise is gamma. I need to have a programming language that generates random variables as gamma random variables. First you need to justify why you need gamma and not normal, etc. Then you can generate randomness.

We have this high frequency trading simulator stuff, and we use these zero intelligence agents to interact with real teams that are doing the trading. We need to worry about, how do we initialize these agents? How much money do we give them? We did some research that if you start with homogeneous agents vs heterogeneous agents, heterogeneous is much closer to reality. So how do you create this heterogeneous? We use the Dirichlet distribution and sample from it to initialize the wealth of the initial agents. We identify the characteristics that the simulation needs to have, then identify distributions and rvs that fit that characteristic.

Once you’re done with steps 1 and 2,

**Step 3**

is really simple. Create values for X\_T (iid), and that’s it.

**Example with Call Option**

Using X\_T1, you can calculate the value of C1 as

$$
C^1 = (X_T^1 - K)_+ e^{-rT}
$$

Then you repeat this for all your samples.

Then we average from LLN:

$$
\\bar{X_T} = \\frac{\\sum_{i=1}^n X_T^i}{n} \\rightarrow \\mathbb{E}[X_T]
$$

These are all matching the expectation of the stock price:

$$
\\bar{C} = \\frac{\\sum_{i=1}^n C^i}{n} \\rightarrow \\mathbb{E}[(X_T - K)_+ e^{-rT}]
$$

**Furthermore**, the CLT tells us how close we are. I can construct the confidence interval

Students get really confused about this. There are two ns. There’s the confidence interval for the mean, which gets closer to 0\. But it also appears in the second one, because that one is for the actual random variable. Not C bar, which is an average, but the actual C random variable.

You have the random variable which is the value of the call. If you have one path, you get an estimate, one estimate, one call value. That estimate, that rv, is going to have a mean, that will be the true value of the call, and it will have a certain variance, which is probably huge. The way you estimate that, you take a sample, maybe 50, and then maybe estimate this quantity. It will get closer to the stdev.

I have my variability, which could be $200. My original option, if I do the correct path, I’m within $200 of the real value. The more I have the n in Sdc, it will go to that 200 value, not 0\.

This is plain vanilla Monte Carlo. What do we do with this?

This works really well for European type options. But it’s tricky for American. There is a method called least squares Monte Carlo on pg 210-216. It does some kind of tree method, with the path, creates a distribution of the future based on where each path is. It’s not really Monte Carlo.

It also works for Barrier Options. I mention this because we discussed them. The path needs to decide if it goes above or stays within a threshold.

Asian options also work. The payoff is determined by taking an average over the lifetime of an option. If it expires in one month, and it’s calculated daily, you take daily stock values, and then the value of the stock is an average. Or you could have an average vs a terminal value, there’s different versions. But in general, one of the terms is the average value of the stock price.

Monte Carlo can be used for ANYTHING. Nothing is financial inherently. If I want to examine deaths from a disesase because Trump took us out of WHO, you can make an estimate of the contagion. This X\_0 could be the number of infected people currently. Then you could have some kind of dynamic of how the disease spreads, and then X\_T is the number of people infected at time T. THen you can simulate multiple things, and then calculate all sorts of derivative prices, with some “payoff” of how much money I pay in hospitals, based on how many people die of disease. Monte Carlo is used everywhere, particularly in biology.

## Monte Carlo for SDEs

Everything in our areas uses SDE. This is on MF pg 273\.

I’ve been saying pages because it was written by two people independently. Monte carlo is written by Mariani, and Monte Carlo written by Florescu.

This is a pretty general dynamic, you can multivariate, multidimensional. In our homework, we have to work out for Bonus how to apply this Monte Carlo to a multidimensional process (Heston).

$$
dX_t = \\alpha(t, X_t) dt + \\beta (t, X_t) dW_t
$$

This is odne in the book so you can look it up.

How do you develop a Monte Carlo skill from SDE?

You can assume that X\_0 is some fixed point.

The first thing is to remember that this is the notation, the SDE doesn’t actually exist. The actual SDE is

$$
X_t - X_0 = \\int_0^t \\alpha(s, X_s) ds + \\int_0^t \\beta(s, X_s) dW_s
$$

### Euler Discretization

**Euler** is a very old mathematician. There was no SDE when he was living. His method worked to discretize regular integrals, so we are using the same exact method, which is Euler’s method.

Euler discretization.

We will take \[0, T\] divided into M.

Typically you generate millions of paths. The number of intervals you create has nothing to do with number of paths. Good estimation requires number of paths. But for this thing it doesn’t matter. You use whatever frequency you want. Estimate a month call option. Now you have to decide, do I want to generate every day? The time interval will be 1/252 or 1/365, and generate 25 or 30 for a month, but it’s your choice, and it doesn’t make a big difference.

The actual diffusion of your rv will be the same. It will matter if for example you estimate a barrier option. It’s about passing a threshold. If you have a lot of frequency, your rv might cross the barrier and you don’t know it.

We have m intervals and m \+ 1 points, t\_0, t\_1, t\_m \= T.

X\_0 will start at fixed x\_0

Then our process is:

$$
X_i = X_{i-1} + \\alpha(t_{i-1}, X_{t_{i-1}}) \\Delta t_i + \\beta(t_{i-1}, X_{t_{i-1}}) \\Delta W_i
$$

IT does not really need to be equally spaced, it works with everything. You can take day 1, 2, 14\.

You just need to be careful about time between observations.

The functions α and β is known. You choose the times. The only unknown noise is W. We know that increments are N(0, Δt), so you can calculate this as Z \* √Δt where Z is N(0, 1).

99% of the errors are coming from the student using the N(0,1) directly for W, and it’s too large.

Always use the left hand point that you have.

This is one path, you store the final value. But if you’re pricing the barrier option, you don’t just need to know this, you need to know path.

The problem he gave us:

## Monte Carlo with Jumps

Jumps allow us to introduce events that are unpredictable. You need to know they’re going to happen, but I don’t know when. I know that Trump will introduce tariffs again, because he’s a moron. We know that this is going to happen, but we don’t know why. We need this compound Poisson process.

We discussed two ways.
Exponential times we accumulate,

or in our case (much better), since we have 0 to T and we know the time interval, we create the Poisson random variables, generated, with λ \* t as the expected number of events. Once you generate that, the Poisson tells you how many times our president will influence the financial market. Then you create these n uniform variables from 0 to T, and sort them, and those are the actual generated times when he says the stupid things.

Then how are the stupid things going to influence the markets? Last week, he said tariffs on Wednesday, and markets went down. I am not watching the market, so tell me when to buy. NVDA is overpriced, TSLA will go down, I can’t make up my mind. This is being an investment banker or trader, not FE.

We have to

**Step 1**

Identify our model.

$$
dX_t = \\alpha(t, X_t) dt + \\beta(t, X_t) dW_t + dY_t
$$

This can be ANYTHING, our choice, could be Black-Scholes, or something else. You just have to fit it to real data.

Where Y\_t is a compound Poisson process. The sum of these jumps, where the time of these jumps happens according to an actual Poisson process.

We know how to generate the α β part, same methodology. The only question is, what do I do with the jumps?

I’m going to have to generate for each path, a set of jumps, and then add them to the price process.

Generate Poisson(λT) \-\> k (every time a different k)

Once I know k, I generate T\_1…T\_k times of the jumps for the Y\_t process.

And these are in the interval \[0, T\]. If you forgot how to do this, you take each T\_i \~ Uniform(0, T) and sort them.

What about jump amounts? Y\_1… Y\_k the size of the jumps

It depends how you model your stochastic process. Let’s say I’m modeling Donald Trump. Maybe he says something about tariffs, he goes down. So there’s no point generating a rv that goes up, I know it goes down. So I will generate it on a distribution of negative numbers, uniform(-0.5, \-1). Let’s say the second jump will be positive, so do something like that. You need to adapt it to your case.

But let’s just say for simplicity it’s iid. Homework says you should use the Normal distribution.

Identify the intervals Δt which contain T\_1.. T\_k
It’s possible that all the jumps happen really close to each other, in the same interval. I will just add all the jumps in the interval together.

The jumps happen in the interval.

Whenever you have the jump, you add the jump. If not, you don’t care.

The path

In the example in the homework, it uses returns, so it’s going to be logarithm S\_t plus other stuff, so be careful. Write down the math before you program anything. You might not be sure whether to multiply or to add.

This is the basic idea behind Monte Carlo.

Next week, he’s going to give us a better Monte Carlo method

One of the other problems is a variance deduction technique.

Euler Milstein is a better approximation than this one, but it only works for homogeneous processes, which are not time-varying i.e. don’t contain x in α or β.

## Variance Reduction

Imagine I’m pricing an option, and I look at the price I’m getting, and I get a 95% CI which is $10 wide, with n \= 100 paths. If you look at the difference, it’s \\(2 \* 1.96 (because it’s margin of error) \* \\frac{\\hat{\\sigma}}{100} \= 10\\)

This is about $10.

And then my boss tells me the price of the option is $3, to give him a better estimate.

So how many paths do I need to do to get this to $3? Sigma hat is going to change, but that sigma hat converges to the true σ, so it’s supposed to be kind of close. If I divide by 10, I get

$$2 \\cdot 1.96 \\frac{\\hat{\\sigma}}{\\sqrt{10000}} \= 1$$

I get $1 if I increase my sample size to 10000 paths.

So then I go to my boss and he tells me the price is between $2 and $3. DId you forget that these options are sold in multiples of 100? It’s $200 to $300. This is way too wide a margin\!\!\! I want to get within 10 cents. So I have to multiply by 100, and now I get to 1 million. Now that’s a lot of paths\! And then if I want 0.01, which is within $1 of the actual contract, I need 100M paths. And it’s because of this square root.

So what do we do? Variance Reduction techniques. Paul Glasserman is the expert at this. If you want to read more about this. He has this classic book Monte Carlo Methods in Financial Engineering (2003). Also a paper Monte Carlo methods for security pricing, 50 pages, but it does what the book does in a condensed way. This was written in 1997, so it’s old, but a lot of techniques still used today. Broadie sucks, by the way. This paper: [Paper](https://d1wqtxts1xzle7.cloudfront.net/97653387/BBG_jedc96-libre.pdf?1674420173=&response-content-disposition=inline%3B+filename%3DMonte_Carlo_methods_for_security_pricing.pdf&Expires=1744764322&Signature=I3cZHcahNRTM0-xMOo-cU96LFGfP51D-a2UMwsuXvCoBMTWMQw9Odh9DYY3sWeRIwJAHwmna-x3H3HiWMi~yebvujsqdyv2a2cWBZhJIT6gv06dt1iLOYfQmqfQI6y6PEUAtmFrZ657C493Y1Ac98Cl3lDtgpL-RnGNuXaVaGZ3ImTx8PiGr0uHM~mKZkL-zdyijEHrrks-9FYwi64-2GW1u7r3~J7NrkMH29zevcXT8pNy9yoqDvUntfJHuJ45YxzQY3Kq4u1D3sunt4SGVIrxqRNJ8WKvk8ZwiSe-uAO~B6317UFO-E2--5gWfee1fQ2glTOzNqH9Aigx343VK3A__&Key-Pair-Id=APKAJLOHF5GGSLRBV4ZA)

Having more n is a better approximation, but it is not the solution, because it gets harder to reduce the confidence interval.

So can we calculate σ hat smartly?

The quantile doesn’t change (1.96), n doesn’t change, so how do I get a better σ hat. That’s wy these are considered Variance reduction techniques.

### Antithetic Variate

Th doesn’t exist in Latin languages. English is confusing, sometimes you pronounce it differently. It’s the same writing but it’s different\! Always with the tongue in your mouth. Like the Sylvester from Looney Tunes, apotheosis of using the th sound.

How does this work? This antithetic variate is based on a very simple idea. If Z \~ N(0, 1), then \-Z is also N(0, 1). That’s the entire idea.

So how does this work? The problem with this path generation, what takes you time? The time generating the random variables. The idea is to generate the path with m increments. Z1, Z\_2, Z\_m, N(0,1) rvs. You can create a path using these rvs, and also \-Z\_1, \-Z\_2, \-Z\_m. For the same amount of numbers, you calculate two paths, where the second one is created for free.

Unfortunately, it is not the same as having 2m independent paths. Then my stdev would decrease by √2, old interval, divided by 1.41. But these paths are correlated. So the estimate for σ hat is going to grow. This is a worse estimate.

The net result is still better, but it’s not √2 better.

$$C \= \\frac{\\sum\_{i=1}^m C\_i \+ \\sum\_{i=1}^m C\_i^a}{2m}$$

Really simple to implement, easy to do, but not that impactful. You do it because it’s free.

Then we will talk about the versatile method, which is more complicated.

### Sidebar: ChatGPT Investing

I don’t know how to invest. I asked ChatGPT. Tell me which stocks have the largest return drop since April 2 (Liberation Day). What I have noticed is ChatGPT is completely useless. I can’t even calculate. I said give me a table of returns showing largest drop. He found the three journal articles that talk about this, limit to what other people have published. Interesting: how do the results of ChatGPT correlate with the market.

## Control Variates

The idea of this, this is more complicated. There are other simpler methods. Antithetic is the simplest.

Control variate takes advantage of certain relations between derivatives.

If you know certain things about derivatives, you can use that to your advantage.

This first example is on page 207 of MF, well-explained. Related to **delta hedging**.

How does this work?

At t \= 0, we, the option seller, receive C\_0, the premium. This is the option price. The idea of delta hedging is that I pay the payoff C\_T to the option buyer.

(Only works for European options).

If we held Δ, the derivative of call price with respect to stock, units of stocks at time any time t. Then we can replicate the option payoff C\_T.

If I hold that Δ units of stocks, at time T, I’m going to end up with exactly with the payoff. If the payoff is 0, I have 0 units of stocks, if I have one, I get one.

The problem of course is that you can’t own something that moves all the time. How do I own a derivative? I own 2 shares, then it goes to 1.5 shares. Everyone hates this because you have to buy stock when it goes up, and sell when it goes down.

The fact is that we don’t buy and hold. We have to adjust this delta hedge all the time. So how does this work in practice?

Say we have time t\_0 \= 0, t\_i \= iΔt, Δt \= T/m, where m is number of intervals

I’m going to take these equally spaced, option expires in 30 days, take every day.

I find this easier to explain my way than the way other people do it.

⬇️check the notes for this table

**Time | Receive | Pay to hold Δ units of S\_t**

If I do this instantaneously, this is supposed to be 0\. The Δ is matched exactly. If you make m reasonably high, it should be close to 0\. But I can’t really add them together. Because these are cash flows at certain times, and you have to multiply them by the discount factor. You could either discount them all to present day, or compound them to time T. Multiply by e-rΔt, e-r2Δt, … or ermΔt, er(m-1)Δt, …

If we are compounded, then we cancel out most of these, and then we get

If the time increment is really tiny, I get an error. Then we will rewrite this whole expression.

$$C\_0 \= C\_T e^{-rT} \- \\sum\_{i=1}^{m-1} \\frac{\\partial C\_i}{\\partial S} (S\_{(i+1)\\Delta t} e^{-r\\Delta t} \- S\_i) e^{-i\\Delta t} \+ \\eta e^{-rT}$$

And we will say η is approximately 0, noise that is discounted.

This expression says that my value for my option, equals, using my paths, the intermediate steps. I know the final value, and I subtract it by all these steps. The only thing I don’t know is Δ, the derivative of the option. If I knew that, I would know how to generate my path. This control variate gives me a way better estimate. The only problem is I don’t know is Δ… except I do\! For Black-Scholes, Δ \= N(d\_1) (for a call). This d1 you can calculate with current value of stock price, and you know what it is based on your path.

The idea behind this control variate method, which is conceptually so much more complicated, once you derive it is much easier. You generate paths using the Euler method, as explained before.

The larger the model variability, the worse prediction. The standard error, the sigma over error, if you have no variance reduction, antithetic is some reduction. The control variate has a huge reduction in standard error. And this is typically the difference between financial engineer and computer scientist. You need to know what you’re doing. Monte Carlo is really bad, UNLESS you know what to do. And this is a lot of derivation.

If you don’t have Black-Scholes, you need to find the Δ somehow, and that might take a long time. The variance might look good, but it will take longer.

## Asian Options

This is the Asian option calculation, the example from the Monte Carlo paper.

What is an Asian option?
It’s an option whose payoff depends on an average price throughout the lifetime of the option.

It’s usually easier to solv things in continuous time, and not discrete time.

The most general type of Asian option:

There are two types:

### Arithmetic

The payoff looks like this

$$\\frac{1}{T} \\int\_0^T S\_t dt \- S\_T \- K)\_+$$

This is the most general type you can imagine. It doesn’t exist in practice. This is the one mathematician slike to solve because it’s simpler. The integral takes the entire stok price, which you assume is continuous, calculate an average here. It’s basically the area. What you’re doing is, you’re taking the side, and dividing it by T. You’re actually finding out the height such that the area of the rectangle is equivalent to the area under the curve (integral). That’s the arithmetic average. And, it is including S\_T and K. Typically it is only one of them. I wrote it in the most possible general way. You can get even more general.

### Geometric

The payoff here is written like

$$(e^{\\tfrac{1}{T}\\int\_0^T \\ln S\_t dt} \- S\_T \- K)\_+$$

This is called geometric, I’ll explain why.

It’ll reduce to a geometic average on discrete formula. But this looks so ugly\! For this, we have an analytical formula. But for arithmetic, we don’t have a formula.

The reason we have a formula is because ln S\_T is normal, which means that this is an mgf, and we have a formula that we can calculate with. In practice, none of this exists, it’s theoretical baloney. But in practice, everything that is solved is arithmetic. Nobody understands geometric average. What is that?

### In RL

And how does it look like in practice?

Monitor the stock price at certain times, from S\_t\_1… S\_t\_m. You’re going to observe the price every end of the day. This is defined int eh contract. The contract says, look at the average, it’s calculated using beginning of the day prices, the high during the day, low, average, etc. That’s a specification on the S\_t\_i.

The arithmetic Asian:

$$(\\frac{\\sum\_{i=1}^m S\_{t\_i}}{m} \- K)\_+$$

This is a call

This is the same as the integral. You can take T/m as the integrand, you approximate LHS, and that’s what you get. T cancels, increment is T/m.

For geometric,

If you use the previous formulation, it is

$$e^{\\tfrac{1}{m}\\sum\_{i=1}^m \\ln S\_{t\_i}} \- K)\_+$$

This is replacing the integral with an approximation, t cancels. THis is equal to, if you cancel out all of these sums of logs, you get

$$= (\\sqrt{S\_{t\_i} \\ldots S\_{t\_m}} \- K)\_+$$

Except not square root, it’s mth root.

This is a lot harder to price than using the initial formula.

And geometric has a formula\!

If you assume that the underlying is GBM, same as Black-Scholes.

Arithmetic does not have ea formula. But  in the market, there are zero contracts that are sold using the geometric average, because no one understands it. But everyone trades using the arithmetic Asian option. So how do you price the arithmetic, using the geometric?

You use the control variate thing.

First, we generate a path i, which is S\_t\_0, S\_t\_i, S\_t\_m

you calculate the arithmetic premium A\_i from the same formula as before:
$$(\\frac{\\sum\_{i=1}^m S\_{t\_i}}{m} \- K)\_+ e^{-rT}$$

You can also calculate G\_i the geometric premium from before:
$$= (\\sqrt{S\_{t\_i} \\ldots S\_{t\_m}} \- K)\_+$$

I have three different ways to do this.

One is one that I came up with, which you can’t find anywhere, and I don’t know if it works.

Two is given by controlv ariates.

You have all these A\_i and G\_i. It would make sense to do some kind of regression. I assume that there is a certain distance between A\_i and G\_i. A which is the true price, follows

$$A \= \\alpha \+ \\beta G$$

This is a theory, but it must be true because these are two numbers, in general.

What you do is a regression between A\_i and G\_i.

$$A\_i \= \\alpha \+ \\beta G\_i \+ \\epsilon\_i$$

The idea is to minimize the noise, you’re fitting a regression so there is some noise.

We can come up with three different estimates.

Estimate 1:

Don’t use any control anything. Just use A bar, just the average, regular Monte Carlo.

Estimate 2:

This is what control variate is supposed to do. I have a formula G. I don’t need any estimation for that. In that formula, which is a function f(S\_0, K, T, r, σ). I don’t need any path, so I know what that number is, without doing any approximation.

I basically take A bar, and adjust it by the following adjustment.

$$\\bar{A} \- \\hat{\\beta}(\\bar{G} \- G\_{\\text{formula}})$$

You can derive this, it’s not very complicated. That’s the other estimate. EXCEPT THAT, I don’t understand what’s wrong with

#### Estimate 3

It would make sense that the relationship between A and G should be the same as the theoretical relationship between real A and real G. So why don’t we just take

$$\\hat{\\alpha} \+ \\hat{\\beta} \* G\_{\\text{theory}}$$

These intrinsically depend on all the paths, so they contain information about the paths.

Pretty sure I’m going to give you a problem for this, cook it up on the final.
