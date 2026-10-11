// r2 — Academic paper and slides template
//
// Usage (paper):
//   #import "@local/r2:0.1.0": paper, nneq, caption-note, caption-with-note,
//     table-note, theorem, proof, prop, lem, asp
//
// Usage (slides):
//   #import "@local/r2:0.1.0": slides-style, title-slide
//   #import "@preview/polylux:0.4.0": *

#import "@preview/ctheorems:1.1.3": *

// ---------------------------------------------------------------------------
// Design tokens — edit these to change the look everywhere
// ---------------------------------------------------------------------------

#let default-style = (
  // Page
  page_margin: (x: 1.2in, y: 1.2in),
  page_numbering: "1",

  // Typography
  body_font: "New Computer Modern",
  body_size: 11pt,
  body_color: black,
  body_top_edge: 0.7em,
  body_bottom_edge: -0.3em,
  paragraph_leading: 1em,
  paragraph_indent: 1.8em,

  // Headings
  heading_numbering: "1.",
  heading_size: 1em,
  heading_weight: "bold",
  heading_color: black,
  heading_level1_size: 0.9em,

  // Title block
  title_size: 1.4em,
  subtitle_size: 1em,
  title_leading: 0.5em,

  // Abstract
  abstract_size: 0.9em,
  abstract_leading: 0.4em,

  // Tables and figures
  table_text_size: 0.8em,
  table_leading: 0.65em,
  table_top_edge: 0.35em,
  table_bottom_edge: -0.3em,
  block_above: 1.5em,
  block_below: 1.5em,

  // Footnotes
  footnote_numbering: "[1]",

  // Colors
  accent_main: rgb(0, 0, 100),
  accent_link: rgb(0, 0, 100),
  accent_ref: rgb(0, 0, 100),
  accent_cite: rgb(0, 0, 100),
  accent_footnote: rgb(0, 0, 100),
)

// ---------------------------------------------------------------------------
// Utilities
// ---------------------------------------------------------------------------

/// Unnumbered display equation.
#let nneq(eq) = math.equation(block: true, numbering: none, eq)

/// Figure caption with a note underneath.
#let caption-note(body) = align(left)[
  #pad(x: 2em, y: 0em)[
    #par(leading: 0.2em)[
      #text(size: 0.9em)[*Note:* #body]
    ]
  ]
]

/// Caption title + note combined.
#let caption-with-note(title, note) = [#title #caption-note(note)]

/// Italic note below a table.
#let table-note(body) = align(left)[
  #text(size: 0.9em)[#emph(body)]
]

// ---------------------------------------------------------------------------
// Theorem environments
// ---------------------------------------------------------------------------

#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem")
#let proof = thmproof(
  "proof", "Proof",
  inset: (x: 2em, y: .5em),
  titlefmt: smallcaps,
  bodyfmt: body => [#body],
)

#let prop = thmbox(
  "prop", "Proposition",
  inset: (x: 2em, y: .5em),
  base_level: 0, base: "prop",
  titlefmt: smallcaps,
  bodyfmt: body => [#body],
).with(numbering: "1")

#let lem = thmbox(
  "lem", "Lemma",
  inset: (x: 2em, y: .5em),
  base_level: 0, base: "lem",
  titlefmt: smallcaps,
  bodyfmt: body => [#body],
).with(numbering: "1")

#let asp = thmbox(
  "asp", "Assumption",
  inset: (x: 2em, y: .5em),
  base_level: 0, base: "asp",
  titlefmt: smallcaps,
  bodyfmt: body => [#body],
).with(numbering: "1")

// ---------------------------------------------------------------------------
// Paper layout
// ---------------------------------------------------------------------------

/// Format a manuscript. Pass `style: (key: value)` to override design tokens.
#let paper(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  abstract: none,
  style: none,
  doc,
) = {
  let s = if style == none { default-style } else { default-style + style }

  set page(margin: s.page_margin, numbering: s.page_numbering)
  set par(leading: s.paragraph_leading, first-line-indent: s.paragraph_indent, justify: true)
  set text(font: s.body_font, size: s.body_size, fill: s.body_color,
           top-edge: s.body_top_edge, bottom-edge: s.body_bottom_edge)

  set math.equation(numbering: "(1)")
  set table(align: (x, _) => if x == 0 { left } else { center })
  set figure(numbering: "1", placement: auto)

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      numbering(el.numbering, ..counter(eq).at(el.location()))
    } else { it }
  }

  set quote(block: true)
  set heading(numbering: s.heading_numbering)
  show heading: set block(above: 2em, below: 1em)
  show heading: set par(leading: 0.3em)
  show heading: set text(size: s.heading_size, weight: s.heading_weight, fill: s.heading_color)
  show heading: it => {
    if it.level == 1 { smallcaps(align(center, text(size: s.heading_level1_size, it))) }
    else { it }
  }

  set enum(indent: 1.8em)
  show enum: set block(above: 1em, below: 1em)

  show table: set text(size: s.table_text_size)
  show table: set par(leading: s.table_leading)
  show table: set text(top-edge: s.table_top_edge, bottom-edge: s.table_bottom_edge)
  set block(above: s.block_above, below: s.block_below)
  show figure.where(kind: table): set block(below: 0em)
  show figure.where(kind: image): set align(center)
  show table: set align(center)
  show figure.where(kind: table): set align(center)
  show figure.where(kind: "thmenv"): set block(above: s.block_above, below: s.block_below)
  show figure.where(kind: "thmenv"): it => {
    show math.equation.where(block: true): set block(above: s.block_above, below: s.block_below)
    align(left, it.body)
  }

  show link: set text(s.accent_link)
  show ref: set text(s.accent_ref)
  show cite: set text(s.accent_cite)
  show footnote: set text(s.accent_footnote)
  show footnote: set text(weight: "bold")
  set footnote(numbering: s.footnote_numbering)

  // Title block
  v(6em)
  set align(center)
  par(leading: s.title_leading)[
    #text(size: s.title_size)[#title]
    #if subtitle != none {
      linebreak()
      text(size: s.subtitle_size)[#subtitle]
    }
  ]

  let count = authors.len()
  if count > 0 {
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 24pt,
      ..authors.map(a => [
        #text(a.name)
        #if "affiliation" in a and a.affiliation != none { linebreak(); text(size: 0.9em)[#a.affiliation] }
      ]),
    )
  }

  if date != none { text(date) }

  set align(left)
  if abstract != none {
    pad(x: 2.5em,
      par(leading: s.abstract_leading,
        text(size: s.abstract_size, [#smallcaps("Abstract.") #abstract])))
  }

  doc
}

// ---------------------------------------------------------------------------
// Slides layout
// ---------------------------------------------------------------------------

/// Auto-spaced one-by-one: adds vertical gap between revealed items.
/// Re-export this to shadow polylux's default `one-by-one`.
#let one-by-one(start: 1, ..items) = {
  import "@preview/polylux:0.4.0": one-by-one as _one-by-one
  let section-gap = 0.4em
  let pos = items.pos()
  let spaced = pos.enumerate().map(((i, item)) => {
    if i == 0 { item } else { v(section-gap) + item }
  })
  _one-by-one(start: start, ..spaced)
}

/// Apply slides styling. Use with `#show: slides-style`.
#let slides-style(doc) = {
  set page(paper: "presentation-4-3", margin: (top: 3em, rest: 3em))
  set text(size: 22pt, font: "PT Sans")
  set par(spacing: 1.5em)

  show heading: it => { set align(center); set text(size: 0.75em); it }
  set list(marker: ([•], [‣], [–]), indent: 1em)
  show list: set par(leading: .8em, spacing: 1.7em)
  set bibliography(style: "american-political-science-association")
  show bibliography: set par(first-line-indent: 0em)
  show cite: set text(size: .8em, rgb(169,169,169))

  doc
}

/// Title slide for presentations.
#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  affiliation: none,
  date: none,
) = {
  import "@preview/polylux:0.4.0": slide
  slide[
    #set align(center + horizon)
    #set par(spacing: 0.8em)
    #text(size: 1.2em, weight: "bold")[#title] #v(.1em)
    #if subtitle != none { text(size: .9em)[#subtitle] }
    #v(1em)
    #if author != none { text(size: 1em)[#author] }
    #if affiliation != none { linebreak(); text(size: .8em, fill: rgb(100,100,100))[#affiliation] }
    #if date != none { v(.5em); text(size: .75em, fill: rgb(130,130,130))[#date] }
  ]
}
