+++
title = "Crank–Nicolson and the Heston Model"
date = 2025-03-04
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Crank-Nicolson","Linear Systems","Heston Model","Finite Differences"]
+++

## AI Rant

Don’t use AI, you won’t learn anything.

And it’s not really intelligent, it just takes things from the Internet.

## Crank-Nicholson Finite Difference Methods

7.4 in the book.

There are two different general finite difference schemes, which are about which points you use in the grid.

In the explicit scheme, you go from many points to one point, so you can find out each point from the points in the boundary, kind of in a trinomial tree way.

In the implicit scheme, you go from one point to three points, which allows you to solve the systems, and find all the points altogether.

Crank-Nicholson is a variation of the implicit finite difference that is better than both, because it is more complicated.

We have the points. Remember that \\(i\\) is \\(\\Delta t\\), and \\(j\\) is \\(\\Delta x\\). We need three points for each derivative.

We will actually use the average of the points to calculate the x-type derivative.

This is the definition of ad derivative in a numerical sense:

$$
\\frac{\\partial u}{\\partial t} = \\frac{u(i + 1, j) - u(i, j)}{\\Delta t}
$$

For this one, we use the top yellow minus the bottom yellow.
It’s a bit tricky because it’ saveraged, the point is to use both at the same time.

Then you divide by the interval between them.

$$
\\frac{\\partial u}{\\partial x} = \\frac{\\tfrac{1}{2}(u(i, j+1) + u(i + 1, j + 1)) - \\tfrac{1}{2}(u(i, j - 1) + u(i +1, j - 1))}{2\\Delta x}
$$

Then the second derivative is horrendous. It works by using the two second derivatives and reducing to the value of the topmost plus the value of the bottom most minus twice the middle

$$
\\frac{\\partial^2 u}{\\partial x^2} = \\frac{\\tfrac{1}{2}(u(i, j+1) + u(i + 1, j+1)) - (u(i, j) + u(i + 1, j)) + \\tfrac{1}{2}(u(i, j-1) + u(i + 1, j - 1))}{\\Delta x^2}
$$

We have all these derivatives in the equation, but we will also use the u. We will use u\_i for the last term, which is just u(t, x)  for easier usage. I’m usinthe mid points, the yellow points, all over the place.

If I plug them into the equation, what do I get?

$$
\\frac{\\partial u}{\\partial t} + \\nu \\frac{\\partial u}{\\partial x} + \\frac{1}{2}\\sigma^2 \\frac{\\partial^2 u}{\\partial x^2} - ru = 0
$$

where \\(\\nu = r - \\tfrac{\\sigma^2}{2}\\)

Then, plugging in our finite differences, it’s

$$
\\frac{u(i + 1, j) - u(i, j)}{\\Delta t} + \\nu \\frac{u(i, j +1) + u(i + 1, j + 1) - u(i, j - 1) - u(i + 1, j - 1)}{4\\Delta x} + \\frac{1}{2} \\sigma^2 \\frac{u(i, j + 1) + u(i + 1, j + 1) - 2(u(i, j) + u(i + 1, j)) + u(i, j - 1) + u(i + 1, j - 1)}{2 \\Delta x^2} - r\\frac{u_{ij} - u_{i+1, j}}{2} = 0
$$

If this doesn’t work, please follow up because it might not work

I will isolate all terms that have terms u(i) because those are unknown, I already know i \+ 1\. So I should factor out these three terms here to get our coefficients

$$
u(i, j + 1)(\\frac{\\nu}{4\\Delta x} + \\frac{\\sigma^2}{4\\Delta x^2}) - u(i, j)(\\frac{1}{\\Delta t} + \\frac{\\sigma^2}{2\\Delta x^2} + \\frac{r}{2}) + u(i, j - 1)(-\\frac{\\nu}{4\\Delta x} + \\frac{\\sigma^2}{4\\Delta x^2})
$$

The point of being careful about this is that this is what gives us our A, B, and C. So it becomes Ax \+ By \+ Cz \=...

And now this is the nightmare you have to move to the other side, and make sure to change the sign.

$$
= -\\frac{1}{\\Delta t} u(i + 1, j) - \\frac{\\nu}{4\\Delta x}(u(i + 1, j + 1) - u(i + 1, j - 1) - \\frac{\\sigma^2}{4\\Delta x^2} (u(i + 1, j + 1) - 2u(i + 1, j) + u(i + 1, j - 1)) - \\frac{r}{2} u_{i+1, j}
$$

Now I have everything I need to do the pseudocode.

### Pseudocode

Initialize \\(\\Delta x\\) values.

Then I get the payoffs on the right most boundary based on \\((e^{x+ n\\Delta x} - K)_+\\) or whatever.

That is my values for u(n, N), u(n, N \- 1)...u(n, \-N)

These equations supposedly work from top to bottom. Because I can’t go to infinity. I need to add two boundary numbers. And all of these numbers should recursively go backwards.

Then you will end up with the tridiagonal system with A B C, 0 A B C, 0 0 A B C, etc.

Then you will also need the \\(\\lambda\_u\\) and \\(\\lambda \-L\\) to finish the vector.

The system has the very same form as the implicit finite difference method. The only difference is that the last b vector is solved in a complex way.

### Stability

How is this method stable with floating point errors?

You are dividing by A \+ B, which as long as it’s not tiny, it won’t explode.

## Methods to Solve Linear Systems of Equations

Imagine you have to solve Ax \= b.

Jacobi says, let’s do a trick. (This only works for nonzero diagonal systems).

$$
A = \\begin{bmatrix} a_{11} & a_{12} \\\\ a_{21} & a_{22} \\end{bmatrix}
$$

The diagonal cannot be zero.

You will take the lower triangle of the matrix L, the diagonal D, and the upper triangle U. This allows me to do

$$
(L + D + U)x = b
$$

You would normally take the inverse to get

$$
x = A^{-1} b
$$

But Jacobi was a finance guy. When you try to invert 2x2 it’s okay, 3x3 is painful, and 4x4 is unbelievable. So before they had calculators, he wanted to invert something easier.

$$
Dx = b - (L + U)x
$$

Basically only inverting the part I know how to invert easily, since inverse diagonal is just the inverse of all its elements.

$$
x = \\frac{1}{D}(b - (L + U)x)
$$
That might seem useless, but then we can do this:

Let’s start with some random x^0, maybe all zeroes, then plug this into the equation, and take the following recurrence:

$$
X^(k) = D^{-1} (b - (L + U) X^{(k - 1)})
$$

This looks ugly in matrix form, but it’s more easily expressed as:

$$
a_{11} x_1 = b_1 - a_{12} x_2 - \\ldots - a_{1n} x_n
$$

$$
x_2 = \\frac{1}{a_{22}}(b_2 - a_{21} x_1 - a_{23} x_3 - \\ldots - a_{2n} x_n)
$$

So you just move everything to the other side.

We’ll take \\(x^{(0)}\\) to be all zeroes.

Then you take the result in the next x, and recur it, and Jacobi proved that it will converge, AS LONG AS the diagonal elements are nonzero because notice that we have to divide by them.

There’s another generalization of this that will be useful when we talk about American options pricing.

## Gauss-Seidel

This is the PPO of the Jacobi, where it’s a very small change from the Jacobi.

$$
x_1^k = \\frac{1}{a_{11}} x_2^{(k - 1)} + a_{13}x_3^{(k-1)} \\ldots + a_{1n} x_n^{(k-1)})
$$

But if you notice in x\_2, we already calculated the previous recurrence. And this does two steps in 1, and it has faster convergence.

This is a very common idea called the fixed point method. Whenever you solve equations, you look for things that are fixed. If you calculate a derivative, the reason is because it is the maximum. However, when you get close to the maximum, and you get bigger, then you get stuck. The gradient method goes up and up until you can’t go anymore. You need to see this pattern everywhere, because it’s very important.

The human brain is stupid.

## Finite Difference for Heston

This is pretty tough, so we won’t get all the details.

There are some convergence issues with the explicit finite difference method. You need the conditions that

\\(\\Delta x \\geq \\sigma \\sqrt{3\\Delta t}\\) and \\(N = n\\).

Also, the order of convergence is \\(O(\\Delta x^2 + \\Delta t)\\). So you want \\(\\Delta x\\) to be as small as possible, to make convergence faster, so effectively the optimal is that it equals this.

We will pick an n, and then the following values fall out of it:
$$
\\Delta t = T/n, \\Delta x = \\sigma \\sqrt{3\\Delta t}, N = n
$$

There’s nothing to choose.

But you have some more freedom for IFD (Implicit Finite Difference) and Crank Nicholson.

We have the same order of convergence

$$
O(\\Delta x^2 + \\Delta t)
$$

but this is unconditionally convergent, so it doesn’t matter what values you pick, it doesn’t have this condition about being greater than whatever.

Let’s say that you want to be within epsilon of the true number.

So how do I make sure that I’m within? Technically you can’t, because big O has constants associated with it, but we might take

$$
\\Delta x^2 + \\Delta t = \\epsilon
$$

Because there is no relationship between them, you can pick anything for either. Let’s say

\\(\\Delta x^2 = \\tfrac{\\epsilon}{2}\\) and the same for \\(\\Delta t = \\tfrac{\\epsilon}{2}\\).

This gives you a known \\(\\Delta t\\) which will give you n.

But \\(\\Delta x\\) is not fixed.

But how far should I go? (N).

Because this process is Black-Scholes, we know that the spread at time T is lognormal, so \\(X_T \\sim N(x_0, \\sigma^2 T)\\)

So we need N such that \\(N \\Delta X > 3.5 sigma \\sqrt{T}\\)

We know that most values are within 3 standard deviations, I do 3.5 just in case, but generally it doesn’t matter.

For the Crank-Nicholson, we have

$$
O(\\Delta x^2 + \\frac{\\Delta t^2}{2})
$$

So we handle it in kind of a similar way to IFD. How you split it is your choice.

Last thing is about Calculating Greeks:

These finite difference methods are useful for calculating these derivatives.

You are approximating derivatives, and the Greeks are derivatives.

Gamma, theta, vega, are instilled in the u-values.

Delta x is not the stock price, so you actually need to take e^x\_0

For Delta:

$$
\\frac{u_{0, 1} - u_{0, -1}}{e^{x_0 + \\Delta x} - e^{x_0 - \\Delta x}}
$$

And similar for Gamma, we will need all three points, in the same way as the other second derivative was described.

The solution to the PDE is the same as the price of the option here, because that’s how we express the option. So we use the finite difference to numerically solve the PDE.

The best way to solve a PDE is analytically, then you’re done. But, I can count on my hand how many PDEs you can actually solve, just three. So in general, if you write anything (and the heat equation is one where there is a solution) it’s complex and you have to approximate it.

There is no formula for the Heston model.

It involves a characteristic and inverse characteristic function, which is the probabilistic version of a Fourier transform. And there are not that many known analytical solutions for the Fourier Transform.

So you do the discrete Fourier transform and the inverse discrete Fourier Transform.

That’s how the solution for the Heston model is expressed.

The ultimate way to solve for the Fourier is to do this finite difference method for the Heston model.

In order to solve the Heston model, we need to use a bunch of parameters. r is the reglar risk free interest rate.

$$
dS_t = (r - q)S_t dt + \\sqrt{y_t} S_t dW_t
$$

This is the same as Blck-Scholes but \\(\\sigma\\) is replaced by this other stochastic process \\(y_t\\).

And the parameters are

$$
dY_t = \\kappa (\\bar{y} - y_t) dt + \\sigma \\sqrt{y_t} dW^2_t
$$

where the two Brownian motions are correlated with \\(\\rho\\)

This is a Cox Ingersoll Ross process (or Ornstein Uhlbeck)

Let’s consider Black-Scholes: one reason it’s nice is because you can do this logarithm transformation like this:

$$
dS_t = rS_t dt + \\sigma S_T dW_t
$$

$$
dR_t = (r - \\tfrac{\\sigma^2}{2}) dt + \\sigma dW_t
$$

So you might use this for interest rates, but actually it’s bad. So you usually use this Vasicek (or Ornstein Uhlerbeck) model:

$$
dR_t = \\kappa(r - R_t) dt + \\sigma dW_t
$$

where r is the long term interest rate what the Fed does an model the short term interest rate. The problem is that it can be negative.

So this was created in 1978 and it was rejected immediately. Then in 2008, interest rates went negative and now Vasicek is what people actually use. And this can actually be solved. If you’re taking a qualifying exam you should know how to do this.

Then you have the Cox-Ingersoll-Ross model where you take the mean reverting feature and then add a square root term

$$
dR_t = \\kappa (r - R_t) dt + \\sigma \\sqrt{R_t} dW_t
$$

That R\_t makes the variance dependent ont he value of the proess. So when it goes close to 0, the volatility goes to 0 and the mean reverting term moves the process more to the mean. And this is the process used everywhere.

And you can see that this is the same dynamic for the Heston model.

However, unlike the CIR, this cannot be solved, does not have analytical solution.

One way to solve this is with transformations, which we will do after the midterm.

Another way is to come up with the PDE and solve the PDE with our other solutions.

Writing the PDE is not easy, you have to make a lot of no-arbitrage arguments.

### Heston Option Price

v is actually the variance, it is the value for the Y process.

$$
u(t, S, v)
$$

You can derive the equation, but I will write it down like I’m God.

q is the dividend thing. It’s a general thing for if you have a continuously paid dividend.

\\(\\theta\\) is the \\(\\bar{y}\\) in the heston model.

$$
\\frac{\\partial u}{\\partial t} = \\frac{1}{2} vS^2 \\frac{\\partial^2 u}{\\partial S^2} + \\rho \\sigma v S \\frac{\\partial^2 u}{\\partial S \\partial v} + \\frac{1}{2} \\sigma^2 v \\frac{\\partial^2 u}{\\partial v^2} - ru + (r - q) S \\frac{\\partial u}{\\partial S} + \\kappa (\\theta - v) \\frac{\\partial u}{\\partial v}
$$

In order to get this nice equation, we also take a change of variable where \\(t = T - \\tau\\) so this goes from a terminal problem to an initial problem. So I actually know the solution

$$
u(0, S, v) = (S - K)_+
$$

The reason why it’s like this is because in the solvers you have, they are designed to work as an initial value problem.

For all these terms, you need to substitute them and do the derivative stuff.

Everything else we’ve seen, but the mixed derivative is a little weird. It’s in the book, though. The bigger deal is that these coefficients depend on the location you are. They depend on where you are, they depend on S and v.

So in the equations, every time the coefficients are dependent on the grid. When you move back (or forward in this case) you have to keep track of your grid points and change your coefficients based on where you are.

There are two approaches:

**Fixed Grid**:

You will have three dimensional grid where you have to keep track of stock, time, AND variance. This is on page 190-191 of the book.

You read the corresponding points, you plug them into the equation, and the solution is solved in the same way.

The scheme here is an explicit scheme. The implicit scheme is absolutely horrendous for this.

**Smart Grid**:

Instead of using a rectangular grid, you will put your points in non-equally spaced space. The coefficients will become constant if you do it in this way. The coefficients are easy to solve.

## Remember This

There are two different types of finite difference,

EXPLICIT AND IMPLICIT

and implicit has some variations.

It’s about discretizing the derivatives. You have to look at every equation you discretize, which points you bring into the equations, because the equation is a relationship between these points.

It’s all about the points you pick. If your boundary is not a straight line, say a curve, then you want to form a relationship that has three points you know, a point you don’t know.

That’s the explicit scheme. Which is easier, but it has some drawbacks and some limitations, as descried relating to convergence.

Implicit gives you a system of equations, which will be linear, and eventually you will solve it.

## Research

I wrote 3 or 4 papers on this.

All of the equations, if you look, it’s like

$$
\\frac{\\partial u}{\\partial t} = L u
$$

where the operator L contains all this second derivatives, mixed derivatives, whatever.

We created a way to solve this, in a way that is parallel to the Jacobi idea.

You start with some u0 and plug it in here, take the derivative of the function, and then you get the derivative, which you can replug and recur.

Their methodology does both: it moves through the tree and recurs at the same time. It’s slow, but it works.
