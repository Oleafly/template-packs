#import "@preview/datify:0.1.2": day-name, month-name, custom-date-format

#let project(title: "", authors: (), date: datetime.today(), body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(
    paper: "a4",
    header: context {
      if counter(page).get().first() > 1 [
        #set text(10pt)
        #grid(
          columns: (1fr, 1fr),
          align(left,
            image("../assets/insa_logo.png", width: 50%)
          ),
          align(right, [
            #let subheading = query(
                selector(heading.where(level: 1)).before(here())
              )
            #if subheading.len() != 0 {
              subheading.last().body
            }
          ]),
        )
        #pad(bottom: 2pt, box(width: 100%, height: 1pt, fill: black))
      ]
    },
    header-ascent: 10%,
    number-align: center,
    numbering: "1",
    margin: (
      top: 2.5cm,
      bottom: 2cm,
      left: 2cm,
      right: 2cm,
    ),
  )

  set text(lang: "fr", font: "Times New Roman")

  // Title row.
  align(center + horizon)[
    #block(text(weight: 900, 21pt, title))
    #emph(custom-date-format(date, "Day DD MMMM YYYY", "fr"))
    // Author information.
    #pad(
      top: 0.25cm,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, author)),
      ),
    )

  ]


  // Main body.
  set par(justify: true)
  set heading(numbering: "I.1.a)")
  pagebreak()
  set text(11pt)

  body
}