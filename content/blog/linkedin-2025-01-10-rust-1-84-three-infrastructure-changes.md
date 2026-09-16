+++
title = "Rust 1.84: Three Infrastructure Changes"
date = 2025-01-10
published_at = "2025-01-10T13:25:09.372Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7283473947021459456/"
activity_urn = "urn:li:activity:7283473947021459456"
source_post_number = 52
tags = ["Rust","Developer Tools"]
+++

A new version of the Rust language has been released: Rust 1.84.0!

Although there aren't any new language features, this release kickstarts three big infrastructure improvements for Rust that have been a long time coming: minimum supported Rust version (MSRV), a new trait solver, and pointer provenance.

MSRV is a community-driven standard for Rust libraries that seek to be compatible with users that require older versions of Rust. For a while now, Rust has allowed libraries to declare an MSRV, but it doesn't do anything other than inform the user. If, for example, a library bumped the MSRV up when adding a new feature, the user would be forced to manually specify an older version of the library, which is hacky and difficult to maintain. Now, Rust's package manager Cargo will detect the user's MSRV and only download versions of libraries compatible with it.

Rust's powerful type system uses type theory to evaluate the correctness of the code's type specifications. As new features have been requested from Rust over time, the system that solves these types has bolted on the required features as they are implemented, resulting in a hacky system that's difficult to extend. The new from-scratch trait solver is simpler and is a necessary prerequisite to some highly-requested features, like specialization.

In systems programming languages like C, users will often need to work with raw pointers to memory i.e. integers. Rust uses references by default, which are pointers to memory that are tied to the object that created them, and therefore contain information relating to that object, like its mutability. This information is called provenance. References are what allows Rust to declare itself "memory-safe". However, it is sometimes necessary to construct pointers out of thin air, instead of references to an object, for example when working in an embedded environment. Previously, only raw pointers could be used for this, resulting in an unwieldy, buggy, C-like interface for users. Now, pointers can contain provenance, which gives them a safer API.

Nothing flashy, but all great QOL improvements!

[https://lnkd.in/eiBrWqPd](https://lnkd.in/eiBrWqPd)
