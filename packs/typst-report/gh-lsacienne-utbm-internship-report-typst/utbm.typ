#let cover(
  title: "Analyse de durabilité des systèmes de propulsion par microcontrôleurs externe",
  report-type: "STXX",
  report-year: "P20XX",
  picture: "assets/images/background.jpg",
  student: (
    first-name: "Prénom",
    last-name: "NOM",
    specialty: "Nom de la spécialité d'ingénieur",
    sector: "Nom de la filière",
  ),
  company: (
    name: "Entreprise DEMO-Contrôleurs",
    address: "8 rue de la Fierté",
    postal-code: "75013",
    city: "Paris",
    website: "www.democontroleurs.com",
  ),
  tutor: (
    first-name: "Prénom",
    last-name: "NOM",
  ),
  supervisor: (
    first-name: "Prénom",
    last-name: "NOM",
  ),
) = {

  set page(paper: "a4", margin: (top: .5cm, left: 1cm, right: 0cm, bottom: 0cm))
  set text(font: "Arial")

  grid(
    columns: (auto, auto),
    rows: (auto),
    gutter: 1fr,
    inset: (right:1cm),
    align: horizon,
    image(
      "assets/images/french_republic.png",
      width: 1.94cm
    ),
    image(
      "assets/images/utbm_logo.png",
      width: 2.51cm
    )
  )

  show image: set block(above: 6pt)

  image(
    picture,
    width: 20.04cm,
    height: 11.14cm,
    fit: "cover"
  )

  show rect: set block(above: 0pt)

  rect(
    width: 100%,
    height: 0.92cm,
    fill: black,
    inset: (left: 0.8cm)
  )[
    #align(horizon)[
      #text(white, size: 14pt, weight: 900)[UNIVERISTÉ DE TECHNOLOGIE]
      #text(white, size: 14pt, weight: 400)[ DE BELFORT-MONTBÉLIARD]
    ]
  ]

  rect(
    width: 100%,
    height: 3.31cm,
    fill: rgb(27,94,135),
    inset: (left: 0.8cm)
  )[
    #align(horizon + left)[
      #text(
        white,
        size: 24pt,
        weight: "bold"
      )[#title]
    ]
  ]

  rect(
    width: 100%,
    height: 0.92cm,
    fill: rgb(79,78,85),
    inset: (left: 0.8cm)
  )[
    #align(horizon)[
      #text(white, size: 12pt, weight: "bold")[Rapport de stage #report-type - #report-year]
    ]
  ]

  show par: set block(above: 6pt)

  set text(white)
  rect(
    width: 100%,
    height: 10.945cm,
    fill: rgb(98,184,143),
    inset: (left: 0.8cm)
  )[
    #grid(
      columns: (auto, auto),
      rows: (auto, auto, auto),
      gutter: 1fr,
      row-gutter: 1fr,
      inset: (
        top: 0.8cm,
        bottom: 2cm,
        right: 1.2cm
      ),
      align: horizon,
      grid.cell(x:0, y:0)[
        #text(size: 18pt, weight: "bold")[#student.first-name #student.last-name]

        #text(size: 10pt, weight: "bold")[#student.specialty]

        #text(size: 10pt, weight: "bold")[#student.sector]
      ],
      grid.cell(x:0, y:1)[
        #text(size: 18pt, weight: "bold")[#company.name]

        #text(size: 12pt, weight: "bold")[#company.address]

        #text(size: 12pt, weight: "bold")[#company.postal-code #company.city]

        #text(size: 12pt, weight: "bold")[
          #link(company.website)
        ]
      ],
      grid.cell(x:0, y:2)[
        #text(size: 12pt)[Tuteur en entreprise]

        #text(size: 14pt, weight: "bold")[#tutor.last-name #tutor.first-name]

      ],
      grid.cell(x:1, y:2, align: end)[
        #text(size: 12pt)[Suiveur UTBM]

        #text(size: 14pt, weight: "bold")[#supervisor.last-name #supervisor.first-name]
      ],
    )
  ]
}

#let fourth-cover(
  abstract,
  subject: "Sujet de stage et description du travail réalisé",
  report-type: "STXX",
  report-year: "P20XX",
  student: (
    first-name: "Prénom",
    last-name: "NOM"
  ),
  company: (
    name: "Entreprise DEMO-Contrôleurs",
    address: "8 rue de la Fierté",
    postal-code: "75013",
    city: "Paris",
    website: "www.democontroleurs.com",
  ),
) = {

  set text(font: "Arial")
  set page(
    paper: "a4",
    margin: (top: 0cm, left: 1cm, right: 0cm, bottom: 3cm),
    footer: [
      #grid(
        columns: 2,
        column-gutter: 1fr,
        align: top,
        inset: (right:1.5cm),
        image(
          "assets/images/utbm_logo.png",
          width: 2.95cm
        ),
        grid.cell()[
          #grid(
            columns: 2,
            gutter: 1mm,
            image(
              "assets/images/ut_group.png",
              width: 1.87cm
            ),
            image(
              "assets/images/ubfc.png",
              width: 1.81cm
            )
          )
        ]
      )
    ]
  )

  rect(
    fill: rgb(98,184,143),
    width: 100%,
    height: 4.43cm,
    inset: (left: 0.8cm, bottom: 1.2cm)
  )[
    #align(bottom + left)[
      #show par: set block(spacing: 10pt)
      #set text(white)

      #text(size: 18pt, weight: "bold")[#student.last-name #student.first-name]

      #text(size: 14pt, weight: "bold")[Rapport de Stage #report-type - #report-year]
    ]
  ]

  block(
    inset: (left: 0.8cm, right: 2.4cm, top: 0.5cm)
  )[
    #show par: set block(spacing: 20pt)
    #align(left)[
      #text(size: 12pt, weight: "bold")[
        #subject
      ]
    ]
    #par(justify: true)[
      #show par: set block(spacing: 0.65em)
      
      #abstract

    ]
  ]
  block(
    height: auto,
    spacing: 1fr,
    inset: (left: 0.8cm),
    par[
      #show text: set block(spacing: 4pt)
      #show par: set block(spacing: 4pt)
      #text(
        size: 18pt,
        weight: "bold"
      )[#company.name]
      
      #text(rgb(128,128,128), size: 12pt, weight: "bold")[#company.address]

      #text(rgb(128,128,128), size: 12pt, weight: "bold")[#company.postal-code #company.city]

      #text(rgb(128,128,128), size: 12pt, weight: "bold")[
        #link(company.website)
      ]
    ]
  )
}


