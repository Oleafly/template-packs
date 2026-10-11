#let font-size(size, default-scale: 1.0) = (size / default-scale) * 1em

#let NUMBERED-HEADING = arguments(numbering: "1.", outlined: true)

#let heading-config(content) = {
  let h1 = heading.where(level: 1)
  let h2 = heading.where(level: 2)
  let h3 = heading.where(level: 3)

  set heading(numbering: none, outlined: false)

  show heading: set block(above: 2em, below: 1.5em)

  show h1: set text(size: font-size(2, default-scale: 1.4))
  show h1: set par(first-line-indent: 0em)
  show h1: set heading(..NUMBERED-HEADING)
  show h1: set heading(supplement: "fejezet")
  show h1: it => {
    pagebreak(weak: true)
    block(
      {
        v(32mm)
        if (it.numbering != none) {
          par(context [#counter(heading).display(it.numbering) #it.supplement], spacing: 2em)
        }
        it.body
      },
      below: 2em,
    )
  }

  show outline: it => {
    show h1: set heading(outlined: false, numbering: none)
    it
  }

  show bibliography: it => {
    show h1: set heading(numbering: none)
    it
  }

  show h2: set text(font-size(1.4, default-scale: 1.2))
  show h2: set heading(..NUMBERED-HEADING)

  show h3: set text(font-size(1.2, default-scale: 1))
  show h3: set heading(..NUMBERED-HEADING)

  content
}
