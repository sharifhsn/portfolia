/*
title = 'Black–Scholes'
date = 2024-10-17
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Black–Scholes', 'Option Pricing']
*/

== Week 6
<week-6>
=== Lecture Notes
<lecture-notes>
==== Black-Scholes
<black-scholes>
We will either lend or borrow from a bank at interest rate r. In that scenario, the amount of wealth that i have at maturity time T. My wealth would be the value of my shares and the rest of my wealth increased by the interest rate.

I could say that the value of my portfolio at the next time increment can be expressed as the position I take in the stock at the original time, times the current value of the stock.

$X\(t_j\)= Delta\(t_j\)S\(t_j\)+ X\(t_j\)- Delta\(t_j\)S\(t_j\)$

No time has actually elapsed here, so there is no interest rate applied. I have merely shifted my wealth into a different asset. The $Delta$ is the position in the asset, and $X$ is the position in the money market i.e.~wealth.

Then the value of my portfolio at time $t_(j + 1)$, (we'll pun in a bit in the notation here) when I'm talking about my interest rate $r$, you're earning interest over time $T$. Now we're using it for a partition, and then we'll annualize it.

When we move to $t_(j + 1)$, you have an interest rate.

$X\(t_(j + 1)\)= Delta\(t_j\)S\(t_(j + 1)\)+\(1 + r\)\(X\(t_j\)- Delta\(t_j\)S\(t_j\)\)$

If we want to know how much our wealth is changing, that's the value $X\(t_(j + 1)\)- X\(t_j\)$, which ends up being

$X\(t_(j + 1)\)- X\(t_j\)= Delta\(t_j\)\(S\(t_(j + 1)\)- S\(t_j\)\)+\(X\(t_j\)- Delta\(t_j\)S\(t_j\)\(1 + r - 1\)$

This gives us the intuition to understand how the process is actually evolving. If we are to look at infinitesimally smaller pieces of time, we would eventually have the differential

$d X\(t\)= Delta\(t\)d S\(t\)+ r\(X\(t\)- Delta\(t\)S\(t\)\)d t$

If I assume that my stock follows a geometric Brownian motion, which is the assumption in the Black-Scholes model, and I replace $d S\(t\)$ with that, I get

$= Delta\(t\)\(alpha S\(t\)d t + sigma S\(t\)d W\(t\)\)+ r\(X\(t\)- Delta\(t\)S\(t\)\)d t$

And once I plug in, I can group these terms together and get

$= r X\(t\)d t + Delta\(t\)S\(t\)\(alpha - r\)d t + Delta\(t\)sigma S\(t\)d W\(t\)$

just picking and choosing my terms. The reason I have written it in this way is to see three different dynamics on display in the change of my portfolio

$r X\(t\)d t$ is the underlying return. If I had taken that money and put it in the bank, that's how much I would return. Is there an advantage in investing in the stock instead of just using the money market? Then we have to have a risk premium. That's given by $Delta\(t\)S\(t\)\(alpha - r\)d t$, which is the dynamic from choosing to invest in the risky asset instead of the riskless asset. Then we have noise. There is uncertainty that comes about in the value of our portfolio if we choose to invest in our asset instead of the money market. The more money in the asset, our volatility should go up. And that's what we see in $Delta\(t\)sigma S\(t\)d W\(t\)$ where this value is proportional to the value of $Delta\(t\)$.

Our task right now is to try and come up with a methodology to price an instrument. There should be some kind of relationship between these dynamics. I want to study not just how my processes change, but also my discounted process. When I compare money, I need to be comparing apples to apples. We need to look at dynamics of our stock and portfolio. If I wanted to define my discount stock process, I would multiply my stock process by the discount factor: $e^(- r t) S\(t\)$

How would I go about getting the differential? We could rewrite this as an Ito process because we know GBM is an Ito process. We just have to know what our function $f\(a\,b\)$ is.

$d\(e^(- r t) S\(t\)\)= d f\(t\,S\(t\)\)$

$f\(a\,b\)= e^(- r a) b$

$f_a = - r e^(- r a) b$

$f_b = e^(- r a)$

$f_(b b) = 0$ This is going to be

$= - r e^(- r t) S\(t\)d t + e^(- r t) d S\(t\)+ 1 / 2\(0\)\(d S\(t\)\)^2$

This now gives me that

$= - r e^(- r t) S\(t\)d t + e^(- r t) alpha S\(t\)d t + e^(- r t) sigma S\(t\)d W\(t\)$

which I can group the $d t$ terms together and get

$= e^(- r t) S\(t\)\(alpha - r\)d t + e^(- r t) sigma S\(t\)d W\(t\)$

We can see here how the discounted stock process would evolve, as this is the differential of the discounted stock process. How would I go about figuring out the differential of the discounted portfolio process? We use the same Ito process method. $d\(e^(- r t) X\(t\)\)= - r e^(- r t) X\(t\)d t + e^(- r t) d X\(t\)$

Plugging in what we know, we know

$= - r e^(- r t) X\(t\)d t + r e^(- r t) X\(t\)d t + e^(- r t) Delta\(t\)S\(t\)\(alpha - r\)d t + e^(- r t) Delta\(t\)sigma S\(t\)d W\(t\)$

And, if I combine terms, the first two will cancel.

$= e^(- r t)\(Delta\(t\)S\(t\)\(alpha - r\)\)d t + e^(- r t) Delta\(t\)sigma S\(t\)d W\(t\)$

Which we will slightly modify by pulling out $Delta\(t\)$

$= Delta\(t\)(e^(- r t) S \( t \) \( alpha - r \) d t + e^(- r t) sigma S \( t \) d W \( t \))$

Which we can recognize as being the differential of the discounted stock price

$= Delta\(t\)d (e^(- r t) S \( t \))$

We're going to assume that there is some initial stock price and wealth here for the purposes of math.

This makes sense, because once we discount our portfolio, we're ignoring wealth that would be accrued by earning money in the money market, so all the change will come from the changes in my discounted stock process. And the amount of change will be proportional to how many shares we own of the underlying asset.

Now we are going to try and do what is called a #strong[replicating portfolio]. This portfolio will perfectly match the value of the derivative of a security. If I have portfolios A and B, if at maturity, I know that A will perfectly match the value of B, then I know they will always have to have had the same value. If at any point in time, A was different from B, then you would just long one and short the other. At maturity, when you know they will be the same, you would close and get arbitrage. That is a guaranteed way to game the system, which cannot happen. One of the assumptions we will always make is that arbitrage cannot exist in a healthy, functioning market. We will try to construct a portfolio of a riskless and risky asset that will perfectly replicate a call option. In order to have A match B, moving in lockstep, we have to know how they're both going to change. I know now how a discounted portfolio will evolve. How will discounted security evolve?

Let $c\(t\,S\(t\)\)$ represent the value of a derivative security. We will mostly talk about call options today, but we will be explicit about when the calculations require them to be a call option. In this case, $c$ is any derivative. The first and second partial derivatives should exist and all that.

If we are to look at how it evolves, i.e.~its differential, we would use the Ito formula. Here we will adopt the book's notation where we use $t$ and $x$ instead of $a$ and $b$

$d c\(t\,S\(t\)\)= c_t\(t\,S\(t\)\)d t + c_x\(t\,S\(t\)\)d S\(t\)+ 1 / 2 c_(x x)\(t\,S\(t\)\)\(d S\(t\)\)^2$

That'll give me

$= c_t\(t\,S\(t\)\)d t + c_x\(t\,S\(t\)\)alpha S\(t\)d t + c_x\(t\,S\(t\)\)sigma S\(t\)d W\(t\)+ 1 / 2 c_(x x)\(t\,S\(t\)\)sigma^2 S^2\(t\)d t$

Because that is the definition of $\(d S\(t\)\)^2$. Again we will group $d t$ and $d W\(t\)$ together. This shows that keeping track of these is very important.

That gives us that

$=\(c_t\(t\,S\(t\)\)+ alpha S\(t\)c_x\(t\,S\(t\)\)+ 1 / 2 sigma^2 S^2\(t\)c_(x x)\(t\,S\(t\)\)d t + c_x\(t\,S\(t\)\)sigma S\(t\)d W\(t\)$

This is how an arbitrary derivative security will evolve at time $t$. But, that's not what we really want to study. We want to compare things to what is the evolution of discounted security. Automatically, when we have the Ito decomposition of this process, we can see that it's an Ito process. So isn't this just another example of us using Ito processes?

$d (e^(- r t) c \( t \, S \( t \) \)) = - r e^(- r t) c\(t\,S\(t\)\)thin d t + e^(- r t) d c\(t\,S\(t\)\)$

But we just figured that out, so we can plug in. This whole expression becomes

$= e^(- r t)\(- r c\(t\,S\(t\)\)+ c_t\(t\,S\(t\)\)+ alpha S\(t\)c_x\(t\,S\(t\)\)+ 1 / 2 sigma^2 S^2\(t\)c_(x x)\(t\,S\(t\)\)d t + e^(- r t) sigma S\(t\)d W\(t\)$ I now have two dynamics well expressed: the change in a portfolio and the change in a derivative security. I need a list of instructions. I need a way to match one portfolio to another portfolio. I can't really change the value in my derivative security. Let's say A is one share of a derivative security. B is my portfolio where I trade in the underlying, so I choose my $Delta\(t\)$ where they perfectly match. To this end, I need to match the endpoint $X\(T\)= c\(T\,S\(T\)\)$ and the change in the processes:

$d (e^(- r t) X \( t \)) = d (e^(- r t) c \( t \, S \( t \) \))$

Would it be enough for me to match a ball thrown if I raised it to the same height, or if I rolled it across the ground to reach the same point? No, I need to match both horizontal and vertical change for them to match. And those values are expressed by $d t$ and $d W\(t\)$, respectively. For the latter term, we get

$d W\(t\): e^(- r t) Delta\(t\)S\(t\)sigma = e^(- r t) sigma S\(t\)c_x\(t\,S\(t\)\)$

And if I match those, I'm going to see that

$Delta\(t\)= c_x\(t\,S\(t\)\)$ That is the choice for $Delta$ that will make these two portfolios match as far as changes with respect to Brownian motion. If I match the $d t$ terms, then I'm going to have (we'll assume $c$ means $c\(t\,S\(t\)\)$

$d t : e^(- r t) Delta\(t\)S\(t\)\(alpha - r\)= e^(- r t)\(- r c + c_t + alpha S\(t\)c_x + 1 / 2 sigma^2 S^2\(t\)c_(x x)\)$

We can see that we have a $alpha c x$ on both sides, so if we take those out, we get

$0 = - r c + c_t + r S\(t\)c_x + 1 / 2 sigma^2 S^2\(t\)c_(x x)$ And this is 100% where the Black-Scholes PDE comes from. This should work for underlying asset, so I should be able to come up with some differential equation where

$0 = - r c\(t\,x\)+ c_t\(t\,x\)+ r X c_x\(t\,x\)+ 1 / 2 sigma^2 X^2 c_(x x)\(t\,x\)$

This gives me a PDE I could theoretically solve to get the formula for my derivative security. Because these two match at maturity and are in lockstep at every other point in time, we get

$X\(0\)= c\(0\,S\(0\)\)$

==== Call Options
<call-options>
Now let's start pricing an instrument. We have now moved from an arbitrary derivative to a call option. The PDE was just made works for any process that derives its value from an Ito process. Every PDE or DE has an infinite number of solutions. Boundary constraints give us finite solutions. What boundary constraints make sense for a call option. If we live in this world, a call option is the right, but not the obligation to buy an asset for a fixed price at maturity. $K$ represents this price. We can look at the value of this derivative security at time $T$ (or as it approaches maturity). If I know I can buy an asset at $K$ dollars by owning this derivative security, let's say $K$ is 100, and current trading is 150. I would choose to buy this security right away, so I can buy the security at 100 and exercise it immediately. If the current trading was 80, I wouldn't buy. Therefore it's

$lim_(t arrow.r T) c\(t\,x\)=\(X - K\)_(+)$

That only gives me one of my values. There are two other boundaries to consider. Could we look at evolutions with respect to variable $x$? What am I actually saying here? The underlying stock has gone bankrupt. So why the hell would I ever want to buy that security? My call option is now worthless

$lim_(X arrow.r 0) c\(t\,x\)= 0$

What about the limit as $x$ goes in the other direction. Could there be a traded stock that's worth 1000 per share. What about 30,000, 500,000? Nothing says that couldn't happen. There is no upper bound on the value a stock could take. So the value of the derivative security is that price minus the strike price. The strike price must be irrelevant as the price increases, so it just becomes the price.

$lim_(x arrow.r oo) c\(t\,x\)approx X$

==== Black-Scholes-Merton
<black-scholes-merton>
The formula is

$c\(t\,x\)= x N\(d_(+)\(T - t\,x\)\)- K e^(- r\(T - t\)) N\(d_(-)\(T - t\,x\)\)$

But let's derive it so we can understand the pieces. This is bare-bones and we're going to make a few assumptions that we will explain further after the midterm. We just want intuition and a slight tweak. The slight tweak is that GBM will be rewritten as

$S\(t\)= S\(0\)exp\(r - sigma^2\/2\)t + sigma W\(t\)\)$

$d S\(t\)= r S\(t\)d t + sigma S\(t\)d W\(t\)$ We will rigorously derive this later.

To get the fair price, we get the value when it is exercised, discount it today's time, and then take its expected value.

Now we'll say the value of our derivative at time 0 is

$c\(0\,S\(0\)\)= bb(E) [e^(- r T) c \( T \, S \( T \) \)]$ Being a call option, this becomes

$= bb(E) [e^(- r T) \( S \( T \) - K \)_(+)]$

That + makes this a little trickier to integrate, which we will have to do because we want an expected value. To aid with that, we'll ask the question: when do we exercise? When $S\(T\)> K$. And that's the same as

$S\(0\)exp (\( r - 1 / 2 sigma^2 \) t + sigma W \( t \)) > K$

Everything there is known except for the source of randomness, which is the Brownian motion. We can get bounds for the Brownian motion because we know its distribution. So, solving this for Brownian motion by dividing and taking the log, we get

$\(r - sigma^2 / 2\)T + sigma W\(T\)> log (frac(K, S\(0\)))$ This becomes

$W\(T\)> frac(log (frac(K, S\(0\))) - (r - sigma^2 / 2) T, sigma)$

which we will indicate by the convenience variable $d *$

We can re-express this expectation as the indicator function based on this inequality, and then get the integral for it.

$= integral_(- oo)^oo e^(- r T) (S \( 0 \) e^(\(r - sigma^2\/2\)T + sigma X) - k) I_(X > d *) f_(V\(T\))\(x\)d x$

This then becomes

$= integral_(d *)^oo e^(- r t) (S \( 0 \) e^(\(r - sigma^2\/2\)T + sigma x) - K) 1 / sqrt(2 pi t) e^(- frac(x^2, 2 T)) d x$

Now we just evaluate this integral, which is really two integrals, so let's split it up.

$= integral_(d *)^oo S\(0\)e^(- r^2\/2 T + sigma X) 1 / sqrt(2 pi T) e^(- frac(X^2, 2 T)) d x - K e^(- r T) integral_(d *)^oo 1 / sqrt(2 pi T) e^(- frac(X^2, 2 T)) d x$

Looking at this second integral, this is the integral of mY PDF for Brownian motion.

We want to convert to a standard normal. Our mean is 0, and our variance is T. So this second integral ends up being the same as

$integral_(frac(d *, sigma))^oo 1 / sqrt(2 pi) e^(- z^2\/2) d z$

The normal distribution is symmetric around 0, so we can rewrite this in reverse as well

$integral_(- oo)^(- frac(d *, sigma)) 1 / sqrt(2 pi) e^(- z^2\/2) d z$

which is the standard normal of something I didn't have time to write down called $d_(-)$ Now for the other integral. We have

$S\(0\)integral_(d *)^oo e^(- sigma^2\/2 T + sigma x) 1 / sqrt(2 pi T) e^(- frac(X^2, 2 T)) d X$

which we can rearrange algebraically and take the standard normal of to get

$= S\(0\)integral_(frac(d * - sigma T, sqrt(T)))^oo 1 / sqrt(2 pi) e^(- z^2\/2) d z$

That lower term is the same as $d_(-) + sigma sqrt(T)$. This is going to be the same as

$frac(log (frac(S\(0\), K)) +\(r - sigma^2\/2\)T, sigma sqrt(T)) + sigma T$

so we can combine these and get

$frac(log (frac(S\(0\), K)) + (r + sigma^2 / 2) T, sigma sqrt(T)) = d_(+)$

#strong[Open question:] the source note ends this derivation here.

This is set up to work at any point in time up to the time of maturity.

If I'm going to say that $c\(t\,x\)= x N\(d_(+)\)- K e^(- r\(T - t\)) N\(d_(-)\)$

where

$d_plus.minus = frac(log (x / k) + r plus.minus sigma^2 / 2\(T - t\), sigma sqrt(T - t))$

and this standard normal function is the CDF

What is the limit as t approaches T? What does matter is the first piece, the behavior of the logarithm. Since the denominator is going to 0, we might say that it's going to infinity. But that depends on whether that log is positive or negative, which tells us the direction.

$lim_(t arrow.r T) c\(t\,x\)frac(log (X / k), sigma sqrt(T - t)) = {oo & x gt.eq K med - oo & x < K$

What can you tell me about the standard normal CDF evaluated at infinity? It's 1, by definition. What is it evaluated at negative infinity? It's 0.

$lim_(t arrow.r T) c\(t\,x\)= {x - K & x gt.eq K med 0 & x < K$

What about when x approaches 0? Then the log goes to negative infinity

$lim_(x arrow.r 0) c\(t\,x\)= 0$

What about x goes to infinity? We subtract our discounted K, which just becomes X.

$lim_(x arrow.r oo) c\(T\,x\)= x$

So this satisfies our boundary conditions.

If we consider our Black-Scholes

$c\(t\,x\)= x N\(d_(+)\)- K e^(- r\(T - t\)) N\(d_(-)\)$

What is the partial derivative? You might think it's $N\(d_(+)\)$, and it is, but not for the reasons you think. We will take $tau = T - t$, and expand out the definition of the derivatives of the normal distribution.

$c_x = N\(d_(+)\)+ x 1 / sqrt(2 pi tau) e^(- d_(+)^2\/\(2 tau\)) frac(1, x sigma sqrt(tau)) - K e^(- r tau) 1 / sqrt(2 pi tau) e^(- d_(-)^2\/\(2 tau\)) frac(1, x sigma sqrt(tau))$

Which we can rearrange to

$= N\(d_(+)\)+ frac(1, x sigma sqrt(2 p i)) (x e^(- d_(+)^2 / 2) - K e^(- r tau) e^(- frac(- d_(-)^2, 2)))$

Earlier, we had the result that $d_(-) + sigma sqrt(tau) = d_(+)$

So we can derive that

$d_(-)^2 = d_(+)^2 - 2 d_(+) sigma sqrt(tau) + sigma^2 tau$

and

$d_(-)^2 / 2 = d_(+)^2 / 2 - d_(+) sigma sqrt(tau) + frac(sigma^2 tau, 2)$

We also know that

$d_(+) sigma sqrt(tau) = log (x / K) + (r + sigma^2 / 2) tau$

So we can substitute this back in to get, knowing this, can't be bothered to write it out but it shows that the end solution is still $N\(d_(+)\)$

This becomes important when we determine $c_(x x)$ $c_(x x)\(t\,x\)= N'\(d_(+)\)frac(1, x sigma sqrt(tau))$

proof is left as exercise to reader

and $c_t$ is

$c_t\(t\,x\)= - r K e^(- r tau) N\(d_(-)\)- frac(x sigma, 2 sqrt(tau)) N'\(d_(+)\)$

If you take these results and plug them into Black-Scholes, you will get that it satisfies that formula.

We'll do a slight rewrite of Black-Scholes to show that

$r c\(t\,x\)= c_t\(t\,x\)+ r x c_x\(t\,x\)+ 1 / 2 r^2 x^2 c_(x x)\(t\,x\)$ $= - r K e^(- r tau) N\(d_(-)\)- frac(x sigma, 2 sqrt(tau)) N'\(d_(+)\)+ r x N\(d_(+)\)+ 1 / 2 sigma^2 x^2 frac(1, x sigma sqrt(tau))$

Which when we simplify out gives

$- r K e^(- r tau) N\(d_(-)\)+ r_x N\(d_(+)\)$

which is the same answer of Black-Scholes even though it's derived from probability.

==== Put Option
<put-option>
We don't need to start from scratch here.

With portfolio A, I buy one share of a forward. For our purposes, all calls, puts, and forwards share the same maturity $T$ and the same strike $K$. What is going to be the value of this portfolio at maturity? $A\(T\)=\(S\(T\)- K\)$ What about portfolio B? I am going to buy one share of stock, and short a zero coupon bond (aka one payout) that is going to pay $K$ at maturity. For this portfolio B, at time 0, we're going to have the value of the asset we bought one share of, and we shorted the bond, so we're going to owe somebody K dollars in the future, discounted to today:

$B\(0\)= S\(0\)- K e^(- r T)$

What about at $T$? $B\(T\)= S\(T\)- K$

Which is the same as a forward. In order for the market to disallow arbitrage, these two portfolios must have always had the same price.

$B\(t\)= s\(t\)- K e^(- r tau)$

A forward can be valued in this manner, purely through arbitrage arguments.

Now we have portfolio $gamma$ where we buy one call option and short one put option.

$gamma\(0\)= c\(0\,S\(0\)\)- p\(0\,S\(0\)\)$

What is the value at maturity? $gamma\(T\)= c\(T\,S\(T\)\)- p\(T\,S\(T\)\)$ We know the formula for a call option, so we can substitute that in. What about the put? If the price is trading below your strike, then you buy it at the current price, and sell it at the strike price.

$=\(S\(T\)- K\)_(+)-\(K - S\(T\)\)_(+)$

But if you notice, only one of these can be positive. So it ends up always being

$= S\(T\)- K$ So the value of my forward is the same as that

$f\(t\,S\(t\)\)= c\(t\,S\(t\)\)- p\(t\,S\(t\)\)$

This is called #strong[put-call parity]. It requires no assumptions about the stock process, it is purely based on market dynamics.

We can use our Ito magic here

$f\(t\,x\)= c\(t\,x\)- p\(t\,x\)$

$x - K e^(- r tau) = x N\(d_(+)\)- K e^(- r tau) N\(d_(-)\)- p\(t\,x\)$

One assumption is that the risk-free rate is constant. There's a modified version with a stochastic risk-free rate.

We can therefore isolate the put option and find that

$p\(t\,x\)= K e^(- r tau)\(1 - N\(d_(-)\)\)- x\(1 - N\(d_(+)\)\)$

playing around with our normal distributions, we know that this is the same as

$= K e^(- r tau) N\(- d_(-)\)- x N\(- d_(+)\)$

which is the value of the put. We didn't have to rederive everything because of the put-call parity.

==== Q&A
<qa>
You can use the boundary and the PDE to find the value of a put option, or you can use probability arguments. We derived the generic derivative PDE and used boundary constraints, which we will need later. We didn't actually use the PDE to get the formula for the call option, we just use it to confirm the option price.

There's not necessarily a good motivation for the intuition between the d+ and d-, the d\* is when the option is actually exercised, and the d+ and d- are modifications of that. This d\* is arguably the boundary for Brownian motion for the option to be exercised, that's the only real world application.

Because I have these nice boundary constraints on the strike price, it's more common to price the put and then get the call from the put-call parity. Prof did this in this PhD dissertation.

There's not always a real-world analogue in a mathematical construct, like for quadratic variation.

$N_(D +)$ is the number you would use to create the replicating portfolio, but there's no intuitive reason why it would do this.

Midterm will cover everything we've discussed in the first four chapters, including multidimensional stochastic differential equations.
