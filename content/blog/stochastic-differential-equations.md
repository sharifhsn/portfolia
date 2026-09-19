+++
title = 'Stochastic Differential Equations'
date = 2024-11-21
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'SDEs', 'Diffusions']
+++

### Lecture Notes

Came late because my brother couldn’t get up 🙁

#### Stochastic Differential Equations

A SDE is of the form

\(dX(u) = \beta(u, X(u)) du + \gamma (u, X(u)) dW(u)\)

where β is the drift and γ is the diffusion.

Diffeqs always need a boundary condition, given by

\(X(t) = x, t \geq 0, x \in \mathbb{R}\)

In order to solve, we want to find

Most of the time, these don’t have closed-form solutions, so you have to solve numerically with Euler’s method.

We can express SDE as PDE using Feynman-Kac, if our solution



This is the end of the book of the final.

Over the next two weeks, we will look at what we can do based on what we’ve been learning.

Next week, we will introduce the idea of non-continuous stock processes i.e. jumps.
