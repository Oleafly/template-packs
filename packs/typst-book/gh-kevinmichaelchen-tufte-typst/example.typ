// Example document using tufte-thesis template
// Compile with: typst compile example.typ

#import "tufte-thesis.typ": *

#show: tufte-thesis.with(
  title: "Example Document",
  subtitle: "A Demonstration of the Tufte-Thesis Template",
  author: "Your Name",
  date: "January 2026",
  abstract: [
    This document demonstrates the features of the tufte-thesis template for Typst.
    It includes sidenotes, margin quotes, tables, code blocks, and the characteristic
    wide right margin inspired by Edward Tufte's book designs.
  ],
)

// Table of Contents
#outline(title: [Contents], indent: auto, depth: 2)
#pagebreak()

// =============================================================================
// PART I
// =============================================================================

#part-page(1, "Getting Started")

= Introduction

#margin-quote(
  [The purpose of visualization is insight, not pictures.],
  attribution: [Ben Shneiderman],
)

This template provides a Tufte-inspired layout with a wide right margin for sidenotes and margin quotes. The design emphasizes readability and allows supplementary information to live alongside the main text without interrupting the flow.

== Sidenotes

Sidenotes are numbered annotations that appear in the right margin.#sidenote[This is a sidenote. It provides additional context without breaking the reading flow of the main text.]

You can use sidenotes for:
- Citations and references
- Clarifying technical terms
- Providing examples
- Adding commentary

Here's another paragraph with a sidenote to show how they stack.#sidenote[Sidenotes are positioned dynamically based on where they appear in the text. The template handles the positioning automatically.]

== Margin Quotes

#margin-quote[Design is not just what it looks like. Design is how it works.]

Margin quotes are useful for epigraphs, pull quotes, or highlighting key ideas. They appear in italic in the right margin.

= Tables

The template includes a `classic-table` helper for Tufte-style tables with minimal borders:

#classic-table(
  columns: (1fr, 2fr, 1fr),
  header: ([Feature], [Description], [Status]),
  [Sidenotes],
  [Numbered margin annotations],
  [Done],
  [Margin quotes],
  [Italic quotes in margin],
  [Done],
  [Tables],
  [Borderless Tufte-style],
  [Done],
  [Code blocks],
  [Syntax highlighted],
  [Done],
)

= Code Blocks

Code blocks use a light gray background and smaller font to fit more content:

```python
def hello_world():
    """A simple example function."""
    print("Hello, Tufte!")
    return 42

# Call the function
result = hello_world()
```

Inline code like `variable_name` or `function()` is also styled with a subtle background.

= Lists

Bullet lists use maroon markers:

- First item with some text
- Second item with more text
- Third item to round things out

Numbered lists work as expected:

+ First step
+ Second step
+ Third step

#hrule()

= Epigraphs

Use the `epigraph` function for chapter-opening quotes:

#epigraph(
  [Simplicity is prerequisite for reliability.],
  [Edsger Dijkstra],
)

This creates a block-style quote suitable for opening a section or chapter.

// =============================================================================
// PART II
// =============================================================================

#part-page(2, "Advanced Features")

= Chapter Headings

For large chapter numbers (like in a thesis), use the `chapter-heading` function:

#chapter-heading(1, "Sample Chapter")

This creates a decorative chapter opener with a large number and horizontal rule.

= Dedication and Colophon

The template includes helpers for front and back matter:

- `dedication(body)` - centered italic text for dedications
- `colophon(body)` - end-of-document production notes
- `epigraph-page(quote, attribution)` - full-page epigraph

= Typography Summary

The template uses these specifications:

#classic-table(
  columns: (1.5fr, 2fr),
  header: ([Element], [Specification]),
  [Body font],
  [New Computer Modern, 10pt],
  [Line spacing],
  [0.65em],
  [Page size],
  [US Letter (8.5" × 11")],
  [Left margin],
  [1 inch],
  [Right margin],
  [3 inches (for sidenotes)],
  [Sidenote width],
  [1.6 inches],
)

#v(2em)
#hrule()

#align(center)[
  #text(size: 9pt, fill: thesis-gray)[
    _Example Document_ · Created with tufte-thesis for Typst
  ]
]
