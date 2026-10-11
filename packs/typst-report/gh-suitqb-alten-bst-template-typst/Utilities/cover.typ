// ALTEN BST Template - Cover page

#let make-cover(
  title: "",
  subtitle: "",
  year: "",
  department: ""
) = {
  set page(
    margin: 2.5cm,
    footer: none,
    header: none
  )

  align(center)[
    #v(4cm)

    // Title
    #text(size: 30pt, weight: "bold")[
      #title
    ]

    #v(0.4cm)

    // Subtitle
    #text(size: 16pt)[
      #subtitle
    ]

    #v(3.7cm)

    // Logos
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1cm,
      align: (center, center),
      image("../Images/Cover/LogoALTEN.png", width: 40%),
      image("../Images/Cover/LogoDIN.png", width: 65%)
    )

    #v(3.5cm)

    // Department info
    #text(size: 16pt)[
      ALTEN \
      #department
    ]

    #v(1.5cm)

    // Year and confidentiality
    #text(size: 14pt)[
      #year \
      *Company Confidential*
    ]
  ]
}
