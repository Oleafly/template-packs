// Outline Components

// Table of Contents
#let toc(title) = {
  show outline.entry.where(level: 1): strong
  show outline.entry: set block(above: 15pt)
  outline(
    indent: 20pt,
    title: title,
  )
  pagebreak(weak: true)
}

// List of x
#let list_of(title, kind) = {
  heading[#title]
  outline(
    title: none,
    target: figure.where(kind: kind),
  )
  pagebreak(weak: true)
}
