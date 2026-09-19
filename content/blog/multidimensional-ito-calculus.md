+++
title = 'Multidimensional Itô Calculus'
date = 2024-10-24
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Multidimensional Models', 'Correlation']
+++

## Week 7

### Lecture Notes

We’re going to be talking about multivariable stochastic calculus. All of this material is fair game for the midterm. Next week is the midterm review session. Bring questions\!

We’re mostly going to be doing applications and extensions today, which is not too bad.



How do we deal with more than one source of randomness? We need to have more than one Brownian motion. We have been talking about the money market and a risky asset, but there are multiple stocks in existence. We need multiple sources of noise. We can’t use the single source of noise, because Tropicana and Amtrak are impacted differently from e.g. the price of steel. How do we work with multiple sources of noise?

Let’s define what it means to have a d-dimensional Brownian motion. In order to consider a 10-dimensional Brownian motion as opposed to 10 Brownian motions, we need to have each process to be a Brownian motion, and these are all independent. We need to define the associated filtration on this space. Information should accumulate, and everything should be measurable with respect to that filtration, and each of those increments should be independent.

Because each one is a Brownian motion in its own right, the quadratic variation for each Brownian motion is t. I’m still going to have

\(dW_i(t)dW_i(t) = dt\)

We still don’t know the cross-variation between two independent Brownian motions?
\(dW_i(t)dW_j(t) = ?\)

We will prove that this is 0.

Similar to what we did for proving the quadratic variation to be t, we’re going to do a mean squared convergence. We will create a process \(C_\Pi\) the sample cross-variation:

\(C_\Pi = \sum_{k=0}^{n-1} \left(W_i (t_{k+1}) - W_i(t_k)\right) \left(W_j(t_{k+1}) - W_j(t_k)\right)\)

This would be the real cross variation if it went to 0. We are going to study the expectation and variance as the norm of the partition goes to 0.

If we can define these and figure these out, we can show that the cross variation will converge to the variable that has this mean and this variance.

How could I calculate the expected value? Let’s just use the definition

\(\mathbb{E}[C_\Pi] = \mathbb{E}\left[\sum_{k=0}^{n-1} (W_i (t_{k+1}) - W_i(t_k)) (W_j(t_{k+1}) - W_j(t_k))\right]\)

I have linearity, so I can move the expectation inside the summation.

\(= \sum_{k=0}^{n-1} \mathbb{E}\left[(W_i (t_{k+1}) - W_i(t_k)) (W_j(t_{k+1}) - W_j(t_k))\right]\)

Now we use independence. These two Brownian motions are independent from each other, so their increments are independent. Using this independence, we say

\(= \sum_{k=0}^{n-1} \mathbb{E}\left[(W_i (t_{k+1}) - W_i(t_k))\right] \mathbb{E}\left[(W_j(t_{k+1}) - W_j(t_k))\right]\)

Well what is that expected value? 0\!

\(= 0\)

What is the limit as the norm of the partition goes to 0, of 0? 0\!

Now let’s do variance \(\mathbb{V}[C_\Pi]\)

We could try the traditional expectation of squares method, but we would then have to work with \(C_\Pi^2\). What is that?

\(C_\Pi^2 = \sum_{k=0}^{n-1} \left(W_i (t_{k+1}) - W_i(t_k)\right) \left(W_j(t_{k+1}) - W_j(t_k)\right) \cdot \sum_{k=0}^{n-1} \left(W_i (t_{k+1}) - W_i(t_k)\right) \left(W_j(t_{k+1}) - W_j(t_k)\right)\)

Which isn’t wrong, but is maybe more daunting than we need. Maybe there’s a better way we can tackle this. We’re going to take advantage of properties we know about variance. In particular, we have this result:

\(\mathbb{V}[\alpha X + \beta Y] = \alpha^2 \mathbb{V}[X] + 2\alpha \beta cov(X, Y) + \beta^2 \mathbb{V}[Y]\)

In order for this to be useful, we need these numbers to be independent. We have the property that future increments are independent of the filtration, so we will have the independence between the product of the increments.

Aside: The cross variation of a process with respect to itself is the same as quadratic variation.

We can then write

\(\mathbb{V}[C_\Pi] = \sum_{k=0}^{n-1} \mathbb{V}\left[(W_i (t_{k+1}) - W_i(t_k)) (W_j(t_{k+1}) - W_j(t_k))\right]\)

because of this independence. Let’s examine the variance of one of these elements.

To get this variance, we can take the expectation of squares here.

\(= \mathbb{E}\left[\text{Inc}_i^2 \cdot \text{Inc}_j^2\right] - \mathbb{E}\left[\text{Inc}_i \cdot \text{Inc}_j\right]^2\)

I know for any Brownian motion that the variance is length of time, because that’s quadratic variation. Therefore it’s just that value squared.

\(= (t_{k+1} - t_k)^2\)

For this normal random variable, the expected value is 0, so in this case the variance is the same as the variance squared. Now if we look at the limit of the norm of the partition going to 0 for the variance, we get

\(\lim_{\|\Pi\| \rightarrow 0} \sum_{k=0}^{n-1} (t_{k+1} - t_k)^2\)

But that’s just the formula for the quadratic variation of time, which must be 0 because it’s a continuous differentiable function.

If it’s converging to mean 0 and variance 0, then that’s just 0.

We have proven that the cross variation is 0, and therefore the differential of the cross variation is also 0.

If you multiply a Brownian motion by itself, you get the variance not the mean. This result is only for independent Brownian motions.

#### Two Dimensional Ito Process

This leads us to our two dimensional Ito process. Big distinction between just two Brownian motions and the two-dimensional, because dimensional means independent.

We could write a standard Ito process as

\(X(t) = X(0) + \int_0^t \Delta (u) dW(u) + \int_0^t \Theta (u) du\)

But now my delta and W are both vectors, and we take the dot product of these, which is a scalar vector multiplication

Why don’t we have a dot product with the thetas? Can you have multi-dimensional time? No. We don’t want multidimensional time, so we don’t have multidimensional theta. Theta could depend on the process, but you wouldn’t decompose with reference to different aspects of movements in time.

What if we take the differential?

\(dX(t) = \sigma_1(t) dW_1(t) + \sigma_2(t)dW_2(t) + \Theta(t)dt\)

Now what if we square it? Too long to write out, but it follows all the rules of multiplication. We proved earlier that \((dW_1(t))^2\) is dt, and the same for \(dW_2\). We also know that the product of those is 0 because their cross variation is 0, and the product of dt and any of these dW is 0. So most of it is gone. The only thing that sticks around is

\(= \left(\sigma_1^2(t) + \sigma_2^2(t)\right)dt\)
I can use this result. I know that this is a handy way to get the quadratic variation of an Ito process by integrating this differential.

\([X, X](t) = \int_0^t \sigma_1^2(u) + \sigma_2^2(u) du\)

There’s a lot of different ways to do this. Sigma is just standing in here for any adapted stochastic process. We are going to define X(t) by its own Ito process. These multidimensional Ito processes have the nonrandom constant, d Ito integrals, and then the Riemann of time.

Let’s say we have two well-defined multidimensional Ito processes in this way. Defined as such, what is

\(dX(t)dY(t) = ?\)

Let’s not write out all these terms. We know that dW multiplied by any differential except itself is 0, and dt multiplied by any differential is 0. So we get the terms

\(= (\sigma_{X,1} + \sigma_{X,2})(\sigma_{Y,1}+\sigma{Y,2})\)

This is all to build up to the concept of the two dimensional Ito formula. We are going to use the Taylor series expansion with *three* variables now. That would say that

\(f(t_{k+1}, X_{k+1}, Y_{k+1}) = f(t_k, X_k, Y_k) + f_t(t_k, X_k, Y_k)(t_{k+1} - t_k) + f_X(t_k, X_k, Y_k) (X_{k+1} - X_k) + f_Y (t_k, X_k, Y_k)(Y_{k+1} - Y_k)\)
And all the second order terms. But we don’t worry about those… we can use the same arguments from the past and move the first element to the left as a telescoping sum. When we sum all of these together and get the limits, we can turn all those increment terms into differentials. And then because the second order involves multiplying differentials, these all become 0. Not all of them though. The cross terms are not 0 based on our definition, so we still need to consider \(f_{XX}\), \(f_{XY}\), and \(f_{YY}\). But we can rage quit on third order because that definition includes dt, so we will eliminate those and get 0.

**For future reference: \(X = X(t)\), \(Y = Y(t)\), to save my fingers.**

\(df(t, X, Y) = f_t(t, X, Y)dt + f_X(t, X, Y) dX + f_y(t, X, Y) dY + \frac{1}{2} f_{XX}(t, X, Y) dX^2 + f_{XY}(t, X, Y)dXdY + \frac{1}{2}f_{YY}(t, X, Y) dY^2\)

These are all partials.

We have the product rule of Ito processes. And we still need to include the cross term. In normal calculus, this term is 0.
\(d(XY) = XdY + YdX + dXdY\)

Let’s do our partials to prove this.
\(f(t, X, Y) = XY\)

\(f_t = 0, f_X = Y, f_Y = X, f_{XX} = 0, f_{XY} = 1, f_{YY} = 0\)

Then using our formula, that’s

\(= 0dt + YdX + XdY + \frac{1}{2}(0)dX^2 + 1 dXdY + \frac{1}{2}(0)dY^2\)

\(= XdY + YdX + dXdY\)

Let’s find the differential of the discounted stock process

\(e^{-rt}S(t)\)
I could do the whole stochastic mess we did before, or I could recognize that this is something where I can use the Ito product rule.

\(d\left(e^{-rt}\right) = e^{-rt} dS + Sd(e^{-rt}) + d(e^{-rt})dS\)

\(d(e^{-rt}) = -re^{-rt} dt\)

Warning: you need the dt, or it’s not a differential, it’s a derivative\! A derivative is the rate of change, and the differential is the instantaneous change. The derivative does not exist because Brownian motion is not smooth anywhere, so we have to use the differential.

Any continuous process with t and W(t) is an Ito process. All of our results are only for continuous processes.

#### Lévy

This is a very handy result. If we have a martingale M relative to filtration \(\mathcal{F}\), the starting value is 0, it’s continuous, and the quadratic variation is t, then it is a Brownian motion. We don’t actually need the normally distributed part to prove this.

Quadratic variation and variance are different things\! Quadratic variation is how much second order variation a process will have on one path, and it’s a random variable. The variance is how much you expect the process to differ from its mean on average, which is a single number.

We are going to prove that this is a Brownian motion. We will need all of these components. Because M is continuous, it must be a continuous process, which means we have an Ito decomposition, so M is an Ito process.

So we can now use the Ito formula to look at an arbitrary function f on M
\(f(t, M(t)) = f(0, M(0)) + \int_0^t f_a(u, M(u)) du + \int_0^t f_b(u, M(u))dM(u) + \frac{1}{2}\int_0^t f_{bb} (u, M(u)) dM^2(u)\)

I know that M(0) is equal to 0 from rule 2, and we also know that \(dM^2(u)\) is \(du\) because of rule 4 (definition of quadratic variation).

\(f(t, M(t)) = f(0, 0) + \int_0^t \left(f_a(u, M(u)) + \frac{1}{2}f_{bb}(u, M(u))\right)du + \int_0^t f_b(u, M(u))\,dM(u)\)

This is a trick where we use a sledgehammer as a scalpel. We have established this true for any function f, so it has to be true for one particular function. That particular function is if

\(f(a, b) = e^{ub - \tfrac{1}{2}u^2a}\)

with a nonrandom dummy variable \(u\) that we don’t know the value of. Let’s get our partials.

\(f_a = -\frac{1}{2}u^2f(a, b)\)

\(f_b = uf(a, b)\)
\(f_{bb} = u^2f(a, b)\)
If I plugged this in, I would get

\(f(t, M) = e^{uM - \tfrac{1}{2}u^2t}\)
I have now that (skipping some steps)

\(e^{uM - \tfrac{1}{2}u^2t} = 1 + \int_0^t u f(u, M) dM\)

If I take the expected value, I can factor out the nonrandom component

\(\mathbb{E}[e^{uM}] e^{-\tfrac{1}{2}u^2t} = 1 + \mathbb{E}\left[ \int_0^t u \cdot f(u, M) dM\right]\)

Exercise 4.1 asked us to prove that an Ito integral with respect to a martingale is still a martingale, which was a further proof of the class proof on a Brownian motion. Therefore the expectation of the Ito integral, which is itself a martingale, must be 0, because that was its initial value.

\(\mathbb{E}\left[e^{uM}\right] = e^{\tfrac{1}{2}u^2t}\)

And that is the moment generating function of a normal variable with mean 0 and variance t.

So you can prove that the martingale is normally distributed. Then you can go forward and say that it’s a Brownian motion (proof left as exercise).

Now let’s do a two dimensional Lévy.

The same four properties are important to us, with the tweak that the cross variation has to be 0.

We are considering each martingale in the set. We can use the same proof we did before to find the expectation and variance of a two dimensional Brownian motion to get the solution for every function f, and then generalize to

\(f(t, X, Y) = e^{u_1X + u_2Y - \tfrac{1}{2}(u_1^2 + u_2^2)t}\)

which results in

\(\mathbb{E}\left[e^{u_1M_1 + u_2M_2}\right] = e^{\tfrac{1}{2}u_1^2t} e^{\tfrac{1}{2}u_2^2t}\)

which is the joint moment generating function.

What we have expressed here is that the joint moment generating functions are the product of the individual moment generating functions, which means that the martingales are independent. That’s the only requirement to prove dimensionality, since we’ve already proved that they’re individually Brownian motions.

#### Correlated Stock Prices

Let’s say you have two stock prices and you don’t want them to be independent, since that’s how the real world works. The claim is that we can express differentials for the stock processes:

\(dS_1 = \alpha_1S_1dt + \sigma_1S_1dW_1\)

\(dS_2 = \alpha_2S_2dt + \sigma_2S_2\left(\rho dW_1 + \sqrt{1 - \rho^2} dW_2\right)\)

We can all agree that S\_1 follows Brownian motion, so we know its closed form solution.

S\_2 is only a Brownian motion if that big term on the right is a Brownian motion.

Let’s think abstractly. We have a Brownian motion

\(B_1 = W_1\)

And another

\(B_2 = \rho W_1 + \sqrt{1 - \rho^2} W_2\)

Lévy helps us prove this by giving us the four conditions to satisfy. We need the martingale property. So let’s see what the expectation is on the filtration.

\(\mathbb{E}[\rho W_1(t) + \sqrt{1 - \rho^2} W_2(t)|\mathcal{F}(s)]\)

We can separate through linearity.

\(= \rho \mathbb{E}[W_1(t)|\mathcal{F}(s)] + \sqrt{1 - \rho^2} \mathbb{E}[W_2(t)|\mathcal{F}(s)]\)

We already know that Brownian motion is a martingale, so we can use that information here.

\(= \rho W_1(s) + \sqrt{1 - p^2} W_2(s)\)

Which by definition is

\(= B_w(s)\)

It also fulfills the zero property if you substitute. What about continuity? It’s a linear combination of continuous processes, so it must be continuous.

Final: what is quadratic variation? We can solve that simply through \(dB^2\)

\(dB_2^2 = \rho^2 dt + (1 - p^2) dt\)

\(= dt\)

So it must be a Brownian motion.
Now pulling us back to our original stock process.

\(S_1 = S_1(0) e^{(\alpha_1 - \tfrac{\sigma_1^2}{2})t + \sigma_1B_1}\)

We have chosen our correlation coefficient to be between -1 and 1 so that we don’t deal with imaginary numbers.

If we take the cross variation of these stock processes.

These are two Brownian motions, but they have correlation. Their cross variation is not 0\! But what about their covariance?

What is the correlation between our sources of noise? We need to know the covariance. We already know the variances of Brownian motion.

I’m going to have that

\(\mathbb{E}[B_1|B_2] = \int_0^t B_1dB_2 + \int_0^t B_2 dB_1 + \int_0^t dB_1dB_2\)

We have Ito integral with respect to martingale, so that becomes 0

\(= \mathbb{E}[\int_0^t \rho du] = \rho t\)

Therefore the covariance is

\(\frac{Cov(B_1, B_2)}{\sqrt{\mathbb{V}[B_1]} \sqrt{\mathbb{V}[B_2]}} = \rho\)

This is the Kolesky decomposition of these two correlated Brownian motion into independent Brownian motions.

What is the correlation of my two stocks given by these processes? We get this through the original equation that S\_ 1 follows GBM, and we know that structure

\(\mathbb{E}[S_1] = \mathbb{E}\left[S_1(0) e^{(\alpha_1 - \tfrac{\sigma_1^2}{2})t + \sigma_1 B_1)}\right]\)

Skipping some steps,

\(= S_1(0)e^{\alpha_1t}\)

How do we get the variance of S\_1?

\(\mathbb{V}[S_1] = \mathbb{E}[S_1^2] - \mathbb{E}[S_1]^2\)

This would be

\(= S_1^2(0) e^{2\alpha_1t+\sigma_1^2t} - S_1^2(0) e^{2\alpha t}\)

We would then take the square root of this to get the standard deviation, so in order to plug this in we need to know the covariance between S\_1 and S\_2, which is

\(\mathbb{E}[S_1S_2] - \mathbb{E}[S_1]\mathbb{E}[S_2]\)

I’ve created these through correlated Brownian motion, so I can’t just say they’re independent. I know that they’re Ito processes though\! So I can decompose.

\(d(S_1S_2) = S_1dS_2 + S_2dS_1 + dS_1dS_2\)

\(= S_1\alpha_2S_2dB_2\)
