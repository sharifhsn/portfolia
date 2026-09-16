+++
title = "How rustc_codegen_clr Connects Rust to .NET"
date = 2024-09-23
published_at = "2024-09-23T11:47:41.887Z"
description = "A short guide to Rust's compiler pipeline and a backend that targets .NET."
source = "LinkedIn"
source_url = "https://www.linkedin.com/posts/sharif-haason_rust-panics-under-the-hood-and-implementing-activity-7243949143541391360-ia_9"
activity_urn = "urn:li:activity:7243949143541391360"
source_post_number = 71
tags = ["Rust","Compilers"]
+++

If you’re a fan of compilers, Rust, or .NET, then Michał Kostrubiec’s [blog post](https://fractalfir.github.io/generated_html/rustc_codegen_clr_v0_2_1.html) about his project `rustc_codegen_clr` is a must-read. This is one of the most exciting and fast-moving projects in the Rust sphere, all driven by the hard work of one talented programmer. Here’s a quick summary of what the project is and why it’s so significant:

Rust, like many other modern languages, goes through several steps of compilation where it is compiled into different intermediate representations (IRs) before becoming an executable application. The current translation layer goes like so: Rust -> HIR -> MIR -> LLVM IR -> native code. The key step is between MIR and LLVM IR. This is when the Rust compiler frontend `rustc` shells out to a different compiler backend to perform the actual code generation, or “codegen”. The default is LLVM, the highly popular and versatile Apple-supported backend used by Swift and C/C++ (through `clang`). Using an existing backend allowed the Rust team to focus on frontend development. Instead of compiling efficient code to every possible CPU architecture, they were able to take advantage of LLVM’s existing infrastructure and compile to their IR.

Although this works great for the vast majority of use cases, there are some hiccups. LLVM doesn’t support every architecture that the standard C/C++ compiler `gcc` does, limiting Rust’s use in embedded environments. It’s also quite slow because Rust emits a lot of type information by design, which takes a long time to compile since LLVM wasn’t built to optimize that. That’s why efforts have been made to use other backends for codegen, like gcc [2], and there even exists now native Rust backends like Cranelift. [3]

`rustc_codegen_clr` [4] does something different. It translates MIR to the C# IR CIL, which allows .NET to compile Rust code. This has two main effects. .NET can use Rust libraries, which are comparable in performance to C libraries while being more robust. Rust can also use .NET libraries, which would enable Rust programs to access much more of the Windows platform, including the Windows App SDK. Rust native modern Windows GUI is just on the horizon!

Michał’s blog thoroughly examines the technical details behind his implementation and is worth the read for anyone interested in the project!

[1](https://fractalfir.github.io/generated_html/rustc_codegen_clr_v0_2_1.html) · [2](https://lnkd.in/egT4WMJB) · [3](https://lnkd.in/eZaJCvu4) · [4](https://lnkd.in/eZdNpiEr)
