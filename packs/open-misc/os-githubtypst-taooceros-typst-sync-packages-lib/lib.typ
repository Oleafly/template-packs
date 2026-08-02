#let apa(title: [], authors: (), institution: [], course: none, professor: [], body, title-abbr: [], section: none) = {
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center, margin: 1in, paper: "us-letter", header: align(left, text(gray.darken(50%), title-abbr)))
  set text(font: "Charis SIL", lang: "en", weight: 300, size: 12pt)
   
  set heading(numbering: "1.1")
   
  set block(below: 2em, above: 2em)
   
  set par(leading: 2em, first-line-indent: 2em, justify: false, linebreaks: "optimized")

  align(center + horizon, {
    block(text(weight: "bold", title))
    v(3em)
    pad(
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, author)),
      ),
    )

    institution

    if (course != none) {
      [course, section]
    }

    professor

    datetime.today().display("[month repr:long] [day], [year]")
  
    v(15em)
  })

  pagebreak(weak: true)

  body
}