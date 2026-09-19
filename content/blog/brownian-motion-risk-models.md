+++
title = 'Brownian Motion and Geometric Growth'
date = 2024-09-26
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Brownian Motion', 'Geometric Brownian Motion']
+++

#### Univariate Stochastic Processes

Under market efficiency, financial prices should exhibit a random walk.

Eugene Fama is the big guy behind market efficiency. He was interviewed by the Financial Times (**Open question:** read the article) and shared the Nobel prize with Robert Shiller (Rational Exuberance). Fama came up with the efficient market hypothesis, which tells us that if people are seeking profits and you start trading that, putting millions in, the price will go up and it will become expensive. Any time there’s insight or information, that gets priced. A random walk means that it’s unpredictable what the next result will be. As soon as information comes in, everybody starts trading, the price goes up, maybe negative information the next day, and then price goes down. We will say that these returns are not correlated. How are market participants able to process and price information? Some people say that efficient markets are not possible for behavioral reasons. In our class, we will keep it on the iid assumption to keep it simple.

## Week 4

### Lecture Notes

#### Univariate Stochastic Processes (cont.)

Under the efficient market hypothesis, every new piece of information changes the price, which creates a random walk. This means you only care about the previous point because the price should encode all of the information up to that point, which is why it’s a Markov process. If we think about price jumps:

\(P_1 = P_0 (1 + R_1)\)

\(P_2 = P_1(1 + R_2)\)

So the movement/change in that price only depends on the return. Our argument is that these returns are independent. We have this iid assumption so that returns are uncorrelated.

Markov property (weak):

\(\mathbb{P}(S_{T_a}| S_{T-1}, S_{T-2} \ldots) = \mathbb{P}(S_{T=a} | S_{T=1})\)

The next flip of a coin is independent of the previous flip.

On average these jumps will be positives, so we have a certain level of growth or expected return \(\mu\). Our volatility \(\sigma\) is how much it goes differently from expected. We need to pay attention to our time period \(t\). \(\mu\) basically says that if we do these stochastic processes a million times, on average it goes to a certain point. Variance asks how much the process will be dispersed. Time asks where we’re modeling. Dispersion is generally larger with increased time, which is why options pricing makes options more expensive over long periods of time.

We will look at three different distributions:

#### Brownian Motion

\(Z_t\): This is a natural phenomenon. The best biologist is a chemist, the best chemist is a physicist, the best physicist is a mathematician. Also known as Weiner process.

It might go up and down, but it only goes one way.

This has three different properties.

We are reviewing probability and statistics, since we are looking at quantitative analysis.

We have a process that starts at time 0, with value starting at 0.

The very important property is that the process has a Gaussian distribution:

\(Z_t ~ N(0, t)\)

Its variance depends on time (think quadratic variation).

Let’s think about simulations. We’re sampling from the normal distribution.

In Excel, we have the function `=NORM.INV(RAND(), 0, 1)` which generates the next number.

What is the value of \(Z_2\) now that we have observed \(Z_1\) i.e. \(Z_2|Z_1\)? The increments are independent and also follow a normal distribution:

\(\Delta Z = Z_t - Z_s ~ N(0, t - s)\)

In order to generate \(Z_2\), I need to think about the value of \(Z_1\).

\(Z_2 | Z_1 = Z_1 + \Delta Z_2\)

where \(Z_1\) is a constant and \(Z_2\) is a random variable.

We can generate this by simulation to find the properties of the distribution. Eventually you get

\(Z_{\tfrac{d}{100}} = Z_0 + \sum_{i=0}^{d-1} \Delta Z_{\tfrac{i}{100}}\)

We can generate this into the distribution if we assume returns are iid as variance of summations:

\(Z_{\tfrac{d}{100}} \sim N(0, d \cdot 0.01)\)

There should be an Excel spreadsheet related to Brownian motion:

FE\_535\_Session\_02\_games\_SBM\_sim

If we look at the expectation of the values here, this is a simulation of the terminal point of the Brownian path. We created this over smaller increments. I want to validate that this is in fact normal \(N(0, 1)\). We have a “large” simulation so according to the LLN the average should converge to 0. This is a validation of the two moments if we see -0.006788 and 0.985446m, then it’s close enough. If we look in aggregate from a distributional point of view, how do these prices look?

In R, you use the functions rnorm for a randomly generated normal distribution, and dnorm for a true normal distribution. If we lay them on each other, we can see that they are very similar for larger numbers of rnorm.

This gives a good tool to understand pricing.

#### General Brownian Motion

When we talk about normal distribution, there’s only single probabilities within a standard. There are infinite tables that depend on \(\mu\) and \(\sigma\). When we model this, we add two degrees of freedom. One is how the process is changing over time. I start at point \(X_0\), but what it actually implies is that we have some expected increase like in real stocks. That number depends on the \(\mu\). We could imagine a casino where \(\mu\) is negative. The other question is how volatile this is, which is \(\sigma\). This is the generalized process:

\(X_{t+\Delta t} - X_t = \Delta X_t = \mu\Delta t + \sigma \Delta Z_t\)

where \(\Delta X_t \sim N(\mu \Delta t, \sigma^2 \Delta t)\)

If we simulate this process over multiple periods instead of just using \(\Delta t\), we get this.

\(X_t \sim N(X_0 + \mu \cdot t, \sigma^2 t)\)

The problem with the previous BM is that prices could take negative values. But actually stock prices cannot go negative. If you have a limited liability company, the equity value cannot go negative. Whoever owns those stocks is not responsible for e.g. the debts of the company.

You can also think about it as a percentage change, which cannot go to 0 just by multiplication.

Whatever assets you invested in, I lose only what I put in. I don’t care that much if the company goes bankrupt, the only thing that happens is that I lose the money I invested.

If we take this process with the random variable in the same way as with regular Brownian motion, we can see

\(X_t = X_0 + \sum\Delta X = X_0 + \sum{i=1}^{100} \mu \cdot 0.01 + \sigma \cdot \Delta Z_i = X_0 + \mu \cdot 0.01 \cdot 100 + \sigma \cdot \sum_{i=1}^{100} \Delta Z_i\)

Why am I wasting your time with this? If we go back to the initial notation, this 0.01 is the \(\Delta t\), \(N\) is 100, and our \(t\) is \(\Delta t \cdot N\). For calculating \(Z_i\), we cancel out all the deltas in between and get \(Z_{100} - Z_0\). By construction \(Z_0 = 0\), so this is \(Z_{100}\).

Now we have a solution for the process.

If I know what \(Z_t\) is going to be, that matrix, then I know what \(X_t\) is going to be. This is also related to geometric Brownian motion. If we’re able to create \(Z_t\), we’re done.

\[Cue me coughing for ten minutes\]

##### Lab

We have our sheet X\_general\_bm.

The variance of half year through is 50%.

\(\mathbb{V}[Z_t] = t\)

\(\mathbb{E}[X_t] =\)

The simulated value basically tells you, you can go on and pick up the time of 50 which is half year from now, then take the average of that, take the variance of that, that will give you a proxy for the moments you actually want to calculate. Then you need to do this for six months then 1 year.

We have reference points of True Value that simulated value should resemble.

Let’s take the solution that

\(S_T = S_0 e^{R_t}, R_T \sim N((\mu - \tfrac{\sigma^2}{2})T, \sigma^2 T)\)

T always refers to years for simplicity.

We can all relate to annual numbers.

If T was equal to days, then the parameters should represent that.

We need to find the expectation of \(S_T\)

\(S_0\) is a constant

\(\mathbb{E}[S_T] = S_0 \mathbb{E}[e^{R_T}]\)

How do we get there analytically? By simulation we got a hint that it is the correct answer.

Wikipedia tells us the expected value of the log normal distribution, which our returns are.

\(e^{\mu_X + \frac{\sigma_X^2}{2}}\)

If we plug it in, we get

\(\mathbb{E}[S_T] = S_0 e^{\mu_X + \frac{\sigma^2_X}{2}}\)

then when we simplify after ignoring volatility we get

\(= S_0 e^{\mu T}\)

You can repeat this process for variance, where pulling out the constant has to square it

\(\mathbb{V}[S_T] = S_0^2 \mathbb{V}[e^{R_T}]\)

plug in wikipedia log normal variance for returns
\(= S_0^2 [ e^{\sigma_X^2}-1] [e^{2\mu_X + \sigma_X^2}]\)

\(= f(S_0, \mu, \sigma, T)\)

#### Geometric Brownian Motion

The most common process to simulate stock prices is the **Geometric Brownian Motion** (GBM).

\(\Delta S_t = S_t \mu \Delta t + S_t \sigma \Delta Z_t\)

By design we know by the motion itself that

\(dlog(S_0) = \mu dt\)

In the other example we aggregated. How do you aggregate continuously? The integral, which is

\(\log{(S_T)} - \log{(S_0)} = \mu \cdot T\)

\(\log{\left(\frac{S_T}{S_0}\right)} = \mu \cdot T\)

\(S_T = S_0 e^{\mu \cdot T}\)

This is an ordinary differential equation (only one dimension, time)

We have a constant process which evolves with respect to time.

The distribution would be skewed upwards because this cannot take negative values.

We need to use something called Ito’s Lemma, which gives us the nice solution that

\(\log{\left(\frac{S_{t+\Delta t}}{S_t}\right)} = \left(\mu - \frac{\sigma^2}{2}\right) \Delta t + \sigma \Delta Z_t\)

which is equation 4.6 from the textbook.

If you take the \(\sigma\) out with nothing stochastic, you end up with the ODE solution.

The point of the solution is to simulate the price at time \(t + \Delta t\), aka returns over time \(R_T\).

The log-normal distribution tells us that if a random variable is log-normally distributed, then the natural log of the random variable has the normal distribution.

Excel formula for variance of geometric Brownian motion: `=C8^2*EXP(2*C4*C3)*(EXP(C5^2*C3)-1)`.

Proposed simulation code:



`=B2*EXP(NORMINV(RAND(), (Inputs!$C$4-Inputs!$C$5/2)*Inputs!$C$3, Inputs!$C$5*SQRT(Inputs!$C$3)))`
