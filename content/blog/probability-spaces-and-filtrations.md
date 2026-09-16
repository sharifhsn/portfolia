+++
title = 'Probability Spaces and Filtrations'
date = 2024-09-12
source = 'FE-610 | Stochastic Calculus'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Thomas Lonon'
term = 'Fall 2024'
[taxonomies]
categories = ['Stochastic Calculus']
tags = ['Stochastic Calculus', 'Filtrations', 'Measure Theory']
+++
FE-610 begins with the probability-space machinery needed for continuous-time finance. The notes revisit sigma-algebras and probability measures, then add a filtration \((\mathcal F_t)_{t\geq0}\): an increasing family of information sets describing what is known by time \(t\).

An adapted process only uses information available in the current filtration. This is the formal version of the trading constraint that a position cannot depend on tomorrow's price. The notes also distinguish equivalent probability measures, which agree on null events but can assign different weights to events that can occur.

That distinction becomes essential later: a change of measure can simplify the dynamics used for pricing without changing which paths are possible.
