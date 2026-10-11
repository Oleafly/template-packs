#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let img(
  file, path: "figures/",
  alt: none, fit: "cover",
  format: auto, height: auto,
  width: auto,
) = image(
  path + file, 
  alt: alt, 
  fit: fit, 
  format: format, 
  height: height, 
  width: width
)

#let span(content, col: 2) = {
  table.cell(colspan: 2, content)
}

// constants
#let border-thickness = 0.4pt

// formatting
#let bf(body) = text(weight : "bold")[#body]

// course specific stuff
#let hmk(count, altname, authors, class) = {
  table(
    columns: (auto, 1fr, auto),
    align: (left, center, right),    
    row-gutter: 0em,
    stroke: none,
    ..for (i, author) in authors.enumerate() {((
      [#author],
      if (i == authors.len()-1) {
        set text(weight: "bold", size: 16pt)
        if (altname == "") [
          Homework #count
        ] else [
          #altname
        ]
      } else [],
      if (i == authors.len()-1) {datetime.today().display("[month repr:long] [day], [year]")}
      else if (i == authors.len()-2) {class}
      else [],
    ))},
    table.hline(start: 0, stroke: border-thickness)
  )
}

#let arty(
  count: 0,
  draft: false,
  header: "1.a",
  class: "",
  altname: "",
  authors: ["", ""],
  doc
) = {
  show: codly-init.with()

  set table(
    stroke: 1pt + black,
    row-gutter: (2.2pt, auto)
  )
  set table(
    stroke: (x: none),
  )
  set raw(
    block: true,
  )

  set grid( 
    column-gutter: 3pt,
    row-gutter: 3pt,
    columns: 2,
    align: bottom
  )

  set rect( 
    stroke: red, inset: 1em
  )

  set page(
    margin: ( x: 1.5cm)
  )
  set math.stretch(size: 300%)

  show heading: it => {
    if draft {
      pagebreak()
    }
    it
  }

  set text(font: "New Computer Modern", lang: "en", size: 10pt)

  set heading(numbering: header)

  hmk(count, altname, authors, class)

  doc
}
