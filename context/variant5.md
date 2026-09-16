# Variant 5: Orbit

Seed: `5Nt1eKGyjrhJR5R9BZh9qUBTyElV0uQy`

Treating the seed as an oracle, the repeated R and 9 suggest repeated paths, while Q and y introduce a loop with an escape. The alternation between upper and lower case suggests a large geometric gesture interrupted by small, personal details. That becomes an orbital portrait with an offset center, oversized friendly typography, and deliberately simple page navigation.

Tokens: lavender `#e6e2fa`, cobalt `#2229a5`, tangerine `#ff996e`, white `#ffffff`, muted blue `#555c85`. Avenir Next with a local sans-serif fallback carries both expressive display type and readable body text. No remote font dependency.

Layout: left-aligned introduction occupies the left half, a circular portrait composition the right. The composition stacks beneath the introduction on narrow screens. Navigation is a quiet horizontal strip. Directory entries become wide open rows. Resume content sits on a white reading surface.

```
name                                Blog Projects Resume

Hi, I'm                   /------ orbit ------\
Sharif.                   |      (portrait)    |
friendly introduction      \------------------/

Writing                              Projects
```

Plan review: a dark technology palette and terminal labels would be an easy default for Rust interests. The light saturated palette and looping geometry instead come directly from this seed. Only the orbital portrait gets decorative treatment. Directories remain visibly unfinished without inventing articles or shipped projects.

Implementation: standalone Askama template with page branches, conditional local portrait and resume downloads, semantic navigation, current-page state, keyboard focus, responsive layouts and print styles. No JavaScript or motion required.
