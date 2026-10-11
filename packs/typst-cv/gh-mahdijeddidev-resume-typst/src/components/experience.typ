#import "section.typ": section

#let experience(title, experiences) = section(title)[
  #for company in experiences [

    // Company
    #text(
      size: 9.5pt,
      weight: "bold",
    )[
      #company.company    #text(
        size: 8pt,
        fill: rgb("#666666"),
      )[
        • #company.location
      ]
    ]

    #v(2pt)

    // Roles
    #for role in company.roles [

      #grid(
        columns: (1fr, auto),

        [
          #text(
            size: 8.8pt,
            weight: "semibold",
          )[
            #role.position
          ]
        ],

        [
          #text(
            size: 8pt,
            fill: rgb("#6B7280"),
          )[
            #role.date
          ]
        ],
      )

      #v(0.5pt)

      // Bullets
      #set text(size: 8pt)
     
      #for item in role.items [
        - *#item.title:* #item.description \
      ]

      #v(2pt)
    ]

    #v(2pt)
  ]
]
