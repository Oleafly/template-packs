// ALTEN BST Template - Style definitions

// Define colors
#let alten-blue = rgb("#0066CC")
#let emerald = rgb("#009000")
#let definition-shade = rgb("#F2F2FF")
#let example-shade = rgb("#F0FFF0")
#let attention-shade = rgb("#FFFACC")

// Apply document style
#let apply-style(title: "", short-title: "", body) = {
  // Set document metadata
  set document(
    title: title,
    author: "ALTEN Innovation Department"
  )

  // Set page layout
  set page(
    paper: "a4",
    margin: (
      top: 4cm,
      bottom: 5cm,
      left: 3.5cm,
      right: 3.5cm
    ),
    footer: context {
      grid(
        columns: (1fr),
        align: (center),
        [#counter(page).display("1")],
      )
    }
  )

  // Set text properties
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: "en"
  )

  // Set paragraph properties
  set par(
    justify: true,
    leading: 0.6em,
    spacing: 0.6em
  )

  // Set heading numbering
  set heading(numbering: "1.1.1")

  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 18pt, weight: "bold")
    v(0.5cm)
    it
    v(0.3cm)
  }

  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    v(0.4cm)
    it
    v(0.2cm)
  }

  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    v(0.3cm)
    it
    v(0.15cm)
  }

  // Link styling
  show link: set text(fill: alten-blue)
  show cite: set text(fill: alten-blue)

  // Code block styling
  show raw.where(block: true): it => {
    set par(justify: false)
    block(
      fill: luma(245),
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      it
    )
  }

  // Inline code styling
  show raw.where(block: false): it => {
    box(
      fill: luma(240),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      it
    )
  }

  // Lists spacing
  set list(indent: 1em, body-indent: 0.5em)
  set enum(indent: 1em, body-indent: 0.5em)

  body
}

// Definition box
#let definition-box(content) = {
  block(
    fill: definition-shade,
    stroke: (left: 2pt + alten-blue),
    inset: 10pt,
    radius: 2pt,
    width: 100%,
    content
  )
}

// Example box
#let example-box(content) = {
  block(
    fill: example-shade,
    stroke: (left: 2pt + emerald),
    inset: 10pt,
    radius: 2pt,
    width: 100%,
    content
  )
}

// Attention box
#let attention-box(content) = {
  block(
    fill: attention-shade,
    stroke: (left: 2pt + red),
    inset: 10pt,
    radius: 2pt,
    width: 100%,
    content
  )
}
