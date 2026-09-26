/*
title = "Euler–Milstein and Monte Carlo Extensions"
date = 2025-04-15
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Euler–Milstein","Monte Carlo","Control Variates","Correlated Processes"]
*/

== Euler Milstein
<euler-milstein>
We will expand on the variance reduction techniques, we will repeat a couple things from last week.

But before we do that, we should talk about #strong[Euler Milstein] or Euler Maruyama.

$ P e o p l e k e e p t a l k i n g . I t h u r t s F l o r e s c u b e c a u s e h e h a s a d i s e a s e c a l l e d A D H D . $

This is a better approximation. I'm going to show you this because it involves applying Itô's formula a bunch.

Here is the stochastic process we can approximate. Euler works for any stochastic process, but Milstein has to be homogeneous, like so:

$ d X_t = alpha\(X_t\)d t + beta\(X_t\)d W_t $

These coefficients are not functions of time, so they are homogeneous.

The idea is to use Itô for both $alpha$ and $beta$. They are functions of stochastic process $X_t$. Therefore I can use Itô for both.

I get

$ d alpha\(X_t\)= alpha'\(X_t\)d X_t + 1 / 2 alpha''\(X_t\)\(d X_t\)^2 $

This is Itô, so we are lacking the dt, that term would screw up our calculations.

Now we substitute $X_t$ here, so we get

The dX^2 gets eliminated

$ = alpha'\(X_t\)alpha\(X_t\)d t + alpha'\(X_t\)beta\(X_t\)d W_t + 1 / 2 alpha''\(X_t\)beta^2\(X_t\)d t $

If I just group these terms and drop $X_t$ all over the place to make it easier to write:

$ =\(alpha' alpha + 1 / 2 alpha'' beta^2\)d t + alpha' beta d W_t $

Now, if we do the same calculation/derivation for $beta$, then we basically get something very similar. We're not going to go through the entire calculation. You can derive this yourself,

$ d beta\(X_t\)=\(dots.h\)d t + dots.h + d W_t $

Writing in integral from,

Now we substitute $alpha$ and $beta$ from the same formula. So there are two integrals:

```text
X\_{t+\\Delta t} \- X\_t \= \\int\_t^{t+\\Delta t}
```

When we substitute, we will get four terms, two terms for $alpha$ and $beta$ each.

We will get terms such as

$ d s d u tilde.op O\(Delta t^2\) $

We will change the letters to make sure they're right, based on what our dummy variables are

$ d s d W_u approx d u d W_s tilde.op O\(Delta t^(3 / 2)\) $

Because $d s$ is order $Delta t$, and $d W_t$ is order $sqrt(Delta t)$

Then there is

$ d W_u d W_s tilde.op O\(Delta t\) $

For the reason just discussed.

Once I substitute everything, I will neglect the first two orders, and will be left with terms with just du and ds

$ d u $

$ d s $

The existing equation then simplifies a lot

$ X_(t + Delta t) = X_t + alpha\(X_t\)Delta t + beta\(X_t\)Delta W_t + integral_t^(t + Delta t) integral_t^u beta'_s beta_s d W_s d W_u $

And there's another integral term you can see here.

You need to take the increments of Brownian motion and such, but then you can show that the integral term is equal to the

$ = beta'_t beta_t 1 / 2\(Delta W_t - Delta t\) $

This gives the Euler Milstein scheme.

The $X_(t + Delta t)$ is what you're approximating. The first part is the regular Euler, and then the integrals are the Milstein part.

If the model $ d X_t = alpha\(X_t\)d t + beta\(X_t\)d W_t $, then the Euler Milstein scheme is

$ X_(t + Delta t) = X_t + alpha\(X_t\)Delta t + beta\(X_t\)Delta W_t + 1 / 2 beta'\(X_t\)beta\(X_t\)\(Delta W_t^2 - Delta t\) $

And by $W$ you introduce a normal variable multiplied by $ Z tilde.op N\(0\,1\) $. The $Delta W$ is created by $ Z sqrt(Delta t) $. The other one is $ \(Z^2 - 1\)Delta t $ when the thing factors. For the same increment, you put it in two places, not just one places.

However, there is a possible issue, which might be the derivative. If the $beta$ function, the volatility part, if it's complicated, how do you calculate the derivative? That might be hard. There's another way to deal with this, a scheme called Runge-Kutta, a generalization where you calculate the Euler part, and plug it into the $beta$, then you calculate the finite difference as an approximation of the derivative.

One more thing to mention. Which I shouldn't, because it's from the homework. Let's have an example.

We have a process

$ d Y_t = kappa\(macron(y) - Y_t\)d t + sigma sqrt(y_t) d W_t $

This is the CIR process.

In this process, I have my

$ alpha\(x\)= kappa\(macron(Y) - x\) $

Then you have $beta$

$ beta\(x\)= sigma sqrt(x) $

If we now substitute in this formula, we have to calculate the derivative.

$ beta'\(x\)= frac(sigma, 2 sqrt(x)) $

Now if we do Euler Milstein:

$ Y_(t + Delta t) = Y_t + kappa\(macron(Y) - Y_t\)Delta t + sigma sqrt(Y_t) Delta W_t + upright(" milstein correction: ") sigma sqrt(Y_t) frac(sigma, 2 sqrt(Y_t))\(Delta W_t^2 - Delta t\) $

Here, the two $sqrt(Y_t)$ terms cancel, so it becomes $sigma^2\/2$.

The other thing to show is that if you look for example, this process.

$ d X_(=) e^(X_t) cos X_t d t + 0.7 d W_t $

Here, you have this constant

$ beta\(X_t\)= 0.7 $

So

$ beta'\(X_t\)= 0 $

Therefore there is no Euler-Milstein correction, because it relies on multiplication by the derivative. Like for example in GBM.

== Variance Reduction Redux
<variance-reduction-redux>
More of the idea to use on HW 4.

One additional note will be given on antithetic variate.

We discussed the CLT and the basis of the whole thing, and the variance being smaller gives you better estimates.

However, this is more complicated than that.

#strong[The better method is not always the one with smaller variability of the sample paths.]

We also need to consider the time to generate paths. If you have a Monte Carlo technique with less variability, but it takes one minute to generate a path, then it could be that another method with much higher variability that can generate 1 per second, is better, just by raw brute force. The paper mentioned is really good, the basis of the Monte Carlo book, which expands on the paper. Boyle is a Canadian professor from University of Waterloo, in 1997 they met, he did a summer school. He was drunk all the time in the morning lectures. Glasserman is a friend of the show as well. Third guy Brodie sucks.

If method 1 has variance $sigma_1^2$, and $b_1$, they have a term called "work", which could be time, but could be other stuff, $b_1$ is the work to generate one replication of the final parameter, the one you're trying to estimate, then we need to look at

$ sigma_1^2 b_1 < sigma_2^2 b_2 $

He has a better expression, but I'm showing the simple thing. Why multiplication? There's a reason

If you look at this perspective, and if you rewrite this as

$ sigma_1^2 / sigma_2^2 < b_2 / b_1 $

That's when you would prefer one method over another.

#strong[Antithetic note]:

Reminder: The way it works is you create one normal for one path, and use the negative of that normal for another path.

For antithetic variates, one replicate is $ frac(c_i + c_i^a, 2) = macron(C_i) $

The actual estimate is the average of the 2. This is not necessarily important for the final pricing, because if you take the general average, it doesn't matter, but it's important for the variance estimate, for confidence intervals.

This is because these paths are not independent, they're very related. So you would use something like

$ upright("Variance") = frac(1, n - 1) sum_(i - 1)^n\(macron(C_i) - macron(C)\)^2 $

This is important because each sequence of n is independent.

You might think I should iterate over 2n elements instead of n.~and do both the regular and antithetic.

But this one will show less than it really is.

== Control Variates for the Asian Option
<control-variates-for-the-asian-option>
Glasserman's explanation is better than mine, I will follow him.

The one with $Delta$-hedging and Asian option. There's nothing wrong with $Delta$-hedging or Asian option, it's just that it needs to be explained where it's coming from.

The control variate for Monte Carlo, what it does, it should be called "use what you know". You know, for example, that the option that $Delta$-hedges, you're using the concept that if you do this very fast, the two values should be the same.

Similarly, for the Asian option, we're using what we know.

$ P_A $ is the price of an Asian option based on Arithmetic average, which is what is encountered in practice.

$ P_G $ is geometric.

This $P_G$ has a formula, and for any variation on Asian options it's very easy to get a geometric formula.

We'll say we have a formula, if you give me characteristics and $mu$ and $sigma$, you get an exact number.

With this, let

$ hat(P_A) $ be the value calculated using a single path.

It doesn't matter what you use, just one single path, where you calculate the value of the Asian option based on this average of all these paths.

And we'll do the same for geometric

$ hat(P_G) $

We don't need this for geometric because we have the formula.

#strong[We are using the same path for both of these].

I do know that

$ bb(E)\[hat(P_A)\]= P_A $

On expectation, I get the true vlau eof my option.

I also know

$ bb(E)\[hat(P_G)\]= P_G $

If we subtract, we get

$ P_A - P_G = bb(E)\[hat(P_A) - hat(P_G)\] $

This gives you a very natural kind of estimate.

$ P_A = P_G + bb(E)\[hat(P_A) - hat(P_G)\] $

We can create a Monte Carlo path using this control variate:

$ hat(P_A)^(c v) = hat(P_A) - hat(P_G) + P_G $

If I create a new path and average this, then it should give me on average this difference

You can write it like this

$ = hat(P_A) +\(P_G - hat(P_G)\) $

That parentheses statement is the control variate. I have my original path with Euler Milstein, then I control it.

For every path, I obtain the difference between the true value and the value of geometric from that particular path. But is this better than just using $ hat(P_A) $?

If we want, we can calculate the variance. So the variance should be less. And remember that $ P_G $ is just a number, a constant with no variance.

$ bb(V)\[hat(P_A)^(c v)\]= bb(V)\[hat(P_A)\]+ bb(V)\[hat(P_G)\]- 2 upright("Cov")\(hat(P_A)\,hat(P_G)\) $

Everything after the first term should be negative to give me a better variance. The covariance should be greater than the variance. It's only worth it if the covariance is large.

This brings the next idea. This is the original term plus this term. I can control the size of the difference, which puts a $beta$ on the coefficient. That $beta$ allows me to make the thing smaller. This is all specific to the Asian option, where there is this arithmetic and geometric thing. But there is no assumption about the stochastic model.

$beta$ means I'm going to parameterize this:

$ hat(P_A)^beta = hat(P_A) + beta\(P_G - hat(P_G)\) $

I can play around with $beta$ in such a way that the resulting variance is the smallest. What is that? We can do the same exact calculation, and minimize the result with respect to $beta$.

$ bb(V)\[hat(P_A)^beta\]= bb(V)\[hat(P_A)\]+ beta^2 bb(V)\[hat(P_G)\]- 2 beta upright("Cov")\(hat(P_A)\,hat(P_G)\) $

This is a quadratic expression. It's a parabola, so the smallest value is in the vertex. The position of the vertex is obtain for

$ beta_(upright("min")) = - frac(b, 2 a) $

Where the varG is a, and the cov stuff is b.

$ = - frac(- 2 upright("Cov")\(hat(P_A)\,hat(P_G)\), 2 bb(V)\[hat(P_G)\]) $

This cancels to:

$ = frac(upright("Cov")\(hat(P_A)\,hat(P_G)\), bb(V)\[hat(P_G)\]) $

If you have two variables, the regression is the covariance divided by the variance, so this is the formula for market $beta$/regression.

So if we regress $ hat(P_A) = alpha + beta hat(P_G) + epsilon.alt $, the $beta$ is the $beta$.

Last week, we learned this was true, but now we know how to get it.

#strong[This control variate thing is basically]

$ hat(P_A)^beta = hat(P_A) + hat(beta)\(P_G - hat(P_G)\) $

Now we have another problem.

This is kinda screwed up. Because you're using the same paths to estimate $beta$, and the same path to estimate the value of the option. That introduces a bias, and this is calculated in the Glasserman paper.

Typically you have $n$ paths, and you set $n_1$ paths out to do regression. Then you use $n - n_1$ paths for calculation.

The advantage here is to do a proper regression, you don't need a lot of observations, 100 would be plenty. But for Monte Carlo, you need hundreds of thousands.

Hopefully this is more clear, and what I hope you get is that he used the particular relationship that exists in the Asian option, to reason through the whole thing.

I'm going to make another expansion to this. We can introduce more control!!

It's not really necessary because this existing control variate already gives a good estimate, but this shows you can introduce as many control as you like!

Under risk-neutral equivalent martingale measure, we have

$ S_0 = bb(E)^Q\[S_T e^(- r T)\] $

If you take the stock price as a martingale, and discount it back, you should get $S_0$. Nothing new.

This brings up another way to control.

We use the following, with $beta_1$ being our original control variate.

$ hat(P_A)^(c v) = hat(P_A) + beta_1\(P_G - hat(P_G)\)+ beta_2\(S_0 - hat(S_T) e^(- r T)\) $

Now you have the path, you know what $S_T$ is, and $S_0$ is a constant.

You have the same kind of regression of

$ hat(P_A) = alpha + beta_1 hat(P_G) + beta_2 hat(S_T) + epsilon.alt $

The constants don't matter because you're doing a regression, it just changes the y-intercept, doesn't impact the $beta$.

Technically, it's $sigma sqrt(t)$, which is the confidence interval size, the diffusion size. It's an estimate, work could refer to other things.

== Moment Matching Method
<moment-matching-method>
This is simple to use, so I'll mention it, even though it's useless.

If we have $ Z_1\,dots.h Z_n tilde.op N\(0\,1\) $

They should have theoretical mean 0, but the sample mean is not 0.

The idea is to modify the sample to match the theoretical moments.

The reason I actually have never taught this method is because it's kinda stupid, as a statistician.

Also, from the raw power of this method, it doesn't do better than straight Monte Carlo. It does better when you pair it with control variate, where the power comes from the control variate.

In the example here, the random variables don't have mean 0, so instead use $ Z_1 - macron(Z)\,Z_2 - macron(Z)\,dots.h $

These now all have mean 0, but now they're correlated. So it creates problems when estimating stdev, it becomes bad, very tricky for estimating confidence intervals.

In the example, let's say I'm going to price a European option based on GBM. When you do GBM, you don't have to do all the intermediate steps, you can do all in one step. Because the terminal value

$ tilde(S_T)\(i\)= S_0 e^(\(r - sigma^2 / 2\)T + sigma sqrt(T) tilde(Z)_i) $

After you modify the normal variable with the thing I said.

This is fine for European options, but it won't work for path-dependent options.

Confidence intervals are hard to obtain.

This is the first order moment matching. You can also do second order moment matching. Say we want to create $ N\(mu_Z\,sigma_Z^2\) $ I'm trying to create numbers that are normal with this particular target. The usual thing to do here is

$ Z_i tilde.op N\(0\,1\)arrow.r sigma_Z Z_i + mu_Z $

Multiply to create the desired distribution.

But the numbers in the sample will have their own sample mean and stdev. So you have to modify this as

$ tilde(Z_i) = sigma_Z / S_Z\(Z_i - macron(Z)\)+ mu_Z $

Each number is modified by these two numbers $S_Z$ and $macron(Z)$, where $S_Z$ is the sample stdev.

$ S_Z = sqrt(frac(1, n - 1) sum\(Z_i - macron(Z)\)^2) $

For the random variables in the sample, they will have the desired distribution.

Like I said, this is a method from the 90s. I never liked it because it's slower. All these modifications…

And in order to estimate the sample $mu$ and stdev, I have to do all of the simulations first, then calculate the samples, then plug them back, so it's SLOWER than doing it all at once.

And generally, from my experience, improvement is marginal, it's not particularly useful.

Is the sample calculated in one path or all paths? It depends. In this example, you need all the paths. But you can do it for one path if you like.

Computationally, when you have numbers that you're observing, if I have to estimate an average or variance of a certain number of them, theoretically, I can do this.

The idea of the GPU is that you have a lot of matrices and you do these calculations really fast. There is a memory of GPU and a memory of CPU. You want to keep everything in GPU memory as much as possible. The problem is that this method aggregates the paths, and does it again, which is impossible with a GPU.

== Additional Stuff
<additional-stuff>
Stratified sampling is not the best explained here. It is a statistics technique, check any statistics book they will explain better there.

Importance sampling, same deal. I have a chapter in my book about importance sampling which is way better.

#strong[Conditional MC]: very well explained in the paper

Low discrepancy sequences. (Quasi-Monte Carlo techniques). It's not explained well in the paper, but you can look it up and read better papers.

Briefly:

when you start generating one dimensional random variables, we'll say for a uniform distribution, we can use testers to see if the numbers are actually uniform.

Then you can generate pairs, two at a time $\(X_1\,X_2\)$ and plot them. You should definitely do this experiment with a random number generator. It would not look uniform at all. Human mind when you say uniform, thinks that it's perfectly spread out. The point of the quasi generator is to spread out on purpose, to get a perfect uniform distribution. It's okay as an exhaustive search method. But if you need more points, you have to quadruple them to have the same spread everywhere. The more detail you want, the finer quasi becomes, and it gets a lot slower.

But there are circumstances in which this is useful, and people in engineering that don't understand randomness like this thing.

#strong[Chapter 5] is about estimating American options using Monte Carlo simulations.

== subjective probability
<subjective-probability>
George Calhoun sent an article to me in Nature

Trump's election is a subjectiv eprobabiolity, it matters what people's perceptions are.

A stock, TSLA. It's been going down, so you'r wondering if it should keep going down or should it stabilize? And we don't know because the stock is not the value of the company, it reflects the perception of people about the company.

It's the same as poker. Game theory is so close to probability.

When people lose concentration, they react poorly.

== Generating Correlated Processes
<generating-correlated-processes>
If you have multiple stock processes that you want to generate that are correlated, how do you do that?

Each asset looks like

$ d X_t^i = f\(X_t^i\)d t + g\(X_t^i\)d W_t^i $

Each is a separate stochastic process, but they don't move their own way at random.

This Brownian motion is correlated.

If we take the notation $ X_t $ the vector of components, and same for f(x). This is the simpler case. You can have a more complicated thing. Each function could depend on all the other ones, it doesn't have to be driven by just one variable.

g(x) is a matrix dxd size, where dW is dx1, the vector of Brownian motion.

When you do the Monte Carlo simulation, the Brownian motion is what you're interested in simulating.

We will assume that these are correlated. With this notation, we have

$ d X_t = f\(X_t\)d t + g\(X_t\)d W_t $

It's more complicated because it's a collection of multiple integrals on dW, but we will write like this for conciseness.

We have the covariance matrix

$ upright("Cov")\(Delta W_t\)= Sigma Delta t $

This is Brownian motion. So what exactly is the covariance matrix? The components are the covariances of each of the components.

$ mat(delim: "[", 1, rho_12, rho_13, rho_(1 d); #none; #none; #none; #none) $

Symmetric and positive definite matrix!

Positive is vector times matrix times vector transpose, which is a 1x1 number. Positive definite means that for a vector u, this is always greater than 0. This is very important because you can take a vector multiply with vector which will give us the variance, which will be always positive.

For example, take Heston

$ d S_t = r S_t d t + sqrt(Y_t) S_t d W_t^1 $

$ d Y_t = alpha\(macron(Y) - Y_t\)d t + sigma sqrt(Y_t) d W_t^2 $

If I want to simulate this, which is part of homework, how would you do this?

Generate two random numbers which are correlated with $rho$.

For two, it's very simple.

We need $ X_1\,X_2 tilde.op N\(0\,1\) $, such that $ upright("Corr")\(X_1\,X_2\)= rho $

Then we can multiply by $sqrt(Delta t)$ and everything will work.

We will start with uncorrelated $Z_1\,Z_2 tilde.op N\(0\,1\)$. I'll take $X_1 = Z_1$.

Then, I'll take $X_2 = rho Z_1$. We can do this because the variance of $Z_1$ is 1, and covariance of $Z_1$ and $Z_2 = 0$\;

The combination has to have variance of 1, and if we're combining linear combinations, then it's normal.

So total value is

$ X_2 = rho Z_1 + sqrt(1 - rho^2) Z_2 $

If you understand the principle, what do I do when I want to do three? $X_1\,X_2\,X_3$

Take the same idea

$ X_1 = Z_1 $

$ X_2 = rho_12 Z_1 + sqrt(1 - rho_12^2) Z_2 ? ? ? ? $

$ X_3 = rho_13 Z_1 ? ? ? ? $

It becomes tricky. So is there a method to do this?

There is! You should know where this is coming from

We have a vector $X$ which is a lot of $X$s. We are interested in covariance, which is distinct from correlation. Our covariance matrix will be one diagonal, where we multiply by $sqrt(Delta t)$. The values on the diagonal of the matrix are the variance, and the rest are covariance.

So how do I generate a vector with this covariance structure? Here is the idea.

If $X$ is a random vector, (more details you could talk about in 540) with mean $mu$, componentwise for each element in vector, then

$ upright("Cov")\(X\)= bb(E)\[\(X - mu\)\(X - mu\)^T\] $

Take $Y = A X$. $A$ is a matrix, but it can be ANY DIMENSION $n times d$. We can transform 4 components into 15 components with different linear combinations.

The basis of the whole method is this:

$ upright("Cov")\(Y\)= bb(E)\[\(Y - mu_Y\)Y - mu_y\)^T\] $

And we know that the expectation of Y from linear combination si

$ bb(E)\[Y\]= A bb(E)\[X\] $

Because of this, we get

$ = bb(E)\[\(A X - A mu_X\)\(A X - A mu_X\)^T\] $

And you can factor this. Remember that the order is very important.

$ = bb(E)\[A\(X - mu_X\)\(A X - A mu_X\)^T\] $

And we can also do this in the transpose

$ = bb(E)[A (X - mu_X) (X - mu_X)^(T) A^(T)] $

And the inner product is the covariance matrix! So it ends up being this

$ = A Sigma A^T $

#strong[CHOLESKY DECOMPOSITION]

Take the $Z$ vector of iid normals, which are $N\(0\,I_d\)$. On the diagonal, you have 1 correlation.

Find a matrix A such that $ A A^T = Sigma $, the desired covariance.

The reason why you do this is because you have A, and you multiply it, and you get the thing you need.

Cholesky uses eigenvalues and eigenvectors, but it does exactly this.

== Covariance vs Correlation
<covariance-vs-correlation>
How do you get from the covariance matrix to correlation?

$ rho_(i j) = frac(sigma_(i j), sigma_i sigma_j) $

How do you go from this method to other methods and vice versa?

In terms of matrix operations, it's not complicated.

If D is the diagonal matrix of the variances (just the diagonal), then the correlation matrix is this. Inverse is regular inverse because it's just a diagonal.

$ = sqrt(D)^(- 1) times Sigma\(sqrt(D)^(- 1)\)^T $

And the transpose is actually the same thing.

And you do non-inverse to get from correlation to covariance.

Not commutative, so be careful.

== Markov Chain Monte Carlo
<markov-chain-monte-carlo>
Left unsaid
