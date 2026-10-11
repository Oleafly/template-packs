#import "styles.typ": gold, navy
#import "components.typ": info-card

#let cover(data) = page(
  paper: "a4",
  margin: 0pt,
  header: none,
  footer: none,
  fill: white,
)[
  #grid(
    columns: (1fr,),
    rows: (48mm, 96mm, 107mm, 46mm),
    row-gutter: 0pt,

    // Franja institucional superior.
    align(center + horizon)[
      #image(
        "assets/perfiles.png",
        width: 100%,
        height: 48mm,
        fit: "contain",
      )
    ],

    // Bloque principal de la portada.
    block(
      width: 100%,
      height: 100%,
      fill: navy,
    )[
      #pad(
        left: 17mm,
        right: 17mm,
        top: 12mm,
        bottom: 10mm,
      )[
        #grid(
          columns: (3mm, 1fr),
          column-gutter: 10mm,
          rect(
            width: 1.2mm,
            height: 58mm,
            fill: gold,
            radius: 0.6mm,
          ),
          [
            #box(
              stroke: 0.7pt + gold,
              radius: 8pt,
              inset: (
                x: 4mm,
                y: 2mm,
              ),
            )[
              #text(
                size: 7.8pt,
                weight: "bold",
                tracking: 1.2pt,
                fill: gold,
              )[
                #upper(data.document-type)
              ]
            ]

            #v(8mm)

            #par(
              leading: 0.94em,
              justify: false,
              first-line-indent: 0pt,
            )[
              #align(left)[
                #text(
                  size: 27pt,
                  weight: "bold",
                  fill: white,
                  hyphenate: false,
                )[
                  #data.title
                ]
              ]
            ]

            #v(5mm)

            #par(leading: 1.25em)[
              #text(
                size: 11.5pt,
                fill: rgb("#cbd3e0"),
              )[
                #data.subtitle
              ]
            ]

            #v(10mm)

            #grid(
              columns: (auto, 1fr, auto, auto),
              column-gutter: 3mm,
              text(
                size: 7pt,
                weight: "bold",
                tracking: 1.2pt,
                fill: gold,
              )[ASIGNATURA],
              text(
                size: 9.5pt,
                weight: "bold",
                fill: white,
              )[
                #data.course
              ],
              text(
                size: 7pt,
                weight: "bold",
                tracking: 1.2pt,
                fill: gold,
              )[CLAVE],
              text(
                size: 9.5pt,
                weight: "bold",
                fill: white,
              )[
                #data.course-code
              ],
            )
          ],
        )
      ]
    ],

    // Datos académicos.
    pad(
      left: 16mm,
      right: 16mm,
      top: 12mm,
      bottom: 8mm,
    )[
      #grid(
        columns: (1fr, 1fr),
        rows: (30mm, 30mm),
        column-gutter: 5mm,
        row-gutter: 5mm,
        info-card(
          "PRESENTA",
          data.student,
          secondary: [
            Matrícula: #data.student-id \
            #data.email
          ],
        ),
        info-card(
          "PROGRAMA",
          data.program,
          secondary: [
            #data.research-line \
            #data.period
          ],
        ),

        info-card(
          "DIRECCIÓN DE TESIS",
          data.advisor,
          secondary: [Responsable de la dirección],
        ),
        info-card(
          "ENTREGA",
          data.date,
          secondary: [
            #data.city \
            #data.period
          ],
        ),
      )

      #v(2mm)

      #grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 5mm,
        info-card(
          "CODIRECTOR",
          data.coadvisor,
          height: 20mm,
          inset-y: 1.5mm,
        ),
        info-card(
          "REVISOR 1",
          data.reviewer1,
          height: 20mm,
          inset-y: 1.5mm,
        ),
        info-card(
          "REVISOR 2",
          data.reviewer2,
          height: 20mm,
          inset-y: 1.5mm,
        ),
      )
    ],

    // Cintillo institucional inferior.
    align(center + horizon)[
      #image(
        "assets/cintillo.png",
        width: 69mm,
        height: 37mm,
        fit: "contain",
      )
    ],
  )
]
