+++
title = 'Risk-Adjusted Performance'
date = 2024-09-12
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'CAPM', 'Risk-Adjusted Performance']
+++

##### Comparing Multiple Assets

Let’s say we want to invest in long-term U.S. government bonds. The monthly average return of this is 0.47%, half of the equity market, and 2.3% standard deviation, less than half of the equity market. An investor must decide how much of each of these they want to invest in. Their ratio of volatility to return is similar, so it’s a tough decision. Similarly, a bank must decide how much leverage they can assume based on their assets divided by their equity, and how volatile they want their assets to be.

##### Risk-Adjusted Performance Measurement

The simplest metric for this is the **Sharpe ratio** (SR), the ratio of the average rate of return \(\mu(R_P)\) in excess of the risk-free rate \(R_F\) to the absolute risk:

\(SR = \frac{[\mu(R_P) - R_F]}{\sigma(R_P)}\)

The Sharpe ratio uses absolute terms, and it can use the VAR instead of return volatility in the denominator. Graphically, when comparing volatility and expected return, the Sharpe ratio is the slope of the line starting from cash (0 volatility, risk-free return) to the point of the instrument.

For relative risk, the **information ratio** (IR) is the ratio in excess of the benchmark:

\(IR = \frac{[\mu(R_P) - \mu(R_B)]}{\sigma(R_P - R_B)}\)

An illustrative example is that you could have a portfolio with \(R_f = 3%\), \(\mu(R_P) = -6%\), and \(\sigma(R_P) = 25%\), which is negative and terrible. But if the benchmark has a return of -10% and TEV of 8%, then the IR is \([(-6%) - (-10%)]/8% = 0.50\) which is positive and therefore good. So even though the absolute performance is bad, the relative performance is good.

You can calculate TEV from \(\sigma_P\) and \(\sigma_B\), in addition to correlation \(\rho\):

\(\omega^2 = \sigma^2_P - 2 \rho \sigma_P \sigma_B + \sigma^2_B\)

The IR is used to judge active management skills, with an IR of 0.50 being “good”.

One disadvantage is that TEV does not adjust for average returns (**Open question:** give a more illustrative example of this)

##### Mixing Assets

A portfolio can be divided between assets, giving weight to each asset, where the portfolio weights sum to 1:

\(\sum^N_{i=1} w_i = 1\)

Let’s try and shift a portfolio of all bonds to all weights. On the graph of volatility to return, this moves the point on a line. This is called an **asset allocation** problem. The shape of the line depends on the correlation coefficient \(\rho\), which measures how related the assets are and how much they move together. The line is curved, which means that diversifying your portfolio with riskier assets (equities) can give you the same volatility as the pure bond portfolio. Given \(\rho = 0.13\), a portfolio with 77% bonds and 23% stocks:

\(\sigma^2_P = 0.77^2 8.1^2 + 2 \times 0.77 \times 0.23(0.13 \times 8.1 \times 19.2) + 0.23^2 19.2^2 = 65.56\)

The volatility is the square root, which is 8.1%, which is the same volatility that bonds have, but a return of 6.9% compared to 5.6%

##### Efficient Portfolios

#### Risk-adjusted Performance

We refer to the **Sharpe ratio**

\(SR_i = \frac{\mu_i - R_F}{\sigma_i}\)

The interest rate is free money for 5%, so why should I bother taking any risk beyond the 5%?

intuitive weighting of portfolios:

\(w_i = \frac{SR_i}{\sum_{j=1}^N SR_j}\)

you can see data from the yahoo api for public traded apis from [quantstats.shinyapps.com/yahoo](http://quantstats.shinyapps.com/yahoo)

Annualize daily returns by multiplying by \(\sqrt{252}\), average number of trading days in a year. Why?

basic return formula:

\(r_i = \frac{P_1-P_0}{P_0} = \frac{\Delta P_0}{P_0},\qquad \log\text{-return} = \log\left(\frac{P_1}{P_0}\right)\)

If you annualize, it becomes

\(r_i = \frac{P_{252}-P_0}{P_0},\qquad \text{annual log-return} = \log\left(\frac{P_{252}}{P_0}\right)\)

You can show the return as

 \(\log{\frac{P_1}{P_0}} + \log{\frac{P_2}{P_1}} + \ldots + \log{\frac{P_{252}}{P_{251}}}\)

or

\(R_A = \sum_{d=1}^{252} R_d\)

summation of expectations is the expectation of the summation



mean is \(\mu_A = \mathbb{E}[R_A] = 252 \times \mu_d\)

deviation is \(\sigma_A^2 = V[R_A] = 252 \times \sigma_d^2\)

summation of variances is not variances of summations unless variables are iid

\(SR_A = \frac{\mu_A}{\sigma_A} = \frac{\mu_d \times 252}{\sigma_d \sqrt{252}} = SR_d \sqrt{252}\)

Portfolio construction next week

#### Risk-Adjusted Performance (cont.)

The annual return is \(R_A = \log{(\frac{P_{252}}{P_0})}\)

We argue that the expectation of \(R_A\) is simply the proof that it’s going to be \(\mathbb{E}[R_A] = 252 \mathbb{E}[R_d]\)

And that the variance does as well

\(\mathbb{V}[R_A] = 252 \mathbb{V}[R_d]\)

This one guy went to industry from academia. How come you moved? Can you give me a Sharpe ratio of 3. The market is about 0.5-0.6, 1 is good, 2 is great, 3 is exceptional.

#### How Bad Things Can Get?

That’s risk, in a nutshell.

You can imagine a stock going up in a straight line. You could also imagine the stock ending up higher, but bouncing around a lot. How do you express the volatility here? Let’s look at downside risk.

In a distribution, \(\sigma\) tells you how wide the distribution is.

#### Portfolio Construction

The professor constructed his portfolio for his pension looking for the highest return, and ended up on the upside because he had large market caps. He tells us to only invest in mutual funds, the risk premium is very worth it.

We can give better weights to stocks that have a higher Sharpe ratio.

We want a theoretically justified approach to setting our objective.

We want to maximize our return for a given level of risk, or minimize risk for a given return.

The **mean variance model** gives us the optimal portfolio. We have a vector of weights which is \(w\), with some rules that \(w'1 = 1\) and \(w'\mu = m\). The weights all sum to 1, and weights of the vector of mean returns should hit the mean target \(m\), minimizing risk relative to \(\Sigma\) the covariance matrix of asset returns

\(\min{\sigma_p^2}=w'\Sigma w\)

Let’s say I’m targeting 15% annual. When you have only two assets, this is easy because you only have two unknowns. It’s always solvable. But how do we solve this with more assets?

You end up with a curve that is perfectly solvable.

Let’s look at \(\Sigma\) more closely. This has the variance of all of the stocks on the diagonal, which measures the volatility of each asset. We are also concerned with diversifying our portfolio, so we also want to minimize covariance between assets. Each covariance \(\sigma_{ab} = \rho \sigma_a \sigma_b\).

If we’re available to capture \(\mu\) and \(\sigma\), we can get the reward and risk.

There is a slight inverse correlation between bond volume and stock volume because people will put their money in bonds when the market sucks.

The optimal solution is given by the closed form solution:

\(w = w_0 + \frac{1}{A}B\mu\)

This says that I have two funds, a low-risk fund \(w_0\) also known as the global minimum variance portfolio (GMV) and a sophisticated fund that goes long and short in those stocks \(B\mu\), also considered \(w_1\). We can use the IEF (treasury bonds) and SPY (S\&P) as these, respectively. It actually doesn’t minimize risk to put all of our money in IEF because there’s no diversification. To minimize co-risk, we should invest a little in SPY.

Let’s consider the parameter \(A\). What happens if \(A\) goes to \(\infty\)? High \(A\) values means we are very risk-averse and we invest a lot in the low-risk fund. The value of \(w_1\) can be considered how leveraged or risky we are, if it’s very high then that will be the case.

We can repeat this experiment with different values of \(A\), which will give us a different set of weights for the optimal portfolio construction. We can calculate the mean and variance of all these portfolios, and if we graph this we can see the **mean-variance efficient frontier** (MVEF). This set of optimal portfolios has the minimum variance and maximum return for a given level of acceptable risk.

Part of the lab is going through the Excel spreadsheet, you can also code, Majeed says do both.

You can also modify this for Value at Risk but you lose the tractable closed-form solution. There is also SIVAR which does not violate convexity (**Open question:** look this up).

You can also construct special portfolios like the GMV portfolio. Let’s assume that the covariances of the matrix are all 0. Then the inverse of the matrix is just the reciprocal of every variance.

The Sharpe ratio portfolio has weight proportional to SR, and it can be an efficient portfolio.

#### Capital Asset Pricing Model

There are three aspects to it. There’s \(\alpha\), which is the unique value of an asset. There’s \(\beta\), which is market risk. And there is \(\epsilon\), which represents residual errors.

\(R_i = \alpha + \beta R_m + \epsilon_i\)

The market is full of participants that are all making choices.

The CAPM is an equilibrium model between some assets and a limited supply. William Sharpe came up with it. There is a linear relationship of returns on stocks and exposure to market risk. Taking market risk should be compensated.

If I want to minimize risk, I’m going to choose the risk-free portfolio. Let’s say I have a risk-free asset. There’s technically no such thing, but short-term treasury bonds are the closest thing we can get. Long-term treasury bonds do not stay fixed, they change a lot actually. It is a theoretical fact that if you introduce the risk-free rate, the efficient frontier becomes a straight line instead of a curve.

\(w = \frac{1}{A} \Sigma^{-1} [\mu - R_F 1]\)

You can show analytically with a portfolio, the new frontier is

\(\mu_p = R_F + \sigma_P \theta\)

**Open question:** look into \(\theta\) for extra credit

This is called the Sharpe portfolio or the tangent portfolio because it’s tangent to the line of the Sharpe ratio. If we have the most efficient portfolio, the demand for the most risky assets will be determined by the efficient portfolio. All agents in the market have the same risk aversion and they will pick the same asset.

I had a friend tell me that he trades crypto and they do technical analysis, and it works because everyone else is using technical analysis.

This becomes the market portfolio because everyone’s using the same portfolio.

And in fact, this is how you derive the CAPM. \(A\) constitutes the market portfolio.

What is the covariance between this vector of returns and the market portfolio? \(Cov[R, R_M] = \Sigma w^*\)

The end result of CAPM states that the mean return on each risky asset is

\(\mu_i - R_F = \beta_i(\mu_p - R_F)\)

The risk premium \(\beta_i\) is how much you are exposed to the market, which increases compensation.

\(\beta_i = \frac{\sigma_{ip}}{\sigma_p^2}\)

Example: TSLA has a \(\beta\) of 2. This means that if the market swings, TSLA swings twice as much.

Leveraged ETFs (SPXL) gives you 3 times leverage on the market. Experimentally, it’s about 3.11

How realistic is this model? In equilibrium, this model should represent the relationship. Let’s collect data. If the data follows the line, then the theory is correct. The model exists to explain reality. It says that the relationship is linear, so in order for the theory to be correct, reality must also be linear. We can also think of this more strictly using regression modeling when we are benchmarking.

We can price the return on an asset by

\(R_{i,t} - R_F = \alpha_i + \beta_i(R_M,t - R_F) + \epsilon_{i,t}\)

which when you take the expectation on both sides gives the same formula as before, as \(\alpha\) and \(\epsilon\) disappear.

Let’s think about variance in price.

\(\mathbb{V}[R_i] = \beta^2 \mathbb{V}[R_M] + \mathbb{V}[\epsilon_i]\)

\(\sum_{i=1}^N \sigma_i^2 = \sum_{i=1}^N \beta_i^2 \sigma_M^2 +\sum_{i=1}^N  \sigma_{\epsilon,i}^2\)

Monthly volatility of SPY is 4%. TSLA has a lot of idiosyncratic risk at 20% (represented by \(\sigma_\epsilon\)).

Portfolio volatility (\(\sigma_p^2\)) is what we are concerned with.

\(\sigma_p^2 = \sigma^2_m \frac{1}{N} \overline{\beta_p} + \frac{1}{N} \sum_{i=1}^N \sigma_\epsilon^2\)

If our number of stocks goes to infinity, the epsilon shrinks to 0, and we get rid of idiosyncratic risk, which is part of the wisdom of diversification.

#### Relative Performance Measures

Sharpe ratio doesn’t necessarily take into account systematic risk factor, but you can replace volatility in the formula with \(\sigma_p\).

The Treynor ratio only considers systematic risk i.e. exposure to the market, because when you’re comparing two funds you don’t care about the actual market risk since it’s the same between them:
\(TR_i = \frac{\mu_i - R_F}{\beta_i}\)

SPXL is not actually efficient if you use systematic risk because of how exposed it is.

Jensen’s \(\alpha\) is what matters for hedge funds. **Open question:** acquired podcast on rentech, nvidia

RenTech makes 60% annual returns.

You have to take leverage in order to benefit from the market, but then you become exposed. If the market tanks, you’re not going to be happy.

Decomposing the return of the portfolio.

\(\alpha_p = \mu_p - \beta_p \mu_M\)

The Jensen’s alpha

Let’s consider excess returns \(\tilde{R} = R - R_f\). The ratio is

\(SR = \frac{\mathbb{E}[\tilde{R}]}{\sqrt{\mathbb{V}(\tilde{R})}}\)

Information Ratio replaces the risk-free rate with market rate (or some other benchmark). The error in this case is called the **tracking error**. We care about this because we don’t want to be behind the market where everything is priced.

When you’re working with volatility, if you pull a constant from inside to outside, you have to square it because volatility is expectation squared minus square of expectation

Benchmarking is important from a risk manager perspective.

we have confirmation bias for the results we like

Sharpe ratio of 2, but we don’t know where it comes from

#### Risk Measurement Evaluation

We have known knowns, which are known positions. Losses can still occur from bad luck and portfolio decisions. Value at Risk will tell us if our bad luck is too bad which indicates a flawed model.

Known unknowns could be ignoring important risk factors, or nonstationarity. When the market is bad, correlations increase because everyone starts selling.

We can simulate reality via **back-testing**. We have in-sample (IN) and out-of-sample (OUT) from our sample. We use the IN to get the weights of each portfolio using our mean-variance formulas, and then we test the model on the OUT sample.

What about **stress testing**? How much will your assets be able to sustain losses. Portfolio 2 has a big short position in the energy sector. If energy companies recover in the OUT period, the stressed asset return has an increase in variable \(U_t\) which increases volatility.



**Open question:** do we need higher-order co-moments? See the paper.
