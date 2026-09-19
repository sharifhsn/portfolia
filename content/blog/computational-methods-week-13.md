+++
title = "Neural Networks and Credit Ratings"
date = 2025-04-22
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Neural Networks","Backpropagation","Credit Ratings","Volatility Estimation"]
+++

## Artificial Neural Networks (ANN)

This is an idea that was created in the 50s, exploded in the 90s, where it was called neural networks. A lot of development on the brain happened, so ANN was a term to distinguish from the completely different human neural network. There were a lot of movies about AI, grants given, and they all failed. In 2000, every grant would be rejected because nobody believed it was intelligent.

The problem is this stuff is very prone to overfitting. It fits the data you have really well, but trying to predict something else will fail miserably. It cannot move outside that realm. In 2020, they used this to learn the vocabulary. It’s based on the same technology, they put several neural networks together and learned the English language. Turn sout that it works because you can overfit that no problem, because everything you can ask fits in the sample. That’s the principle of generative language. There are some morons like Sam Altman and Elon who don’t understand the technology and think it’s really intelligent.

You can only do well in your overfitted universe. You can’t do well outside of that. GPT-5 was supposed to do judgement and reasoning, but it can’t do this on the limits of technology, a retrieval augmented mechanism.

Today, we’re not talking about any of that. This course is about the bottom of it all, how exactly do you bild a neural network?

ANN is a very general framework, everything that has this kind of mechanics, with lots of designs. LSTM (long short term memory) is an example.

## Multilayer Perceptron

The simplest possible ANN is this, which is inspired by brain function.

Today we will describe just a single layer, but I’m going to explain how it works completely.

At the core, you have $$x \\in \\mathbb{R}^d$$. This is the number. You cannot do any of this with qualitative values. This is why LLMs are built on embeddings, which are numbers. And you also have $$y \\in \\mathbb{R}^k$$.

You observe x and y, and you want to know the connection. If I input x, how do I get y? The oldest problem: I have some function y \= f(x), and I want to know what it is.

This is the one variable description. With multiple variables, you start talking about regressions, ANOVA, etc. These are all functions that relate x to y. But all of these things in typical regression are linear, which means f is a linear function.

What does linear mean exactly?

$$f(x) \= ax$$

In terms of matrices, if $$x \\in \\mathbb{R}^d$$, then $$f(x) \= Ax$$

where A is a matrix $$A \\in M\_{k \\times d}$$ times the x vector $$d \\times 1$$.

The whole problem here is to find the A that will give me the output y.

This is distinct from an **affine** function. This linear function is constrained so that x \= 0 always gives me 0, (0, 0\) is valid.

In general, affine looks like

$$f(x) \= Ax \+ b$$

This b makes it affine. Instead of estimating A matrix and b vector, I estimate both. This is regression, nothing fancy here, I’m just making it look complicated, but it’s really nothing. There is a point in me doing this. These are the building blocks for the neural network.

The next question in the 50s was this. What is the idea? I am going to somehow measure the distance between my output y and the predicted thing $$\\hat{A}x \+ \\hat{b}$$. This is kind of like a difference for y\_observed \- Ax \+ b, where A and b are observed. I somehow want to minimize this distance. What does that mean? The simplest thing is Euclidean distance. These are all points in $$\\mathbb{R}^k$$, so you can take the sum of squares. You can also take absolute values, but it doesn’t work that well because it’s not differentiable. The minimization happens when you take the derivative equal to 0\. Once I have the minimization, I can obtain the value Ahat and bhat. In statistics we take least squares regression, that’s what this is.

Remember that Ax \+ b is f(x). I am literally taking the difference between y and f and finding out f. But what if the function f is nonlinear? Then I’m screwed. The least squares is very simple to derive because the other term will disappear when you take the derivative of a particular term.

The advantage in the 80s was to come up with this function.

## The Idea

Here are the things we have to work with:

$$x\_1^1 \\ldots x\_d^1, y\_1^1\\ldots y\_k^1$$

Typical the models we use are output one dimensional, but nothing prevents you from making it k-dimensional

And then all the way up to

$$x\_1^n \\ldots x\_d^n, y\_1^n \\ldots y\_k^n$$

I have n observations. I have 40 people in the class and I start measuring their x values, like height. Then I monitor something internal to predict, their cholesterol level.

There was a commercial which was the IBM intelligent machines. In Manhattan, for this coffee place, they discovered as they train people to order more puffs, then the IBM machine looked into the data, and they sold more puffs. I hated that commercial because it implied that the machine somehow went int o the data nad saw that connection. You are literally looking at all the k products. First of all, it has to be logical. Machines cannot discover connections. You the researcher will hypothesize the connection, and the machine will check it for you.

The question is, how do we relate x to y? This is howt he neural network works.

(Full diagram in notes)

Let me take the components

x1… xd

This is for a generic input. We talk about random variables in financial engineering. These are observations. We are making a relationship between the random variables in the input and the output

y1 … yk.

How do you make this connection? We are going to form this hidden layer. In the simplest case, just one layer. We will call it

h1… he.

I’m going to make a nonlinear activation function. I’ll combine all of the xs into a nonlinear relationship with the hs. Then I’ll combine these hs in a nonlinear relationship with the ys. How do you do this? First you take for every h\_i, you consider the function g\_1. The difference between linear and affine, we will construct an affine relationship. I will add an x\_0 \= 1 here. This is a free term, this constant. I will add some weights which connect these xs to the hidden layers.

w\_01^1, w\_11^1, … w\_d1^1.

This h\_i will be a function of

$$h\_i \= g\_1(\\sum\_{j=0}^d w\_{ji}^1 x\_j)$$

This relationship is really not important. I am literally taking a linear relationship, this function g\_1, and I’m applying the affine to it

$$= g\_1(w\_{0j} \+ w\_{ij}x\_1 \+ \\ldots \+ w\_{dj} x\_d$$

I’m taking all of the inputs times this weight. And that’s just for one node.

I need to do it for all layers because I will combine them when I reach y.

The y will be another function g\_2.

We will add another h\_0 \= 1 at the top, a constant. So that this function will be

$$y\_k \= g\_2(w\_{0k}^2 \+ w\_{1k}^2 h\_1 \+ \\ldots \+ w\_{ek}^2 h\_e$$

Literally, you are taking a linear combination of the weights, times the nodes, and you put it into the activation function, and put it into the nex tithing. At the end, you have these output y from a mountain of inputs.

So what do we do next?

## Activation Functions

We mentioned g\_1 and g\_2. What are those? These are called **activation functions**. If you’ve taken statistics, or FA590, at the end of the class, you do something called logistic regression. You are associating real numbers with probability. Because you need to map them continuous to continuous, since you can’t really map from continuous to discrete. Instead of mapping x into the outcome, I will map x into something which maps into \[0, 1\], this reduced region. The typical activation functions are the following. Technically you can use anything, but you will usually depend on one of seven fundamental functions, something every math student learns.

Exponential, tirgonometric, polynomial, etc.

(Graphs in notes)

Examples include:

- hyperbolic tangent: $$g(x) \= \\tanh(x) \= \\frac{e^x \- e^{-x}}{e^x \+ e^{-x}}$$
  This maps into \[-1, 1\]
  If x is multidimensional, then replace this with something multidimensional
  You can’t use cosine because it will explode at some values.
  This is what these things are trying to do. If you have x in the left region, it maps into a negative value, and the right is positive. So you can literally by playing with the weights, you can make your resulting point, which is a linear combination of inputs times weights, you can make it be either left or right. You can guide your output to y to be more positive or more negative.
- logistic: $$g(x) \= \\frac{1}{1+e^{-x}}$$
  It’s kinda similar to tanh, but the difference is that it goes into \[0, 1\].
  The reason it’s called logistic and it’s used in logistic regression, because you’re mapping real numbers into probabilities, and this is the correct domain for probabilities.
- Rectified Linear Unit **ReLU**: $$g(x) \= \\max (x, 0\) \= x\_+$$
  This is used in machine learning quite extensively.
  My mom decided to call me Ionut, so I’m only known by that one name. But the computer science decided to call this
  The ReLU gate is used to delete negative numbers. It’s used a lot in computer engineering.
- Softplus: $$g(x) \= \\log(1 \+ e^x)$$
  ReLU is called xplus. But it has a problem at 0, where it’s not derivable. So this makes it smooth. It’s nonzero everywhere and derivable, but it has the same general form.

This is the activated function, you can use it in both places, construct it however you like. It’s really important that you don’t do it with trial and error. People fire up pytorch and use defaults, and think it’s good. Obviously each of these activation functions have their own meanings. You need to know when to use one or the other.

Typically, the probability stuff uses logistic for the y. Typically, you want to predict some kind of number. Sometimes SoftReLU is used, sometimes regular ReLU, I don’t know which one is better. Depends on the output’s relationship with the input.

## The Weights

How many weights, and how do estimate them?

How many weights is pretty simple. I have d input, and k output. In that case, it depends on this internal layer. We’ll say the hidden layer has e nodes. Then I have d \+ 1 inputs (adding the affine part). Each of those d \+ 1, I weight each of them to connect to each of the e nodes. That’s (d \+ 1)e. That’s just for w\_1. Now I have to do the same thing to connect with k output ys. e \+ 1 affine term, and k of it. w\_2 has (e \+ 1)k terms. So it’s total

(e \+ 1)k

We’ll say x is 20 dimensional, we have 20 parameters, and y is one dimensional, with one output.

What is the typical number of nodes in a hidden layer? 64

‘

That would make this calculation 1409 weights. That’s an immense number of weights. In regression, if we have 20 inputs, then we have 22 parameters. If this is a class, and I add class characteristics, and I have years, and I have only 1200 cases, and I fit a neural network, what’s going to happen? I will get a perfect fit. Not only that, it will not be unique, because there are too many weights compared to observations. What about 10k cases? It will still be overfit. You will need millions of observations. That’s why when you’re doing discriminants between images, you need thousands. There are advanced methods to deal with this.

If you want to create a model of a person (this is an old thing, the computer vision problem). When I ame to Stevens, I did CV research for a while, in it searly days. When you plugged in 20 algorithms, 19 would not even work, just give wrong answers. They were based on this overfitting data that you have. Today is 20 years later, very mature CV, things that appear and disappear, all these techniques. You can get the shape from shading problem by lighting it differently, and get a model of a person. A friend of mine has this problem 2D to 3D. All of this is set in this particular domain.

## Backpropagation

This is complicated, I’m not going to explain in detail. But I will explain the fundamentals.

We have these weights that we’re trying to estimate. I know if I put my weights with my function, I get a candidate.

So we get something called a Loss Function. We already have one here, which is the least squares.

There are two cases, if y is discrete or continuous. For the height of a student it’s continuous. If you output a gender, it’s discrete.

Squared error loss is good if it’s continuous:

$$\\sum\_{i=1}^n (y\_i \- \\hat{y\_i})^2$$

yhat\_i is the output of the neural network.

$$\\sum\_1^ |y\_i \- g\_2|\\sum w\_i^1 g\_1(\\sum w^2 x))^2$$

This function contains all 1000 observations, and minimizes it.

The backpropagation does not minimize all the 1000\. It minimizes w2 first, then it minimizes w1 with respect to that, propagating the weights backwards, and then doing it again.

This is the simple part. The complicated part…

I learned in my other class that I should use mean squared error. Who gives a shit. Some of you may say that some are more important than others. You can definitely do that. You might say it’s very important to fit particular ys, and make it a weighted sum. But most of the time, it basically looks like this, with some kind of Euclidean distance.

What do you do in the discrete case?

They use something called Cross-Entropy which is bullshit. The loss function for the discrete variables is called this, and it’s hard to explain.

So first I will explain something simpler.

If we have discrete, we are going to output either male or female. We’re going to create two nodes. We will have probability of one, and 1 \- probability of the other. If you have multiple outputs, you use a hot-cold encoder, which maps this into a multi-dimensional space. The upshot is that you have to compare the observed discrete distribution and what you output, which is going to be probability. The function mapping is of numbers. In any of these ML techniques, you will take those numbers and calculate the probability distribution out of them.

Then how do you compare this probability distribution from the model, with the true probability distribution. Let’s say I have three outputs, green yellow red. If my object that I have is a combination of them, I will write down the combination. That’s the distribution I’m looking for. Most of the time, the categorial thing I’m outputting is one of them. 30s, 20s, teens. When I’m looking at one picture, the actual observed will be 0 0 1 0 0\. The probability distribution is 1 that belongs to this category and 0 to not others. So we nee dto calculate the difference between the output and this distribution.

We will use cross entropy, but it’s hard to understand so we’re not using this.

“If p and q are two probability distributions, and they have the same support. The rv is characterized by probability and outcome. The support is the domain of outcomes.”

For continuous, this is not useful, because we have MSE. But it can be useful for discrete.

$$H(p q) \= \-\\mathbb{E}^p(\\log q) \= \-\\sum\_{i=1}^k (\\log q\_i)p\_i$$

What does that mean? It’s outcome times probability. It’s kind of interesting. They have to be the same outcome to calculate this. So how does this work in terms of ML techniques. I have three outcomes: red, green, blue. One of the distributions is going to be 1 0 0, the other one from the neural network will be a b c, which corresponds to red green blue. So we have to pair these.

That’s the cross-entropy.

Instead we will look at **Kullback-Leibler Divergence**. This is defined as

$$\\mathbb{E}^P(\\log\\frac{P}{Q}) \= \\sum\_{i=1}^k \\log \\frac{p\_i}{q\_i} p\_i \= \\sum p\_i \\log p\_i \- \\sum p\_i \\log q\_i$$

IT’s pretty much the same thing as entropy in practice. The first term is only in p, which is typically a constant, it’s what I know.

This is simple to understand. If p\_i is close to q\_i, this is close to 1\. The logarithm of 1 is 0\. So it’s basically it’s a bunch of small parts of 0.This looks likeaa distance between p and q. But it’s a divergence, not a distance.

Distance has three properties. distance should be commutative, reflexive, and additive (triangle inequality). This only follows the first two. If something is equal to 0, then the two are the same. But, if something is tiny different from 0, and in other experiment you have the same tiny number, you cannot say that this cross function is the same. The distance itself is meaningless. Distance, I can measure 300 km here, 300 km in Romania, which is the same. Divergence, hell no. ou measure something here, the Trump tariff will be different than in Romania, because that’s not a distance.

This is neglected in all of CS literature. It’s a lot of wishy-washy here.

These numbers are special numbers, they’re between 0 and 1, and all sum up to 1\. That’s why you can’t use MSE. If one is distant, the other two are close. In the most common situation, the output is one and a bunch of 0s.

It turns out that thing that maximizes it will give you 1 for each of the outcomes. That would be completely overfitting.

READ ABOUT LOGISTIC REGRESSION.

The way that it’s done is the same as it’s done with this, except you’re using logistic vs Kullback-Leibler or Cross Entropy.

## Logistic Regression

q\_i is the output of th efunction you get from the node.

$$q\_i \= \\frac{1}{q \+ e^{-w^ix}}$$

If you’re going directly from x to y without a hidden layer in between. There are weights that correspond exactly to this particular outcome.

Typically you take q\_i as

$$q\_i \= g\_1(q\_1, \\ldots)$$

For the output, you want to make sure bigger is bigger and lower is lower.



## A case study in corporate credit rating

Basically the idea is, we have a credit rating. A company raises money by issuing stock, or debt. A debt is a loan, and repayment of the loan depends on credit rating. If the rating is high, you can get a low repayment rate. Who does the rating? S\&P, Fitch, and Moody’s. But there are many more smaller ones, DB Morningstar, that hire a lot of our students. In India, these companies, do not operate there. You have consultant companies which work with S\&P to help with their models, and move them to India to use them there. Well, at least they do this in Europe. The bank will hire a consultant that implements a Moody’s model and gives you the answer, it’s very bad.

In practice, you have all the ratings.



We looked at 16 years, some companies started more recently, some later. 62 companies, with 297 financial features, 297 xs. One random variable is the output, but it’s all 24, because you want to create an output for each of the likely outcomes. This is basically talking about the various techniques we used.

How do we evaluate algorithms? How good is it? Once you train you get the weights. So you have to do cross validation to test it.

Typically we have two data sets, training and testing. You typically have three regions in finance. In CS, you split into training and testing. Testing you just use for output, that’s it. Testing you split into this K-fold cross validation techniques. You’re always dealing with hyperparameters, should I have one hidden layer or multiple, 64 nodes, or 128, or 50, how many? The way to determine this is to split the data into 10 pieces, use 9 pieces to construct your weights, and then use that to predict the 10th part, and then see how good it is. Then you pick your hyperparameters which you can use. Estimation of actual parameters is done with the other side of the data. Now you have your weights, you can plug in your features, and get a credit rating.

You use these metrics, which have nothing to do with cross entropy baloney which is used to calculate weights. Once you have the weights, you’re concerned with accuracy. I have my company which is rated A, which has an output number. Is it the same as the observed number? You can do accuracy for the entire dataset. I have 100 points, and 50 of them I guessed the credit rating exactly, the other 50 I did wrong. So my accuracy is 50%.

We also have something called recall. Of those 100 companies, 20 were AA. Of those, the model only predicted 15 of them. 5 of them were predicted as being something else. That’s recall. Recall can only be done per category, and accuracy is done overall.

Precision is the same as accuracy, but only for those categories. You have 100 observations, accuracy for 100 points. My algorithm predicted 25 AA. There were 20 AA. Of those 20, 15 were actually AA. My precision is 15/25, my recall is 15/20.

Math is in corporate credit rating slides for Precision and Recall.

You have two numbers, how many of them were guessed correctly, and how many of the guesses were correct. Which one is better to describe this? The F1 score is the harmonic mean of precision and recall. There are 3 means, arithmetic, geometric, and harmonic. Arithmetic is largest, and harmonic is smallest, always. This is as conservative as possible, so it picks harmonic, the smallest possible average of the two.

This is for only one category.

You can do **macro-averaging**, regular averaging, or **micro-averaging**, which is the same as accuracy.

There’s not that much complication here. You just need to understand the fundamentals.

The skill for interviews: you need to explain the model. GIVE EXAMPLES.

## Shanshan’s Volatility Estimation

Goals: show that ANN can model complex nonlinear relationship, like a function with no closed-form solution

And how to do this with PyTorch

Training and testing process, will be completely

We set up with 5 input features, one output .

Hyperparameters we set up ourselves. There are two hidden layers with 64 nodes in each layer, ReLU is used.

Hidden layer can choose different activation functions. ReLU is common. For output layer, I used ReLU because Volatility is always positive, and can be \>1.

The W1 and b1 parameters are the initialized parameters, which will be updated during training.

Defining PyTorch neural network is done by extending nn.Module in a class.

You define a function Sequential, with a series of nn.Linear and the activation (nn.ReLu). The number of input and output features for each layer is given as parameters to Linear each layer.

Then you run the sequential for a given input.

Dataset prep:

you do this beforehand to understand the data.

training data and test data are split to evaluate the model

convert the dataset into tensor, wrap in Dataset class, allows you to use DataLoader.

You can do batches for efficiency, and shuffle training data for automatic cross validation.

Use Adam optimizer to automatically adjust learning rates, faster than gradient descent.

Compute training MSE loss to monitor progress

Evaluation MSE loss for overfitting

Testing MSE loss for results

How to prevent overfitting? When it learns the noise and random fluctuations instead of general pattern.

Use an evaluation set during training. If training loss and evaluation loss diverge too much, that’s a problem.

Ways to deal:

* Early stopping. Orange line stays, but blue line is decreasing. Then stop the epochs as the point when the blue line passes the orange line.
* Regularization. Penalize large weights. If the model is very complex, it has the space to learn the noise and random fluctuations rather than general pattern. Adam has (, weight\_decay=1e-5)
