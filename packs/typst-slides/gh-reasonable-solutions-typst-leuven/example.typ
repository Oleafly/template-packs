#import "leuven.typ": *

#show: init.with(
  title:    "Leuven Typst Theme",
  subtitle: "A presentation theme inspired by the Leuven Emacs color theme",
  author:   "Carl Hedgren",
  date:     "2026-04-09",
)

#title-slide()

// ── Section 1 ────────────────────────────────────────────────────────────────

#section-slide(sub: "What is the Leuven theme?")[Introduction]

#slide(title: "About the Leuven Theme")[
  The *Leuven* theme is a light Emacs color theme with a clean, readable palette.

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.4em,
    [#box(fill: rgb("#335EA8"), width: 1em, height: 0.8em, baseline: -10%) `leuven-blue`    — primary, headers],
    [#box(fill: rgb("#123555"), width: 1em, height: 0.8em, baseline: -10%) `leuven-navy`    — headings, code bar],
    [#box(fill: rgb("#85CEEB"), width: 1em, height: 0.8em, baseline: -10%) `leuven-sky`     — accent, footer text],
    [#box(fill: rgb("#E5F4FB"), width: 1em, height: 0.8em, baseline: -10%) `leuven-ice`     — highlight bg],
    [#box(fill: rgb("#005522"), width: 1em, height: 0.8em, baseline: -10%) `leuven-green`   — secondary accent],
    [#box(fill: rgb("#EA6300"), width: 1em, height: 0.8em, baseline: -10%) `leuven-orange`  — alerts, warnings],
    [#box(fill: rgb("#333333"), width: 1em, height: 0.8em, baseline: -10%) `leuven-text`    — body text],
    [#box(fill: rgb("#8D8D84"), width: 1em, height: 0.8em, baseline: -10%) `leuven-muted`   — comments, secondary],
  )
]

// ── Section 2 ────────────────────────────────────────────────────────────────

#section-slide[Slide Types]

#slide(title: "Content Blocks")[
  #highlight-block[
    *Highlight block* — uses the ice-blue background with a blue left border.
    Great for definitions or key points.
  ]

  #v(0.8em)

  #success-block[
    *Success block* — uses the green accent.
    Use for positive outcomes, confirmations, or good news.
  ]

  #v(0.5em)

  #alert-block[
    *Alert block* — uses the warm orange accent.
    Use for warnings, caveats, or important notes.
  ]
]

#slide2(
  title: "Two-Column Layout",
  [
    *Left column*

    #leuven-list(
      [First item],
      [Second item],
      [Third item],
    )
  ],
  [
    *Right column*

    #leuven-list(
      [Alpha],
      [Beta],
      [Gamma],
    )
  ],
)

// ── Section 3 ────────────────────────────────────────────────────────────────

#section-slide[Code Blocks]

#code-slide(title: "Python Example", lang: "python",
```
def fibonacci(n):
    """Return the nth Fibonacci number."""
    if n <= 1:
        return n
    a, b = 0, 1
    for _ in range(n - 1):
        a, b = b, a + b
    return b

print([fibonacci(i) for i in range(10)])
```.text)

#slide(title: "Inline Code Block")[
  Use `code-block` inside any slide for finer control:

  #v(0.5em)

  #code-block(lang: "nix",
```
{
  description = "Leuven Typst presentation theme";
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = /* ... */;
  };
}
```.text)
]

// ── Section 4 ────────────────────────────────────────────────────────────────

// ── Section 5 ────────────────────────────────────────────────────────────────

#section-slide[Thank You]

#slide(title: "Summary")[
  #leuven-list(
    [Clean 16:9 slides],
    [Title, section, and content slide types],
    [Two-column layout],
    [Highlight and alert blocks],
    [Colors drawn directly from `leuven-theme.el`],
  )
]
