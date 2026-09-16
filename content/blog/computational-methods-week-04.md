+++
title = "Trinomial Trees, Dividends, and Greeks"
date = 2025-02-18
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Trinomial Trees","Dividends","Greeks","Finite Differences"]
+++

## Homework

I posted an assignment, this assignment is due this week on Sunday. Let’s just talk about the homework.

This covers material from first two lectures.

This lecture and previous lecture (trees) will be HW 2\.

Q: “Implement the Newton \-whatever method, do we have to implement them alL?” A: You can implement all three for bonus

Q: Put, vs call option? A: Use both

Q: When you see equity data in the first part, what should we get? Tick-level data, just the price?

A: You need price of the underlying. You don’t need for daily or anything, the most important option derivative is delta and gamma. Basically, you can calculate the price of the option if you know the price of the stock. You really needed to read the price of the stock, just get that price at the moment you download the option data.

Q: Do we have to include code in the appendix?
A: You don’t need an appendix, but if you use Python, you should include the py file or Jupyter notebook, some way of checking that?

Q: How many strike prices do we need?
A: You should use whatever makes sense to you. Normally, let’s use VIX as an example. That’s calculated from options on S\&P 500\. They literally take all of the options, because there’s tons of them, until they get to the two that have had zero trades in the last five minutes or so. That’s the rules. They basically get to options that haven’t been traded in a long time, so their prices are not current. Look at the most traded options, and don’t include options that don’t have a lot of volume. Just go enough in the tails to make sense for the data. What I want you to see in the option data and detail in the submission is the volatility smirk. I want to see some kind of decrease with strike price, and what happens when you look at next month volatility vs three months, then plot them all and see what you observe. Then it’s possible that the day you downloaded the data you don’t observe that, and that’s okay\! The point is to explain what you get from the data.

## Forgot to Discuss Last Time

When we calculate this option data, we said well, you basically step down in the tree, and then at every step you calculate the discounted expected value based on the nodes further on in the tree.

\[In Romania we have to do a thesis after Bachelor’s degree. In 1995, at the time, something just appeared. Before you type with a typewriter or write nicely with a pen. Computers had appeared, so Windows 3.1 is what we were using. It had a Word document processor. I was saving the files on the floppy disk. I was using the school computer. After I wrote half of my thesis, the file just crashed. So I couldn’t really open it. I was writing it with a pen, and I was typing it, so it was horrible, and I was about to quit school. And then a friend of his said that he was working at some company and said “I don’t know anything”. He was in charge of the Bucharest water system and routing teams to fix water when it breaks. You may not realize, but there’s a lot of emergencies that happen in a big city. He said that because I’m not doing anything else, I’ll type your thesis. And because of this experience, I have to save things. You guys are spoiled, everything is saved online\]

## Combinatorial Formula {#combinatorial-formula}

There’s not really a big deal about this.

We discussed trees and how they are constructed. The tree represents the volution of the stock.

[Embedded diagram omitted from the text export.]

You have to go down at the first step, then go all the way up. Or go down at the second step, then go up the rest. Or go down at third step after happening.

You can think about it in a combinatorial way, where it’s

$$(3 \\choose 1)$$

All of these paths have the same probability.

The probability that you end up in this particular node over here will be

$$(3 \\choose 1\) \* p\_u^2 \* p\_d^1$$

And this is exactly the binomial probability.

In general, if you look at n steps, at the top value, you know what the value is. Let’s say it’s an additive tree.

[Embedded diagram omitted from the text export.]

Because of this, you can calculate the payoff just by using the top price

$$\\varphi(e^{x\_0 \+ n \\Delta x\_u}) \\times (n \\choose 0\) p\_u^n$$

This is the probability of the one node.

My payoff is $$\\varphi(S\_T)$$, but it’s

$$\\mathbb{E}\[\\varphi(S\_T)|\\mathcal{F}\_0\]$$

Conditioned on time 0\.

So my expectation is payoff times probability.

$$= \\sum\_{i=0}^n \\varphi(e^{x\_0 \+ i \\Delta x\_u}) \\times (n \\choose i) p\_u^{i} p\_d^{n-i}$$

You are creating discrete paths for your process, which matches, in the limit, as n approaches infinity, the path of the general process.

That’s the combinatorics formula.

This formula doesn’t work if you price American options because they’re path-dependent. So I don’t know if I will end up with that final payoff, we have to calculate every step of the way.

## Greeks

### δ

$$δ \= \\frac{\\partial C}{\\partial S}$$

The partial derivative of the call option with respect to the stock price, its sensitivity.

You’re supposed to calculate the change in the option price when the current price changes.

What most of the interviews will say, is to do the tree.

[Embedded diagram omitted from the text export.]

You would take the distance, the difference in actual values. When you step back in the tree, you get the call value, and you will actually calculate all these values. You can then approximate this Delta as

$$\\frac{c(S\_0 u) \- c(S\_0 d)}{S\_0 u \- S\_0 d}$$

This is not a very good approximation because you’re not calculating the delta now, you’re calculating it in the future.

In the interview, you will construct the three step tree, and you’ll have the number and differences, and very easy to calculate.

This is not correct though. It’s supposed to be some value with very little difference in the stock.

So you should calculate 2 trees\!

One starts that from S\_0, and one that starts from S\_0 \+ ΔS, and S\_0 \+ ΔS. This will allow you to calculate the first and second derivative. You need the third point for the gamma (second derivative).

Understand the idea\! Don’t just apply what you read. Why am I doing it this way? There is no mystery to this, like math, it has to be logical. If it’s not logical, then it’s wrong.

This is a method that is very useful if you write it on a piece of paper. If you have a computer with you, a call using a tree takes a fraction of a second. So why wouldn’t I do two in a fraction of a second? It’s pretty easy to do the actual calculation, but this was not possible many years ago.

All the other derivatives are the same idea. All you do is vary the underlying derivative slightly, and hold everything constant.

Some are them are irrelevant, but you can\!

That’s the one thing to mention from last class.

## Trinomial Tree

It’s just the same thing as the binomial tree. There is literally no difference.

First of all, I want you to remember how we did the binomial tree.

$$\\mathbb{E}\[\\Delta R^{\\text{disc}}\] \= \\mathbb{E}\[\\Delta R^{\\text{cont}}\]$$

And same thing for variance.

And we did some other stuff to make sure that the probability distribution is correct. So we will use the same exact idea. Remember that from the continuous process dR\_t is the logarithm of the stock price.

$$dR\_t \= (r \- \\frac{\\sigma^2}{2}) dt \+ \\sigma dW\_t$$

$$\\mathbb{E}\[\\Delta R\_t\] \= (r \- \\frac{\\sigma^2}{2}) \\Delta t$$

$$\\mathbb{V}\[\\Delta R\_t\] \= \\sigma^2 \\Delta t$$

$$\\mathbb{E}\[\\Delta R\_t^2\] \= \\sigma^2 \\Delta t \+ (r \- \\frac{\\sigma^2}{2})^2 \\Delta t^2$$

How do we do this?

Two conditions:

- Has to converge
- Has to be recombining

Same number of nodes, two above, and two below. 2n \+ 1 is still a linear increase.

[Embedded diagram omitted from the text export.]

That would be convenient.

If I did like this

[Embedded diagram omitted from the text export.]

It would be O(n^2), really bad.

For the recombining one, it would be

It turns out the condition you need to have is

$$\\Delta R\_u \+ \\Delta R\_d \= 2\\Delta R\_m$$

You can solve the whole thing with this.
The problem is that you’re going to get a huge system. Six unknowns, and three equations. No matter what, we have three equations. One with the expectation, one with the variance, and probabilities must equal to 1\.

The six unknowns is the three ps and three Rs.

This will have a huge number of solutions that will give us a trinomial tree. We won’t do that.

We’re going to say that this is too complicate,d so we will make on etree.

We will take ΔR\_u \= ΔR, ΔR\_d \= \-ΔR, ΔR\_m \= 0\.

[Embedded diagram omitted from the text export.]

Now we have four unknowns, and three equations, so still undetermined. But what’s going to happen is we will write the equations.

### Calhoun Sidebar

some ex-students want to form a business, get help from students.

$$\\Delta R p\_u \- \\Delta R p\_d \= (r \- \\frac{\\sigma^2}{2}) \\Delta t$$

And same thing for

$$\\Delta R^2 p\_u \+ \\Delta R^2 p\_d \= \\sigma^2 \\Delta t \+ (r \- \\frac{\\sigma^2}{2})^2 \\Delta t^2$$

(here is supposed to be \-ΔR, but squared is he same thing)

$$p\_u \+ p\_m \+ p\_d \= 1$$

I have a choice of how large my tree should step. Technically, you can solve for everything(not really)

If you look at the probabilities, you can calculate expected value in terms of the parameters. Once you have the formula,

$$p\_u \= \\frac{1}{2} (\\frac{\\sigma^2\\Delta t^2 \+ (r \- \\tfrac{\\sigma^2}{2})^2 \\Delta t}{\\Delta R^2} \+ \\frac{(r \- \\tfrac{\\sigma^2}{2}) \\Delta t}{\\Delta R})$$

This probability has to be a number between 0 and 1\. And you can guarantee this with a certain condition. In order for this to be true, we need a sufficient condition that

$$\\Delta R \\geq \\sigma \\sqrt{3\\Delta t}$$

This is not easy to get, and it is sufficient, not necessary, so you can get tighter guarantees.

It’s important to understand what’s happening here fundamentally.

[Embedded diagram omitted from the text export.]

The more steps I add, that’s what Δt is. But I can’t make the increments too small, it must have some kind of spread. When you’re guaranteeing a minimum of spread, it captures the distribution, without that you don’t get the distribution. This formula is calculated numerically, but this is the intuition.

## Order of Convergence

Order of convergence of the trinomial tree is O(ΔR^2 \+ Δt). What does that mean? As Δt goes to 0, ΔR also has to go to 0 at the same rate. If I take Δt as 0.01, then I need ΔR to be greater than 0.1 based on that formula above. If I have ΔR \= 0.5, to square it 0.25, it will get too close. So I actually have to take them in the same convergence. And the best ΔR uses this formula, so it’s just EQUAL to that square root. This makes sure that the tree has the fastest convergence.

Now the tree is unique, you calculate ΔR, you get the probabilities, and it’s a unique tree that satisfies these assumptions. Professor, you didn’t explain to us what big O is.

This means that the call option value from the tree, minus the true value (unknown), the absolute value of that should be approximately C(ΔR^2 \+ Δt), where C is a constant.

The constant screws me up, nobody knows what it is. Even if you make your tree within one cents, if there’s a large constant it’s worthless. You can’t get exact numbers.

This is for the trinomial tree. If we do this same thing for binomial, then

|Option(binomial) \- True Value| ≅ O(ΔR^2 \+ Δt)

So you wonder, why should I use a trinomial tree, which is simpler, gives me the same order of convergence? The answer is that there is no reason, other than path-dependent options.

If you are path dependent, then it’s sometimes better, because you get 3^n instead of 2^n, more paths to evaluate.

### Exercise

How many total nodes are in a trinomial tree with n steps?

## Dividends

Most stocks give you discrete dividends. This quarter gave us profit, that we will distribute to our shareholders. We get 20 cents from a $300 share of stock. Typically what happens is that it’s discrete cash, it gets automatically in your account, of this particular date of this particular year, every shareholder.

Mathematically, it’s very difficult. We will explain how to deal with cash dividends.

The simplest dividend is continuously paid dividends.

### SPY Sidebar

(SPY is an ETF, which is done on multiple stocks, which each pay dividends. There are two ETFs, State Street and Vanguard, both of which track the same index. Because they own the stock, they will receive dividends. If they kept the dividends, they would have to pay taxes, which is very complicated. So what they do is distribute the dividends to the ETF shareholders. They calculate. Remember, the weights depend. The way ETF works, is that I own a basket of stocks. The basket is based on (there’s different types, but) in this case it’s *market cap*. You look to the top 500 assets which are in S\&P 500\. Then you look at the largest, say AAPL. The largest component accounts for say 2% of the entirety of my stocks. Market capitalization value for AAPL is $2.5B. The total value of my assets is $50B. If you divide, it gives you 2%. That is my proportion of shares that I will hold in my basket. The reason why they do this is because it’s very easy to calculate the return of the ETF by summing the returns of the components. Now what happens is, obviously the cap value of the company changes, every day, from $200 to $201. If you keep everything the same, the market capitalization value for AAPL grew. Proportionally then, the S\&P 500 portfolio should hold more of AAPL. Obviously that’s not possible (maybe possible with new methodology), but not possible with old. Every day you have to change shares in the big basket. They do this in the middle of the quarter. When the imbecile decided to buy Twitter and call it X. THAT DUDE IS FROM SOUTH AFRICA, A WHITE DUDE FROM SOUTH AFRICA, WHAT CAN HE BE? THAT’S KIND OF RIDICULOUS, RIGHT? When that guy bought Twitter, he bought every share available in the market. The company is automatically withdrawn, it’s a private company one. It was listed on the S\&P 500 and put another company, and then recalculate all of the shares. The whole thing is really simple. Every instrument on the equity market is trivial, they make it sound complicated. What’s a “basis point”? It’s a goddamn percentage.)

They take all the dividends, and scale them in such a way that it’s distributed to the owners of the SPY. It’s distributed when they do the rebalancing. When you open an account with any company (Fidelity, Ameritrade, eTrade) you give them your money, but they don’t put your money in your account. THey put it in some fund, which is their own managed fund. And actually, if you open an account, Fidelity ETF that they keep your money in, returns more money than your bank account. So you should buy Fidelity ETF instead of a bank account. Only difference is that if Fidelity goes under, you’re out of luck. Bank accounts get $250K FDIC coverage.

### Continuing…

The value of the stock depreciates.

$$
dS\_t \= (r \- \\delta)S\_t dt \+ \\sigma S\_t dW\_t
$$

The only difference between this and normal is that we have δ which is a known quantity.

We do the same basic constructions with r replaced by r \- δ. This is not a big deal. Your function will take an input r, just replace that with r \- δ.

### Known proportional dividend

Let’s say $$\\hat{\\delta}$$ is a proportion.

### Elon Rant

Let’s say TSLA, because the owner is an imbecile. I never liked this guy. I played games since I got my first computer when I was 12\. They made me think. One of my favorite games is called Path of Exile, which I played since it started 15 years ago. This idiot put out a video where he claims that he’s rank \#5 in the hardcore version of the game. You don’t understand, I played this game for three years before I understood what was going on. It’s really complicated, it’s 10 years old and every 3 months the devs add something new. There’s so much stuff you can do, in ten different ways. Not only that, but you have to literally play it nonstop to be in the top rank. The company is called Grinding Gear game, they created this game after Diablo. Blizzard, the company that issued it, refused to support it, so these three people in NZ made a Diablo-like game. This imbecile puts out a video showing how he managed to be \#5 on the hardcore ladder. Now hardcore means that if you die in the game one time, your character gets deleted. It’s horrible, basically, because if you make one mistake you die, and I’m going to break my computer. This guy basically opens the game and has a tab that says Elon’s Maps. This \*\*\*\* person has obviously paid another dude to play for him, from India or Romania or whatever, and that guy slaved for this guy, for money, clearly, for three weeks nonstop to become the top. And this guy just claims to be that. Why? What’s the point? And obviously people like me who have played for the longest time know that he has no idea what he’s doing. It’s pretty obvious, so what’s the point of doing this. You want to pretend you’re the smartest. I also like chess, I’ve been playing it for a long time. This dude said he was top two in his chess club. He always says top two, because if he said top, someone would say I remember the top.

### Continuing

The company value is the total sum of the assets. When you are becoming a public company, you are selling the shares, and if you add the shares together, that’s the total number of assets. (You may also have debt, a liability), but otherwise that’s the value of your company. When you pay someone money (dividends), the value of your company decreases

This dividend is paid at time τ. The value immediately becomes $$S\_\\tau \- \\hat{\\delta}S\_\\tau$$

Now what happens here, and why it’s a special case, is because this is

$$S\_\\tau (1 \- \\hat{\\delta})$$

And if you remember the multiplicative tree, it goes from

[Embedded diagram omitted from the text export.]

So you can just price this directly.

Then you look at the dividend payment at time τ between 0 and T, and construct the tree. Then you drop at time τ by this value, S to $$S(1-\\hat{\\delta})$$, and then keep computing the tree.

Now you have a tree that’s kind of broken, like someone hit it with a bat.

[Embedded diagram omitted from the text export.]

What about American options? In order to do this, you do the same thing as for the other tree, but you look what’s the value coming from the tree after τ, and compare it with before τ. If you have an option, you are not paid the dividend. There are going to be a bunch of places where you have to exercise. What’s happening here? I forgot to mention this, and this is a mistake in the book, too. Look at the value

$$(p\_u C\_u \+ p\_d C\_d) e^{-r\\Delta t}$$

When you look back at the [Combinatorial Formula](#combinatorial-formula), you need to multiply by the discount factor.

But when you exercise, this is the expected value of the option in the future. When you compare here, you’re going to take the maximum of this value, and as if you had exercised right before τ, which is

$$(S\_\\tau \- K)\_+$$

If the dividend is sufficiently large, the optimal time to exercise is right before the dividend payment. Except that, this is a fake example, there isn’t such a thing.

### Discretely paid cash dividends

The most complicated, the most common case.

We’ll say D is a quantity of cash that is constant regardless of the price of the stock. We’ll assume it’s known. You can’t do anything if the dividend is not known.

If you use the same idea, and you look at some time t\_i, and t\_{i+1}, and τ is in between. The problem with this is that I have an S\_u and an S\_d. Let’s say I pay the dividend. The value of the stock in between these two is going to drop by D units. If we do like we did before, and drop S\_u by D and S\_d by D, and look at the next node, we have the lost the recombination property.

[Embedded diagram omitted from the text export.]

We have this tree that recombines all nice until time τ, then it becomes unmanageable. That’s the problem here. How do we fix this? The trick is kinda interesting. It’s a pretty complicated construction which is in the book. The idea is that we’re going to create a new tree. This new tree will follow

$$\\tilde{S\_t} \= \\begin{cases} S\_t & t \> \\tau \\\\ S\_t \- De^{r(\\tau \- t)} & t \\leq \\tau \\end{cases}$$

Normally, you drop every time τ by the dividend. Now I drop every node below before the dividend, discounted by the time back. What’s happening here is you make all these trees before τ, nonre-combining. Then starting from that point, every point is recombining. This is better because it’s easier to handle exponential Big O at the beginning, where the numbers are smaller. The second thing that’s really smart about this is that if you have observed real markets, this is how real markets operate. Let’s say I own AAPL stock, and AAPl says that stock is $100 today, and then they say due to our quarterly earnings we will have 10¢ dividend per share on March 15, then the price will go down by exactly that amount. This is the present value of the dividend. But in the real world, there is no real price, there is a bid and ask spread. If you’re participating in HFT, every single winning team was running a market making strategy, from providing liquidity to the market.

If you’re doing a long-dated option with dividends, you can actually treat it as continuously paying.

Everything that we learn in class is not IRL.

## Tree for Deterministic Time Varying Volatility

The stock price doesn’t follow geometric Brownian motion as Black-Scholes assumes. This is well-known.

We take R\_t, under the observed price.

$$
dR\_t \= \\mu \- \\frac{\\sigma^2}{2}) dt \+ \\sigma dW\_t$$

We can take some daily time intervals, t\_1, t\_2, … t\_n.

Then we take

$$\\log S\_t \- \\log S\_{t-\\Delta t}$$

Which is the literal continuously compounded return, which should be equal to this quantity in the formula.

That quantity is very simple, because the stochastic part is normal, then you add a constant.

Then your returns, say

$$r\_i \= \\log S\_i / s\_{i-1}$$

r\_i… r\_n

These should be normal, you can test with a QQ plot. But it’s not normal, it is leptokurtic, it has fat tails.

You can try a different variability. The simplest thing to do is σ√t. You will look at two different data points. It will still be normal, but we will make the variance

$$\\sigma^2(t \+ \\Delta t) \- \\sigma^2(t)$$

What’s happening here is that some of the observations are coming from one variability, and others are coming from another. If this is possible, then it’s possible to be leptokurtic, combining N(0, 1\) and N(0, 2). That is one way in which you can make this leptokurtic distribution appear.

Having said that, the thing about this is the resulting process is not truly random. What happens is, and there’s a formula of this, if you price something from 0 to T, and you have the σ which is a function of time, it is exactly the same as if you are pricing under GBM with a variability equal to the average (integral) of the function, this proof is in Shreve.

## My Research

**Quadrinomial tree**. Tree with four nodes.

Somehow, somebody has estimated σ(t) and r(t), risk-free interest rate changes in time, and standard deviations changes in time. Take Δt \= T/n. At times iΔt, we take the volatility values

$$\\sigma\_i \= σ(iΔt)$$

and

$$r\_i \= r(iΔt)$$

and we will also define

$$\\mu\_i \= r\_i \- \\frac{\\sigma\_i^2}{2}$$

We take fixed ΔX\_u and ΔX\_d. We will do an additive tree. They are fixed for every t so that the tree is recombining. When I solve my tree, initially, for binomial and trinomial, on the right hand side, we calculate the value coming from the continuous process, which was the r \- sigma squared thing, same for every Δt. Now it’s different because the r and σ are changing, and at that particular time I have to match a different value.

So now the intervals have to be changing, because I don’t want my X to change.

[Embedded diagram omitted from the text export.]

You can see that the probabilities are different. And actually at each step we will assume that the probabilities are the same within the stpe. If you don’t ,then that’s stochastic volatility. For convenience, we will define

$$p\_u^i \= p^i, p\_d^i \= 1 \- p^i$$

I also don’t want to deal with ΔX like this, so it will be the same ΔX and \-Δx.

So now we have our equations

$$
p\_i \\Delta x \- (1 \- p\_i) \\Delta X
$$

On the right hand side, it’s supposed to be the integral of an interval, and technically you can pick any point, but the left point will give us the stochastic process.

$$p\_i \\Delta X \- (1 \- p\_i) \\Delta X \= μ\_i \\Delta t$$

$$p\_i \\Delta X^2 \+ (1 \- p\_i) \\Delta X^2 \= \\sigma\_i^2 \\Delta t \+ \\mu^2\_i \\Delta t^2$$

The system has a ton of unknowns, because it’s for every i. So there are actually 2n such unknowns.

How do we solve it? I’m going to do a thing. We’re going to express

$$p\_i \= \\frac{1}{2} \+ \\frac{\\mu\_i \\Delta t}{2 \\Delta X}$$

You can extract the ΔX directly to get

$$\\Delta X^2 \= \\sigma\_i^2 \\Delta t \+ \\mu\_i^2 \\Delta t^2$$

We have a problem. You can see here that the μ here changes at every i, but ΔX can’t change. What you do, is you change this, this model doesn’t work.

The next step is to make every step change, and then take an average to get ΔX

$$\\Delta t\_i$$

Then $$\\bar{\\Delta t} \= T/n$$

and

$$\\Delta X \= \\sqrt{\\bar{\\sigma^2} \\bar{\\Delta t} \+ \\bar{mu^2} \\bar{\\Delta t}^2}$$

The point of these bars is the average.

$$\\bar{\\sigma^2} \= \\frac{1}{n} \\sum\_{i=1}^n \\sigma\_i^2$$

etc.

You take these averages and put them here. The constructions can get complicated. But if you take the binomial tree with these values, you get a pretty good approximation for the moving volatility and the moving interest rate.

It’s given to you that σ(t) \= 0.4t \+ sin(t \- π), or whatever. It’s deterministic.

## The most complicated part

The problem is that none of these trees solve the Heston model (e.g.)

Heston:

$$\\frac{dS\_t}{S\_t} \= r dt \+ \\sqrt{y\_t} dW\_t$$

where

$$dy\_t \= \\alpha(\\bar{y}- y\_t) dt \+ \\sigma \\sqrt{y\_t} dZ\_t$$

First of all, the construction I have applies to these types of stochastic processes. There are two conditions in the original paper. It can be any general function, for this construction to work, by the way.

The stock price must look like this, where it’s dS\_t/S\_t, so when you apply logarithm it becomes explicit, just y\_t.

The Brownian motions must also be independent. I had one student that worked on this, and I’m pretty sure it’s solvable, but he quit to go work at Millennium.

The question is, how do you construct a tree for this process?

It’s similar. The tree has to be recombining, and match the stochastic process. How it goes, the spread… Remember the condition Δt \> 3σ√t. It’s commensurate with σ. The spread is captured by √y\_t. The problem is the variability, like we saw in the deterministic case, it changes. But unlike the deterministic case where we know, there’s 52 weeks in a year, we can plug 1/52 into this bar bar expression. But the problem is that Z\_t is random, so we can’t get the complete thing. We can only get the distribution, and we can’t do the tree because we can’t match it.

So the idea that I had, was the following. I’m going to forget about dY\_t, and work with the distribution of y\_t, and at any moment in time t. I’m going to work at the distribution now. I can observe price, but I can’t observe volatility. Implied vol is a surface. You can get these values which will give you some stupid wrong distribution, but you can think of those values as being a histogram. Then I can simplify it and say it takes values y\_1, y\_2, and y\_3.

[Embedded diagram omitted from the text export.]

The idea is to have a two-dimensional tree, which R on one axis and y on another.

From tis one point, I can form multiple different trees. Each point is a σ. The R is a vertex, and I’m moving to four different points. I could move to a different four points for each σ. For each one of these sets of four points, I can move to a different four on a different plane. It’s kind of like a huge pyramid. There’s a two dimensional pyramid, where you have values with a lot of facets.

Obviously this is impossible to calculate because it’s non-recombining.

Instead I will take a slice of σ values and do a Monte Carlo, some σ\_1 at t\_1, σ\_2 at t\_2 kinda thing. At each sample, I take a different tree. It’s kinda like a combination of Monte Carlo and binomial tree. I spent a year figuring out that binomial tree works, then sent it to a university and realized that there was a mistake and got 0 \= 0\. Then in 2015, they put it online. The first paper I published is wrong.

This is very efficient for pricing.

Section 6.11 in the book if you’re interested.
