+++
title = 'Monte Carlo Risk Simulation'
date = 2024-09-19
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Monte Carlo', 'Simulation']
+++

## Week 3

### Lecture Notes

#### Fed Talk

50 bps cut\! Markets exploded today. Information gets priced in a nonlinear way

Today’s topic will be a little independent of what we’ve done, so it will be more into the quantitative analysis, simulation, law of large numbers.

#### Lab Solutions

labs are only 10% of the grade, one point or two is not a big deal, don’t stress

if you look at the annual sharpe ratio, you have an average sharpe ratio which changes over time.

We have weekly returns, based on the end price divided by the previous one. Continuous allows us to use derivations, even if real life is discrete. You can either cut into pieces or eat whole pizza pie. Does it matter? Depends on the assumption we’re making. We can actually represent this as a summation of returns. When we’re trying to understand the expectation, we can use the linearity of expectations.

Annualization also allows you to expand data.

Limit is 15 pages for projects, keep it compact, only wants to see results

R has apply function for functional programming



**Open question:** Regress mu\_p on sigma\_p, what’s going to be the alpha, the beta?

You have this market representative agent who picks the most efficient portfolio with a high Sharpe ratio and says you don’t need to do something else. It’s the same with picking a pensions, dictates how you allocate your money, higher risk equity if you’re younger.

#### Monte Carlo Methods

Assumes some quantitative analysis background.

Monte Carlo is a simulation method. Example: let’s flip this coin and see the next result. We don’t know for sure, but if we run it 100 times, it might be around 50/50 heads and tails. We run an R simulation to do this more and more times. As N number of trials increases, we get closer to 50% on average. This applies to any distribution, which helps us avoid solving complicated mathematical equations. It gives us a lot of good solutions. Let’s have \(X ~ N(\mu, \sigma^2)\) normal distribution.

What’s the expectation?

\(\mathbb{E}[x] = \mu\)

Second moment? Variance

\(\mathbb{E}[x^2] = \sigma^2 + \mu^2\)

Third moment (skew) becomes more complicated

Mean of (x^2) ends up being 5 when (x) is uniform on ((1,2)).

We use this a lot when looking at options and derivatives

If you ask one person how many M\&Ms we can put in a jar, it will probably be wrong. But if you ask 1000 people, it will be more right on average. “The wisdom of the crowd.” This is the Law of Large Numbers. You can figure out the values and moments you’re actually looking at. We will price some games as our motivation for finance.

Maybe it’s the same guy, which makes it biased

Bayesian is far away, long-term, this thing only gets one chance.



Monte Carlo (MC) methods allow risk managers to avoid complex analytical solutions and derive complex distributions, price complex instruments. The major part of managing risk is identifying it and understanding its sensitivity. The simulation will help us stress test. What about when things go bad? This will be useful.

Black-Scholes became popular because no one had laptops.

MC relies heavily on the model’s assumption. It needs to have the right distribution, parameters, pricing function. If you have a contract to get $5 if this happens, if you model risk issues, what’s the parameters?

Model risk is always a part of things

Calibration of parameters will be taken for granted.



By flipping a coin, you can either get a $1 heads or lose a $1 tails. There’s a premium to participate in this game, so how much would you pay? Depends if it’s a fair coin or not a fair coin.



You can think of it as \(\pi\) as the probability of heads and \(1 - \pi\) as tails. Therefore, we can model this problem as

\(\pi \times 1 + (1 - \pi) * -1 - p = 0\)

where \(p\) is the premium to pay into the game.

To solve this we get \(p = 2\pi - 1\).

In the case when \(\pi\) is \(0.5\) in the fair case, then the premium is 0. If \(\pi < 0.5\), then you actually get paid to participate.

In Atlantic City, they give you a free bus ride in order to get you in. The odds are against you, so as long as you come in, they’re making money.



How would you price this?

The price of a security is

\(p = \sum_{s=1}^S CF_s \times \mathbb{P}(s)\)

where cash flows from state \(s\) and the probability of \(s^a\) is probability.



The martingale is the fair game, where expected value is the same as the initial investment.

Lottery tickets are not a fair game. You pay a higher premium for the euphoria of imagining you win.



Let’s consider a complicated game. We have a fair die with equal probability of the results. We want to roll the die 3 times, with three results \(X_1\), \(X_2\), and \(X_3\). We consider \(X_{\text{max}}\), where if it’s 6, you get a dollar, otherwise you get nothing. What is the premium for this game? This is actually a binary or digital option.



We can solve this two ways. Analytically, and numerically.



We can combine each of these states into an indicator variable, which will tell us whether the maximum is 6 or not.

\(\mathbb{E}[I_n] = p\)



\(\mathbb{P}(X_\text{max} \leq i) = (i/6)^3\)

We understand this as \(1 - (5/6)^3 = 0.4213\)

##### Numerical (my own)

~~~text
PS C:\Users\sharif> python
>>> import rand
Traceback (most recent call last):
ModuleNotFoundError: No module named 'rand'
>>> import random
>>> random.randint()
TypeError: Random.randint() missing 2 required positional arguments: 'a' and 'b'
>>> random.randint(1, 6)
2
>>> v = [[random.randint(1, 6), random.randint(1, 6), random.randint(1, 6)] for i in range(1, 1000000)]
>>> m = [int(max(c) == 6) for c in v]
>>> sum(m)/len(m)
0.42147742147742145
>>> 1 - (5/6)**3
0.42129629629629617
~~~


##### Numerical (Professor’s)

Done in Excel, which approximates the answer.

We can establish the weak law as such

\(\lim_{N \rightarrow \infty} \frac{\textstyle{\sum_{n=1}^N} X_n}{N} \rightarrow \mu\)



Sports betting is a binary option.

There’s a certain probability something will happen, and you will get nothing otherwise. We can play the game under different conditions than the maximum of dice rolls.

If the current stock price is $100, the stock goes beyond $110 next month, you get paid $1, if not you get nothing and you lose the down payment \(p\). What is the fair price of \(p\). We can consider two regions, the winning and losing. If we have some model that will allow us to model the different scenarios, we can analyze numerically what might happen.

We need the return to be above 9.53% (because of interest rates it’s not 10%), so our option price is

\(\mathbb{P}(R_1 > 9.53%).\)

If we know that returns are normally distributed on \(R_1 ~ N(0.02, 0.04^2)\), then

\(\mathbb{P}(R_1 > 0.0953) = 1 - \phi \left(\frac{0.0953 - 0.02}{0.04}\right) = 1 - 0.9701 \approx 3%\)

based on the formula

\(= \phi \left( \frac{K - \mu}{\sigma} \right)\)

If you have high volatility, then there’s a higher probability of exercising the option, and vice versa. Nobody writes options for penny stocks.

European options have a closed form solution. American options have no analytical solution. Asian options also don’t (what are these? don’t know).
