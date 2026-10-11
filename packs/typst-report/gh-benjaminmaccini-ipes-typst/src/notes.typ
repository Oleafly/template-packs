// ===========================================================================
// notes.typ — the dual note system.
//
// Policy reports of this kind run two independent note streams, and conflating
// them is the single most common way to make one unreadable:
//
//   `aside[..]`   explanatory footnotes, numbered i, ii, iii, at the foot of
//                 the page — for caveats and definitions the reader needs now.
//   `@key`        source citations, numbered 1, 2, 3, collected into an
//                 ENDNOTES section at the back — for provenance.
//
// Typst reads BibTeX natively, so citations need no package: the endnote list
// is just `bibliography(..)` in a numeric CSL style, retitled.
// ===========================================================================

#import "@preview/marginalia:0.3.1" as marginalia
#import "theme.typ": get-theme
#import "marks.typ": hairline

/// An explanatory footnote, numbered with lowercase roman numerals.
///
/// Distinct from a citation: use this for a caveat, a definition or a
/// digression, and `@key` for a source.
#let aside(body) = footnote(numbering: "i", body)

/// A note in the outer margin, via `marginalia`.
///
/// Useful for glosses that would break the flow of a footnote stream, and for
/// annotating figures.
#let margin-note(
  /// Set `false` to omit the marker in the text.
  marker: true,
  /// Note contents.
  body,
) = context {
  let t = get-theme()
  marginalia.note(
    counter: if marker { marginalia.notecounter } else { none },
    // marginalia's default marker style asks for Inter; use the report face.
    numbering: marginalia.note-numbering.with(
      style: text.with(weight: 900, font: t.fonts.body, size: 5pt, fill: t.colors.accent),
    ),
    {
      set text(size: t.scale.fine, fill: t.colors.muted)
      set par(leading: 0.52em)
      body
    },
  )
}

/// Footnote presentation, applied by `report`.
#let footnote-rules(body) = {
  show: it => context {
    let t = get-theme()
    set footnote(numbering: "i")
    set footnote.entry(
      separator: line(length: 32%, stroke: (thickness: 0.5pt, paint: t.colors.rule)),
      gap: 0.5em,
      indent: 1em,
    )
    show footnote.entry: e => {
      set text(size: t.scale.micro + 0.5pt, fill: t.colors.muted)
      set par(leading: 0.5em, justify: false)
      e
    }
    it
  }
  body
}

/// The ENDNOTES section: the bibliography, styled as a back-matter list.
///
/// ```typ
/// #endnotes(bibliography("refs.bib", style: "nature"))
/// ```
#let endnotes(
  /// Section heading.
  title: [Endnotes],
  /// Number of columns. Two is usual for a long source list.
  columns: 2,
  /// Start on a fresh page.
  pagebreak-before: true,
  /// The result of a call to `bibliography(..)`.
  bib,
) = context {
  let t = get-theme()
  if bib == none { return }
  if pagebreak-before { pagebreak(weak: true) }

  block(below: 1.1em)[
    #text(font: t.fonts.display, size: t.scale.h1, fill: t.colors.primary)[#upper(title)]
    #v(0.4em)
    #line(length: 26%, stroke: (thickness: 2.5pt, paint: t.colors.accent, cap: "square"))
  ]

  set text(size: t.scale.micro + 1pt, fill: t.colors.ink)
  set par(leading: 0.5em, justify: false)
  show bibliography: set heading(outlined: false)

  std.columns(columns, gutter: 1.4em, bib)
}
