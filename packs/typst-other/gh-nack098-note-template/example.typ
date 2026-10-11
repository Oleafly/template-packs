#import "templates/title_template.typ": title, report-cover
#import "templates/chapter_template.typ": (
  toc,
  chapter,
  goal, concept, definition, pitfall,
  block-quote,
  image-fig, overflowing-image,
)

// ── Title Page ────────────────────────────────────────────────────────────────
#title(
  title: "NOTE TEMPLATE EXAMPLE",
  subtitle: "Full Component Showcase",
  author: "Nakuya (泣くや)",
  role: "Software Engineer",
  version: "1.0.0",
)

// ── Table of Contents ─────────────────────────────────────────────────────────
// depth: 2 shows H1 + H2. Use depth: 3 to also include H3.
#toc()

// ── Chapter ───────────────────────────────────────────────────────────────────
#chapter(
  name: "Showcase",
  title: "Component Reference",
  subtitle: "Full Example",
  author: "Nakuya",
)[

// ═══════════════════════════════════════════════════════════════════════════
= Typography
// ═══════════════════════════════════════════════════════════════════════════

This template is built on Typst @typst — a modern typesetting system with a
compiled Rust core. The body font is Inter @inter at 9.5 pt, typeset on A5
paper with justified paragraphs.

H1 headings render at 18 pt bold navy with a full-width rule underneath.
They mark major sections — keep them broad.

== Heading Level 2

H2 is 14 pt semibold blue (`#2980b9`). Typst pins it to the next paragraph
so a heading never strands at the bottom of a page.

=== Heading Level 3

H3 and below inherit the body style — 9.5 pt Inter, navy. Use sparingly;
if you need more than three levels, the section is probably too deep.

==== Heading Level 4 (unstyled)

Same as H3. Consider refactoring into a new `chapter` instead.

== Body Text

Paragraphs are justified with Inter at 9.5 pt on A5 paper. The narrow
column width makes full justification comfortable — lines stay short enough
that rivers are rare. Typst's line-breaking algorithm handles hyphenation
automatically.

Line spacing and paragraph spacing are set to Typst defaults, which read
well at this font size. No manual `par` tweaks are needed for ordinary prose.

== Inline Styles

*Bold* draws the eye. _Italic_ marks terms or titles. `monospace` labels
identifiers and values. Combine them freely: *_bold italic_*, _`italic mono`_.

- #strike[Strikethrough] for deprecated or removed items.
- #underline[Underline] — use sparingly; it reads as a link.
- #link("https://typst.app")[Hyperlink] — rendered in the accent colour.
- #super[Superscript] and #sub[Subscript] for math notation inline.

// ═══════════════════════════════════════════════════════════════════════════
= Lists & Tables
// ═══════════════════════════════════════════════════════════════════════════

== Unordered List

- First item
- Second item
  - Nested item
  - Another nested item
    - Deeper nesting
- Third item

== Ordered List

+ Step one — install Typst
+ Step two — clone this repo
+ Step three — run `make compile-example`
  + Sub-step: check `build/example.pdf` opens correctly
+ Step four — rename and start writing

== Mixed Nesting

- Category A
  + First task
  + Second task
- Category B
  + First task

== Table

#table(
  columns: (auto, 1fr, auto, auto),
  inset: 8pt,
  align: (left, left, center, right),
  table.header(
    [*Component*], [*Description*], [*Status*], [*Lines*],
  ),
  [`chapter`],          [Main note wrapper with cover page],  [stable],  [~100],
  [`title`],            [Standalone personal title page],     [stable],  [~55],
  [`report-cover`],     [Academic cover page],                [stable],  [~85],
  [`toc`],              [Styled table of contents page],      [stable],  [~35],
  [`callout`],          [Base for goal / concept / etc.],     [stable],  [~12],
  [`image-fig`],        [Captioned figure block],             [stable],  [~8],
  [`overflowing-image`],[Fill-container image helper],        [beta],    [~15],
)

// ═══════════════════════════════════════════════════════════════════════════
= Code
// ═══════════════════════════════════════════════════════════════════════════

== Inline Code

Reference identifiers mid-sentence: `VkCommandBuffer`, `Option<T>`,
`make compile-all`. The box uses Catppuccin @catppuccin `sky` on `surface0`
with 4 pt corner radius and 2 pt vertical padding.

== Block Code

Block code uses Catppuccin Macchiato via a `.tmTheme` file. The language
label appears top-right. Font is Fira Code at 8.5 pt.

```rust
/// Fibonacci using memoisation.
fn fib(n: u64, memo: &mut HashMap<u64, u64>) -> u64 {
    if let Some(&v) = memo.get(&n) { return v; }
    let result = match n {
        0 => 0,
        1 => 1,
        _ => fib(n - 1, memo) + fib(n - 2, memo),
    };
    memo.insert(n, result);
    result
}
```

```python
from functools import cache

@cache
def fib(n: int) -> int:
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)
```

```typ
// Typst itself renders with syntax highlighting too.
#let greet(name: "world") = [
  Hello, *#name*!
]

#greet(name: "Typst")
```

```sql
SELECT
    u.name,
    COUNT(o.id)  AS order_count,
    SUM(o.total) AS revenue
FROM users  u
JOIN orders o ON o.user_id = u.id
WHERE o.created_at >= NOW() - INTERVAL '30 days'
GROUP BY u.name
ORDER BY revenue DESC
LIMIT 10;
```

// ═══════════════════════════════════════════════════════════════════════════
= Callouts
// ═══════════════════════════════════════════════════════════════════════════

Callouts highlight ideas that need to stand out from the prose. They share
a common structure — bold coloured title, light-weight body — but each
carries a distinct semantic meaning.

#goal[
  State the _why_ before the _how_. Readers who understand the goal first
  will remember the implementation detail longer.
]

#concept[
  *Cache coherence* — the guarantee that all processors in a shared-memory
  system observe a consistent view of memory at any given point in time.
]

#definition[
  *Amortised complexity* — the average cost per operation over a sequence
  of $n$ operations, even if some individual operations are expensive.
  A dynamic array `push` is $O(1)$ amortised despite occasional $O(n)$ resizes.
]

#pitfall[
  Never call `malloc` inside a real-time audio callback. Memory allocation
  can block for an unbounded time on any OS, causing audible glitches.
]

Callouts can contain any content — inline code, *bold*, even lists:

#concept[
  The three rules of ownership in Rust:

  + Each value has exactly one owner.
  + When the owner goes out of scope, the value is dropped.
  + Ownership can be transferred (*moved*) or temporarily lent (*borrowed*).
]

// ═══════════════════════════════════════════════════════════════════════════
= Block Quotes
// ═══════════════════════════════════════════════════════════════════════════

With full attribution:

#block-quote(
  author: "Rob Pike",
  source: "Notes on Programming in C",
)[
  Data dominates. If you've chosen the right data structures and organised
  things well, the algorithms will almost always be self-evident.
]

Source only, no author:

#block-quote(source: "The Zen of Python")[
  Explicit is better than implicit. Simple is better than complex.
]

Body only — no attribution line is rendered:

#block-quote[
  The purpose of abstracting is not to be vague, but to create a new
  semantic level in which one can be absolutely precise.
]

// ═══════════════════════════════════════════════════════════════════════════
= Figures
// ═══════════════════════════════════════════════════════════════════════════

== image-fig

`image-fig` wraps any content in a centred figure block with an 8 pt
light caption. Replace the gradient rect below with a real `image(...)` call.

#image-fig(
  rect(
    width: 100%,
    height: 5cm,
    fill: gradient.linear(
      rgb("#1a3a5f"), rgb("#2980b9"), rgb("#6dd5fa"),
      angle: 135deg,
    ),
    radius: 4pt,
    stroke: none,
  ),
  [
    Replace with #raw("image(\"assets/diagram.png\", width: 100%)", lang: "typ") \
    Caption supports *bold*, _italic_, and `inline code`.
  ],
)

== overflowing-image

`overflowing-image` fills its container by aspect ratio — useful when you
want an image to bleed edge-to-edge inside a constrained block without
distortion or letterboxing.

#block(width: 100%, height: 4cm, clip: true, radius: 4pt)[
  #overflowing-image(
    rect(
      width: 20cm,
      height: 8cm,
      fill: gradient.linear(
        rgb("#f39c12"), rgb("#e74c3c"), rgb("#8e44ad"),
        angle: 45deg,
      ),
      stroke: none,
    )
  )
]

// ═══════════════════════════════════════════════════════════════════════════
= Math
// ═══════════════════════════════════════════════════════════════════════════

Math is standard Typst — no extra packages needed.

Inline: the quadratic formula is $x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a)$.

Display block:

$ sum_(i=1)^n i = (n(n+1))/2 $

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $

$ bold(F) = m bold(a) quad arrow.r.double quad
  mat(F_x; F_y; F_z) = m mat(a_x; a_y; a_z) $

// ═══════════════════════════════════════════════════════════════════════════
= Standard Typst Features
// ═══════════════════════════════════════════════════════════════════════════

These are not part of the template — they work in any Typst document.

== Footnotes

Use `#footnote[...]` for asides that would interrupt the prose
flow.#footnote[Footnotes render at the bottom of the page with an automatic
counter. They support *bold*, _italic_, and `code` just like body text.]
A second footnote on the same page gets the next number automatically.#footnote[
  Typst resets the footnote counter per page by default.
]

== Smart Quotes and Special Characters

Typst converts `"double"` and `'single'` quotes automatically: "hello world"
and 'it works'. Dashes: en-dash -- and em-dash --- are also handled.
The ellipsis ... collapses to a single glyph.

== Horizontal Rule

A `#line` at full width works as a visual separator:

#v(0.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)

// ═══════════════════════════════════════════════════════════════════════════
= Bibliography
// ═══════════════════════════════════════════════════════════════════════════

Cite with `@key` anywhere in the text — Typst links the marker to the
reference list automatically. The style is set once on the `bibliography`
call and applies to every citation in the document.

This template uses Typst @typst for rendering. The Inter typeface @inter
was chosen for its excellent screen legibility at small sizes. Syntax
highlighting uses the Catppuccin palette @catppuccin. The Rob Pike quote
in the Block Quotes section is from @pike1989.

For multiple citations back-to-back, write them in sequence:
the classic algorithmic reference is @knuth1997.

// Primary format: Hayagriva (.yml) — Typst's native bibliography format.
// BibTeX (.bib) also works — just change the filename.
// Common styles: "ieee", "apa", "chicago-author-date", "mla"
#bibliography("refs.yml", style: "ieee")

]
