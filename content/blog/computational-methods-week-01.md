+++
title = "Stochastic Processes and Computational Pricing"
date = 2025-01-28
source = "Computational Methods in Quantitative Finance"
source_date_basis = "Scheduled Tuesday FE-621 meeting date inferred from the syllabus sequence and the Academics calendar."
[taxonomies]
categories = ["Computational Methods"]
tags = ["Computational Methods","Stochastic Processes","Numerical Methods","Option Pricing"]
+++

I’m out on vacation this week, so I watched the recording

## Textbook

### Stochastic Processes

A stochastic processes is merely a collection of indexed random variables. The indexing of these variables confers a structure onto the rvs which gives them some properties.

The indexing structure can be a set or an interval, which would imply a discrete or continuous stochastic process, respectively.

## Syllabus

Late assignments are not accepted under any circumstances, at least 24 hours in advance must be warned.

Attendance is mandatory for in-person, not for online.

Old book with pseudocode with formula.

which is a lot more

Main things we cover:

Monte carlo approximation

Finite difference

Trees

Black-Scholes PDE solution we study in 610

Most models do not have a formula though

So how do we estimate the value then? That’s what this class is about

There are two fundamental ways

Approximate the process. Let’s say I know the path for sure. I can calculate the value by using the payoff formula.

I can generate millions of paths and then average them. That is very slow.

Or I could look at the probability of each path, and then average them? That’s trees.

Or you could solve the PDE. You can get complicated PDEs, but they always have a very similar structure.
