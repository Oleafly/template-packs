// ============================================================================
// Front matter (UCSD formatting manual §III, PhD non-joint).
//
// Public builders take a plain `meta` dict (see plan / spec) and are pure
// functions of their inputs — NO global state.  Composed in a document as
// inline calls AFTER P1's #front-matter():
//   #show: dissertation
//   #front-matter()
//   #title-page(meta) ... #abstract(meta)[...]
//   #main-matter()
// This module does NOT edit dissertation(); it layers on top.
// ============================================================================

#import "blocks.typ": single-spaced

// ── Helpers ──────────────────────────────────────────────────────────────────
// (_-prefixed functions are private; prelim-heading and register-toc are public
// API consumed by lib/lists.typ.)

// Centered, regular-weight, all-caps section heading at the body size (12pt).
// NOT a `heading` element: floats-rules (P3) renders front-matter level-1
// headings plainly (default bold/left), which would fight this styling.  The
// title-page top line and the abstract heading both use this, so they match.
#let prelim-heading(title) = {
  set par(first-line-indent: 0pt)
  align(center, text(weight: "regular", style: "normal", upper(title)))
}

// <ucsd-toc-entry> contract: front-matter pages that appear in the TABLE OF
// CONTENTS emit this metadata carrying their Title-Case title (distinct from the
// all-caps page heading). lib/lists.typ queries it cross-module by label — no
// import, exactly like the state("ucsd-matter") contract. Title page & copyright
// page deliberately register nothing (they are counted i/ii but never listed).
#let register-toc(title) = [#metadata((title: title)) <ucsd-toc-entry>]

// "Professor <name>".
#let _professor(name) = [Professor #name]

// Title-page committee block: chair, co-chair (if any), then members in the
// author-given order; left-justified label, members indented 0.5in,
// single-spaced. Manual: double space between the label and the chair.
#let _committee-block(committee) = {
  assert(committee.chair != none, message: "committee.chair is required")
  let lines = ([#_professor(committee.chair), Chair],)
  if committee.co-chair != none {
    lines.push([#_professor(committee.co-chair), Co-Chair])
  }
  for m in committee.members {
    lines.push([#_professor(m)])
  }
  align(left, single-spaced[
    Committee in charge:
    #v(1em)
    #pad(left: 0.5in, lines.join(linebreak()))
  ])
}

// ── Public builders ──────────────────────────────────────────────────────────

// Title page — counted i, footer NOT displayed. Sample p.13. The v() gaps below
// are a tuned starting point; adjust against the sample in this task's Step 6.
#let title-page(meta) = page(footer: none)[
  #set par(first-line-indent: 0pt)
  #set align(center)
  #prelim-heading("University of California San Diego")
  #v(0.25in)
  #meta.title
  #v(0.3in)
  A dissertation submitted in partial satisfaction of the \
  requirements for the degree #meta.degree
  #v(0.5in)
  in
  #v(0.3in)
  #meta.degree-field
  #v(0.35in)
  by
  #v(0.3in)
  #meta.author
  #v(0.4in)
  #_committee-block(meta.committee)
  #v(1fr)
  #meta.year
]

// Copyright page — counted ii, footer NOT displayed. Centered just above the
// bottom margin. Sample p.17. Optional notice; if declined, use blank-page()
// instead (page ii must still exist — manual p.16).
// <ucsd-copyright-page-end> anchors the page-ii counter check in tests without
// depending on the floating position of a #context block in the main flow.
#let copyright-page(meta) = page(footer: none)[
  #set par(first-line-indent: 0pt)
  #set align(center)
  #v(1fr)
  #single-spaced[
    Copyright

    #meta.author, #meta.year \
    All rights reserved.
  ]
  #[] <ucsd-copyright-page-end>
]

// Empty counted page for the declined-copyright case (page ii, no footer).
#let blank-page() = page(footer: none)[]

// Generic single-section preliminary page: a centered heading then the body.
// Body inherits P0's double-spaced, 0.5in-first-line-indent defaults (required
// for acknowledgements; harmless for the "any format" dedication/epigraph).
#let _section-page(title, body) = {
  pagebreak(weak: true)
  register-toc(title)
  prelim-heading(title)
  v(2em)
  body
}

#let dedication(body) = _section-page("Dedication", body)
#let epigraph(body) = _section-page("Epigraph", body)
#let preface(body) = _section-page("Preface", body)
#let acknowledgements(body) = _section-page("Acknowledgements", body)

// Approval page — first DISPLAYED roman number (iii). No section heading. The
// approval statement is left-justified at the top; the university + year are
// centered below; the whole block is centered vertically. No signature lines
// (non-joint — signatures are collected on the Final Report Form). Sample p.19.
// The fractional spacers are a tuned starting point; adjust against the sample.
// Plain flow page — inherits the state-driven roman footer from dissertation().
#let approval-page(meta) = {
  pagebreak(weak: true)
  register-toc("Dissertation/Thesis Approval Page")
  set par(first-line-indent: 0pt)
  v(1fr)
  align(left)[
    The dissertation of #meta.author is approved, and it is acceptable in quality
    and form for publication on microfilm and electronically.
  ]
  v(3fr)
  align(center, single-spaced[
    University of California San Diego \
    #meta.year
  ])
  v(2fr)
}

// Abstract chair line(s): chair, then co-chair if present. Shared shape with the
// committee block but centered and without the members (manual abstract sample p.33).
#let _chair-line(committee) = {
  assert(committee.chair != none, message: "committee.chair is required")
  let lines = ([#_professor(committee.chair), Chair],)
  if committee.co-chair != none {
    lines.push([#_professor(committee.co-chair), Co-Chair])
  }
  align(center, lines.join(linebreak()))
}

// Abstract — heading + structured header + double-spaced body. Sample p.33.
// The 2.5in top margin is achieved on the FIRST page only via a v(1.5in) spacer
// above the inherited 1in margin (continuation pages stay at 1in). The header is
// centered with first-line-indent reset; the body keeps the inherited
// double-spaced 0.5in-indent defaults.
#let abstract(meta, body) = {
  pagebreak(weak: true)
  register-toc("Abstract of the Dissertation")
  v(1.5in) // 1in margin + 1.5in = 2.5in top margin on the abstract's first page
  prelim-heading("Abstract of the Dissertation")
  {
    set par(first-line-indent: 0pt)
    align(center)[
      #v(0.5in)
      #meta.title
      #v(0.4in)
      by
      #v(0.3in)
      #meta.author
      #v(0.4in)
      #meta.degree in #meta.degree-field
      #v(0.4in)
      University of California San Diego, #meta.year
      #v(0.4in)
      #_chair-line(meta.committee)
    ]
  }
  v(0.5in)
  body
}

// Vita (required, doctoral). Sample p.31. Year-column entries as a 2-col grid
// (single-spaced); optional PUBLICATIONS / FIELDS OF STUDY sections. Author uses
// "Master" not "Masters" in degree titles (manual note).
#let vita(entries: (), publications: none, fields: none) = {
  pagebreak(weak: true)
  register-toc("Vita")
  prelim-heading("Vita")
  v(2em)
  single-spaced(grid(
    columns: (auto, 1fr),
    column-gutter: 0.5in,
    row-gutter: 1em,
    ..entries.map(e => (e.year, e.body)).flatten(),
  ))
  if publications != none {
    v(2em)
    prelim-heading("Publications")
    v(1em)
    single-spaced(publications)
  }
  if fields != none {
    v(2em)
    prelim-heading("Fields of Study")
    v(1em)
    single-spaced(fields)
  }
}
