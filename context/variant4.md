# Variant 4: Open workbench

Seed: `_myPGmoKMwI6nON-yP--ksDB9GJR779_`

Treating this seed as a visual oracle: the matching underscores imply a containing frame; the uneven mixed-case clusters imply changes in width and density; the `--` calls for paired rails; and the final `779` asks for a repeated rhythm with one offset. This is an interpretation for creative direction, not an objective property of randomness.

## Design tokens

- Electric blue `#254AF4`: main canvas, a direct and energetic introduction.
- Ice `#EDF2FF`: text and document canvas.
- Apricot `#FFC198`: portrait backing and active navigation.
- Ink `#182551`: body text on light surfaces.
- Steel `#AEC0FA`: secondary text on blue.
- Typography: system Helvetica Neue / Arial for the oversized tightly set greeting and clean body. No external font dependency.
- Layout: left-aligned, broad introduction beside a narrower portrait; a pale horizontal directory shelf crosses the blue frame. On small screens, all content forms one column.

```
name                         Blog Projects Resume
=================================================
Hello,                 |         portrait
I'm Sharif.            |      offset caption
friendly introduction  |
-------------------------------------------------
 Writing                     Projects
=================================================
```

## Review against the brief

The first idea used floating cards and code-like micro-labels. Removed both: they resembled a software landing-page template and made the site talk about itself. The final design spends its boldness on the oversized greeting, solid blue field, and offset portrait. Blog and project rows remain explicit planned destinations, without invented published work. Resume content has a quieter paper view within the same visual identity. HTML/CSS-only design fits the existing Rust/Askama framework.

## Implementation notes

Routes use `/v/4` and its Blog, Projects, and Resume children. Photo and download links are conditioned on availability. Resume HTML is supplied by the Rust server. Keyboard focus, a skip link, mobile layouts, and reduced-motion handling are included. No JavaScript, network fonts, or fake links required.
