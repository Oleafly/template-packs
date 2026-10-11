// lib/components/toc.typ

// =============================================================================
// Table of Contents Styles
// =============================================================================

/// Classic table of contents
#let toc-classic(title: "Contents", depth: 3) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  outline(
    title: none,
    depth: depth,
    indent: auto,
  )
  pagebreak()
}

/// Minimal table of contents (no fill)
#let toc-minimal(title: "Contents", depth: 2) = {
  align(center)[
    #text(size: 1.5em, weight: "semibold")[#title]
  ]
  v(2em)
  {
    show outline.entry: it => {
      it.body()
      h(1fr)
      it.page()
    }
    outline(
      title: none,
      depth: depth,
      indent: 1.5em,
    )
  }
  pagebreak()
}

/// Dotted table of contents
#let toc-dotted(title: "Table of Contents", depth: 3) = {
  align(center)[
    #text(size: 1.5em, weight: "bold")[#title]
  ]
  v(1em)
  outline(
    title: none,
    depth: depth,
    indent: auto,
  )
  pagebreak()
}

/// Chapter list only (level 1 headings)
#let toc-chapters-only(title: "Chapters") = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  outline(
    title: none,
    depth: 1,
    indent: none,
  )
  pagebreak()
}
