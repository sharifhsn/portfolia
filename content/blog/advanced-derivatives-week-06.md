+++
title = "Hull–White Interest Rate Trees"
date = 2025-03-06
source = "Advanced Derivatives"
source_date_basis = "Scheduled Thursday FE-680 meeting date inferred from the syllabus sequence and the Academics calendar."
instructor = "Dragos Bozdog"
term = "Spring 2025"
[taxonomies]
categories = ["Fixed Income"]
tags = ["Fixed Income","Hull-White Model","Trinomial Trees","Interest Rate Models"]
+++

## Numerical construction of the trinomial tree for the Hull-White model

This will be focused on numerical methods, next week we will have more examples.



What is the difference between interest rate risk and stock price risk?

One of the most important differences is that the discount rate will vary from node to node. We will look at an example:

We’ll assume that the payoff of a derivative is 100(r-0.11)\_+



We also know the probability of going up, staying and going down as 0.25, 0.5, 0.25

![Hand-drawn Hull-White trinomial tree from the source notes.](/static/img/Advanced Derivatives-week-06-hull-white-tree.png)

Hull-White uses an alternative branching process. There is the typical (up med down) then (UP up med), (med down DOWN).

$$
dr = [\\theta(t) - ar] dt + \\sigma dz
$$

So what is the procedure?

First we have to assume \\(\\theta(t) = 0\\)

And the start is \\(r(0) = 0\\)

The construction of this trinomial tree should match the expectation and variance of the process? Basically we run the simulation based on the parameters.

Then we determine \\(\\theta(t)\\) so it matches the initial term structure.

Let’s look at the stages:

![Handwritten tree-construction steps from the Week 6 source notes.](/static/img/Advanced Derivatives-week-06-tree-construction.png)

Then we set \\(\\Delta R = \\sigma \\sqrt{3 \\Delta t}\\)

This particular equality is chosen for numerical convergence.



We need to determine which branching method applies at each node: (regular, up, down).

Let each node be \\((i, j)\\) where \\(t = i \\cdot \\Delta t\\) and \\(R* = j \\Delta R\\)

So this is the position in the state space.

As for indices,

i is related to time, it is positive. j can be positive or negative because Hull-White allows negative interest rates.

switching the branching scheme is dependent on the index j

**when a \> 0**

switch from branching *regular* to *down* for sufficiently large positive j.

switch from branching *regular* to *up* for sufficiently large negative j.

Let \\(j_{\\max}\\) and \\(j_{\\min}\\)for the value where you switch

Hull and White (posted on Canvas) show that the probabilities are always positive *if* \\(j_{\\max}\\) is equal to the smallest integer \> \\(\\frac{0.184}{a \\Delta t}\\)

$$
j_{\\min} = -j_{\\max}
$$

The point where we change branching is both dependent on the speed of mean reversion and the length of the time step.

Therefore we can say that the probabilities \\(p_u\\), \\(p_m\\), and \\(p_d\\) are chosen to match expected change and variance of change in R\*. We will solve for these unknowns with equations. What are those equations?

That depends on the branching strategy:

*regular*:

$$
p_u \\Delta R - p_d \\Delta R = -aj\\Delta R \\Delta t
$$

$$
p_u \\Delta R^2 + p_d \\Delta R^2 = \\sigma^2 \\Delta t + a^2 j^2
$$

$$
p_u + p_m + p_d > 1
$$

So this is your system of equations.

And by setting \\(\\Delta R = \\sigma \\sqrt{3 \\Delta t}\\), our system becomes

$$
p_u = \\frac{1}{6} + \\frac{1}{2}(a^2 j^2 \\Delta t^2 - aj \\Delta t)
$$

$$
p_m = \\frac{2}{3} - a^2 j^2 \\Delta t^2
$$

$$
p_d = \\frac{1}{6} + \\frac{1}{2} (a^2 j^2 \\Delta t^2 + aj\\Delta t)
$$

Note that these are all dependent on index j. We will look at an example of this.



Similarly, for *up*

$$
p_u = \\frac{1}{6} + \\frac{1}{2}(a^2 j^2 \\Delta t^2 + aj \\Delta t)
$$

… I didn’t write them down in time.

And for *down*

$$
p_u = \\frac{7}{6} + \\frac{1}{2}(a^2 j^2 \\Delta t^2 - 3aj\\Delta t)
$$

$$
p_m = -\\frac{1}{3} - a^2 j^2 \\Delta t^2 + 2aj\\Delta t
$$

$$
p_d = \\frac{1}{6} + \\frac{1}{2}(a^2 j^2 \\Delta t^2 - aj \\Delta t)
$$



Let’s take values of a zero curve

0.5

1

1.5

2

2.5

3

3.43

3.824

4.183

4.512

4.812

5.086



Building the first tree, we set our **vertical spacing** to the special numerical value \\(\\sigma \\sqrt{3\\Delta t}\\)

Then what is the value of j in our example?

$$
\\sigma = 0.01
$$



Then after we construct the tree, we have to displace the nodes to match the original term structure.

**STEP 2**

Convert this R\* tree into a tree for R, where we displace the nodes so that we match the initial term structure.

Our displacement function is

$$
\\alpha(t) = R(t) - R*(t)
$$

These can be calculated from the \\(\\theta(t)\\) expression. Recall that

$$
\\theta(t) = F_t(0, t) + a F(0, t) + \\frac{\\sigma^2}{2a}(1 - e^{-2at})
$$

Note

$$
dR = [\\theta(t) - aR] dt + \\sigma dW
$$

$$
dR* = -aR* dt + \\sigma dW
$$

So therefore if we substitute in,

$$
d\\alpha = [\\theta(t) - a\\alpha(t)] dt
$$

Then we can rearrange and integrate to get

$$
\\alpha(t) = F(0, t) + \\frac{\\sigma^2}{2a^2} (1-e^{-at})^2
$$

for infinitesimally small values.

So this is kind of a continuous function. In this case, we need finite Δt to match the term structure exactly. So it’s a little more simple

We define \\(\\alpha_i\\), which corresponds to each time step on the tree,

$$
\\alpha(i \\Delta t) = R(i \\Delta t) - R*(i \\Delta t)
$$

Here we’re interested in the discrete points on the tree.



Then the overall procedure here is that we are given some rates on the zero curve, but you can have multiple rates on the time step. So you have to price, and look at the value given by the market, and the value given by the tree.



Then we can define the present value of the security \\(Q_{i, j}\\) that pays $1 if node (i, j) is reached and $0 otherwise, so we can add up the probabilities and discount them. And we can calibrate α and Q to match the initial term structure.



So how do we start?

At 0, by definition, we pay $1

$$
Q_{0, 0} = 1
$$

And the displacement of the initial node is chosen to give the right price for a ZCB maturing at Δt. Since our zero rate is 3.824 for a one-year rate, we can set α\_0 to be that. In an exercise, if you were to take Δ to be 0.5 it would be that rate.

And then \\(\\alpha_1\\) should be chosen in such a way to be a ZCB that matures in two years.

Then next we calculate \\(Q_{1,1}, Q_{1,0}, Q_{1,-1}\\). i.e., at time i=1, there are three possibilities for j.

We use the probabilities, for \\(Q_{1,1}\\) it’s 0.1667. And then the discount factor is the value of R, in this case 3.824%.

we get the three values 0.1604, 0.6417, and 0.1604. And then we can use it to calculate \\(\\alpha_1\\) which is chosen to match the right price of a ZCB maturing at 2Δt.



We have the rate from the market, so we can price the bond with that rate. Such bond at 2Δt, you will discount with the rate applicable per branch, which is 1.732%. What we will see in this displaced tree, will be this original value 1.732% discounted.

$$
e^{-(\\alpha_1 + 0.01732) \\times 1}
$$

Then for node C, the rate 0 will be ignored so we just use α\_1

Then having the price of the bond at nodes B, C, and D, we can calculate the price of the node.

$$
A = Q_{1,1} e^{-(\\alpha_1 + 0.01732)} + Q_{1,0} e^{-\\alpha_1} + \\ldots
$$

From the initial term structure, we can get the ZCB for two years as the “market price” \= 0.9137.

And then we substitute in the Q values to get the total formula for the adjustment \\(\\alpha_1\\)

$$
\\ln\\left[\\frac{Q_{1,1}e^{R_{1,1}} + Q_{1,0} + \\ldots}{\\text{P(0, 2)}}\\right]
$$



**Here is the formal approach**. If we have \\(Q_{i,j}\\) already determined for \\(i \\leq m\\) where m is the final step of the tree. Then BIG LONG FORMULA on page 18\.


If you have the transition probability matrix, it’s an iterative approach where you determine α, then Q, then α, then Q.

## Recombining binomial tree
