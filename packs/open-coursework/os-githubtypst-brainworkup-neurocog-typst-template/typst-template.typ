#let script-size = 7.97224pt
#let footnote-size = 8.50012pt
#let small-size = 9.24994pt
#let normal-size = 10.00002pt
#let large-size = 11.74988pt

#let neurocog(
  title: none,
  date: none,
  cols: 1,
  paper: "a4",
  margin: (x: 25mm, y: 30mm),
  lang: "en",
  region: "US",
  font: (),
  fontsize: 12pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1/1",
    columns: cols,
    header: locate(
        loc => if [#loc.page()] == [1] {
            []
        } else {
            [
              #set text(9pt)
              #smallcaps[
               *CONFIDENTIAL* \ 
               Patient Name
             ]
           ]
        }
    )
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  // Save heading and body font families in variables.
  let body-font = "Ale­greya"
  let sans-font = "Ale­greya Sans"

  // Set body font family.
  set text(font: body-font, lang: "en", size: 12pt)
  show math.equation: set text(weight: 400)

  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)
  
  // Set heading font.
  show heading: set text(font: sans-font)

  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    if it.level > 3 {
      parbreak()
      text(10pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  }

  // Configure lists and links.
  set enum(indent: 5pt, body-indent: 5pt)
  set list(indent: 5pt, body-indent: 5pt)
  show link: set text(font: "New Computer Modern Mono")

  // Logo
  block(
    figure(
      image("logo.png"),
    )
  )

  // Title row.
  align(center)[
    #block(text(font: sans-font, weight: 700, 1.75em, title))
    #v(2.2em, weak: true)
  ]

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
