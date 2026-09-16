+++
title = "Neural Networks Aren't Impressive on Their Own"
date = 2025-06-07
published_at = "2025-06-07T19:26:59.305Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7337198409189150720/"
activity_urn = "urn:li:activity:7337198409189150720"
source_post_number = 20
tags = ["AI","Machine Learning"]
+++

Neural networks AREN'T impressive...

in the context of data analysis, by themselves.

With the explosion in discourse about AI, traditional neural networks have also gained cultural prestige. LLMs do use neural networks as their underlying architecture, as do other forms of machine learning.

At first blush, neural networks can accomplish some pretty cool results. For any input and output, neural networks can create a mapping that works effectively.

The obvious problem is that without mitigation, neural networks will massively overfit the training data, and therefore be useless when applied to new data.

But even when neural networks successfully fit test data, they are limited in what they can do.

Sure, if your only goal is to predict outputs from an input, neural networks can do that for you.

But neural networks (and nonparametric models in general) don't give a lot of general insights into relationships in your data. If you tried to approximate the relationship with a polynomial, you would get an ugly, long expression where the numbers don't mean anything.

Compare to linear regression. You get a simple number of parameters on the same order of your features, and each number directly expresses the relationship of the feature with the label.

Obviously, linear regression isn't feasible for expressing nonlinear relationships, which are common in data. And there's no parametric model that fits all types of data.

That's kind of the point, though. By finding a model that fits your data, you're inherently saying something about the structure of the relationships in your data, which is often useful information.

Neural networks are the lowest common denominator. You can put something in, and get something out, but for the real questions about your data, there's only a black box. They can be useful as a starting point. But they can't be the end of your data analysis.

What do you think? Are neural networks useful in data analysis?
