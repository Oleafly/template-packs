#import "../func/header-numbering.typ": content-header-numbering

#let numbered-header(body) = {
  set heading(numbering: content-header-numbering)
  show heading: it => {
    let f_size = if it.level == 1 { 16pt } else { 14pt }
    if it.level == 1 { pagebreak(weak: true) }
    set text(size: f_size)
    let (align_at, indent_at) = if it.level <= 3 { (0cm, 0.5in) } else {
      (0.5in, 1in)
    }
    block(
      above: if it.level == 1 { 1em } else { 1.2em },
      below: 1.5em,
      grid(
        columns: (align_at, indent_at - align_at, 1fr),
        column-gutter: 0pt,
        row-gutter: 0.8em,
        [],
        if it.numbering != none { counter(heading).display(it.numbering) },
        it.body,
      ),
    )
  }

body }

#let centered-unnumbered-header(body) = {
  show heading: it => {
    set text(size: 16pt)
    pagebreak(weak: true)
    align(center, block(below: 2em, it.body))
  }

body }