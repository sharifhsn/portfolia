+++
title = "Black–Scholes, Calibration, and Implied Volatility"
date = 2025-02-04
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Black-Scholes","Calibration","Implied Volatility","Stochastic Volatility"]
+++

## Bad News

Hanlon 2 is occupied by the system administrator, Zheng Xing. He will move his class so that we can occupy there. They will need to remote desktop into the lab.

I should have come here early to help him 🙁

There’s two modes, Zoom Mode, and Bypass Zoom. If you bypass, you can’t use microphone or camera.

Doesn’t really matter, next week will be different.

## Plan

We’ll look at some stochastic models. Then we will look at finding roots, and finding volatility, and so on.

## Black-Scholes Model

Traditional model:
$$
dS_t = \\mu S_t dt + \\sigma S_t dW_t
$$

The thing about this equation, is that it is under the objective probability measure.

You can see that there is a μ parameter that characterizes the stock.

Last time we talked about MLE. That is concerned with estimating the parameters, such as μ and σ.

This can only be done when you observe the actual stochastic process prices. It’s an estimation that you do under this objective probability measure.

However, when you calculate option prices, you go to the equivalent measure Q which is risk-neutral. The equation is slightly different.

$$
dS_t = r S_t dt + \\sigma S_t dW_t^Q
$$

We can observe this by doing the Girsanov transformation.

So what’s the difference here?

The option prices are always under Q.

### Calibration

There is a different method to estimate parameters, called **calibration**.

We’re going to mention this idea here, and then expand later. *Estimation and calibration are different*. Estimation is a very standard method in statistics. The condition of estimation is that you observe the option prices. Calibration is a term invented in finance, which is only applicable here. It deals with this particular situation where you observe option prices \\(c_1, c_2, \\ldots c_n\\). These are *derivative prices*, not the underlying prices, derived under Q. If you’re estimating parameters for this, you’re going to be estimating r and σ. We’re lucky because under Black-Scholes because σ is the same. But we can’t estimate μ at all, we need stock prices to do that, because μ vanishes.

The method is, we would set theoretical prices “equal” to observed prices, and then we solve for parameters. And this is called calibrating parameters. In traditional statistics, you assume that this is a number. But when you do this methodology, and you estimate (e.g.) implied volatility, you would see how it changes based on different option prices. But then you say that σ is different, so how do you adjust for that? When you calibrate to real data, then you get it. The problem is that the model is bullshit.

Every time you use derivatives, you are estimating under Q.

The reason we are using BS and implied volatility is because there is a formula for this. You should know the formula. C the option price is a function of both S and t, the observed stock price and the time. However each price depends on other stuff, like K the strike price, r the interest rate, and T the time to maturity, and σ the volatility. It looks like there are six things in this equation, but it actually only depends on time to maturity, so there are five things.

$$
C(S, T - t, K, r, σ) = SN(d_1) - Ke^{-r(T-t)} N(d_2)
$$

Where

$$
d_1 = \\frac{\\log (S/k) + (r + \\sigma^2 / 2) (T-t)}{\\sigma \\sqrt{T - t}}
$$

$$
d_2 = \\frac{\\log (S/k) + (r - \\sigma^2 / 2) (T-t)}{\\sigma \\sqrt{T - t}}
$$

And N is the normal cdf. If you know K and you divide by K everywhere, you can get the same equation in terms of **moneyness**, which is determined by S/k. Moneyness is used in practice, because, for example, if you calculate at the

money option for AAPL, where it’s $600 at the money, then the following options are $605, then $610. But for AMD, it’s $10 at the money, then $10.5, then $11. By using moneyness, you scale all of these in the same way.

S is observed, K is observed, r is not really observed but you keep it fixed. You just go to the Federal Reserve and pick whatever risk-free interest rate, just keep it consistent, 3M or 3Y, whatever.

Time to maturity is a small value. Everything here is expressed in years. **You need to keep this consistent: *everything is in years*.** Unit conversions are a big problem.

This will give you yearly volatility. This is something well understood. S\&P 500 has volatility 0.2, IBM 0.6. This is relatively stable. You could express everything in terms of days, but then you would get a scaled daily volatility which is very small. Because of this normality assumption.

You can get returns here by doing a transformation and applying Ito. To be clear, this is under Q.

$$
R_t = \\log S_t
$$

$$
dR_t = (r - \\tfrac{\\sigma^2}{2})dt + \\sigma dW^Q_t
$$

You always eliminate S this way when you take the logarithm.

Look at the form of this\! If you discretize this process, you get

$$
R_{t + \\Delta t} - R_t = \\int_t^{t+\\Delta t} (r - \\tfrac{\\sigma^2}{2}) dt + \\sigma (W_{t + \\Delta t} - W_t)
$$

You can see the increment of the Brownian motion, which is normal.

This is why the return is very nice, because this is the increment.

Then you get the continuously compounded return, which is normal and also independent.

This is very nice to work with, and it only works for the Brownian motion.

### Continuously Compounded Return

Typically if you calculate return over a year, let’s say you have an asset that changes over time. That has the following return:

$$
r_t = \\frac{S_{t + \\Delta t} - S_t}{S_t}
$$

This is the simple return, and tells you what happens at the end. But what happened in the middle? When you make the increments smaller, you eventually get

$$
R_t = \\log \\left(\\frac{S_{t+\\Delta t}}{S_t}\\right)
$$

Every moment in time, I’m going to earn more. This is a mathematical construct and doesn’t exist. But it’s convenient, because it gives us the mean plus variance of the normal.

## Approximating PDEs

If V is a European type option, you can only exercise at maturity. V(T) is then only a function of S(T). It only depends on the stock price at maturity. You can have European call or put, as long as the value only depends on the stock price at maturity. We can show that V solves a particular type of education, which is called the parabolic PDE.

$$
\\frac{\\partial V}{\\partial t} + \\frac{1}{2}\\sigma^2S^2 \\frac{\\partial^2 V}{\\partial S^2} + rS \\frac{\\partial V}{\\partial S} - rV = 0
$$

This is the PDE, but in order to solve this, you need boundary conditions to solve this. The proper solution is a surface, with an infinite number of solutions. We know that

$$
S \\in [0, \\infty]
$$

$$
t \\in [0, T]
$$

Let’s consider the boundary at T, the time of payoff.

$$
V(S, T) = f(S_T)
$$

We are not necessarily concerned with the function itself, it could be K \- S, we’re not worried about that.

In the theory of PDEs, there are boundary conditions expressed in the function itself, or of derivatives of the function. there are also Dirichlet conditions.

We can’t put a condition at t \= 0, because that’s what we’re looking for, the price at t \= 0\.

We can put a condition on the boundary at S \= 0, and when S converges to ∞.

These are specific, and depend on the option you are pricing. If you are looking at a call option, going to infinity becomes S \- K. which becomes 1 if you derive with respect to S. Going to 0 becomes 0 because

We will talk about this later. But these conditions are important\!

These boundaries involved are [Dirichlet boundary condition](https://en.wikipedia.org/wiki/Dirichlet_boundary_condition)

## Greeks

The Greeks involve the derivatives of the parameters. We have five Greeks.

K is fixed so it doesn’t have a derivative.

$$
\\frac{\\partial V}{\\partial T} = \\theta
$$

When time changes, how does the option change?

$$
\\frac{\\partial V}{\\partial r} = \\rho
$$

The interest rate changes for time to time, but it’s not that big of a deal.

$$
\\frac{\\partial V}{\\partial \\sigma} = Vega
$$

By this theory, σ is supposed to be constant. So this doesn’t really exist, it’s kind of a joke.

$$
\\frac{\\partial V}{\\partial S} = \\delta
$$

$$
\\frac{\\partial^2 V}{\\partial S^2} = \\gamma
$$

These are the big kahunas.

Delta is the sensitivity to changes in stock price.

Gamma measures the concavity or convexity, wherever you are on the curve.

These are used in hedging.

## Job Market Tangent

Fortunately, finance is very competitive. So it’s very hard to find a job based on your specialty, becoming a quant. JP Morgan has 300 quants in total, throughout its whole company, out of tens of thousands. 200 of them are in England. It’s very hard to become a quant.

Those are real quants that do this shit. The good news is that this program doesn't only prepare you to become a quant. It prepares you to become a quant in any company. JP Morgan has 300 real quants, but it has data scientists, quantitative analysts, that do other related things.

## Heston Model

I’ve been making fun of this stochastic process BS, what is the alternative? Why do we keep learning about IV if it doesn’t really work?

Two reasons. 1\. Most people in finance are imbeciles, so BS is the only thing they can understand. Ten years ago IV wasn’t on Yahoo Finance. 2\. It’s a self-fulfilling prophecy, because everyone uses it. I’m going to buy Trump stock because he’s elected, so it goes up. Now there’s lots of people buying, but nobody selling. But the guy selling will see that the model says that they’re overpaying, so he will sell.

The Heston model is not useful for vanilla option prices. If you happen to work as a quant, you won’t work with idiots trying to buy Trump stock. You are going to deal with another quant who works at Barclays who says I have $500 million cash flow, and I want to ensure that the rate I’m getting is 5%, so I’m going to do a swap. Give me the price of a swap. This is a completely nontraditional thing, some instrument that you need to price. In order to understand this non-standard situation, you need to understand the simple model.

$$
dS_t = rS_t dt + \\sqrt{V_t} S_t dW^1_t
$$

$$
dV_t = K(\\theta - V_t)dt + \\sigma \\sqrt{V_t} dW^2_t
$$

These two Brownian motions are correlated by ρ

$$
\\rho dt = \\mathbb{E}[dW^1_t dW^2_t]
$$

You can write a Heston PDE and solve it with the methodology in the book.

Let’s just understand this structure.

Note that S\_t is linear, so we can get rid of it and make it explicit in terms of the process V\_t and the Brownian motion. We can do the Ito to the logarithm of S\_t.

The Brownian motion part can be negative. You can approximate the increment of V\_t by the dt, because the increment is normally distributed.

### Mean Reversion

θ \- V\_t will push towards θ because it reverts to it. The increment will be negative if V\_t is above θ, and positive if V\_t is below θ. And the mean of this process is actually θ, which we can calculate. In practice, K is called *the speed of mean reversion*.

If the speed of mean reversion determines how much it goes back and forth across the mean. Keep in mind that this is stochastic and not guaranteed, but this is the average trajectory.

## SABR \- Stochastic α β ρ

This is one of the first stochastic volatility models to be created, and was used in the insurance industry.

$$
dS_t = \\alpha_t S_t^\\beta dW_t
$$

$$
d\\alpha_t + \\nu d_t dZ_t
$$

ρ correlation

This doesn’t have a solution, but it’s very popular.

Assume that the stochastic process follows the SABR model. THen you have an option price, but with no formula. But you do have a formula for the IV of that option price. So what you do is calculate that IV, and then plug it into BS. The reason that it was powerful because interest rate models had used BS already in their code, so they would need to change all their code to use something else. They were all spaghetti code idiots.

There used to be a guy at JP Morgan who was 70 years old and kept working. The reason was because he wrote code in COBOL 30 years ago and was running $5 billion instruments valued every day based on this model. Jamie Diamond commanded that they rewrite everything in Python, so he’s gone now.

## Cox-Ingersoll-Ross

$$
dV_t = \\alpha (\\bar{V} - V_t) dt + \\sigma \\sqrt{V_t} dW_t
$$

I like α for speed of mean reversion and \\(\\bar{V}\\) for my mean reversion.

The square root thing is called the **vol of vol** parameter.

You can use this for stock prices directly.

Before they went back to Vasicek, they used this for interest rates, or anything dealing with them like swaps, caps, floors, etc.

The question is, what’s the expected value and squared?

We can solve this very neatly by expressing this as an integral.

$$
V_t - V_0 = \\int_0^t \\alpha(\\bar{V} - V_s) ds + \\int_0^t \\sigma \\sqrt{V_s} dW_s
$$

$$
\\mathbb{E}[V_t] - \\mathbb{E}[V_0] = \\mathbb{E}\\left[ \\int_0^t \\alpha(\\bar{V} - V_t) dt \\right] + \\mathbb{E}\\left[\\int_0^t \\sigma \\sqrt{V_t} dW_t\\right]
$$

The expectation of the right side is 0 because it’s a Brownian motion.

For the left side, as long as what is under the Riemann integral is finite, the integral order doesn’t matter. So we can flip them, and we want to know the expectation.

We will define a deterministic function here based on the time t.

$$
\\mathbb{E}[V_t] = v(t)
$$
Now we can determine

$$
v(t) - v(0) = \\int_0^t \\alpha(\\bar{V} - v(s)) ds
$$

This is a Riemann integral that we can directly solve.

Then take the derivative.

$$
v'(t) = \\alpha(\\bar{V} - v(t))
$$

$$
dv = \\alpha \\bar{v} dt - \\alpha v(t) dt
$$

α appears out of nowhere if we derive

$$
e^{\\alpha t}
$$

so we will actually multiply this to make it appear

$$
e^{\\alpha t} dV + \\alpha e^{\\alpha t}dt V = \\alpha e^{\\alpha t} \\bar{V} dt
$$

Now we can integrate to give us the solution.

\[I can’t see the solution from where I’m sitting, check the textbook for this\]

The trick is literally useful when you can get some nice mean here in terms of prices. If you can say that, if the stochastic part was deterministic, then it would be easy to solve.

V^2 is left as exercise.

Tips: Apply Itô, then use the same trick to get rid of the stochastic part.

## Implied Volatility

Implied volatility fits somewhere in between the bid and ask price for options.

Mathematicians solve this problem with a formula to calculate option price, such as BS.

In that model, σ is the only thing we don’t know. In order to solve this, we will set the option price formula to the average of the bid and ask (mid) and then solve for σ. You can rearrange as the difference between the theoretical price and the mid is 0\. Then you can say you’re finding the root of a function.

$$
f(\\sigma) = C(\\sigma) - mid = 0
$$

This value is called the implied volatility.

There is an obvious problem with this. This is for K\_1 and t\_1. What if I have a different strike price, or a different time to maturity? Then I’m going to have a different value. This is despite the fact that volatility is calculated on the underlying stock price and therefore should be constant.

This is called the **volatility smile**, or really the volatility smirk because the upwards trajectory is only in one direction. If you graph moneyness against implied volatility, you get the smirk. This only goes for one time. For T\_2 larger than T\_1, the smile is less clear, it’s shallower. How do you calculate implied vol? You might want to take an average of these points. Or you could take an average of a certain range.

Let’s say you have the data for option prices. Let’s do this

$$
\\min \\sum_{i=1}^n (C(S, T_i, K_i, r, \\sigma) - C^i)^2 \\cdot W_i
$$

Where you weight each price and you minimize the volatility. This is a fix, because the model is crap.

There’s something better.

## Local Volatility

This was pioneered by a bunch of math guys at Bloomberg. Dupire, Derman (director of FE at NYU, now retired).

They said, let’s fit everything. We’ll look at these values and create the local vol surface. It is a bad model, but it’s what people use. The industry uses a combination of local vol and stochastic vol. The professor’s students who work use this.

Local vol is not that complicated. Remember the equation for stock price from BS?

$$
dS_t = S_t(r - \\tfrac{\\sigma^2}{2})dt + \\sigma S_t dW_t
$$

What these guys said, is that the dt term is crap, we’ll say it’s 0\. The σ is clearly not constant, but I don’t want it to be a stochastic process. Then the natural thing to do is replace σ with σ(t) which is a function of time. Now this is a failure because nothing changes.

Now they have tons of data, and this is used for interest rates. Interest rates have two important times, the tenor and the maturity. Tenor is how much time remains. So they need a way to fit based on this information.

Let’s do σ(t, S\_t). Where do we get this function from?

In the dV PDE, we have σ. So let’s extract σ.

~~~text
\\sigma(T, K)^2 = 2\\frac{\\tfrac{\\partial C}{\\partial t} + (r_T  - 2T)K\\tfrac{\\partial K}{Z}
~~~

This is pretty much the same question in terms of strike price and time.

For each particular option price, I can estimate these derivatives. I’m going to market, r\_t, and Q\_t re known.

Then you can construct a vol surface from this, which you can find in Bloomberg.

The whole thing is bullshit. I wrote a paper about this. You’re fixing the problem by creating another problem. These derivatives are a big problem. How do you solve for the derivatives? You use finite differences (we will mention later when talking about approximating PDEs). If you have a function f, the derivative df/dx is approximately f(x+Δx) \- f(x). As long as you take Δx goes to 0, this will converge to the derivative. This is called the finite difference, which you can express in multiple ways. This is first-order difference, and then you can use it substitute the derivatives. To get the second derivative, you do the first difference of the first difference.

You can see that this is the strike price minus a little bit. But the problem is that it DOES NOT EXIST. In practice, strike prices are very far apart from each other. They justify this for use in interest rate models, in which the interest rate increments are very small. But then with interest rates, the change in time is VERY FAR, so each of them will fail.

## Paper

This stuff is not new, in 1998\. Black-Derman-Toy? Model. Florescu heard about it and got mad, and wrote a paper to critique this.

*Personal reminder: look at this on Canvas.*

## ChatGPT

Gradient descent is “Brute force”, so optimization actually SUCKS, brute force is the best thing.

## Bisection

If I have f(x), how do I find x\_0 such that f(x\_0) \= 0\. This is finding the root of a function, which is a famous problem.

Bisection is very stupid and very simple, and it only works for our problem.

It’s designed on the fact that if you have a root on an interval, then you see that

f(a) \* f(b+a/2) \< 0, and if it’s true, then you can bisect this interval and look for the root, repeating like binary search.

None of this requires the BS formula, you just need a way to get the option value for a set of parameters. You could use an approximation method like a tree or finite difference. But because you are doing this a lot, you would like to have an analytical solution to be faster.

A couple of issues with this:

- Interval \[a, b\] needs to contain the root. There cannot be two roots. The option price is increasing in terms of σ, and this is monotonically increasing, so there is only one root. The root is always positive, we know that IV is always positive, so you can always use a \= 0\. Idiots tell you IV is always less than 1 because it’s a percentage. But the IV depends on the actual Call option price. If the price is way weird, then it’s not. The bid might not have been traded in a while, and the ask price moved with the stock price, so the spread is now huge. So now the average is way off. If you consistently get the root to be a or b for certain options, it is usually a problem with your data. IV is usually not huge, although it is possible when stock price moves a lot but option prices don’t. If you use \[0, 1\], you won’t capture that. The fix is simple, to use \[0, 10\], or \[0, 4\]. In two steps, you’re at \[0, 1\].
- This only works for R → R. You need to map into R to do comparisons of greater or less than, like Euclidean distance.

### Newton Method

$$
x_1 - x_0 = \\frac{f(x_1) - f(x_0)}{f'(x_0)}
$$
My goal is to find x where f(x) \= 0, aka the root.

Let’s rearrange

$$
x_1 = x_0 - \\frac{f(x_0}{f'(x_0)}
$$

where we delete f(x\_1)

Then I can keep doing this until the two points are the “same” (within ε)

This is the recurrence formula.

It works for R\_n generalized, but there is a problem.

If you start too far away, you’re going to go in a weird direction.

## Trump

I saw a conference from Trump on Tuesday when he brought a CEO from Morocco, and the Sam Altman guy. He thinks that because it creates words, it’s alive.

Trump said we need to be leaders in AI. “I am prepared to give you $500 billion” The next day Chinese do it cheaply.

Next class, approximate stochastic processes using trees.

First homework is due… will be determined tomorrow. We will have 2-3 weeks to do it.

## Old Paper

## Introduction

We are concerned with estimating expected future volatility. One approach is with historical data. Another is to use market option prices and derive volatility from option valuation formulas.

Doing this derivation requires some assumptions based on which formula you’re using. Black-Scholes requires asset prices to follow geometric Brownian motion and constant volatility. Since volatility is constant, then this disagrees with the real-life volatility smile.

In order to account for this, we might think to change volatility based on the stock price. This typically means some kind of stochastic volatility model, which is not easy to solve for. In a special case, if the volatility is deterministic, then we can use the Black-Scholes PDE to solve option prices.

DK, D, and R have developed “local volatility” which does the following:

“Their methods attempt to fit a cross section of option prices and deduce the future behavior of volatility as anticipated by market participants. Rather than give a formula or a structural form for the volatility function, they search for a binomial or trinomial lattice that achieves an exact cross-sectional fit of reported option prices.”

In this way it’s similar to implied volatility, but it attempts to capture the volatility surface.
