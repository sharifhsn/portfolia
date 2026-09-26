/*
title = "Yield Curves and Bootstrapping"
date = 2025-02-06
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Yield Curves","Interpolation","Bootstrapping","Nelson-Siegel","Smith-Wilson"]
*/

== From Last Time
<from-last-time>
We started to look at interest rates. In the first part we're going to discuss various interpolation methods, functions that are useful for modeling the yield curve.

That's useful because many times you might have to discount or use forward rates or discount factors for maturities that are not available. For this reason you have to do some interpolation.

== Yield Curve Interpolation Methods
<yield-curve-interpolation-methods>
What do we want to achieve?

In general, the interpolation problem can be expressed in the following format:

- given some data as a function of time $t_1\,t_2\,dots.h\,t_n$ and $x_1\,x_2\,dots.h\,x_n$ known
- construct a continuous function $x\(t\)$ that satisfies $x\(t_i\)= x_i$ for $i = 1\,2\,dots.h\,n$

What does it mean that the function is continuous? It means that at all points, the limit on left and right is the same, and that it passes through all points.

== Criteria for choosing the Interpolation Method
<criteria-for-choosing-the-interpolation-method>
- Smoothness of the forward curve is desirable

What does this mean? The derivative should be continuous i.e.~it should be differentiable. If the model has smooth curves, it should be more accurate because there's no reason to have rough changes in curvature.

- How local is the interpolation method?

If an input changes, does the interpolation function change locally or globally? Simple interpolation, linear interpolation have a local impact. Typically, each input just changes

It's good to have interpolation that impacts globally, but maybe not with very high sensitivity.

- Are the forwards not only continuous, but also stable?

The #strong[degree of stability] is the maximum basis point change in the forward curve given a basis point change in move in input (???? look this up)

== Linear Methods
<linear-methods>
Let's graph t against r

For $t_(i - 1) < t < t_i$ (this is the general case for local interpolation

$ r\(t\)= frac(t - t_(i - 1), t_i - t_(i - 1)) dot.op r_i + frac(t_i - t, t_i - t_(i - 1)) dot.op r_(i - 1) $

This is a simple rate from drawing a straight line between two points and picking the rate that corresponds to time

What is important for this class is to have consistent curves, to prevent arbitrage.

If this is the rate, how do we get the forward?

The price of a zero coupon bond is the continuously discounted forward rate

$ P\(0\,t_1\,t_2\)= e^(- f\(0\,t_1\,t_2\)dot.op\(t_2 - t_1\)) $

Then the forward rate is just the natural log of this scaled to time

$ f\(0\,t_1\,t_2\)= - frac(ln P\(0\,t_1\,t_2\), t_2 - t_1) $

Zero coupon bonds can also be determined in this way.

$ f\(0\,t_1\,t_2\)= - frac(ln P\(0\,t_2\)- ln P\(0\,t_1\), t_2 - t_1) $

In the limit, we can use the derivative

$ f\(t\)= - frac(d, d t) ln P\(t\)- frac(d, d t)\[r\(t\)dot.op t\] $

So this is the relationship between the forward and the zero rate r(t) Now we can determine a consistent forward. Therefore f(t) is the derivative rate of this product

$ f\(t\)= r\(t\)+ t r'\(t\) $

So if you take such derivatives, you can substitute the formula for the instantaneous forward.

$ f\(t\)= frac(\(2 t - t_(i - 1)\)r_i +\(t_i - 2 t\)r_(i - 1), t_i - t_(i - 1)) $

This is linear, so you can do a function which is linear in log rates if you prefer

== Linear in log rates
<linear-in-log-rates>
$ ln\(r\(t\)\)= frac(t - t_(i - 1), t_i - t_(i - 1)) ln\(r_i\)+ frac(t - t_(i - 1), t_i - t_(i - 1)) dot.op ln\(r_(i - 1)\) $

So this is kind of a linear interpolation between two points, but in general these curves are not linear, they have some curvature

== Exponential Interpolation
<exponential-interpolation>
The discount factors are

$ d\(t_1\)= e^(- r_1\(t_1 - t_0\)) $

$ d\(t_2\)= e^(- r_2\(t_2 - t_0\)) $

This is exponential interpolation for the discount curve, which will give us

$ r_1 = - frac(ln d\(t_1\), t_1 - t_0) $

$ r_2 = - frac(ln d\(t_2\), t_2 - t_0) $

Then we define

$ r\(t_a\)= lambda r\(t_1\)+\(1 - lambda\)r\(t_2\) $

Now we're going to calculate the discount factor

$ d\(t_a\)= e^(- r\(t_a\)\(t_a - t_0\)) = e^(- (lambda r \( t_1 \) + \( 1 - lambda \) r \( t_2 \)) (t_a - t_0)) $

$ = e^(- lambda r\(t_1\)\(t_a - t_0\)) dot.op e^(-\(1 - lambda\)r\(t_2\)\(t_a - t_0\)) $

== Cubic Spline Interpolation
<cubic-spline-interpolation>
Given n zero rates of n distinct maturities,

we will denote jth maturity and zero rate pair, which we will denote as

$\(t_j\,R_j\)$ where $j = 1\,2\,dots.h\,n$

The idea is to use such polynomials

How many can we create? n-1 cubic polynomials.

These polynomials will have different coefficients

$ R\(0\,t\)= cases(delim: "{", beta_(1\,0) + beta_(1\,1) t + beta_(1\,2) t^2 + beta_(1\,3) t^3 & t in\[t_1\,t_2\], beta_(2\,0) + beta_(2\,1) t + beta_(2\,2) t^2 + beta_(2\,3) t^3 & t in\[t_2\,t_3\], med beta_(n - 1\,0) + beta_(n - 1\,1) t + beta_(n - 1\,2) t^2 + beta_(n - 1\,3) t^3 & t in\[t_(n - 1)\,t_n\]) $

That's the system, but how do we solve it?

What might be the problem with this?

Right now we have four parameters, and it's 4 \* (n-1). 4n-4 unknowns, n-1 determinants, so this is an undetermined system. We don't have information in this system.

We can add some more information. The curve is continuous, so we can say that each part should be equal. Skipping some steps, we can say that

If R(0, t) is continuous and twice differentiable in t,

then n - 1 equations simplifies to (in a more compact form)

observed at time 0, maturity t

$ R\(0\,t\)= a + b\(t - t_1\)+ c\(t - t_1\)^2+ sum_(k = 1)^(n - 1) d_k\(t - t_k\)_(+)^3 $

This is dependent on the value of t, obviously.

Let's say you have a value of t in between t\_2 and t\_3.

$ sum_(k = 1)^(n - 1) d_k\(t - t_k\)_(+)^3= d_1\(t - t_1\)_(+)^3+ d_2\(t - t_2\)_(+)^3+ d_3\(t - t_3\)_(+)^3+ dots.h $

The first two terms will have positive values, and the rest will be 0

Now we've restricted our unknowns to a, b, c, and the discount factor $d_q\,d_2\,dots.h d_(n - 1)$ which is n + 2 unknowns with n discrete rates. This is still not fully determined.

You may see different results in different implementations based on the next steps, in Python or R.

We need two more conditions. It depends on the problem. Typically, there are conditions that make sense.

The first derivative at the ends of the intervals, we can make the assumption that the convexity is 0 right at the end of the intervals.

$ lim_(t arrow.r t_1) R''\(0\,t\)= 0 $

This counts as two conditions because it's left and right.

Then you have n + 2 linear equations and n + 2 unknowns. Now we are fully determined. The solution is very easy to obtain 😏

Let's take the vector

R\_1 is going to correspond to t\_1

Then you have to take the second order derivative, so what do you get for c? First derivative is 2c

In another way, you could write this as

$ mat(delim: "[", R_1; R_2; dots.v; R_n; 0; 0) = A dot.op mat(delim: "[", a med b med c med d_1 med dots.v med d_(n - 3) med d_(n - 2) med d_(n - 1)) $

Which we can solve by inverting the matrix

$ A^(- 1) dot.op mat(delim: "[", R_1; R_2; dots.v; R_n; 0; 0) = A^(- 1) dot.op A dot.op mat(delim: "[", a med b med c med d_1 med dots.v med d_(n - 3) med d_(n - 2) med d_(n - 1)) $

And then

$ mat(delim: "[", a; b; c; d_1; dots.v; d_(n - 3); d_(n - 2); d_(n - 1)) = A^(- 1) dot.op mat(delim: "[", R_1; R_2; dots.v; R_n; 0; 0) $

We got the values in A by taking the second order derivative, and the limit approaching t\_1

Explanation of derivatives

$ R\(0\,t\)= a + b\(t - t_1\)+ c\(t - t_1\)^2+ sum_(k = 1)^(n - 1) d_k\(t - t_k\)_(+)^3 $

$ R'\(0\,t\)= b + 2 c\(t - t_1\)+ sum_(k = 1)^(n - 1) 3 d_k\(t - t_k\)_(+)^2 $

$ R''\(0\,t\)= 2 c + sum_(k = 1)^(n - 1) 6 d_k\(t - t_k\)_(+) $

Then the limit will show this collapse

$ lim_(t arrow.r t_1) R''\(0\,t\)= 2 c $

$ lim_(t arrow.r t_n) R''\(0\,t\)= 2 c + 6 d_1\(t_n - t_1\)+ 6 d_2\(t_n - t_2\)dots.h $

But the matrix is a more elegant form.

This particular function will pass through all of these points, and it will be a beautiful curve.

== Functional Form of Yield Curve
<functional-form-of-yield-curve>
In general, if coupon bonds are available, then use the functional form

We're going to look at three popular models:

=== Nelson-Siegel Model
<nelson-siegel-model>
This is no longer an interpolation function, it's more of a fitting function.

We will write the specification and the characteristics for this function, and understand the procedure

$ R\(0\,t\)= beta_0 + beta_1 (frac(1 - e^(- lambda t), lambda t)) + beta_2 (frac(1 - e^(- lambda t), lambda t) - e^(- lambda t)) $

where we have $beta_0\,beta_1\,beta_2$ constants and $lambda > 0$ to specification. This is finding four parameters.

This particular function has some characteristics, we can look at these.

$ lim_(t arrow.r oo) R\(0\,t\)= beta_0 $

If you take a longer maturity, it goes to a constant. So $beta_0$ should be associated with the long-term interest rate, like the level of it. Before that, it has some curvature. What about at 0?

Well, you would end up a 0/0, so you can apply L'Hopital's rule.

$ lim_(t arrow.r 0) = beta_0 + lim_(t arrow.r 0) e^(- lambda t) + beta_2 lim_(t arrow.r 0)\(e^(- lambda t) - 1\) $

$ = beta_0 + beta_1 $

This is the spot interest rate, at t = 0.

Level Slope Curvature represent the three betas.

We have a numerical example just to see

==== Example
<example>
Assume that there are N coupon bonds.

For i = 1, 2, \\ldots N, the ith bond has the following specification

B\_i = cash(dirty) price of bond

m\_i = remaining number of coupon payments

These bonds have different maturities, and they may have different specifications in the coupon payments (frequency and amount)

t\_i^j = coupon payment date for j = 1, \\ldots m\_i

t\_i^1 = date of next coupon payment

t\_i^{m\_i} = maturity date and date of last coupon

$ delta_i = t_i^(j + 1) - t_i^j $

P\_i = principal

C\_i (amount of each coupon) = $delta_i P_i dot.op C o u p o n R a t e$

B\_i = Market Quote (Clean Price) + $C_i frac(delta_i - t_i^1, delta_i)$ (Accrual of Interest)

Theoretical Price:

$ hat(B_i) = sum_(j = 1)^(m_i) e^(- R\(0\,t_i^j\)dot.op t_i^j) dot.op C_i +\(T h e n D i s c o u n t P r i n c i p a l\)e^(- R\(0\,t_i^(m_i)\)dot.op t_i^(m_i)) dot.op P_i $

Basically you can calculate this for all bonds.

If you want to write this as an optimization problem, we want to find

$beta_0\,beta_1\,beta_2\,lambda$ that minimizes

$ sum_(i = 1)^N w_i\(hat(B_i) - B_i\)^2 $

that satisfies

$ {beta_0 > 0 med beta_0 + beta_1 > 0 med lambda > 0 $

This w\_i item is the weight assigned to bond i, if you want to equally weight them then it's 1.

Choices for w\_i:

- w\_i = $1 / t_i^(m_i)$ This one is a function of maturity, so longer maturity will have smaller weights. This will fit better on shorter maturity than longer maturity.
- w\_i =$- 1 / B_i dot.op frac(partial B_i, partial Y T M)$ This one is dependent on the duration of the bond

== Siegel-Svensson
<siegel-svensson>
Adds a second hump term (2 possible maximaminima

Let R(0, t) be the zero rate for maturity t, then

$ R\(0\,t\)= beta_0 + beta_1 (frac(1 - e^(- lambda_1 t), lambda_1 t)) + beta_2 (frac(1 - e^(- lambda_1 t), lambda_1 t) - e^(- lambda_1 t)) + beta_3 (frac(1 - e^(- lambda_2 t), lambda_2 t) - e^(- lambda_2 t)) $

We have some constraints:

$ {beta_0 > 0 med beta_0 + beta_1 > 0 med lambda_1\,lambda_2 > 0 $

The optimization problem for the previous problem was for price of the bonds. But otherwise we can write it as

We have the factor function, then the fitting function, then the objective function. That's how you get Nelson-Siegel.

For the optimization methods, there are some characteristics,

constrOptim.nl is what he uses

estimates

== Smith-Wilson
<smith-wilson>
Generates a smoothed interpolated and extrapolated term structures that fit the spot market rates.

has simplicity, works for low number of market data points but performance

This going to work like an interpolation, but it also extrapolates for longer maturities.

Parameters:

UFR: ultra long-term forward rate

LLP: last liquid point, where the zero coupon market support ends (e.g.~20 years)

CP: Convergence

== Assignment
<assignment>
This homework is due in two weeks. The first problem is similar to what we did last time, given some cash flows from different bonds, fill in the curve.

Determine the forward curve, bump it, and then if you change it, what's the change? If you have 10 years, you have 10 such cases, bump for each year.
