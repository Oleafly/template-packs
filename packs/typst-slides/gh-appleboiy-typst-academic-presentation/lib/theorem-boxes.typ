// LaTeX-style theorem boxes for academic presentations

// Academic algorithm box with Computer Modern font
//
// Two calling conventions:
//   1. Content-body (old, backward-compatible):
//        #paper-algorithm(name: "...", inputs: [...], outputs: [...])[
//          + Step 1
//          + Step 2
//        ]
//      Add `count: N` to enable auto multi-column when N > 10.
//
//   2. Steps-array (new, enables automatic multi-column):
//        #paper-algorithm(name: "...", steps: ([Step 1], [Step 2], ...))
//      Column count and font size are derived from steps.len() automatically.
//
// Column rules:   ≤ 10 steps → 1 col (0.95em)
//                 ≤ 20 steps → 2 col (0.88em)
//                 > 20 steps → 3 col (0.80em)
#let paper-algorithm(
  title: "Algorithm",
  name: none,
  inputs: none,
  outputs: none,
  steps: none,  // array of content items — enables auto multi-column
  count: none,  // manual step-count hint for content-body mode
  ..body-args   // captures optional trailing [body] block
) = {
  let body = if body-args.pos().len() > 0 { body-args.pos().at(0) } else { none }

  // Effective step count used for all layout decisions
  let n = if steps != none { steps.len() }
          else if count != none { count }
          else { 0 }

  // Auto-select column count based on step count
  let cols = if n <= 10 { 1 } else if n <= 20 { 2 } else { 3 }

  // Font sizes proportionally scaled for column density
  let font-size = if cols == 1 { 0.95em } else if cols == 2 { 0.88em } else { 0.80em }

  block(
    width: 100%,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black),
    inset: (y: 8pt),
    {
      // ── Header ────────────────────────────────────────────────────────────
      text(font: "New Computer Modern", weight: "bold")[#title]
      if name != none [
        #text(font: "New Computer Modern", style: "italic")[ (#name)]
      ]
      v(4pt)
      line(length: 100%, stroke: 0.5pt + black)
      v(4pt)

      // ── I/O Definitions ───────────────────────────────────────────────────
      if inputs != none [
        #text(font: "New Computer Modern")[*Require:* #inputs]
        #linebreak()
      ]
      if outputs != none [
        #text(font: "New Computer Modern")[*Ensure:* #outputs]
        #linebreak()
      ]
      if inputs != none or outputs != none [
        #v(4pt)
      ]

      // ── Algorithm Body ────────────────────────────────────────────────────
      if steps != none {
        // Array-based: precise equal-distribution across columns
        let per-col = calc.ceil(n / cols)
        if cols == 1 {
          text(font: "New Computer Modern", size: font-size)[
            #enum(numbering: "1.", indent: 1em, ..steps)
          ]
        } else {
          grid(
            columns: range(cols).map(_ => 1fr),
            column-gutter: 14pt,
            ..range(cols).map(c => {
              let start = c * per-col
              let end   = calc.min(start + per-col, n)
              text(font: "New Computer Modern", size: font-size)[
                #enum(
                  start:     start + 1,
                  numbering: "1.",
                  indent:    0.8em,
                  ..steps.slice(start, end)
                )
              ]
            })
          )
        }
      } else if body != none {
        // Content-body mode (backward-compatible)
        if cols == 1 {
          set enum(numbering: "1.", indent: 1em)
          text(font: "New Computer Modern", size: font-size)[#body]
        } else {
          // Natural-flow multi-column; numbering continues across columns
          set enum(numbering: "1.", indent: 0.8em)
          text(font: "New Computer Modern", size: font-size)[
            #columns(cols, gutter: 14pt, body)
          ]
        }
      }
    }
  )
}

// Academic theorem box with Computer Modern font
#let paper-theorem(title: "Theorem", name: none, body) = {
  block(
    width: 100%,
    fill: luma(250), // Classic LaTeX theorem background
    stroke: 0.8pt + black, // Sharp academic boundary
    radius: 0pt,
    inset: 10pt, // Reduced from 12pt
    {
      // Formal Title (e.g., THEOREM 1 (Time Complexity))
      text(font: "New Computer Modern", weight: "bold")[#upper(title)]
      if name != none [
        #text(font: "New Computer Modern", style: "italic")[ (#name)]
      ]
      [.]
      v(4pt)

      // Theorems are traditionally italicized in LaTeX
      text(font: "New Computer Modern", style: "italic", size: 0.95em)[#body]
    }
  )
}

// Academic proof box with Computer Modern font
#let paper-proof(body, title: "Proof") = {
  block(
    width: 100%,
    stroke: (left: 1.2pt + black), // Strong left rule to visually group the proof
    inset: (left: 10pt, top: 4pt, bottom: 4pt), // Reduced left padding
    {
      // Standard italicized proof heading
      text(font: "New Computer Modern", style: "italic", weight: "bold")[#title.]
      [ ]

      // The body of the proof
      text(font: "New Computer Modern", size: 0.95em)[#body]

      // Automatically pushes the Q.E.D. symbol to the far right of the last line
      h(1fr)
      sym.square.filled
    }
  )
}


#let definition(title: none, body) = {
  block(
    fill: white,
    inset: 10pt,
    radius: 0pt,
    stroke: 1pt + black,
  )[
    #text(weight: "bold")[Definition#if title != none [ (#title)].]
    #body
  ]
}

#let example(title: none, body) = {
  block(
    fill: rgb("#f8f8f8"),
    inset: 10pt,
    radius: 0pt,
    stroke: 0.5pt + black,
  )[
    #text(weight: "bold")[Example#if title != none [ (#title)].]
    #body
  ]
}

#let lemma(title: none, body) = {
  block(
    fill: white,
    inset: 10pt,
    radius: 0pt,
    stroke: 1pt + gray,
  )[
    #text(weight: "bold")[Lemma#if title != none [ (#title)].]
    #body
  ]
}

#let corollary(body) = {
  block(
    fill: rgb("#fafafa"),
    inset: 10pt,
    radius: 0pt,
    stroke: 0.5pt + gray,
  )[
    #text(weight: "bold")[Corollary.]
    #body
  ]
}

#let remark(body) = {
  block(
    fill: rgb("#f8f8f8"),
    inset: 10pt,
    radius: 0pt,
    stroke: 0.5pt + black,
  )[
    #text(weight: "bold")[Remark.]
    #body
  ]
}

#let note(body) = {
  block(
    fill: white,
    inset: 10pt,
    radius: 0pt,
    stroke: 1pt + black,
  )[
    #text(weight: "bold")[Note.]
    #body
  ]
}

#let important(body) = {
  block(
    fill: white,
    inset: 10pt,
    radius: 0pt,
    stroke: 2pt + black,
  )[
    #text(weight: "bold")[Important.]
    #body
  ]
}

#let assumption(body) = {
  block(
    fill: rgb("#fafafa"),
    inset: 10pt,
    radius: 0pt,
    stroke: 0.5pt + gray,
  )[
    #text(weight: "bold")[Assumption.]
    #body
  ]
}

#let quote-block(body, author: none) = {
  block(
    fill: white,
    inset: 10pt,
    radius: 0pt,
    stroke: (left: 3pt + gray),
  )[
    #text(style: "italic")[#body]
    #if author != none [
      #v(0.5em)
      #align(right)[— #author]
    ]
  ]
}
