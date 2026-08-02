#let template(
  title: "Title",
  author: "Author",
  date: datetime.today(),
  heading-numbering: "1.1.1.1",
  title-size: 20pt,
  body,
) = {
  set document(title: title, author: author, date: date)
  set page(
    paper: "a4",
    margin: (x: 1in, y: 1in),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(8pt)
        #smallcaps[#author]
        #h(1fr)
        #smallcaps[#title]
        #line(length: 100%, stroke: 0.1mm)
      ]
    },
    footer: context {
      [
        #line(length: 100%, stroke: 0.1mm)
        #set text(8pt)
        #smallcaps[Last Modified: #date.display()]
        #h(1fr)
        #counter(page).display()
      ]
    },
  )
  set text(
    font: "New Computer Modern",
    size: 10pt,
  )
  set par(
    leading: 0.55em,
    justify: true,
    first-line-indent: 1.8em,
  )

  set heading(numbering: heading-numbering)
  show heading: set block(above: 1.4em, below: 1em)
  set list(indent: 1.8em, spacing: 1.0em)
  set enum(indent: 1.8em, spacing: 1.0em)

  set raw(block: true)
  show raw: set block(inset: 1.8em)

  set math.equation(block: true, numbering: "(1)", number-align: right)

  align(center, text(title-size, title))
  v(0.5cm, weak: true)
  align(center, text(14pt, author))
  body
}
