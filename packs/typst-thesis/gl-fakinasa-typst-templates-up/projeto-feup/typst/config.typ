// This module provides document configuration and styling
// This currently allows the configuration of
// - Document language
// - Link color
// - Heading numbering style
// - Chapter formatting

#let apply_config(body) = {
  set text(lang: "pt")

  show link: set text(fill: blue)

  set heading(numbering: "1.1")

  // TOC Configuration
  // Level 1 (chapters): bold, no fill
  show outline.entry.where(level: 1): set text(size: 12pt)
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): strong

  // Customize chapter headings
  // This will add "Capítulo X" before each chapter title
  // and then the title itself. It also configures the
  // spacing before and after the chapter titles
  show heading.where(level: 1): it => {
    if it.numbering != none {
      pagebreak(weak: true)
      v(2em)
      text(size: 1.2em, weight: "bold")[
        Capítulo #counter(heading).display()
      ]
      v(0.5em)
      text(size: 1.5em, weight: "bold")[
        #it.body
      ]
      v(2em)
    } else {
      it
    }
  }

  body
}
