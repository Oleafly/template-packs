// ===========================================================================
// contents.typ — table of contents and the secondary indices.
//
// Level-1 entries read "SECTION 2 | Market management tools", picked out in
// the display face and the section's own accent; level-2 entries carry dot
// leaders to the folio. Indices of boxes, case studies and data stories reuse
// the same machinery via `outline(target: figure.where(kind: ..))`.
// ===========================================================================

#import "@preview/outrageous:0.4.1"
#import "theme.typ": get-theme
#import "marks.typ": hairline

/// Table of contents.
#let contents(
  /// Heading printed above the list.
  title: [Contents],
  /// Deepest heading level listed.
  depth: 2,
  /// Start the contents on a fresh page.
  pagebreak-before: true,
  /// Set `false` to drop the "Section n |" prefix on level-1 entries.
  section-prefix: true,
) = context {
  let t = get-theme()
  if pagebreak-before { pagebreak(weak: true) }

  block(below: 1.4em)[
    #text(font: t.fonts.display, size: t.scale.h1, fill: t.colors.primary)[#upper(title)]
    #v(0.45em)
    #line(length: 26%, stroke: (thickness: 2.5pt, paint: t.colors.accent, cap: "square"))
  ]

  show outline.entry: outrageous.show-entry.with(
    font-weight: (700, 400, 400),
    font: (t.fonts.display, t.fonts.body, t.fonts.body),
    vspace: (1.5em, 0.45em, 0.3em),
    fill: (none, align(right, repeat(gap: 4pt)[.]), align(right, repeat(gap: 4pt)[.])),
    fill-right-pad: 0.4cm,
    fill-align: true,
    // Level 1 reads "SECTION 2 | Market management tools". The number comes
    // from the entry prefix, so it tracks `set heading(numbering: ..)`.
    prefix-transform: (lvl, prefix) => if lvl == 1 { [] } else { prefix },
    body-transform: (lvl, prefix, body) => {
      if lvl == 1 {
        text(size: t.scale.h2, fill: t.colors.primary)[
          #if prefix != none and section-prefix [
            #upper(t.options.section-word) #prefix
            #h(0.45em) #text(fill: t.colors.rule)[|] #h(0.45em)
          ]
          #upper(body)
        ]
      } else {
        // `prefix-transform` already emits the number for deeper levels;
        // printing it here too is what produced "1.1 1.1 Title".
        text(size: if lvl == 2 { t.scale.base } else { t.scale.small })[#body]
      }
    },
    page-transform: (lvl, page) => {
      if lvl == 1 {
        text(font: t.fonts.display, size: t.scale.h3, fill: t.colors.ink)[#page]
      } else {
        text(size: t.scale.small, fill: t.colors.muted)[#page]
      }
    },
  )

  outline(title: none, depth: depth, indent: n => if n <= 1 { 0pt } else { 1.1em })
}

/// An index of one figure kind — boxes, case studies, data stories, tables.
///
/// ```typ
/// #index-of(kind: "box", title: [Boxes])
/// #index-of(kind: "case-study", title: [Case studies])
/// ```
#let index-of(
  /// The `kind` given to the figures being listed.
  kind: "box",
  /// Heading printed above the list.
  title: [Boxes],
  /// Start on a fresh page.
  pagebreak-before: false,
) = context {
  let t = get-theme()
  if pagebreak-before { pagebreak(weak: true) }

  block(above: 1.6em, below: 0.8em)[
    #text(font: t.fonts.display, size: t.scale.h2, fill: t.colors.primary)[#upper(title)]
    #v(0.3em)
    #hairline()
  ]

  show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.outrageous-figures,
    font: (t.fonts.body,),
    vspace: (0.2em,),
    page-transform: (_, page) => text(size: t.scale.small, fill: t.colors.muted)[#page],
  )

  set text(size: t.scale.small)
  outline(title: none, target: figure.where(kind: kind))
}
