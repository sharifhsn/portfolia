+++
title = "American Options and Cubic Splines"
date = 2025-03-11
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","American Options","Linear Complementarity","Successive Over-Relaxation","Cubic Splines"]
+++

## Three New Topics

Cubic Splines, you solve something that is like a tridiagonal system

Artificial Neural Network multilayer perceptron…

Copulas (useful for 680\)

## American Option Valuation

page 192 of the QF book

the whole point of this is that you can exercise this at any time.

So when do we exercise, at time τ?

$$\\tau \\in \[0, T\]$$

There is a short, bad theorem that will help us.

If the underlying process does not pay dividends, and is continuous, then the price of an American call and a European call are identical.

You can prove this (the proof in the book is incorrect):

Clearly, $$C\_A(S, t) \\geq C\_E(S, t)$$ American call for price S and time t, and European, because the American has extra on top of the call. And this is also true for the Put.

$$C\_A(S, t) \\geq (S\_t \- K)\_+$$

$$P\_A(S, t) \\geq (K \- S\_t)\_+$$

You can argue this from a no-arbitrage argument, because if this were not true, you could instantly buy the option and exercise it and make money.

In general, no-arbitrage arguments go by assuming that there is a strict inequality, then showing how you can buy low and sell high and make money instantly.

Furthermore,

$$C\_A(S, t) \\geq S\_t \- Ke^{-r(T-t)}$$

Why? We can do another non-arbitrage argument. You can put some money in a bank and get that K term risk-free. If we take the opposite of this, we can buy the cheap thing and sell the expensive thing. You buy the call option and the K ZCB (which becomes negative when you move it to the other side).

First you short sell 1 share of stock (S\_t)

Then you borrow Kert and put it in a bank

Then you buy 1 call

Because of this inequality, I will receive S\_t, and take my portion of the money I get and after taking away the call premium and the Kert, I’m left with a positive quantity.

Everything with a minus is a liability, everything with a plus I have.

At time T, my S becomes S\_T, which I have to give back because I short sold it. Then I will receive K and it will make up the balance

Note that Kert is less than K, because e is raised to a negative exponent. And therefore

$$C\_A(S, t) \\geq S\_t \- Ke^{-r(T \- t)} \\geq S\_t \- K$$

Because the value is always greater than the early payoff, then you should never exercise it early.

The derivation in the book is wrong.

This doesn’t work for puts.

This result will also hold for continuous dividends, not discrete dividends.

### Free Boundary

To understand the American option problem, we have to understand the free boundary problem. In the differential equation described, you have a system of equations you have to tie down with boundaries. There are two types of boundaries, Neumann in terms of the actual function, Dirichlet which is expressed in the derivative. This is one boundary on the top and one boundary at the bottom (and the terminal condition). These are tied down to these curves.

Now a free boundary problem (which the American problem is) has another condition. This condition is not in a specific location. When are you going to exercise? When the expected future value of my option is going to be equal to or less than the value when I exercise now. If I exercise now and make more money, I should do that. But you don’t know what value of S and t will give you this. The problem is that you have to find this boundary.

In the book, it refers to the physics problem. A lot of the applications of these math problems come from physics. In our case, let’s say I price an American Put. The payoff is at $$(K \- S\_T)\_+$$

You can prove that because the form of the function is monotonic. This is the final payoff, so it decreases as S increases, and then stays the same, so it is not. Then the value of the put option is also monotonic.

There exists a price for the stock

$$S\_f(t)$$

At any time t, this stock price exists, the “frontier” price (another name for boundary)

we exercise if $$S\_t \< S\_f(t)$$ and we hold if $$S\_t \> S\_f(t)$$

What is the point of this? It’s a put option, so you make money if the stock price goes down. If the stock price is high, you make no money, and you want to hold. However, if the price is too low, maybe it will bounce up, so I should probably exercise.

If you look instantaneously, like a fraction of a second right before maturity, and you should definitely exercise if the option is in the money. So there’s a region that has no exercise and a region where you do exercise.

There’s a theorem:

$$\\frac{\\partial P\_A}{\\partial S}(S\_f, t) \= \-1$$

The derivative right at the frontier is \-1. If you’re exercising at the frontier, the value you get is K \- S\_f, so you have take the derivative with respect to S\_f, it becomes \-1. There are a couple more steps in the actual proof because you need to say that it’s continuous and so on but this is the basic idea.

If $$S\_t \\leq S\_f$$, then we exercise and get immediately $$(K \- S\_t)\_+$$

Then the free boundary problem tells us:

$$P(S\_F, t) \= (K \- S\_f)\_+$$

and

$$\\frac{\\partial P\_A}{\\partial S}(S\_f, t) \= \-1$$

As opposed to the other boundary problem, where it’s at fixed T, and you don’t know what S\_f is.

### Linear Complementarity Problem (LCP)

$$(\\frac{\\partial P}{\\partial t} \+ \\frac{1}{2} \\sigma^2 S^2 \\frac{\\partial^2 P}{\\partial S^2} \+ rS \\frac{\\partial P}{\\partial S} \- rP) (P\_A(S, t) \- (K \- S)\_+) \= 0$$

For the first parentheses, this is geq 0, and the second parenthesis is also geq 0 . On each side of the space, one of them is 0\. It’s the same as the tree. You went to a point, and if that point is more worth it to exercise, you would store the value that comes from the tree. In American, you’re never going to solve the early exercise.

Go back to your code for the American put and make the notes where you early exercise in red, and where you don’t exercise in black. In the lower part of the tree, you always exercise, and in the higher part you never do.

Left paren is you cannot exercise, and right paren is where you do. If you don’t exercise, the fair value is the european value.

If this stock value happens to be falling, then you exercise and right paren takes precedence.

We set up the problem so that it takes over when you exercise.

And then we also have the free boundary problems mentioned earlier.

Basically, we solve the LCP using finite difference.

In this, there are a bunch of steps that are reducing the problem, mentioned in the book like logarithm transformation, time transformation, and then you get equation 7.4.1

When you look at the finite difference method, you are looking backwards from the b\_i column at the end, and then u\_{i+1}

(however we are going forward not backward)

And then you solve it with AUi+1 \= bi

But that’s for European. With American we get inequalities

$$AU\_{i+1} \\geq b\_i$$

$$U\_{i+1} \\geq g\_{i+1}$$

The book will mention this g condition, describes the no-arbitrage condition.

To solve this system, we have to use what we learned last time about solutions.

We can use Jacobi or Gauss-Seidel. Gauss-Seidel is more computationally efficient because you only need one vector. Sometimes Jacobi is faster because Gauss-Seidel goes further, so it might go further in the wrong direction.

### Successive Over Relaxation

Recently, 70 years ago, they invented **Successive Over Relaxation (SOR)** which is used a lot in machine learning.

We don’t have much ML in the core of financial engineering, so we should be putting some methodology.

Bishop had a million ML methods and didn’t explain how.

$$U^{(k)} \= U^{(k \- 1)} \+ (U^{(k)} \- U^{(k \- 1)}$$

This illustrates an innovation from an old thing to a new thing. This particular example does nothing. Let’s do this instead. Instead of moving all the way to U^k, let’s move a little bit with ω

$$U^{(k)} \= U^{(k-1)} \+ \\omega (U^{(k)} \- U^{(k-1)})$$

If you make it less than 1, than you’re moving a fraction or otherwise you’re moving too much according to Gauss-Seidel.

Somehow that doesn’t make sense because we don't have U^(k) yet, so how do we do this?

We’ll store the whole Jacobi expression into a single variable y\_j

Then you calculate

$$U\_j^{(k)} \= U\_j^{(k-1)} \+ \\omega (y\_j \- u\_j^{(k-1)})$$
So basically instead of moving all the way with y\_j, you preserve it a little bit, and you decide how much you move based on ω. You can also change ω at every step, but this is not generally done. This is the SOR method. This is used to solve American options.

You don’t need to know the excruciating details, but you should know the big ideas.

### Cubic Splines

These were developed to approximate functions

Let’s say we observe f: (a, b) \-\> R

You don’t know the value of the function, maybe it’s really complicated, you want to approximate it.

in regression, you have a bunch of points, and you fit one line.

Let’s say our points are all over the place, and a line does not really fit.

You could group all the points as some kind of average, between the x and y coordinates, so you get multiple centers of mass for each region.

Then you want the curve to go through those points. The initial point distribution is totally irrelevant.

It doesn’t have to be a function. What if I have something that goes in circles, or has behavior that doesn’t go in circles. This is the computer science extension which uses B-splines, and conceptually there is no difference.

This is the principle. I do an endpoint approximation. We want to approximate f with piecewise polynomials, different polynomials on each segment.

We have n \+ 1 knots, these known points. It’s kind of like an anchor point to tie down your curve.

In our process, we take

$$t\_i \= a \+ \\frac{b-a}{n} i$$

That fractional thing is our Δt.

They don’t have to be like this. In general, we can have t\_0, t\_1, … t\_n and it will work the same way.

What is the condition? I want to make my curve smooth. I’m going to pick for each interval $$\[t\_i, t\_{i \+ 1}\]$$ we have $$f(t) \= P\_i(t)$$ polynomial

What are the conditions on this polynomial?

Let’s understand what happens at $$t\_{i-1}, t\_i, t\_{i+1}$$,

Well, one condition is that the polynomials have to connect, so $$P\_{i-1}(t\_i) \= P\_i(t\_i) \= f(t\_i)$$

And this becomes two equations for each i. That becomes 2n conditions.

Then I have to stitch them.

I don’t actually know what the derivative of the polynomial is. If I did know, I could impose the extra conditions that has another 2n conditions, for a total of 4n. But this is only if you know the derivative is, which would make this a lot easier.

You need to pick a cubic spline.

The realistic condition:

$$\\frac{\\partial P\_0}{\\partial t} (t\_i) \= \\frac{\\partial P\_1}{\\partial t} (t\_1)$$

You have 2n \- 2 equations

So how do you interpolate?

You could take a linear polynomial

$$P\_i(t) \= a\_i \+ b\_i t$$

This will clearly not work. You have 2n unknowns and 4n \- 2 equations.

The same is true for quadratic.

Cubic gives us

$$P\_i(t) \= a\_i \+ b\_i \+ c\_i t^2 \+ d\_i t^3$$

Now we have 4n unknowns and 4n \- 2 equations. So how do we fix this?

There are n \+ 1 points.

There’s a very clear order unless you somehow define it. And that determines how you stitch the functions. There’s an infinite number of solutions by fixing the two missing equations.

In traditinoal splines that come from statistics, the way it works is that there’s two possibilities.

There can be a free boundary problem where the $$S\_0’’ t(0) \= S\_nn’’ t(n) \= 0$$

When you say the second derivative is 0, that’s the maximum of the first derivative.
It starts with the largest slope possible,

Then the second one is the clamped boundary

$$S\_0’ (t\_0) \= f(t\_0)$$

$$S\_n’ (t\_n) \= f’(t\_n)$$

Because you don’t know the derivative, you constrain the curve to have a certain fixed slope.

You constrain the first one to start at a certain angle.

Then how do you solve this? It’s in terms of the functions and their derivatives.

I plug in these points and gets an equations in a\_i, b\_i, c\_i, and d\_i, and then the next parameters.

Basically I have four end parameters, and since these equations are relative to each other, it becomes a sparse system of equations.

It’s not tridiagonal, but it does have a system.

Then you solve it with Jacobi, Gauss-Seidel, SOR, etc. when you solve it in R.

These are very useful for smoothing approximations of curve. I have used them in my lecture earlier in the pricing the implied vol surface paper. This whole paper is inspired by two dimensional cubic splines. Basically, the Derman people created a bullshit local volatility problem. I thought about it and I realized, if you give me the option prices, and get the IV, and then fit a curve through these things. R had just created the 2D approximation and just used this. It’s basically the same as just described, but you do it with a line instead of points, but I don’t remember how and it’s pretty complicated.

There are many many applications to all of these numerical methods.

I learned about this realized volatility surface from these people, reading about this other method of approximation, and putting them together. That’s why it’s very important to learn approximation methods.

There’s many people that start the task, cut government waste, and then you go in there and have no clue what you’re doing. Method, knowing what to do is the most important thing.

Either you get videos from FOX that are BINGQILIN
