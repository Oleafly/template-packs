// Cover page and committee page functions for Invicta thesis

// Helper function for cover page
#let make-cover(config) = {
  set page(
    numbering: none,
    background: if config.stage == "jury" {
      rotate(-45deg, text(70pt, fill: rgb("CCCCCC"))[
        For Jury Evaluation
      ])
    } else { none },
  )


  // Switch to Arial/Sans-Serif for the cover page
  set text(font: ("Arial", "Helvetica", "sans-serif"))
  set align(center)

  v(0.5em)
  text(size: 14pt, weight: "bold")[
    UNIVERSIDADE POLITÉCNICA DE SANTARÉM
  ]
  linebreak()
  text(size: 14pt, weight: "bold")[
    #config.school
  ]

  v(1fr)

  if config.logo != none {
    image(config.logo, height: 6cm)
  }

  v(1fr)

  // Title
  text(size: 16pt, weight: "bold")[
    #config.title
  ]

  v(0.5cm)
  text(size: 14pt, weight: "bold")[
    #config.document-type
  ]

  v(0.5cm)
  text(size: 14pt, weight: "bold")[
    Mestrado em #config.degree
  ]
  
  v(0.5cm)
  text(size: 14pt, weight: "bold")[
    #config.author
  ]

  v(1.5fr)

  // Supervisor
  text(size: 12pt, weight: "bold")[
    Orientação:
  ]
  
  v(0.3cm)
  text(size: 12pt, weight: "bold")[
    #config.supervisor
  ]

  if config.second-supervisor != none {
    parbreak()
    text(size: 12pt, weight: "bold")[
      #config.second-supervisor
    ]
  }

  v(1.5fr)

  // Date
  let date-text = if config.thesis-date != none {
    config.thesis-date
  } else {
    datetime.today().display("[month repr:long], [year]")
  }
  text(size: 12pt)[
    #date-text
  ]

  set page(background: none)

  pagebreak()

  if config.copyright-notice != none {
    place(
      bottom + center,
      text(size: 10pt)[
        © #config.copyright-notice
      ],
    )
  }

  if config.signature {
    v(1cm)
    line(length: 5cm)
    text(size: 10pt)[Signature]
  }

  pagebreak()
}

// Helper function for committee page
#let make-committee-page(config) = {
  if config.committee-text != none and config.committee-members.len() > 0 {
    // Date
    let date-text = if config.thesis-date != none {
      config.thesis-date
    } else {
      datetime.today().display("[month repr:long], [year]")
    }

    set page(numbering: none)

    // Centered title, author, and degree at top
    set align(center)
    v(2cm)

    text(size: 18pt, weight: "bold")[
      #config.title
    ]

    v(1cm)

    text(size: 14pt, weight: "bold")[
      #config.author
    ]

    v(0.5cm)

    text(size: 12pt)[
      #config.degree
    ]

    v(1fr)

    // Committee information at bottom left
    set align(left)

    v(4cm)

    block(
      text(size: 14pt)[
        #config.committee-text
      ],
    )

    v(0.3cm)

    for member in config.committee-members {
      text(size: 12pt)[
        #member.role: #member.name
      ]
      linebreak()
    }

    v(0.6cm)

    // horizontal line
    align(right)[
      #line(length: 75%)
    ]

    v(1.5cm)

    block(
      text(size: 12pt)[
        #date-text
      ],
    )

    pagebreak()
  }
}
