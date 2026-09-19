+++
title = 'Random Variables and CDFs'
date = 2024-09-16
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Random Variables', 'CDFs']
+++

## Week 3

### Reading - Random Variables Generalities (FT 3)

#### Definition

We can consider a mapping between all of the sets in the \(\sigma\)-algebra of one measurable space \((\Omega, \mathcal{F})\) to another sample space \(\Omega_1\), where the mapping is measurable each set has a mapping. A **random variable** is a measurable function \(X: \Omega \rightarrow \mathbb{R}\) where the target sample space is the Borel set. Random variables are capital letters and their values are lowercase letters.

The sum, product, or composition of measurable functions are measurable functions, so those are still random variables.

We consider the *preimage* of \(X\) to be \(X^{-1}(A)\), which is not precisely the inverse function. It’s the set in the \(\sigma\)-algebra in the input sample space which generated the set \(A\).

#### Distribution

The distribution of a random variable is itself a random variable, denoted by \(\mathbb{P}_X = \mathbb{P} \circ X^{-1}(\mathbb{R})\). This variable is defined on the Borel set as a probability on the measurable space. We can consider the probability space of the distribution to be \((\mathbb{R}, \mathbb{B}(\mathbb{R}), \mathbb{P}X)\) i.e. the sample space is all real numbers, the function mapping is the Borel subset (every interval and combination of such), and the distribution is the probability measure.

If we have a sequence of disjoint sets in the Borel subset of \(\mathbb{R}\), then the distribution of \(X\) (\(\mathbb{P}(X)\)) on the unions of those sequences is the same as the sum of the probability measure on each individual set.

We will consider the notation \(\{X \in A\}\) to mean that there’s an outcome \(\omega\) in sample space \(\Omega\) \(X\) which maps to the set \(A\) in \(\mathcal{B}(\mathbb{R})\)

#### Cumulative Distribution Function

Formally, the cdf of a random variable is \(F(x) = \mathbb{P}(\{\omega: X(\omega) \leq x\})\) or the probability measure of the outcomes where the mapping to the real numbers is less than a specified number x.

This function has the properties that it is increasing, right continuous, and it approaches 0 and 1 from left and right, respectively.

The **infinimum \(\inf\)** is the largest element smaller than every element of a set (aka it’s the element just to the left of the set in the order) and the **supremum \(\sup\)** is the element to the right.

If we consider the variable.

For every cdf that exists, there exists a random variable that has that cdf.

A **Borel function** is a measurable function that maps from \(\mathbb{R}\) into \(\mathbb{R}\).

### Lecture Notes

#### CDF

\(F:\mathbb{R} \rightarrow [0, 1]\) with \(F(x) := P_X((-∞, x]) = P_X(B)\), where \(B = (-\infty, x]\)

These are equivalent ways of writing a cdf. This counts the accumulated probability less than or equal to x.

More interestingly, the cdf has these properties: increasing

The increasing property is fairly intuitive. Rigorously, you can show that for y \>= x, \((\infty, x] \subset (-\infty, y]\). The interval from x to y must be 0 or greater, so then the cdf to y must be greater than the cdf to x.

You can also show that it’s right continuous, proof is beyond the scope, involves monotone class

\(\lim_{h \searrow 0} F(x+h) = F(x)\) for any x in the domain.

Let’s examine the first quadrant of an equation. We have \(x\) . If we imagine the difference between that and \(x + h\), in a continuous function this is well-defined. But we might have a discontinuous function. This cannot be a cumulative distribution function. This is a complicated statement.

\(\lim_{x \rightarrow -\infty} F(x) = 0, \qquad \lim_{x \rightarrow \infty} F(x) = 1\)

We can prove this by showing that

\(\lim_{x \rightarrow -\infty} F(x) = 0 = \lim_{x \rightarrow -\infty} P_X(-\infty, x] = P_X(\emptyset) = 0\)

Why is this empty set? Because if you have the interval \((-\infty, \infty]\), left open interval says I don’t have it, right says I do, because they conflict then there must be an empty set.

\(\lim_{x \rightarrow -\infty} F(x) = 1 = P_X(-\infty, \infty] = P_X(\mathbb{R}) = 1\)

This just becomes the probability measure of the sample space which is definitionally 1.

Most of the focus in this course will be calculation and not proof. But if you understand the proof, it will guide you in calculations.

Lemma 3.11: If we have \(F(X)\) as the cdf, then

\(\mathbb{P}(X \geq x) = 1 - \mathbb{P}(X \leq x)\)

This is known as the survival function. If you survive over sixty years, then you get your retirement money. This assumes that \(\mathbb{P}(X=x) = 0\) which is true if \(X\) is a continuous random variable.

Proof is \(\{X > x\} \cup \{X \leq x\} = \mathbb{R} = \Omega\)

**Important identity:**

\(\mathbb{P}(x < X \leq y) = F(y) - F(x)\)

This proof comes from the set inequality: \(\{X \leq x\} \cup \{x < X \leq y\} = \{X \leq y\}\)

And then if we take the probability measure of all of these then we see that the right side is the cdf of y, left side is cdf of x disjoint with the other part so you can add them by earlier definition

Also known

\(\mathbb{P}(X=x) = F(x) - F(x-)\) this is us taking the left limit where

 \(F(x-) := \lim_{y \nearrow x} F(y) = \lim_{h \searrow 0} F(x - h)\)

consequences of this? If this \(F(x)\) is left-continuous, it means that the limit is equal, which means this whole thing is equal to 0. However, it’s not left-continuous, then \(\mathbb{P}(X=x) > 0\) strictly larger than 0. This looks like when the dot is on the right and the open circle is on the left. This is allowed, and it happens when \(X\) is a discrete random variable. Binomial, Poisson, Geometric random variables are all discrete.

#### Numerical

Roll a die, probability that number is smaller than five. (strictly less than on an exam)

\(\mathbb{P}(X < 5) = \mathbb{P}(X \leq 4) = F(4) = \mathbb{P}(\{X = 1\} \cup \{X = 2\} \cup \{X = 3\} \cup \{X = 4\})\)

\(= \mathbb{P}(X=1) + \mathbb{P}(X=2) + \mathbb{P}(X=3) + \mathbb{P}(X=4)\)

\(= \tfrac{1}{6} + \tfrac{1}{6} + \tfrac{1}{6} + \tfrac{1}{6}\)

\(= \tfrac{2}{3}\)

alternatively, I could do the same with 5 and 6 and use the 1 - property.
Two random variables are independent if

\(\mathbb{P}(X \in A, Y \in B) = \mathbb{P}(X \in A) \times \mathbb{P}(Y \in B)\)

or put another way

\(= \mathbb{P}(\{X \in A \} \cap \{Y \in B\} )\)

Intuitively, this means that the outcome of \(X\) does not affect the outcome of \(Y\).

For any \(x, y \in \mathbb{R}\), where \(x, y\) are independent

\(\mathbb{P}(X \leq x, Y \leq y) = \mathbb{P}(X \leq x) \times \mathbb{P}(Y \leq y)\)

 are mutually independent if

\(\mathbb{P}\left(\bigcap_{i=1}^n \{x_i \in B_i\} \right) = \prod_{i=1}^n \mathbb{P}(X_i \in B_i)\)

They are also pairwise independent in this case.

For an arbitrary family of random variables where we have some index set \(I\) for \(X_i\), they are mutually independent if every finite subfamily is independent. That means any finite subset of the indices will cause this to be the case. This is not very useful as a way to prove independence because there are so many cases to prove, this is just a definition.

Let’s say we roll a fair die twice and we have \(X\) represent the maximum of both rolls. The first question we’re interested in calculating the image of \(\Omega\) through \(X\) and the distribution of \(X\).

\(\Omega = \left\{ \omega = (j_1, j_2), j_1, j_2 \in \{1, 2, 3, 4, 5, 6\}\right\}\)

total of 36 elements

the probability of observing any particular outcome is \(\tfrac{1}{36}\) because it’s fair. This \(X\) is clearly a mapping from the sample space to the set of six numbers. If we calculate probabilities:

\(\mathbb{P}(X=1) = \mathbb{P}_X(\omega = (1, 1)) = \tfrac{1}{36}\)

\(\mathbb{P}(X=2) = \mathbb{P}_X(\omega = (1, 2)) + \mathbb{P}_X(\omega = (2, 1)) + \mathbb{P}_X(\omega = (2, 2)) = \frac{3}{36}\)

\(\mathbb{P}(X=3) = \mathbb{P}\left( \bigcup_{k=1}^3 \{\omega = (3, k\} \cup \bigcup_{k=1}^2 \{\omega = (k, 3)\}\right) = \frac{5}{36}\)

This is 3 then 2 because you don’t want to double count the same number.

\(\mathbb{P}(X=4) = \mathbb{P}\left( \bigcup_{k=1}^4 \{\omega = (4, k\} \cup \bigcup_{k=1}^3 \{\omega = (k, 4)\}\right) = \frac{7}{36}\)

\(\mathbb{P}(X=5) = \mathbb{P}\left( \bigcup_{k=1}^5 \{\omega = (5, k\} \cup \bigcup_{k=1}^4 \{\omega = (k, 5)\}\right) = \frac{9}{36}\)

\(\mathbb{P}(X=6) = \mathbb{P}\left( \bigcup_{k=1}^6 \{\omega = (6, k\} \cup \bigcup_{k=1}^5 \{\omega = (k, 6)\}\right) = \frac{11}{36}\)

Now let’s get the cdf \(F(X)\). Let’s consider each instance of \(F(b) = \mathbb{P}(X \leq b)\)

Obviously, this has to be 0 for less than 1 because that’s not an outcome. For the rest of them, you add up the probabilities (because they’re disjoint).

Another example.

You are given

\(\mathbb{P}(0 \leq X \leq 1) = \frac{8}{12}\)

\(\mathbb{P}(0 \leq X \leq 2) = \frac{7}{12}\)

\(\mathbb{P}(0 \leq X \leq 3) = \frac{10}{12}\)

\(\mathbb{P}(X=3) = \mathbb{P}(X \geq 4)\)

We want to know the probability for up to 3.

We can solve for \(\mathbb{P}(X=0) = \frac{3}{12}\)



We also want to show this inequality \(X(\omega) \leq Y(\omega), \forall \omega \in \Omega\)

You wnt to show that \(F_X(a) \geq F_Y(a), a \in \mathbb{R}\)

Hint: \(F(X(a) = \mathbb{P}(X \leq a) ? \mathbb{P}(y \leq a) = F_Y(a)\)



More interesting example 3.4

cdf

you have to find the conditions on a, b, c, d, that \(F\) satisfies the properties of a cdf.

We have the property

\(\lim_{x \rightarrow \infty} F(x) = 1 = d\)

Because that’s if \(t \geq 3\).

a gives you the same solution of 0.
