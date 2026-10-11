//
// Description: Custom pages for the thesis template
// Author     : Sierro Yann

#import "/metadata.typ": *

#let l = {
  line(length: 100%, stroke: 0.5pt)
}

#let mse-title-page = {
  set page(
    margin: (
      top:3.0cm,
      bottom:3.0cm,
      rest:3.5cm
    )
  )
  //-------------------------------------
  // Page content
  //
  align(center)[
    #logos.logo-hesso

    #v(1cm)

    #logos.logo-mse

    #v(1cm)

    #text(size:20pt)[
      #school.orientation
    ]

    #v(0.5cm)

    #text(doc.title, size:30pt)

    #v(0.5cm)

    #text(doc.subtitle, size:24pt)

    #v(0.5cm)

    #text(size:22pt, doc.author.name)
  ]

  v(2cm)

  grid(
    columns: (1fr, 1fr),
    align: left + horizon,

    text(size:12pt)[

      #if professor != none [
        Professor: \
        - #professor.name
        - #professor.email
        - #professor.affiliation
      ]
    ],

    text(size:12pt)[

      #if expert != none [
        Expert: \
        - #expert.name
        - #expert.email
        - #expert.affiliation
      ]
    ]
  )

  v(1cm)

  text(size:15pt)[
    _Submission date of the report_ \
    #date.submission.display()
  ]

}
