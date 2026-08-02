/*
* based on:
*    - https://typst.app/docs/tutorial/making-a-template/
*/

#let author_info(
  authors: ()
) = {
  pad(
    top: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
          #grid(
            columns: (auto),
            rows: 2pt,
            [*#author.name*],
          )
          #author.student_number \
          #author.email
        ]
      )
    )
  )
}

#let conf(
  title: "",
  subtitle: "",
  authors: (),
  date: datetime.today(),
  date_format: "[day].[month].[year]",
  language: "de",
  show_page_numbers: true,
  bottom_margin: 25mm,
  doc
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  if(show_page_numbers) {
      bottom_margin = bottom_margin + 10mm
  }
  set page(
    margin: (left: 25mm, right: 25mm, top: 25mm, bottom: bottom_margin),
    number-align: center, 
    header: [
      #set text(fill: luma(15%))
      #title - #subtitle
      #h(1fr)
      #date.display(date_format)
    ],
    footer: [
      #set text(fill: luma(15%), weight: 100)
      #author_info(authors: authors)
      #if(show_page_numbers) {
        align(center)[
        #set text(fill: black)
          #counter(page).display(
            "1/1",
            both: true
          )
      ]  
    }
    ]
  )
  
  set text(font: "New Computer Modern", lang: language)
  show math.equation: set text(weight: 400)
  show math.equation: set block(spacing: 0.65em)


  line(length: 100%, stroke: 1pt)
  // Title row.
  pad(
    bottom: 4pt,
    top: 4pt,
    align(center)[
      #block(text(weight: 500, 1.75em, title))
      #v(1em, weak: true)
      #block(text(weight: 500, 1.25em, subtitle))
    ]
  )
  line(length: 100%, stroke: 1pt)

  author_info(authors: authors)


  // Main body.
  set text(hyphenate: false)

  doc
}
