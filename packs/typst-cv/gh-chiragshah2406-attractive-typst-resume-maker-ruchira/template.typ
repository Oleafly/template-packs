// template.typ
// A template for a professional two-column resume

#let project(
  theme: rgb("#0F83C0"),
  name: "",
  title: "",
  contact: (),
  main: (),
  sidebar: (),
  body
) = {
  set page(
    margin: (left: 10mm, right: 10mm, top: 15mm, bottom: 15mm),
  )
  set text(font: "Mulish", size: 10pt)

  // Header
  grid(
    columns: (auto, 1fr),
    column-gutter: 20pt,
    [
      #text(size: 24pt, weight: "bold", fill: theme, name) \
      #v(2pt)
      #text(size: 14pt, weight: "medium", fill: theme.lighten(20%), title)
    ],
    align(right + bottom)[
      #set text(size: 9pt)
      #contact.join("  |  ")
    ]
  )

  v(10pt)
  line(length: 100%, stroke: 1pt + theme)
  v(10pt)

  // Body layout: Main (left) and Sidebar (right)
  grid(
    columns: (2fr, 1fr),
    column-gutter: 20pt,
    [
      // Main content
      #for sec in main {
        sec
      }
    ],
    [
      // Sidebar content
      #for sec in sidebar {
        sec
      }
    ]
  )
}

#let contact(text: "", url: none) = {
  if url != none {
    link(url)[#text]
  } else {
    text
  }
}

#let section(title: "", content: []) = {
  v(10pt)
  text(size: 12pt, weight: "bold", fill: rgb("#333"), upper(title))
  v(2pt)
  line(length: 100%, stroke: 0.5pt + gray)
  v(5pt)
  content
}

#let subSection(
  title: "",
  titleEnd: "",
  subTitle: "",
  subTitleEnd: "",
  content: none
) = {
  v(5pt)
  grid(
    columns: (1fr, auto),
    text(weight: "bold", title),
    text(style: "italic", titleEnd)
  )
  if subTitle != "" or subTitleEnd != "" {
    grid(
      columns: (1fr, auto),
      text(subTitle),
      text(style: "italic", size: 9pt, subTitleEnd)
    )
  }
  v(2pt)
  if content != none {
    content
  }
  v(5pt)
}

#let list(..items) = {
  for item in items.pos() {
    grid(
      columns: (10pt, 1fr),
      [•],
      item
    )
    v(2pt)
  }
}