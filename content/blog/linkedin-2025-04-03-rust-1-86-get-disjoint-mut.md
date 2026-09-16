+++
title = "Rust 1.86: `get_disjoint_mut`"
date = 2025-04-03
published_at = "2025-04-03T18:41:40.946Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7313631796301099010/"
activity_urn = "urn:li:activity:7313631796301099010"
source_post_number = 39
tags = ["Rust","Programming Languages"]
+++

Rust 1.86.0 has been released, with a very nice ergonomic feature to get around the borrow checker: `get_disjoint_mut`

Rust's borrow checker is the heart of its promise of memory safety. On a basic level, it ensures the following
- when you obtain an immutable reference to an object, no mutable reference can be made to that object while that reference exists
- when you obtain a mutable reference to an object, that reference is the only reference that exists

This creates a problem with slices, however. Imagine that you have a buffer, and you want to mutate only the last element, and pass around the rest of the buffer through immutable reference. You can take a mutable reference to the buffer to mutate the last element through `get_mut`, but you can't take an immutable reference to the rest of the buffer through `get`. Even though you know you're only mutating the last element, the borrow checker doesn't know that. This can require unergonomic reshuffling of memory access, or in the worst case, unnecessary cloning.

The new `get_disjoint_mut` solves this problem. By returning mutable references to only the slices that you intend to mutate, you can have finer control over mutable memory access.

Read more details in the release notes.
[https://lnkd.in/e5Je6Mb3](https://lnkd.in/e5Je6Mb3)
