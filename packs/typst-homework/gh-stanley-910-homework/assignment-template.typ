// Assignment Template Library
// Import this file to use assignment formatting functions

// Document setup function
// This returns content with the set rules applied
#import "@preview/finite:0.5.0" as finite: automaton, transition-table

#import "@preview/cetz:0.3.4" as cetz      // ← same for cetz

#let setup-document(body) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.5in),
    header: align(right)[#context counter(page).display()],
    header-ascent: 1.0em,
  )

  set text(
    font: "Charter",
    size: 10pt,
  )

  set par(
    justify: true,
    leading: 0.5em,
    spacing: 1.0em,
  )
show raw.where(block: true): block.with(
    fill: luma(240),        // light gray background
    inset: 8pt,
    radius: 4pt,
    width: 100%
  )

  // Style for inline code (single backticks)
  show raw.where(block: false): box.with(
    fill: luma(240),        // light gray background
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  body
}

#let styled-automaton(..args) = {
  set text(font: "New Computer Modern Math", size: 9pt)
  automaton(..args)
}

#let styled-transition-table(..args) = {
  set text(font: "New Computer Modern Math", size: 9pt)
  transition-table(..args)
}

#let styled-pda(body) = {
  set text(font: "New Computer Modern Math", size: 9pt)
  cetz.canvas(body)
}


// Header function for assignment title and name
#let assignment-header(course: "", number: "", name: "", date: "") = {
  set par(spacing: 0.5em)
  align(center)[
    #text(size: 11pt, weight: "bold")[#course - Assignment #number]

    #text(size: 10pt)[#name]

    #text(size: 10pt)[#date]
  ]
  v(0em)
}

// Exercise function with automatic indentation
// The content after the problem description will be automatically indented
#let exercise(number: "", title: "", problem: [], solution: []) = {
  // Exercise header (not indented)
  [*Exercise #number:* #emph[#title]]

  // Only add problem block if there's content
  if problem != [] {

    // Problem description (not indented)
    // Using a block to allow display math and other block-level content
    block(
      width: 100%,
    )[
      #set par(first-line-indent: 0pt)
      #problem
    ]
  }

  // Add minimal spacing if no problem, normal spacing if there was a problem
  if problem == [] {
    v(0.3em)
  }

  // Solution (indented)
  // Using a block with left padding to create the indent effect
  block(
    inset: (left: 2em),
    width: 100%,
  )[
    #set par(first-line-indent: 0pt)
    #solution
  ]

  v(1em)
}

// Convenience function for inline math
#let m(content) = $#content$

// QED symbol at the end of a proof (right-aligned on new line)
#let qed = {
  v(0.5em)
  align(right)[$square$]
}

// Subpart function for multi-part problems
// Use within solution block to create subparts at base indentation
// label: the subpart label like "(a) (5 points)"
// description: optional problem description at base indent (can contain text, math, etc.)
// content: the actual solution content (will be indented)
#let subpart(label: "", description: [], content) = {
  // Negative margin to counteract solution block's indent
  block(
    inset: (left: -2em),
  )[
    #v(0.5em)

    // Label and description at base indentation
    #block[
      #set par(first-line-indent: 0pt)
      #text(weight: "bold")[#label] #description
    ]

    // Only add spacing if there's actual content
    #if content != [] {
      v(0.3em)

      // Content is indented again (back to solution level)
      block(
        inset: (left: 2em),
      )[
        #set par(first-line-indent: 0pt)
        #content
      ]
    }
  ]
}

// Nested subpart function for subparts within subparts
// Use this inside a subpart's content to create nested subparts with additional indentation
// label: the subpart label like "(i)" or "Part 1:"
// description: optional problem description (will be at current indent level)
// content: the actual solution content (will be indented further)
#let nested-subpart(label: "", description: [], content) = {
  // No negative margin - stays at current indentation level
  block[
    #v(0.5em)

    // Label and description at current indentation
    #block[
      #set par(first-line-indent: 0pt)
      #text(weight: "bold")[#label] #description
    ]

    // Only add spacing if there's actual content
    #if content != [] {
      v(0.3em)

      // Content is indented relative to current level
      block(
        inset: (left: 2em),
      )[
        #set par(first-line-indent: 0pt)
        #content
      ]
    }
  ]
}

// ════════════════════════════════════════════════════════════════════
//  rule() + grammar() — CFG Display Template      (Typst ≥ 0.11)
// ════════════════════════════════════════════════════════════════════
//
//  Two ways to pass a rule — both work together:
//
//    Plain array  (multi-line only, backward-compatible)
//      ($S$, $0S$, $1S$, $A$)
//
//    rule() helper  (unlocks single-line: option)
//      rule($S$, $0S$, $1S$, $A$, single-line: true)
//
// ════════════════════════════════════════════════════════════════════

// ── Companion helper ─────────────────────────────────────────────────
#let rule(lhs, ..rest, single-line: false) = (
  lhs:         lhs,
  alts:        rest.pos(),
  single-line: single-line,
)

// ── Main display function ─────────────────────────────────────────────
#let grammar(
  arrow:    $arrow.r$,
  row-gap:  0.50em,
  col-gap:  0.75em,
  rule-gap: 0.75em,
  ..rules,
) = {
  let as-math(x) = if type(x) == str { eval(x, mode: "math") } else { x }

  // Accept both plain arrays (old style) and rule() dicts (new style)
  let normalise(r) = if type(r) == dictionary { r } else {
    (lhs: r.at(0), alts: r.slice(1), single-line: false)
  }

  let cells     = ()
  let row-guts  = ()
  let all-rules = rules.pos().map(normalise)

  for (r, rule) in all-rules.enumerate() {
    let lhs       = as-math(rule.lhs)
    let alts      = rule.alts
    let sl        = rule.single-line
    let last-rule = (r == all-rules.len() - 1)

    if sl {
      // ── Single-line: join all alternatives as  alt₁ | alt₂ | …
      let parts = ()
      for (i, alt) in alts.enumerate() {
        if i > 0 { parts.push([#h(0.4em)$|$#h(0.4em)]) }
        parts.push(alt)
      }
      cells += (lhs, arrow, parts.join())
      if not last-rule { row-guts.push(rule-gap) }

    } else {
      // ── Multi-line: one row per alternative
      for (i, alt) in alts.enumerate() {
        cells += (
          if i == 0 { lhs }   else { [] },
          if i == 0 { arrow } else { $|$ },
          alt,
        )
        let last-alt = (i == alts.len() - 1)
        if not (last-rule and last-alt) {
          row-guts.push(if last-alt { rule-gap } else { row-gap })
        }
      }
    }
  }

  grid(
    columns: 3,
    align:         (right + horizon, center + horizon, left + horizon),
    column-gutter: col-gap,
    row-gutter:    row-guts,
    ..cells,
  )
}
