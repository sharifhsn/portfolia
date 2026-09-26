/*
title = "Operational Semantics"

date = 2022-02-17



[taxonomies]

categories = ["Principles of Programming Languages"]

tags = ["Principles of Programming Languages"]
*/

What are the formal semantics of how a programming language works, mathematically? That's a broad topic. #strong[Operational semantics], which are how programs #emph[execute], are narrow enough for one article.

== Rules
<rules>
The basis behind the mathematics of operation are based on using #strong[rules] to define a #strong[judgment]. The expression `e` will always evaluate to the value `v`. We can construct a micro-OCaml through the datatypes `exp` and `value`:

```ocaml
eval: exp -> value
```

This way of presenting semantics is called a #strong[definitional interpreter]. `eval` means `exp -> value`, and we use interpretations to define the language's meaning.

== Grammar
<grammar>
It is useful to define #strong[meta-variables] which represent categories of syntax. We will list a few here:

- `x`: any identifier or variable name

- `n`: a numeral value

- `e`: any expression

- `::=`: meta-syntax for definition

- `|`: meta-syntax for variants

```bnf
e ::= x | n | e + e | let x = e in e
```

This is an important line which defines what an expression #emph[exactly] is. Up until now, we have used the term expression quite loosely, so it's good to have an exact definition in operational semantics. An expression is either an identifier, a numeral or a combination of expressions. The last variant may seem a little strange to you, but remember, `let` expressions are simply replacing identifiers in an expression, so they are also expressions. This is a powerful definition because it fully encompasses the #strong[abstract syntax tree (AST)].

We can define an evaluation as `eval: exp -> value` where evaluation is the process of turning an expression into a final value (in this case an `int` only).

== Rules of Inference
<rules-of-inference>
In order to prove the veracity of a judgment, we check its composite rules. For example, let's prove that `1 + 3 ⇒ 4` is true. `1` and `3` are expressions in the sum function which evaluate to their own numeral value. Two values being added together is their sum, which is `4`.

The notation of #strong[rules of inference] are used to present rules in formal mathematics:

$ frac(H_1 dots.h.c H_n, C) $

If all the hypotheses are true, then the conclusion is true. If there are no hypotheses, then the conclusion is automatically true (#strong[axiom]).

Let's express those same rules about numeral self evaluation and sum expressions in rules of inference:

$ frac(e_1 arrow.r.double n_1 quad e_2 = > n_2 quad n_3 med upright("is") med n_1 + n_2, e_1 + e_2 arrow.r.double n_3) $

We can similarly describe the more complicated rules of let expressions:

$ frac(e_1 arrow.r.double v 1 quad e_2 { v_1\/x } arrow.r.double v_2, upright("let") med x = e_1 med upright("in") med e_2 arrow.r.double v_2) $

== Derivations
<derivations>
The #strong[derivation] is a process in which we apply rules to an expression in succession. We take our conclusion, then break it up into its constituent rules. If any of the rules need more rules themselves, we break them up too. Think of it like a tree which expands out from the conclusion. Let's use `let x = 4 in x + 3 ⇒ 7` as an example.

$ frac(4 arrow.r.double 4 quad frac(4 arrow.r.double 4 quad 3 arrow.r.double 3 quad 7 med upright("is") med 4 + 3, 4 + 3 arrow.r.double 7), upright("let") med x = 4 med upright("in") med x + 3 arrow.r.double 7) $

Let's look at this derivation step by step. First, we start at our conclusion. We say that `x = 4` in the let expression. Because `4` is used an expression here, we need to generate the hypothesis that the expression `4` will evaluate to itself, which is true from our reflective axiom. Then, we need to show that the resulting expression `4 + 3 ⇒ 7` is valid, which requires the sum rule of inference. Knowing that `4` and `3` evaluate to themselves and that `7` is the sum of those two values, then we can confirm that hypothesis and therefore the conclusion!

The way that we've written this derivation is recursive in nature. This is how definitional interpreters will evaluate expressions; they will search the expression for any constituent and evaluate them in turn in order to evaluate the entire expression.

$ frac(upright("eval Num ") 4 arrow.r.double 4 quad upright("Plus(Ident(\"x\"), Num 3)"), upright("eval Let(\"x\", Num 4, Plus(Ident(\"x\"), Num 3))")) $

All evaluation is mathematical proof. An expression `e` that provably evaluates to value `v` #strong[is] `v`.

== Environment
<environment>
From a mathematical perspective, an environment is a partial function that maps identifiers to values. Because it's partial, not all possible identifiers are mapped, so some identifiers are undefined.

The notation for an empty environment is `•`, which is undefined for every identifier. We can use notation here like in OCaml lists where we can define arguments as either the nil form `•` or a mapping cons the rest of the environment. Lookup of a value is similarly recursive like an OCaml list. In fact, in an OCaml definitional interpreter, the environment has type `(id * value) list` where we can search and match mappings like a regular #emph[association list].

We can add environment semantics to our previous understandings of judgments like so: `A; e ⇒ v`. Now, when we use identifiers in expressions, we can search the environment for the equivalent value and substitute it. The environment is the formal way of representing #emph[state] in an operation.

== Conditionals
<conditionals>
So far all we've done in terms of operational semantics is define variables and perform simple sums on them. One of the greatest powers of programming is the ability to implement control flow: if this, then that. Since we're programming functionally and not imperatively, these conditionals evaluate to expressions, not just operations, so we must have else as well to account for all cases.

To accommodate this, we must expand our earlier definition of expressions to include #emph[equality] and the #emph[if expression]. The if expression takes an equality expression as a conditional, and if it satisfies the boolean argument then the if body is returned as the evaluation, else the else body.

=
<section>
