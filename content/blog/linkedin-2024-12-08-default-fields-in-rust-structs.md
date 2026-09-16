+++
title = "Default Fields in Rust Structs"
date = 2024-12-08
published_at = "2024-12-08T16:50:39.228Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7271566862621020161/"
activity_urn = "urn:li:activity:7271566862621020161"
source_post_number = 55
tags = ["Rust","Programming Languages"]
+++

A recent RFC (request for comment) for the Rust language has divided the community: default fields in structs.

In order to implement a default version of a struct in Rust, one has to implement the `Default` trait on it. The easiest way to do this is to use the derive macro for `Default`, which requires every single one of the structs fields to implement `Default`.

This works fine for structs composed of simple elements that already implement `Default`, like integers and strings, but for more complex objects, you will need to either implement `Default` through an `impl` block for each of the struct's unimplemented fields, or have an `impl` block for the whole struct.

Both of these workarounds have disadvantages. Implementing `Default` for every struct field type you design is tedious, especially if they are rarely used in a `Default` context. Additionally, it is often possible that a struct field type needs different `Default` implementations in different parent struct contexts, rendering this workaround impossible. The other solution, writing a bespoke `impl Default` block for every parent struct, is prone to code duplication, a common source of errors.

The simple solution is default field types. These allow users to specify the default initializer for a struct field type tersely within a parent struct. You can see in this attached image how much easier this is.

The controversy arises from the fact that Rust already has ways of dealing with this problem. In addition to the workarounds I mentioned earlier, the "pure" way of doing this would involve instantiating a new struct field type for every different `Default` implementation. In the example I've shown here, instead of being an `i128`, the `age` field would have a special type `PetAge(i128)` which would have a separate `impl Default`. However, this creates a lot of boilerplate and bloats code size, which is always a code smell.

Additionally, the RFC has the limitation that the in-struct `Default` initializer must be `const`, a limitation that `impl Default` *does not face*. This is important because some of the most common use-cases of this in third-party derive macros that provide this functionality are for non-`const` initialization, particularly `String` initialization.

You can read more discussion about this on the RFC pull request page:
[https://lnkd.in/eTZ8FPd7](https://lnkd.in/eTZ8FPd7)

What do you think of this upcoming feature? Is it useful, or just needless complexity?
