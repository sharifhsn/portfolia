+++
title = "The Big Short and the Boring Cause of the 2008 Crisis"
date = 2025-04-12
published_at = "2025-04-12T18:25:14.194Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7316889148353630210/"
activity_urn = "urn:li:activity:7316889148353630210"
source_post_number = 31
tags = ["Financial Markets","Housing"]
+++

I rewatched The Big Short last night, and realized that they sensationalized a pretty boring reason that the 2008 crisis happened.

When the housing bubble burst and the Great Recession occurred in 2008, everyone wanted to find the individuals to blame. The easiest targets were the Wall Street bankers who made the bad bet that people wouldn't default on their mortgages, even as riskier and riskier subprime loans were issued.

The Big Short is the most popular movie depicting these events. It focused on the maverick investors who realized that there was a bubble and bet against the housing markets. The villains of this movie are the bankers who created and sold the "CDO" or "collateralized debt obligation", which is what caused the housing crisis to become an economic disaster.

The movie explains the CDO like this: imagine a chef buys some fresh fish which doesn't sell. He can throw the unsold fish into a stew, which becomes a whole new thing and is now palatable.

In this case, the unsold fish are poorly rated BBB bonds, the stew is the CDO (a portfolio of bonds), and the new palatability is a AAA rating.

But why would ratings agencies rate a bunch of terrible bonds packaged together as AAA?

The movie frames this as a corrupt racket. The main characters ask their colleague at S&P why these securities are being rated AAA, and she admits that if they don't rate them AAA, then the banks will go down the block to Moody's and get a better rating there. They have essentially become a ratings shop.

The reality of the situation was that the ratings agencies were using a flawed model, the Gaussian copula. In essence, the model assumed that bond default probabilities were uncorrelated.

Any good portfolio manager knows that the key to risk management is diversification. By packaging together uncorrelated assets, you can reduce the risk of all of them going down at once. So in theory, if you have a lot of uncorrelated BBB bonds, the likelihood of many of them defaulting is fairly low.

You can see that in this graph. The probability of portfolio loss exceeding 10% is vanishingly small for a portfolio of uncorrelated bonds. As correlation increases, such a risk becomes more and more likely.

In this case, the likelihood of bond default wasn't uncorrelated. Unscrupulous mortgage brokers were issuing subprime loans en masse, making it likely that all of these people would default on their mortgages.

In the wake of the crisis, on top of stricter banking regulations by Dodd-Frank, ratings agencies have adopted more complex models that incorporate bond default correlation, meaning that they're unlikely to make the same mistakes.

The narrative of a ratings shop might play well to a lay audience, but it doesn't fit with reality.

Did you know about this flaw, or did you assume that The Big Short had it right? Let me know in the comments.
