// /template/core/formatting.typ
// Show rules for headings, code blocks, tables, and general formatting
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Extracted from the monolithic lib.typ. Each function takes the
// resolved configuration so rules adapt to class + output mode.

#import "fonts.typ": *
#import "colors.typ": *

// MARK: Heading Rules

/// Applies heading show rules for the preamble/front-matter section.
/// Headings are unnumbered, with a bottom rule.
///
/// - config (dictionary): Resolved document configuration
/// -> content
#let apply-preamble-heading-rules(config, body) = {
  set heading(numbering: "1.")
  show heading: set block(below: 1.2em)

  show heading.where(level: 1): it => [
    #set align(left)
    #set text(font: heading-font, size: 20pt, weight: "regular")
    #block(
      width: 100%,
      stroke: (bottom: 0.5pt + clr-heading-rule),
      inset: (bottom: 0.5em),
      below: 0.8em,
    )[
      #smallcaps[#it.body]
    ]
  ]

  body
}

/// Applies chapter heading show rules for the main content section.
/// Style varies by document class.
///
/// - config (dictionary): Resolved document configuration
/// - labels (dictionary): i18n labels
/// -> content
#let apply-chapter-heading-rules(config, labels, body) = {
  show heading.where(level: 1): it => {
    // Auto pagebreak before each chapter (unless article class)
    if config.chapter-pagebreak {
      pagebreak()
    }

    if config.doc-class == "article" or config.doc-class == "report" {
      // Article / Report: simple underlined heading
      align(left)[
        #set text(
          font: heading-font,
          size: 20pt,
          weight: "regular",
        )
        #block(
          width: 100%,
          stroke: (bottom: 0.5pt + clr-heading-rule),
          inset: (bottom: 0.5em),
        )[
          #smallcaps[#it.body]
        ]
      ]
    } else {
      // Book / Thesis: "CHAPTER X" + title + horizontal rule
      align(left)[
        #stack(
          dir: ttb,
          spacing: 2em,
          text(
            font: heading-font,
            size: 18pt,
            weight: "regular",
            fill: clr-heading-rule,
          )[#if it.numbering != none [#labels.chapter-prefix #counter(heading).display(it.numbering)]],
          text(
            font: heading-font,
            size: 30pt,
            weight: "regular",
          )[#smallcaps[#it.body]],
          line(length: 100%, stroke: 1pt + clr-heading-rule),
        )
      ]
    }

    // Vertical space after heading
    v(0.5em)
  }

  body
}

// MARK: Code Block Rules

/// Applies show rules for inline and block code.
///
/// -> content
#let apply-code-rules(body) = {
  // Inline code: light gray box
  show raw.where(block: false): box.with(
    fill: clr-code-bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Block code: rounded box with line numbers
  show raw.where(block: true): it => align(start)[
    #block(
      radius: 8pt,
      fill: clr-code-bg,
      inset: 0pt,
      stroke: none,
      width: 100%,
      clip: true,
      breakable: true,
    )[
      #text(font: code-font, size: 1em)[
        #grid(
          columns: (auto, 1fr),
          inset: (x, y) => {
            let v = 1em
            let inner = 0.5em
            let outer = 1.5em
            if x == 0 { (top: v, bottom: v, left: outer, right: inner) } else {
              (top: v, bottom: v, left: inner, right: outer)
            }
          },
          stroke: (x, y) => if x == 0 { (right: 0.5pt + clr-code-line) } else { none },
          align: (right, left),
          // Line number column
          align(right, text(fill: gray)[
            #for i in range(1, it.text.split("\n").len() + 1) [ #i \ ]
          ]),
          // Code content column
          it,
        )
      ]
    ]
  ]

  // Cho phép code block trong #figure trải dài trên nhiều trang
  show figure.where(kind: raw): set block(breakable: true)

  body
}

// MARK: Table Rules

/// Applies show rules for tables.
/// Accent color adapts to output profile.
///
/// - accent (color): Accent color from output profile
/// -> content
#let apply-table-rules(accent, body) = {
  // Disable justified text in tables
  show table: set par(justify: false)
  // Slightly smaller text inside tables to save space
  show table: set text(size: 0.9em)

  set table(
    // Header row gets a slightly darker border than body rows
    stroke: (x, y) => if y == 0 {
      0.5pt + accent.lighten(86%)
    } else {
      0.5pt + accent.lighten(90%)
    },
    fill: (x, y) => if y == 0 {
      accent.lighten(90%)
    } else if calc.even(y) {
      accent.lighten(98%)
    } else {
      none
    },
  )

  // Rounded table wrapper — breakable: true allows spanning multiple pages.
  // Typst 0.14+ supports clip: true and breakable: true simultaneously.
  show table: it => block(
    radius: 8pt,
    stroke: 1pt + accent.lighten(90%),
    clip: true,
    breakable: true,
    width: 100%,
    inset: 0pt,
    it,
  )

  // Cho phép table trong #figure trải dài trên nhiều trang
  show figure.where(kind: table): set block(breakable: true)

  body
}

// MARK: General Formatting Rules

/// Applies show rules for emphasis, strong, links, lists, quotes, TODOs.
///
/// - profile (dictionary): Output profile (from output-profiles.typ)
/// -> content
#let apply-general-rules(profile, body) = {
  // Emphasis & Strong
  show emph: it => text(style: "italic", weight: "medium")[#it.body]
  show strong: it => text(weight: "bold")[#it.body]

  // Links: color from output profile
  show link: set text(fill: profile.link-color)

  // Citations: color from output profile
  show cite: set text(style: "italic", fill: profile.cite-color)

  // Lists
  set list(indent: 1em)
  set enum(indent: 1em)

  // Callout blocks alignment
  show block.where(fill: rgb("#f0f8ff")): it => align(left, it)

  // Block quotes — left-aligned, orange left border
  show quote: it => block(
    fill: clr-quote-bg,
    stroke: (left: 3pt + orange.lighten(50%)),
    inset: (left: 1em, rest: 0.8em),
    radius: (right: 3pt),
  )[
    #set text(style: "italic")
    #it
  ]

  // TODOs: render body directly (no figure frame)
  show figure.where(kind: "todo"): it => it.body

  body
}

// MARK: Figure Supplement Rules

/// Sets localized supplement names for figures.
///
/// - labels (dictionary): i18n labels
/// -> content
#let apply-figure-supplements(labels, body) = {
  show figure.where(kind: raw): set figure(supplement: labels.figure-code)
  show figure.where(kind: image): set figure(supplement: labels.figure-image)
  show figure.where(kind: table): set figure(supplement: labels.figure-table)

  body
}
