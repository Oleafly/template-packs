// =====
// THIS IS CONFIG FILE FOR THE CONTENTS OF YOUR THESIS
// =====
#let configure_content(body) = {
  set page(
    paper: "a4",
    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 3cm,
      right: 1.5cm,
    ),
    numbering: "1",
    footer-descent: 0em,
  )

  set text(
    size: 14pt,
    font: "Times New Roman",
    lang: "ru",
  )

  set par(
    justify: true,
    leading: 1em,
    first-line-indent: (amount: 1.25cm, all: true),
    spacing: 1em,
  )

  show heading: set text(font: "Arial")
  show heading: set block(above: 2em, below: 1em)
  show heading: set align(center)
  show heading.where(level: 1): set text(size: 18pt)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)

  show heading.where(level: 1): set heading(numbering: "Глава 1.")
  show heading.where(level: 2): set heading(numbering: "1.1.")
  show heading.where(level: 3): set heading(numbering: "1.1.1.")


  show outline: it => {
    show heading.where(level: 1): set heading(numbering: none)
    it
  }

  show bibliography: it => {
    show heading.where(level: 1): set heading(numbering: none)
    it
  }

  // Apply styling for block code snippets
  show raw.where(block: true): it => {
    block(
      // fill: luma(240), // Light gray background
      inset: 10pt, // Padding
      // radius: 4pt,         // Rounded corners
      width: 100%,
      stroke: 0.25pt + black,
      align(start, it),
    )
  }

  show figure.caption: set text(size: 12pt)
  show figure.where(supplement: [Рис.]): set figure(supplement: [Рисунок])

  show outline.entry: set block(above: 1.2em)
  show outline.entry: it => {
    if it.element.func() == heading {
      // get supplement for the heading
      let suppl = it.element.supplement

      // check for appropriate supplement content
      if suppl == [Приложение] {
        // fetch the exact counter sequence for this specific heading location
        let heading_num = numbering(
          it.element.numbering,
          ..counter(heading).at(it.element.location()),
        )

        // re-order them to say: "Appendix A"
        let new_prefix = [#suppl #heading_num. ]

        // clear the native it.prefix() by passing 'none' and using new order
        return link(
          it.element.location(),
          it.indented(none, new_prefix + it.inner()),
        )
      }
    }
    it
  }

  show table: set text(size: 12pt)

  show raw: set text(font: "Consolas")

  set list(
    spacing: 1em,
    // indent: 2.5cm-1em,
    indent: 1.25cm,
    marker: ([•], [◦], [▪]),
  )

  show list: it => {
    set list(indent: 1.25cm)
    it
  }

  set enum(
    full: true,
    spacing: 1em,
    // indent: 2.5cm-1em,
    indent: 1.25cm,
  )

  show enum: it => {
    set enum(indent: 1.25cm)
    it
  }

  body
}

#let uheading = body => heading(numbering: none, level: 1, body)
#let uheading1 = body => heading(numbering: none, level: 1, body)
#let uheading2 = body => heading(numbering: none, level: 2, body)

#let appendix_section(content) = {
  counter(heading).update(0)
  show heading.where(level: 1): set heading(numbering: none)
  show heading.where(level: 2): set heading(
    numbering: (..n) => {
      let n = n.pos()
      let letter = ("А", "Б", "В", "Г", "Д", "Е", "Ж").at(n.at(1) - 1)
      [#letter]
    },
    supplement: [Приложение],
  )
  show heading.where(level: 2): it => context {
    let letter = numbering(it.numbering, ..counter(heading).at(it.location()))
    block([
      #text(weight: "bold")[Приложение #letter.]
      #h(0.3em)
      #it.body
    ])
  }
  content
}
