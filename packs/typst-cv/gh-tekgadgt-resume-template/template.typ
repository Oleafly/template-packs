// ── Resume template ───────────────────────────────────────────────────────────
// Reusable styling + entry helpers. Usage:
//
//   #import "template.typ": *
//   #show: resume
//   ... your content, using #job / #project / #community / #talk / #press ...
//
// Body-link underlining is applied in the document (a `#show link: underline`
// placed after the header) so header contact links stay clean. See resume.typ.

#let resume(body) = {
  set page(margin: (top: 0.55in, bottom: 0.55in, left: 0.6in, right: 0.6in), numbering: none)
  set text(font: ("Arial", "Helvetica"), size: 10pt, fill: rgb("#222222"))
  set par(leading: 0.6em, spacing: 0.55em, justify: false, first-line-indent: 0pt)
  set block(above: 0.55em, below: 0.55em)
  set heading(numbering: none)

  // Section header: bold, accent color, with a rule beneath. Sticky so the header
  // travels to the next page with its first entry (no orphaned headers). The
  // block's `below` sets one uniform gap under every section header (it collapses
  // with the following content's spacing instead of stacking on top of it).
  show heading.where(level: 1): it => block(sticky: true, breakable: false, above: 0pt, below: 0.6em)[
    #v(0.85em)
    #text(size: 11pt, weight: "bold", fill: rgb("#1F5C99"))[#upper(it.body)]
    #v(-0.55em)
    #line(length: 100%, stroke: 1.5pt + rgb("#1F5C99"))
  ]

  // List styling
  set list(tight: true, spacing: 0.5em, indent: 1.2em, body-indent: 0.4em, marker: [•])
  show list: it => {
    set par(leading: 0.6em)
    block(breakable: false, it)
  }

  body
}

// ── Entry helpers ─────────────────────────────────────────────────────────────
// Each entry wraps its title + body (bullets/description) in one unbreakable
// block, so a title is never split from its content by a page break. Entries
// are not sticky to each other, so a section may still break between entries.

#let job(company, title, date, body) = {
  block(breakable: false, {
    block(grid(
      columns: (1fr, auto),
      [#text(weight: "bold", size: 10.5pt)[#company] #text(fill: rgb("#555555"))[ · #title]],
      [#text(size: 9.5pt, fill: rgb("#555555"))[#date]],
    ))
    v(0.05em)
    body
  })
}

#let project(name, url, label, tech, body) = {
  block(breakable: false, {
    block([#text(weight: "bold")[#name] #h(0.3em) #text(fill: rgb("#555555"))[|] #h(0.3em) #link(url)[#text(
        fill: rgb("#1F5C99"),
        size: 9pt,
      )[#label]] #h(0.3em) #text(fill: rgb("#555555"), style: "italic", size: 9pt)[| #tech]])
    v(0.05em)
    body
  })
}

#let community(title, body) = {
  block(breakable: false, {
    block([#text(weight: "bold")[#title]])
    v(0.05em)
    body
  })
}

#let talk(title, venue, year) = {
  [#text(style: "italic")[#title], #venue (#year) \ ]
  v(0.05em)
}

#let press(title, source, url, date) = {
  [#link(url)[#text(style: "italic")[#title]], #source (#date) \ ]
  v(0.05em)
}
