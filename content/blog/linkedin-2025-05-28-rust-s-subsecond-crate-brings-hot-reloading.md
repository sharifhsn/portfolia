+++
title = "Rust's `subsecond` Crate Brings Hot Reloading"
date = 2025-05-28
published_at = "2025-05-28T18:00:05.331Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7333552661541117952/"
activity_urn = "urn:li:activity:7333552661541117952"
source_post_number = 22
tags = ["Rust","Developer Tools"]
+++

Rust's `subsecond` crate is a game changer for application and game development in Rust! Its innovative hotpatching method enables hot reloading for select libraries.

By far the biggest drawback of Rust is its compilation time. Although it has improved over the years, it is far slower than any other language. Even an extra wait of a few seconds can break developer flow.

This is, unfortunately, by design. C/C++ are able to compile quickly because they are generally split up into source code and header files which describe the functions individually, so the compiler can compile them in parallel if they don't depend on each other.

Rust, however, treats the entire package as the compilation unit. Library authors have to split up their code, often awkwardly, in order to achieve faster compilation times.

Dioxus Labs have finally engineered the solution for their GUI library Dioxus. Their innovative `subsecond` crate compiles only the part of the code that has changed and patches the change into the existing binary, significantly reducing compilation time for small changes. This is common when designing UIs, when shifting elements and changing small details.

Most significantly, `subsecond` is available on ALL major platforms, which has never been achieved by ANY hot patching system for a compiled language.

The developers behind the game engine Bevy were able to integrate `subsecond` into Bevy and hot patch game development with 500 ms compilation times, basically as fast as you can press Ctrl + S!

Currently, `subsecond` is too bespokely designed to be used widely throughout the ecosystem. However, the Dioxus team is actively working to improve `subsecond`, and hopefully it will become an option for developers working on large, complex libraries.

`subsecond` hot reloading will be included in the upcoming release of Dioxus 0.7, and likely Bevy 0.17. The Dioxus team will be presenting technical details about `subsecond` at Seattle RustConf from September 2-5.

Dioxus release post: [https://lnkd.in/eJfHXWJH](https://lnkd.in/eJfHXWJH)

Example of Bevy running `subsecond`: [https://lnkd.in/e457vQX9](https://lnkd.in/e457vQX9)
