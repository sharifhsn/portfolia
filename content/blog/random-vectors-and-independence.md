+++
title = 'Random Vectors and Independence'
date = 2024-11-04
source = 'FE-540 | Probability Theory'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Zhenyu Cui'
term = 'Fall 2024'
[taxonomies]
categories = ['Probability Theory']
tags = ['Probability Theory', 'Random Vectors', 'Independence']
+++
The later FE-540 notes package several random variables into a random vector, such as \(X=(X_1,X_2)\). The joint distribution records probability over rectangles and more general subsets of the product space. Marginal distributions come from integrating or summing out the other coordinates.

Independence has a clean joint-density form when densities exist:

$$f_{X,Y}(x,y)=f_X(x)f_Y(y).$$

The same factorization can be stated with a joint CDF or with sigma-algebras. It is stronger than zero covariance: independent variables have zero covariance when the moments exist, but uncorrelated variables need not be independent. The notes use this distinction before moving into conditional distributions and covariance calculations.
