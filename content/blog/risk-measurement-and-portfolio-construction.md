+++
title = 'Risk Measurement and Portfolio Construction'
date = 2024-09-05
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Portfolio Construction', 'Market Risk']
+++

## Week 1

### Reading - Risk Management

Financial risk management involves identifying, assessing, measuring, and managing financial risks. Some risks are measurable, others are not. Risk cannot always be avoided, but it can be mitigated. In order to leverage risk, you must measure it. The first centralized risk management tool was **value at risk** (VAR), developed in the 1990s. These tools measure risk in the portfolio context, as well as measuring on a forward-looking basis.

#### Risk Measurement

##### Example

The issue for a portfolio is whether expected profit warrants the assumed risk. The first step is to understand the profit and losses in the portfolio. \(\Delta P\) is the PnL variable, measured in a **risk currency**, like the dollar. This is the product of the initial investment \(P\) and future rate of return \(R_P\). Rate of return is a random variable described by a **probability density function**, which is a distribution. For example, the return on the S\&P 500 follows a normal distribution, though with slightly worse risk. There is a 3% **cumulative probability** of losing 10% or more in a month. In order to reduce risk, money can be allocated to cash to benefit from the riskless interest rate for a reduced return.

##### Absolute vs. Relative Risk

Risk can be measured relative to a **benchmark**, such as the S\&P 500 index, or an investor’s present value of liabilities compared to future value. This can also be adjusted for inflation.

**Absolute risk** is a shortfall relative to the value of the investment, expressed in terms of standard deviation:
\(\sigma(\Delta P) = \sigma(\Delta P / p) \times P = \sigma(R_P) \times P\)

**Relative risk** is relative to a benchmark index \(B\). In this case, risk is measured via deviation in the **tracking error** \(e = R_P - R_B\) scaled to the principal:

\(\sigma(e)P = [\sigma(R_P - R_B)] \times P = \omega \times P\)

where \(\omega\) is **tracking error volatility** (TEV), literally just the standard deviation in the difference between the returns in the investment and returns in the benchmark.

#### Evaluation of Risk Measurement

There are two parts to measuring risk. The easy part is that the scale of dollar returns should be proportional to the initial investment, which is just a simple scaling based on the value of \(\Delta P\). Constructing the distribution of future rates of returns is difficult. We might have strong historical data like the S\&P 500, but historical data doesn’t always work. Gold was stable until 1967 and then fluctuated wildly in price afterwards. Loss doesn’t mean risk management failed, so you have to measure it in other ways.

##### Known Knowns

These are risks that are identified and measured. They are unlikely to cause losses. A portfolio with VAR at 99% confidence of 14.4% would be highly unlikely to have consecutive losses of 15% or more and indicative of a flawed model.

##### Known Unknowns

These are model weaknesses that are known but not measured, inaccurate measurements of risk factors like volatilities, and mapping errors from positions to exposures. This is called **model risk**, which can be evaluated with stress tests that shock variables beyond typical ranges. For example, in 2007, banks over relied on historical data and credit rating and accrued too much exposure on risky assets.

**Liquidity risk** describes the ability to liquidate a position, which is based on the inherent liquidity of the asset as well as the size of the position. Some assets are very illiquid, like real estate, and if they are too large they cannot be cashed out quickly without disrupting the market.

##### Unknown Unknowns

These are out of scope events that cannot be considered typically, like regulatory risks, counterparty risks, and some amount of liquidity risk. This is also known as **Knightian uncertainty**, which is immeasurable risk, with only the government being the end risk manager.

##### Risk Management Failures

A risk manager should identify risks, assess and monitor them, manage them, and communicate them. A failure in risk management is a failure in at least one of these.

#### Portfolio Construction

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

If you diversify across a large number of stocks like the S\&P 500, it seems more difficult. Markowitz simplifies the problem. He assumes that assets follow a jointly normal distribution i.e. normal distribution extended to higher dimensions, which means that the distribution of portfolio returns can be summarized by mean and variance. You need to identify an **efficient set**, which is a locus of points that represent portfolio mixes with the best risk-return characteristics. For an expected return \(\mu_p\), the risk should be minimized: \(Min_w\sigma^2_p\) where the portfolio return is equal to a specified value \(k\), with a different efficient set for each value. A closed-form solution exists for every efficient set *if* there are no short-sale restrictions on portfolio weights **Open question:** what does this mean?, which is the linear combination between the global **minimum-variance portfolio** with the lowest volatility and the portfolio with the highest Sharpe ratio. This can be used for value at risk as well as regular variance, which is valuable for fat-tailed distributions **Open question:** why?. But in the general case, no closed-form solution exists.

#### Asset Pricing Theories

##### Capital Asset Pricing Model (CAPM)

The **capital asset pricing model** (CAPM) was developed by William Sharpe in 1964. The covariance structure of stocks is simplified with a one-factor model. Run a regression with the following returns at time \(t\): stock \(i\) - \(R_{i,t}\), risk-free - \(R_{F,t}\), market - \(R_{M,t}\)

\(R_{i,t} - R_{F,t} = \alpha_i + \beta_i [R_{M,t} - R{F,t}] + \epsilon{i,t}\)

### Lecture Notes

#### Risk Management

risk: the possibility that something bad might happen

everybody deals with risk, we are dealing with it in a financial context

making a decision to buy headphones, you risk it breaking and you’re out $150, so you might buy something cheaper if you think you’re likely to lose it, keep backup headphones



in the case of bond price, you have a financial instrument subject to interest rates,

they’re about to cut interest rates

let’s say we have interest rate risk

we graph interest rate y against P

graph of yield of bonds at [quantstats.shinyapps.io/FRED/](http://quantstats.shinyapps.io/FRED/)

the interest rate has moved significantly, was raised to about 5% in 2022-2023

trying to price a bond over ten years, the interest rate changes significantly, presents risk



four steps:

identify

analyze

assess impact

manage



when identifying risks,

you could find correlations, maybe spurious correlations



pricing assesses the impact of risk



transferring risk: insurance, like credit default swaps



typology of risks:

cyber risk - hacking and stuff

#### Market Risk

interest rates are a sort of market risk. the price for the bonds is exposed for something systematic.

i have this inventory of assets. a market is a representation of the whole economy, this is what we think of the market right now, and there’s a value for that.

NVidia is a big company, part of the market. all these asset managers hold trillions in assets and diversify across different products. if i want to buy the market, it’s a combination of assets including NVidia. I think the economy will do well so I will buy the market and it will go up. If I buy an ETF exchange traded fund, I’m buying everything, including NVidia.

But the market is going down because the economy is not doing well, so even though NVidia has launched a new product, they will go down as well. Stock prices go up and down because of information. For example, this Tuesday there was a poor economic outlook so people began to sell shares, driving down market

\(r_i = \alpha + \beta r_m + \epsilon_i\)

The return of the stock is influenced by two noises. the \(\beta\) is the **systematic general market risk**. Ignoring \(\alpha\), we have \(\epsilon_i\), which is the **idiosyncratic specific market risk** for the specific asset, like how Elon Musk is unpredictable, will tweet and might make the stock go down

In order to reduce the impact of \(\epsilon_i\), you diversify your portfolio to add justin whang and others to mitigate the risk of any individual stock. you hold a cross section of stocks, and you analyze them under different characteristics and groups and get their risk factors so you can combine them to mitigate risk

people have views of where the market is going, and that’s where the market price comes from.

#### Credit Risk

A credit score is a way to monitor creditworthiness. The lender lends $100 to the borrower at 20% interest. The risk is that the borrower will not pay back the loan. That risk is priced into the interest rate.

Interest rate also comes from inflation, as money becomes less valuable over time. The possibility of default is the same thing. As an individual I can get loans based on my credit score, but if it gets lowered I will be downgraded which will decrease my ability to obtain credit, decreasing my value. Same happens to companies

COVID kills all these companies, but the Fed bail out junk bonds and created positive sentiment to increase prices

#### Liquidity Risk

What moves prices is supply and demand. If there’s too much supply, I can buy a small amount as an individual and nothing happens, but if a big institution buys a lot it will have an impact.

If you’re  a small player, liquidity doesn’t matter. but if you're a bank trying to unleash millions of shares it becomes a liquidity issue.

The fed fund rate is overnight borrowing between banks, and is a good measure of liquidity. This is the cost just to borrow and lend. When Lehman Brothers went down, there was a big spike in the interest rate. **Open question:** read Afonoso 2011 stressed not frozen which goes over this. liquidity was still provided but the cost increased

#### Operational Risk

The risk of loss resulting from inadequate or failed internal processes, people, and systems or from external events

Every business has an input and an output. Databricks??? LOL

Bourbon is made of barley/corn input, bourbon comes out as output.

external events could be a shock, maybe machines are too old, not enough R\&D

one of the big meat farmers got hacked, cyber risk led to operations risk

LTCM long term capital management was a highly leveraged company that had a lot of model risk

ML is LSTM, predict categorizations based on operational risk data, come with sensitivity analysis

corporate governance scandals with enron

How much do you trust the model? that’s operational risk

#### Other Risks

Business risks, consumer demand, pricing decisions, managing product innovation, just making bad decisions as a CEO

Strategic risks involves making large decisions about the firms direction long-term, major investments of capital, HR, management reputation

Reputation risk is danger firm will suffer a sudden fall in market standing, volkswagen with emissions, boeing with broken-down planes

#### Process

The reason to take risks is to pursue a reward, food, shelter, or bitcoin.

Two questions: Is the risk commensurate with the reward? And could we lower the risk for the same reward?

#### Modern Portfolio Theory

People used to only think about the return, now people think about reward in terms of risk-taking. The guy was Markowitz who came up with the Mean-Variance model, shared the Nobel prize with Sharpe for CAPM and also shared it with Merton Miller (who is this?)

Risks that are measured are easier to manage

you try to do the best you can given the circumstances



Let’s say we have ten assets to construct a portfolio. Measuring risk, evaluating the potential gains and losses. You could completely diversify equally by doing a naive classification, and it’s actually quite difficult to beat on average



consider the annual mean return of various ETFs. you might choose XLK because it has the highest mean return, but you don’t know anything about the risk. XLK is technology, which did well between 2018-2022 because of cutting interest rates but is not doing well now



There is a certain volatility, fluctuation, anxiety associated with holding shares, even if on average you are outperforming the market. We are all risk averse, it’s all about tolerance.

Capturing the risk dimension in terms of volatility on x axis and returns on y axis. We make these heuristics to determine the efficiency of the asset.

This is data from rational risk reward tradeoff



Motivate the idea of choosing between stocks

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
