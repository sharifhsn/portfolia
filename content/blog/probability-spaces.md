+++
title = 'Probability Spaces'
date = 2024-09-02
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Measure Theory', 'Sigma Algebras']
+++

## Week 1

### Reading

#### FT-1 | Probability Space

The purpose of probability is to obtain answers about real-life phenomena which do not have a predetermined outcome. We need a mathematical model to describe this so that we can provide answers to these questions. To this end, we define a **probability space**.

This space is defined on the **sample space** of all possible outcomes of a random experiment, denoted as \(\Omega\). Each element (outcome) of \(\Omega\) is denoted by \(\omega\), and a collection of outcomes is called an **event**, aka a subset of \(\Omega\). Probability requires us to understand the size of an event. Not all subsets of \(\Omega\) can be measured, so we will define a collection of subsets on which a measure can be defined, the \(\sigma\)**-algebra**.

A set is described in braces like so:

\(\{x | x \text{ satisfy property } \mathcal{P}\}\)

The set which does not contain an element is the empty set \(\emptyset\).

To say that an element belongs to a set is that \(\omega \in A\), and for it not to belong is \(\omega \notin A\).

A union of sets \(A \cup B\) has elements that are in either of them.

An intersection of sets \(A \cap B\) has elements that are in both of them.

The complement \(A^c\) of set \(A\) is the set of elements in \(\Omega\) but not in \(A\)

The difference of two sets \(A \backslash B\) is the set of elements in \(A\) but not \(B\)

The symmetric difference of two sets is \(A \Delta B = (A \backslash B) \cup (B \backslash A)\), which is the reverse of \(A \cap B\) if \(A\) and \(B\) share elements. In terms of a Venn diagram, it would be the left and right circle parts without the middle part.

If \(A \cap B = \emptyset\), then these sets are considered **disjoint** or mutually exclusive.

There is a distributive law (DeMorgan’s law) for intersection over union:

\(A \cap (B \cup C) = (A \cap B) \cup (A \cap C)\)

and the reverse for unions.

Let’s consider all possible subsets of \(\Omega\) as \(\mathcal{P}(\Omega)\). An **algebra** on \(\Omega\) is a collection of sets in \(\mathcal{P}(\Omega)\) which is closed under complementarity and finite union.

There are three basic properties of the algebra \(\mathcal{A}\):

- \(\Omega \in \mathcal{A}\)
- If \(A \in \mathcal{A}\), then \(A^c \in \mathcal{A}\)
- If \(A, B \in \mathcal{A}\), then \(A \cup B \in \mathcal{A}\)

These properties naturally extend themselves to other properties, like the empty set being in the algebra, intersections being in the algebra, and the union of all different sets being in the algebra.

A \(\sigma\)-algebra is a kind of algebra which is closed under countable unions. Regular algebras can have uncountable unions. These kinds of unions arise in stochastic processes. In order to use \(\sigma\)-algebras when describing stochastic processes, we will define **filtrations** that increase \(\sigma\)-algebras over time. When we try to prove properties of \(\sigma\)-algebras, we will instead prove properties about their generators, and then extend them to the \(\sigma\)-algebra.

Let’s consider a collection \(\mathcal{C}\) of sets in \(\Omega\). The \(\sigma\)-algebra of \(\mathcal{C}\) defined as \(\sigma(\mathcal{C})\) has the properties that it contains all sets in \(\mathcal{C}\) and it is the smallest \(\sigma\)-algebra which is a subset of any other \(\sigma\)-algebra which contains \(\mathcal{C}\).

Here are some facts about \(\sigma\)-algebras:

\(\mathcal{P}(\Omega)\) is the largest possible \(\sigma\)-algebra on \(\Omega\).

If \(\mathcal{C}\) is already a \(\sigma\)-algebra, then the generated \(\sigma\)-algebra is the same.

If \(C\) is \(\emptyset\) or \(\Omega\), \(\sigma(\mathcal{C})\) is \(\{\emptyset, \Omega\}\), the trivial \(\sigma\)-algebra.

Any collection of sets which has \(C\) has subset has the same \(\sigma\)-algebra as \(C\).

There are a lot of elements of \(\sigma\)-algebras, so we typically consider them in the context of generator \(\mathcal{C}\).

A **measurable space** is a pair \((\Omega, \mathcal{F})\) where \(\Omega\) is the sample space and \(\mathcal{F}\) is a \(\sigma\)-algebra on \(\Omega\).

For two \(\sigma\)-algebras \(\mathcal{F}_1\) and \(\mathcal{F}_2\), \(\mathcal{F}_1 \cap \mathcal{F}_2\) is a \(\sigma\)-algebra (and in fact this can be generalized to any countable intersection of \(\sigma\)-algebras, but \(\mathcal{F}_1 \cup \mathcal{F}_2\) is not a \(\sigma\)-algebra. You would have to define \(\sigma(\mathcal{F}_1 \cup \mathcal{F}_2)\), better denoted as \(\mathcal{F}_1 \vee \mathcal{F}_2\).

To picture the **Borel \(\sigma\)-algebra**, we must first envision our \(\Omega\) as a topological space where geometry is defined. We will specifically consider \(\Omega = \mathbb{R}\), where our sample space is the real number line. The Borel \(\sigma\)-algebra \(\mathcal{B}\) is generated by the class of open subsets of \(\Omega\). Think of this as every subdivision of the number line. Almost every subset of \(\mathbb{R}\) is in \(\mathcal{B}\), except for some very exotic sets.

As an example: if you partition \(\Omega\) i.e. you split it into disjoint sets, the different unions of all those sets is the same as the \(\sigma\)-algebra generated by all the disjoint sets. This can be proven by the fact that the complement of each collection of sets is present as a union of different sets, since they encompass the whole sample space.
