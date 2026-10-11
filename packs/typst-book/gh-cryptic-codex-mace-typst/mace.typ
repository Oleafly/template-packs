// MACE Codex — a Typst template emulating the MACE Adventurer's Codex.
//
// Copyright (C) 2026 Justin Hamilton
// SPDX-License-Identifier: LGPL-3.0-or-later
//
// Body text is set in Study; display/headers in Goudy Medieval.
// A5 pages, 0.5in margins with a 0.65in inner gutter.

// Preferred fonts first; open-licensed fallbacks (shipped in fonts/)
// take over on machines without Study / Goudy Mediaeval installed.
#let body-font = ("Study", "EB Garamond")
#let display-font = ("Goudy Mediaeval", "Manufacturing Consent")

// Zebra-striped rules table: horizontal rules only, small-caps bold
// header row, alternating grey data rows. Kept on one page by default;
// pass breakable: true for tables taller than a page (the header row
// repeats after the break).
#let codex-table(
  columns: 1,
  align: center,
  header: (),
  note: none,
  breakable: false,
  ..cells,
) = {
  let ncols = if type(columns) == int { columns } else { columns.len() }
  block(
    above: 1em,
    below: 1em,
    width: 100%,
    breakable: breakable,
    // Center tables narrower than the text column (all-auto columns);
    // full-width tables are unaffected. std. prefix: the align *param*
    // shadows the align function in this scope. Cells wrap ragged-right
    // rather than justified.
    {
      set par(justify: false)
      std.align(center, table(
      columns: columns,
      align: align,
      stroke: none,
      inset: (x: 6pt, y: 3.5pt),
      fill: (x, y) => if calc.odd(y) { luma(239) },
      table.hline(stroke: 1pt),
      table.header(..header.map(h => smallcaps(text(weight: "bold", h)))),
      table.hline(stroke: 0.5pt),
      ..cells,
      table.hline(stroke: 0.8pt),
      // Footnote-style line under the bottom rule, e.g. "* may not ..."
      ..if note != none {
        (table.cell(
          colspan: ncols,
          fill: none,
          align: center,
          inset: (top: 2.5pt, bottom: 0pt),
          text(size: 8pt, style: "italic", note),
        ),)
      },
      ))
    },
  )
}

// Keep a run of content together on one page — wrap a heading plus its
// paragraph and list when they must not split across a page break.
// Don't wrap more than a page's worth of content: it would overflow.
#let keep(body) = block(breakable: false, width: 100%, body)

// Title page in the style of the codex cover: huge display title,
// italic tagline, display subtitle, centered art, caps blurb,
// version line, and a license block pinned to the bottom.
#let title-page(
  title: [],
  tagline: none,
  subtitle: none,
  art: none,
  blurb: none,
  version: none,
  license: none,
) = page(
  footer: none,
  align(center)[
    #set par(justify: false)
    #v(0.35in)
    #text(font: display-font, size: 68pt, title)

    #if tagline != none {
      v(-4.0em)
      text(size: 11pt, style: "italic", tagline)
    }

    #if subtitle != none {
      v(-0.8em)
      text(font: display-font, size: 26pt, subtitle)
    }

    #if art != none {
      v(1fr)
      art
    }

    #v(1fr)

    #if blurb != none {
      text(size: 11pt, tracking: 0.3pt, upper(blurb))
    }

    #if version != none {
      v(1em)
      text(size: 9pt, style: "italic", version)
    }

    #v(2fr)

    #if license != none {
      text(size: 9pt, style: "italic", license)
    }
  ],
)

// Styled table of contents: Goudy title, bold-italic entries with
// dot leaders.
#let table-of-contents(title: [Table of Contents]) = {
  align(center, text(font: display-font, size: 24pt, title))
  v(1em)
  show outline.entry: set text(size: 11pt, weight: "bold", style: "italic")
  show outline.entry: set block(above: 1.15em)
  outline(title: none, depth: 1)
  pagebreak()
}

// Main document wrapper. Wrap your whole document:
// #show: codex.with(title: "My Codex", author: "Me")
#let codex(
  title: none,
  author: none,
  body,
) = {
  set document(
    ..if title != none { (title: title) },
    ..if author != none { (author: author) },
  )

  set page(
    paper: "a5",
    margin: (inside: 0.65in, outside: 0.5in, top: 0.5in, bottom: 0.5in),
    footer: context align(center, text(size: 9pt, counter(page).display("1"))),
  )

  set text(font: body-font, size: 10pt)
  set par(justify: true, leading: 0.6em, spacing: 0.9em)

  set heading(numbering: none)
  show heading.where(level: 1): it => block(
    above: 1.5em,
    below: 0.9em,
    sticky: true,
    text(font: display-font, weight: "regular", size: 19pt, it.body),
  )
  show heading.where(level: 2): it => block(
    above: 1.3em,
    below: 0.55em,
    sticky: true,
    text(size: 11pt, weight: "bold", tracking: 0.8pt, it.body),
  )
  show heading.where(level: 3): it => block(
    above: 1.1em,
    below: 0.4em,
    sticky: true,
    text(size: 10pt, weight: "bold", style: "italic", it.body),
  )

  set list(indent: 1.25em, body-indent: 0.6em, spacing: 0.65em)
  set enum(
    indent: 0.75em,
    body-indent: 0.6em,
    spacing: 0.65em,
    numbering: n => text(weight: "bold")[#n.],
  )

  set footnote.entry(separator: none, indent: 0pt)
  show footnote.entry: set text(size: 8pt, style: "italic")
  show footnote.entry: set par(justify: true)

  show image: it => align(center, it)

  body
}
