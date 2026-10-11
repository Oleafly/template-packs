// If the theme lives in a sibling directory, use a relative path instead:
// #import "../hackmeck-typst-theme/hackmeck-theme.typ": *
#import "hackmeck-theme.typ": *

// ── Theme setup ──────────────────────────────────────────────────────────────
#show: hackmeck-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [hackmeck-typst-theme],
    subtitle: [A terminal-aesthetic Typst presentation theme],
    author: [Your Name],
  ),
)

// ── Title slide ──────────────────────────────────────────────────────────────
#title-slide()


// ── Getting started ───────────────────────────────────────────────────────────
== Getting Started

Import the theme and wrap your document with `hackmeck-theme`:

```typst
#import "hackmeck-theme.typ": *

#show: hackmeck-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [My Talk],
    subtitle: [A subtitle],
    author: [Your Name],
  ),
)

#title-slide()
```

Slides are created automatically for every level-2 heading (`==`).


// ── Slide types ───────────────────────────────────────────────────────────────
== Slide Types

Three slide types are available:

- `slide()` — regular content slide (used implicitly via `==`)
- `title-slide()` — opening slide with title, subtitle, and author
- `focus-slide[…]` — full-screen emphasis slide for dramatic statements


// ── Focus slide example ───────────────────────────────────────────────────────
#focus-slide[
  Focus slides look like this.
]


// ── Text and emphasis ─────────────────────────────────────────────────────────
== Text and Emphasis

Regular text is rendered in Courier Prime at 20 pt in terminal green.

Use `#emph[…]` or `_underscores_` for _italic emphasis_.

Use `#strong[…]` or `*asterisks*` for *bold text*.

Combine them for *_bold italic_*.

`#alert[…]` highlights in bright green: #alert[important!]


// ── Inline code and raw blocks ────────────────────────────────────────────────
== Inline Code and Raw Blocks

Wrap short snippets in backticks for inline `code styling`.

Fenced code blocks get the same monospace look:

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

print(greet("Hackmeck"))
```


// ── Pauses ────────────────────────────────────────────────────────────────────
== Pauses

Use `#pause` to reveal content step by step.

First bullet.

#pause

Second bullet — shown on the next sub-slide.

#pause

Third bullet — shown after another advance.


// ── Images ───────────────────────────────────────────────────────────────────
== Images

Use `align(center + horizon, image(…))` to centre an image on the slide.

Specify a fixed `height:` to avoid the blank-subslide bug that `layout()` \
triggers when combined with `#pause`:

```typst
#align(center + horizon,
  image("path/to/image.png", height: 240pt, fit: "contain")
)
```


// ── Custom slide title ────────────────────────────────────────────────────────
#slide(title: [Custom Header Title])[
  Pass `title:` to `#slide()` to override the heading shown in the header bar.

  The section heading (`==`) is still used for the outline — only the displayed
  header changes.
]


// ── Columns ──────────────────────────────────────────────────────────────────
== Columns

Split content into columns using standard Typst `columns()`:

#columns(2)[
  *Left column* \
  Anything goes here — text, code, lists.

  #colbreak()

  *Right column* \
  The theme's dark background and green palette work across all content types.
]


// ── Lists and nested lists ────────────────────────────────────────────────────
== Lists and Nested Lists

- Top-level item
  - Nested item
    - Deeply nested item
- Another top-level item

Numbered lists work too:

+ First
+ Second
+ Third


// ── Tables ───────────────────────────────────────────────────────────────────
== Tables

#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.5pt + rgb("#1d6b1d"),
  fill: (_, row) => if calc.odd(row) { rgb("#001800") } else { none },
  [*Slide type*],    [*Counter*], [*Header*],
  [`title-slide`],   [frozen],    [none],
  [`focus-slide`],   [frozen],    [none],
  [`slide` / `==`],  [counting],  [auto from heading],
)


// ── Colour reference ──────────────────────────────────────────────────────────
== Colour Reference

The theme exposes these palette values for use in your slides:

#align(center)[
  #table(
    columns: (auto, auto, 1fr),
    stroke: none,
    [#box(fill: rgb("#33cc33"), width: 1em, height: 1em)], [`_green`],    [body text],
    [#box(fill: rgb("#7dff7d"), width: 1em, height: 1em)], [`_green-hi`], [headings · alerts · code text],
    [#box(fill: rgb("#1d6b1d"), width: 1em, height: 1em)], [`_green-lo`], [dividers · counters · author],
    [#box(fill: rgb("#001800"), width: 1em, height: 1em)], [`_code-bg`],  [inline code background],
    [#box(fill: rgb("#0a0d0a"), width: 1em, height: 1em)], [`_bg`],       [slide background],
  )
]


// ── That's it ────────────────────────────────────────────────────────────────
#focus-slide[
  Happy hacking!
]
