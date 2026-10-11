// Outline Components

// Table of Contents
#let toc(title) = {
  show outline.entry.where(
    level: 1
  ): it => {
    v(0.5cm, weak: true)
    show repeat: none
    strong(it)
  }
  outline(
    indent: auto,
    title: title,
  )
  pagebreak()
}

// List of x
#let list_of(title, kind) = {
  heading[#title]
  outline(
    title: none,
    target: figure.where(kind: kind),
  )
  pagebreak()
}
