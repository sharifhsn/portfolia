+++
title = "Rust 1.83 Brings More `const`"
date = 2024-11-28
published_at = "2024-11-28T16:16:30.611Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7267934391442583554/"
activity_urn = "urn:li:activity:7267934391442583554"
source_post_number = 56
tags = ["Rust","Programming Languages"]
+++

A happy Thanksgiving to all! Today, in addition to my loved ones, I'm grateful for a brand-new version of Rust, now with more `const`! `const` evaluation is one of the most important steps in making Rust more ergonomic in memory-constrained environments, such as embedded computing or the Linux kernel, as it allows for more code to be evaluated before execution.

For example, let's say that a program requires the result of some complex mathematical expression to run. Computing this at runtime would add significant overhead and could violate memory constraints. By placing this computation in a `const` context (either a `const` expression or a `const` function), the computation is guaranteed to run at time of compilation, with the result stored in the program to be used immediately upon execution.

This new release allows users to take mutable references in a `const` context, greatly expanding what kind of expressions are allowed and improving the flexibility of `const` code. As a result, many common functions in the standard library are now stabilized in the `const` context, including many operations on floating point numbers. I'm looking forward to how this new feature will enable better patterns in embedded Rust!

[https://lnkd.in/eC3x_U52](https://lnkd.in/eC3x_U52)
