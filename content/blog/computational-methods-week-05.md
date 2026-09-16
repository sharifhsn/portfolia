+++
title = "Differential Equations and PDE Methods"
date = 2025-02-25
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Differential Equations","PDEs","Finite Differences","Black-Scholes"]
+++

## Plan for the next weeks

Finite difference methods to approximate PDEs this week

Next week we will continue this and do a little bit more complicated stuff.

Homework is due right before spring break.

Exam will be any four hours during the weekend, questions will be a little different.

## Differential Equations

The first thing is the ODEs, the ordinary differential equations.

There is an entire class about this in every program, as long as you do some kind of engineering science you need to take Calc 3, which covers these.

The reason they’re called ordinary is because they’re about finding a function \\(f(x)\\).

The solution of the equation would be a function, expressed as derivatives of this function.

A fake example would be \\(2f''(x) + 3xf'(x) + x^2 + 2 = 0\\)

subject to \\(f(0) = 3\\)

just to see how it looks.

Normally you spend a lot of time solving first-order, the most complicated one. You learn how to solve equations with constant coefficients, and things that can be reduced by transformations to having constant coefficients. Then you make a polynomial that solves the PDE.

## PDEs

This is Calc 4, partial differential equations. You would only do this if your area requires it.

Not necessarily all of us have done this.

I thought this was the hardest, most horrible class. My professor purposely failed people (especially young women) so they would pay him for tutoring.

These will usually be a function of more than one variable, like

$$
f(t, x)
$$

The second variable is usually time, but it doesn’t have to be. x can be multi-dimensional also. Let’s say it’s a line. A practical application would be the heat equation. You have a metal rod and you apply heat to one end, and you look at the distribution of heat over time, f will measure the heat, t will measure time, x will measure location. You could also have a metal plate, and then x is multidimensional.

[Embedded figure omitted from the text export.]

So \\(f(t, x)\\) is what we’re trying to find.

We’re solving in the time \\(t \\in (0, \\infty)\\)

Most of the time, these problems have the initial condition.

The equations that we will deal with will have a **terminal boundary condition**, ending at T. You know what the option value is at T.

Some equations will start at 0, but you can change between boundary condition 0 and T with change of variables. If you do the \\(\\tau = T - t\\), then it will go from terminal to initial.

The x we’re talking about is \\(x \\in \\mathbb{R}\\), aka one dimensional, but in general \\(x \\in \\mathbb{R}^n\\).

## NYHOPS

Here is a practical example of this. I worked a former Stevens professor some years ago on NYHOPS, New York Harbor Ovserving and Predicting System. Something solves a bunch of PDEs to do forecasts of things like salinity, etc. for the next 48 hours, on a revolving 6 hour period. Actually they just calculate salinity, and it turns out that water speed is driven by salinity.

So how does he do it?

He uses some other equation that is used for viscosity of water, but we don’t need to worry about it.

Because this \\(f(t, x)\\) has two variables, the equations will involve multiple derivatives, **joint derivatives**.

LEt’s say we have a **Linear PDE**, which we will define as \\(u(t, x)\\). We will use u for our own purposes. This will only have second order derivatives

$$
a \\frac{\\partial^2 u}{\\partial t^2} + b \\frac{\\partial^2 u}{\\partial t \\partial x} + c \\frac{\\partial^2 u}{\\partial x^2} + d\\frac{\\partial u}{\\partial t} + e \\frac{\\partial u}{\\partial x} + fu + j
$$

This is the most general form of a linear PDE. Although they don’t have to be constant, for our definitions they need to be constant. The behavior of our solution, it turns out, is only governed by the second order derivatives. So we only need to worry about a, b, and c.

We will make a polynomial in α and β, where these represent the derivative with respect to t and x, respectively. Then,

$$
P(\\alpha, \\beta) = a\\alpha^2 + b\\alpha \\beta + c \\beta^2 + d\\alpha + e\\beta + ct
$$

And again we only worry about a, b, and c.

To reiterate: **The nature of the PDE is determined by the properties of these 2nd order terms.**

Specifically, we can look at these terms

\\(a \\alpha^2 + b \\alpha \\beta + c \\beta^2\\) and divide by \\(\\beta^2\\). THis gives us

$$
a(\\frac{\\alpha}{\\beta})^2 + b \\frac{\\alpha}{\\beta} + c
$$

And you can see this is a quadratic polynomial. It’s very well-studied and easy to solve. To solve for the determinant, it is

$$
\\Delta = b^2 - 4ac
$$

We have different behavior based on this Δ.

There are three types of major equations.

### Δ \< 0

The equation has no real solutions, only complex conjugate solutions. These lead specifically to **elliptic equations**. One example of this that you would have done if you covered PDEs is the **Laplace equation**.

The Laplace equation looks like

$$
\\frac{\\partial^2 u}{\\partial t^2} + \\frac{\\partial^2 u}{\\partial x^2} = 0
$$

This is the simplest equation that is elliptic. It appears in thermodynamics. If you’re dealing with gases, behavior in physics, you will see this.

### Δ \> 0

This is called a **hyperbolic equation**. These terms (by the way) come from the behavior of the solution.

When you solve a PDE like this, if you don’t have boundary conditions, you get a function which conducts a field. You can look at the derivative of a function and it will tell you where the function goes. You have to tie it down to get one particular surface. The magnetic field is one such function.

The minimum is (this is trivial)

$$
\\frac{\\partial^2 u}{\\partial t^2} - \\frac{partial^2 u}{\\partial x^2} = 0
$$

And if you pay attention to where a and c are, you can see where the positive and negative come form.

This is called the **wave equation**, the jumprope equation which vibrates, useful for earthquakes. The way they do it is by solving an equation of this time, (although with more terms), and the constants are determined by the structure of the earth.

### Δ \= 0

This is called the **parabolic PDE**. The **diffusion equation**, if you’ve heard of diffusion tensor imaging, or something like that, uses these kinds of equations. You can see the image of the brain, but it’s not even correct. The brain is made of grey matter, the neurons, and the white matter, which are the axons that connect them. But nobody can cut open your brain to look at the structure. But the white matter decomposes immediately. Nobody knows how they are connected, so you have to put them in the MRI and see how the water molecules move. These are very intrusive, so you can’t do it for too long, then you have to make connections. You can’t see the cables, you can only see the regions. So someone says to take the PDE from the 1970s where they consider the axons are pipes that they heat up.

The **heat equation** is the most classical example:
$$
\\frac{\\partial u}{\\partial t} - \\frac{\\partial^2 u}{\\partial x^2} = 0
$$

You have two terms that are missing, that’s the only way to get this equation. If you do this with parameters, then you get a square, which will become transformed into first-order aka not interesting. The only way to get second order you have to keep only one term. And in fact you can flip the t and x here and it’s not a big deal.

**All finance of any kind uses this equation**.

Because this is basically what you get when you have Markov processes. And in general diffusion of particles involves this.

## Boundary Conditions

In general, PDEs are solved for \\(t \\in (0, \\infty) \\times x \\in \\mathbb{R}\\). So how does this space look?
[Embedded figure omitted from the text export.]

But in finance, we are bounded by T:

If I don’t specify the boundary condition, the solution is floating, it can be infinite number of curves. I have to tie it down with the boundary T. And there’s another boundary at x \= 0\. You tie it down from three different places, t \> 0, t \< T, and x \> 0\. And I don’t care about anything other than when t \= 0, because that’s where I am now.

[Embedded figure omitted from the text export.]

In a nutshell, to solve this, we create a domain, and we make a grid on this domain. In order for this grid to fit, we have to make squares. They solve the equation on each tiny square. Then they propagate the solution (I will show you how soon). This is nothing special, it is general and it applies to any PDE whatsoever.

## Methodology

First: what is the PDE?

Let’s call \\(V(t, S)\\) for the value of an option at time t with asset price S.

We know that if the asset follows risk-neutral geometric Brownian motion, then V solves the following PDE:

$$
\\frac{\\partial V}{\\partial t} + rS\\frac{\\partial V}{\\partial S} + \\frac{1}{2} \\sigma^2 S^2 \\frac{\\partial^2 V}{\\partial S^2} - rV = 0
$$

And this is the Black-Scholes PDE (technically, it’s Merton’s because he’s the one that did the PDE.

However this does not look like the heat equation, because the coefficients are not constant.

But you can make it constant through the use of transformation:
\\(S = e^x\\), which is the same as \\(x = \\ln S\\)

You can make the t go to T to solve the initial value as well, but this is a different way.

Then we can call

$$
V(S, t) = V(e^x, t) = u(x, t)
$$

$$
\\frac{\\partial V}{\\partial t}(t, s) = \\frac{\\partial u}{\\partial t}(t, x)
$$

Since t doesn’t do anything, this is easy.

But what is

\\(\\frac{\\partial V}{\\partial S}\\) in terms of x? I have to substitute two derivatives.

But you can do the chain rule to solve for dvdS

$$
\\frac{\\partial u}{\\partial t} + (r - \\frac{\\sigma^2}{2}) \\frac{\\partial u}{\\partial x} + \\frac{1}{2} \\sigma^2 \\frac{\\partial^2 u}{\\partial x^2} - ru = 0
$$

And we’ll call r \- σ^2/2 \= μ for convenience.

Because this is constant coefficients, you can actually make this into a heat equation which is easy to solve. Merton solves it in a horrible way which is not like that. And you can reduce it into Black-Scholes.

But if there is no analytical solution, how do I approximate this solution? For Black-Scholes, we already have the analytical solution. We learn it as an example here, and once we learn the principle we can apply the methods for problems where there are only numerical solutions. NYHOPS does not have an analytical solution.

There’s two different ways of solving this. There is the **explicit** and **implicit** way. They are both **finite difference methods**. There is another way which is more appropriate to NYHOPS, but we will not cover that.

## Explicit Finite Difference

First, we take our domain.

$$
t \\in [0, T)
$$

x is different because we did this logarithm.

$$
x = \\ln S = (-\\infty, \\infty)
$$

We need to discretize this domain. A square grid is the easiest, simplest way to do it. Most PDEs are solved in this way.

We substitute the derivative with the finite difference at each point on the grid. Then we can solve based on where the asset price is. In the explicit method, we use the boundary, and you move from there to the direction you want to go. And you do so explicitly (Will explain soon what that means). Depending on how many terms you have, you need t terms to get one term, in this case 3\.

[Embedded figure omitted from the text export.]

## Implicit

The difference in this equation, is that you won’t be able to explain each point in terms of one. You have to solve equations in general. Explicit describes the points explicitly in terms of previous points. For implicit, the value is expressed by the value implied by ALL the values on the previous points.

## Differences

Generally, explicit is easier, but it may not converge. Implicit always converges.

BTW, NYHOPS works with curves and boundaries, which is called the finite element method. When you propagate these, you get inconsistencies, so if you have to keep propagating until you get convergence. You solve for the vertices of the cube. Now you have nine points available.

## How

This is the actual math for doing this.

### Discretize the Domain

We need to discretize t and x.

$$
\\Delta t = \\frac{T}{n}
$$

very simple.

Δx can be anything, with smaller being better. Is there an ideal relationship between Δx and Δt? There is, but we worry about that later.

$$
t = (0, \\Delta t, 2 \\Delta t, \\ldots, n \\Delta t)
$$

$$
x = (-N \\Delta x, (-N + 1) \\Delta X, \\ldots, 0, \\Delta x, \\ldots, N \\Delta x)
$$

So we have

2N \+ 1 points in x, and n \+ 1 points in t.

t thing doesn’t matter, x is crucial.

And we will notate the value of the function u as

$$
t_i = i\\Delta t
$$

$$
x_i = j\\Delta x - N
$$

$$
u(t_i, x_j) = u_{ij}
$$

We need three derivatives


### Explicit

This one is easy. The big difference is in how I make my derivatives.

They are calculated directly from these three points:

[Embedded figure omitted from the text export.]

Here are our equations:

$$
\\frac{\\partial u}{\\partial t} = \\frac{u_{i+1,j}-u_{ij}}{\\Delta t}
$$

$$
\\frac{\\partial u}{\\partial x} = \\frac{u_{i+1, j+1} - u_{i+1, j-1}}{2\\Delta x}
$$

$$
\\frac{\\partial^2 u}{\\partial x^2} = \\frac{u_{i+1,j+1}-2u_{i+1,j}+u_{i+1,j-1}}{\\Delta x^2}
$$

To get it, you need those three points.

All of these things are now substituted in our PDE.

$$
\\frac{\\partial u}{\\partial t} + \\mu \\frac{\\partial u}{\\partial x} + \\frac{1}{2} \\sigma^2 \\frac{\\partial^2 u}{\\partial x^2} - ru = 0
$$

Just the points with some constants like μ and σ.

Now you can determine those constants in terms of the other terms:

$$
u_{ij} = \\Delta t(\\frac{\\sigma^2}{2\\Delta x^2} + \\frac{\\mu}{2\\Delta x}) \\mu_{i+1,j+1} + (\\text{a term})u_{i+1,j} + \\text{another term}u_{i+1,j-1}
$$

If we take those coefficient terms to be \\(P_u\\), \\(P_m\\), and \\(P_d\\), respectively, the probability of going up, staying the same, or going down, then it turns into a trinomial.

And it’s almost the same as the formula for the trinomial tree\! The only difference is that explicit finite difference has \\(\\frac{1}{1+r\\Delta t}\\) inside the formulas, whereas the trinomial uses \\(\\frac{1}{e^{r\\Delta t}}\\) aka discrete vs continuous. And of course as N increases we approach continuous.

## Stability and Convergence

In order for this thing to converge, we must have \\(\\Delta x \\geq \\sigma \\sqrt{3\\Delta t}\\) which is the same condition as the trinomial tree. You can make Δx small, but not too small. Conceptually, Δx tells me how many points I have to solve for, and Δt tells me the number of steps I have to go through the tree. Because we have 3 to 1, we must have N \> n. We’re working around the grid, and N tells me how many points I have. And you can see this visually, that you will get stuck if you have too many Δx compared to Δt:
[Embedded figure omitted from the text export.]

If I pick \\(\\Delta x = \\sigma \\sqrt{3 \\Delta t}\\).

If you calculate Δ you need two points in the origin, Γ you need three points. Sometimes that is useful.

## Implicit Scheme

Fundamentally, if you understand the explicit, it’s similar.

Keep in mind the points. We’ll be using FOUR POINTS for the three derivatives.

[Embedded figure omitted from the text export.]

It’s hard to remember formulas. But it’s easier to remember how to derive them.

Now I’m going to plug them into the PDE, and then solve it. Remember that these coefficients are constants. Then you will get an equation relating these four points

$$
Au_{i,j+1} + Bu_{i,j} + Cu_{i,j-1} = u_{i+1,j}
$$

The NUMBER ONE MOST IMPORTANT THING IS:

**A, B, C are the same for all i,j**. This is normal because the coefficients of the PDE don’t depend on the location or time, no t or x in it. That makes it simpler to solve\!

Nonetheless, this is still an implicit solution.

**A, B, C are not probabilities anymore**.

We previously generalized American options by calculating the expected value of the future value of the option given that you are at that point. So you could take that point and compare what happens at exercise and store it. However, this doesn’t work, so it loses the interpretation of expected value.

**There will be an exercise about this**.

We have three unknowns and one equation, so we have to solve a lot of equations. We have 2N \+ 1 points. Because we are writing one equation for each set of three points, we will be lacking two equations, so we have 2N \- 2 equations. So the system built here CANNOT be solved.

Therefore we need to come up with two more equations.

The two extra equations are coming from boundary conditions. Remember, N is supposed to be very large. And our underlying is the log of the stock, these boundaries relate to very high and very low stock value.
It depends, because for a call, when a stock rises in value, the call becomes very valuable, for a put, it becomes worthless.

For Put, when \\(S \\uparrow \\infty\\), then value is small. Under our property of log, it can’t be 0, although obviously we think it is.

$$
\\frac{\\partial V}{\\partial S} = 0
$$

because it’s not going to change at all.

And then when \\(S \\downarrow 0\\)

$$
\\frac{\\partial V}{\\partial S} = -1
$$

This comes from the fact that K is a constant and derivative of S by itself is 1\.

If we consider the topmost \\(i,N\\). The difference

$$
\\frac{u_{i,N} - u_{i,N-1}}{e^{N\\Delta x + x_0} - e^{(N-1)\\Delta x + x_0}} = 0
$$

We should not be using u, but the corresponding Vs. We need to use the unknowns that we have, not other unknowns. So we can’t use dV/dS, we have to use the corresponding du/dS.

And we can get an extra equation from

$$
u_{i,N} - u_{i,N-1} = 0
$$

For the bottom put, it’s

$$
\\frac{u_{i,-N} - u_{i, -N+1}}{e^{(-N+1)\\Delta x + x_0} - e^{-N\\Delta x + x_0}}
$$

and that becomes

$$
u_{i, -N} - u_{i, -N+1} = \\lambda_D
$$

where λ is some number.

$$
u_{i,N} - u_{i,N-1} = \\lambda_U
$$

$$
u_{i, -N} - u_{i, -N+1} = \\lambda_D
$$

And these are two extra equations that we can use to solve.

But this matrix is HUGE, 2N+1 by 2N+1, will cripple your computer. We deal with imbeciles that solve by exhaustive search, that’s how LLMs work. If you take these matrix 201x201 and ask R to solve it, it’s very fast. Then 1000x1000 is a little slower, but it can still do it. However, you can solve this with your brain, by derivation.

It is three formulas, which are easy to implement\!

Since basically only the diagonal is populated, we are wasting our time doing typical matrix solving.

The idea is kinda cool. We know the matrix is solvable, because it’s invertible. We know that because the determinant exists and is not 0, easy to show.

There is a general method called the **Jacobian**, where you come up with some random numbers and plug them in. But there are two other methods to solve, the 5th grade ones: substitution and elimination.

And you can solve it in this way.

The first equation is

$$
u_N u_{N-1}
$$

You can express the latter in terms of the former..

Then you can express \\(u_{N-2}\\) in the same way, and keep bootstrapping to make it all functions of \\(u_N\\).

Then you go to the end and get

\\(u_{N-1}\\) and \\(u_{-N}\\) and get \\(u_N\\) from there, and then get everything else from there.

This is called in the book **solving a tridiagonal system**. Because you have three main diagonals, this is possible.

Technically you can solve this in general.

And this is in the book too.

We will assume matrix A
[Embedded figure omitted from the text export.]

You’ll see that this works with the numbers being all different, although it’s easier in our case with the numbers being the same.

To solve this, we go through the motion:

$$
a_{11} x_1 + a_{12} x_2 = y_1
$$

$$
x_1 = \\frac{1}{a_{11}} y_1 - \\frac{a_{12}}{a_{11}}x_2
$$

Let’s look at this structure. We have a number \- another number times x\_2. We’ll call those numbers C\_1 and D\_1.

$$
x_1 = C_1 + D_1 x_2
$$

Then

$$
x_2 = \\frac{y_2 - a_{21} C_1}{a_{21}D_1 + a_{22}} - \\frac{a_{23}}{a_{21} D_1 + a_{22}} x_3
$$

And you can see it’s the same type of expression as x\_1.

I came up with this on my own, the general idea of the derivation.

In general, each step i follows

$$
x_i = C_i + D_i x_{i+1}
$$

where

$$
C_i = \\frac{y_i - a_{i, i -1} C_{i-1}}{a_{i, i-1} D_{i - 1} + a_{i,i}}
$$

and

$$
D_i = -\\frac{a_{i, i+1}}{a_{i, i-1} D_{i-1} + a_{ii}}
$$

In general, \\(y_i\\) is

$$
a_{i+1, i}x_i + a_{i+1,i+1} x_{i+1} + a_{i+1,i+2} x_{i+2} = y_{i+1}
$$

we can substitute the same C and D terms as we had done in 2, and turns out to be the exact same terms.

That means it’s really easy to program\!

The only thing is, the end gets treated a little differently.

The last equation:

$$
a_{n, n-1} x_{n-1} + a_{nn} x_n = y_n
$$

We take that x value, and we say it’s equal to

$$
x_{n-1} = C_{n-1} + D_{n-1} x_n
$$

It makes it easy to express in the future, because then you can move them all to the end. Once you plug that in backwards, you’re going to get x\_n, so

$$
x_n = \\frac{y_n - a_{n,n-1} C_{n-1}}{a_{n,n-1} D_{n-1} + a_{nn}}
$$

AND THEN I’M DONE\!
