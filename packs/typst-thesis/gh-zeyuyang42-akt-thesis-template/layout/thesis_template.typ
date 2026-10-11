// Main thesis style. You should not need to edit this file —
// all thesis data lives in metadata.typ, all text in content/ and chapters/.
#let project(
  title: "",
  author: "",
  body-font: ("New Computer Modern",),
  sans-font: ("New Computer Modern Sans", "New Computer Modern"),
  bibliography: none,
  appendices: none,
  list-of-figures: true,
  list-of-tables: true,
  body,
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 35mm, right: 25mm, top: 25mm, bottom: 25mm),
    numbering: "- 1 -",
    number-align: center,
  )

  set text(
    font: body-font,
    size: 12pt,
    lang: "en"
  )

  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1)")
  show footnote.entry: set text(size: 8.5pt)

  // --- Headings ---
  set heading(numbering: "1.1")
  show heading: it => {
    set block(below: 0.85em, above: 1.75em)
    set text(font: body-font)
    if it != none and it.func() == heading and it.level == 1 {
      pagebreak()
      block([
        #smallcaps([Chapter]) #counter(heading).display() \
        #smallcaps(it.body) \
        #v(1em)
      ])
    } else {
      block([
        #counter(heading).display()
        #smallcaps(it.body)
        #v(0.5em)
      ])
    }
  }

  show outline: set heading(numbering: "1")

  // Entries wrap with a hanging indent, and the page number lives in its own
  // reserved right-hand column: long captions or headings wrap inside the
  // middle column and never extend under the page numbers.
  show outline.entry: it => {
    let prefix = if it.prefix() == none { [] } else { it.prefix() }
    link(
      it.element.location(),
      pad(
        left: (it.level - 1) * 1.5em,
        grid(
          columns: (auto, 1fr, 3em),
          column-gutter: (0.5em, 4pt),
          align: (left, left, bottom + right),
          prefix,
          it.body() + [ ] + box(width: 1fr, repeat([.], gap: 0.3em)),
          it.page(),
        ),
      ),
    )
  }

  // --- Figures ---
  show figure: set text(size: 0.85em)

  // --- Table of Contents ---
  page(numbering: "I")[
    #align(left, text(font: sans-font, 2em, weight: 700, "Contents"))
    #outline(
      title: none,
      indent: auto,
      depth: 4
    )
  ]

  // --- Main body ---
  set par(justify: true, first-line-indent: 2em)

  body

  set par(justify: true, first-line-indent: 0em)

  // --- List of figures ---
  if list-of-figures {
    pagebreak()
    align(left, text(font: sans-font, 2em, weight: 700, "List of Figures"))
    v(2em)
    outline(
      title: none,
      target: figure.where(kind: image),
    )
  }

  // --- List of tables ---
  if list-of-tables {
    pagebreak()
    align(left, text(font: sans-font, 2em, weight: 700, "List of Tables"))
    v(2em)
    outline(
      title: none,
      target: figure.where(kind: table),
    )
  }

  // --- Bibliography ---
  if bibliography != none {
    pagebreak()
    align(left, text(font: sans-font, 2em, weight: 700, "Bibliography"))
    v(2em)
    bibliography
  }

  // --- Appendices ---
  if appendices != none {
    pagebreak()
    appendices
  }
}
