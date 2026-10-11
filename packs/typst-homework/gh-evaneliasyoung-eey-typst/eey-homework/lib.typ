#let us-date(dt) = dt.display("[month repr:long] [day padding:none], [year]")

#let long-us-date(dt) = dt.display(
  "[weekday], [month repr:long] [day padding:none], [year] at [hour padding:none repr:12]:[minute] [period case:lower]",
)

#let eey-response(content) = box(
  fill: rgb("#eeeeee"),
  width: 100%,
  inset: 1.25em,
  radius: 0.3em,
)[#content]

#let eey-homework(
  doc,
  university: "Missouri University of Science and Technology",
  subject: "Comp Sci",
  course: 1500,
  section: 101,
  assignment: "Homework #1",
  semester: "FS2019",
  pubdate: datetime(
    year: 2019,
    month: 9,
    day: 18,
  ),
  authors: (
    (name: "Evan Elias Young", email: "eeymrr@mst.edu"),
  ),
  section_index_base: 0,
) = {
  set document(
    author: (authors.map(author => author.name)),
    date: pubdate,
    title: assignment,
  )

  set page(
    paper: "us-letter",
    margin: (
      top: 1in - 20.5pt,
      left: 1in,
      bottom: 1in,
      right: 1in,
    ),
    header: context [
      #move(
        grid(
          columns: (1fr, 1fr),
          align(left)[
            #university
          ],
          align(right)[
            #subject #course\-#section #semester
          ],
        ),
        dy: (1em - 2pt),
      )
      #line(length: 100%, stroke: 0.5pt)
    ],
    header-ascent: 20pt,
    footer: context [
      #line(length: 100%, stroke: 0.5pt)
      #move(
        context [
          #h(1fr)
          *#counter(page).display("1", both: false)*
        ],
        dy: -(1em - 2pt),
      )
    ],
    footer-descent: 30pt,
  )
  set text(
    font: "New Computer Modern",
    size: 11pt,
  )

  set par(justify: true)

  set heading(
    outlined: true,
    numbering: (n1, ..rest) => {
      numbering("1 a i", calc.max(n1 + section_index_base - 1, 0), ..rest)
    },
  )

  set enum(numbering: "1. a. i.")
  show heading: it => block(below: 1em)[
    #if it.numbering == none {
      it.body
    } else {
      counter(heading).display() + "  " + it.body
    }
  ]

  v(3pt)
  align(center, text(18pt)[#assignment])

  align(center)[
    #grid(
      columns: (1fr,) * calc.min(authors.len(), 4),
      align: center,
      gutter: auto,
      row-gutter: 1em,
      ..authors.map(author => context [
        #set text(12pt)
        #author.name \
        #v(-0.7em)
        #link("mailto:" + author.email)
      ])
    )
  ]

  v(0.2em)
  align(center)[
    #set text(12pt)
    #us-date(pubdate)
  ]

  v(1.5em)

  doc
}
