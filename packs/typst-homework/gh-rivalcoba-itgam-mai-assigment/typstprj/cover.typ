#import "styles.typ": burgundy, gold, muted, navy

// Separacion entre bloques de la portada
#let cover-block-gap = 18mm

#let cover-entry(label, primary, secondary: none) = [
  #text(
    size: 11pt,
    weight: "bold",
    tracking: 1.15pt,
    fill: burgundy,
  )[#upper(label)]
  #v(1mm)
  #text(
    size: 14pt,
    weight: "semibold",
    fill: navy,
  )[#primary]
  #if secondary != none [
    #v(0.8mm)
    #text(
      size: 9.5pt,
      fill: muted,
    )[#secondary]
  ]
]

#let cover(data) = page(
  paper: "a4",
  margin: 0pt,
  header: none,
  footer: none,
  fill: white,
)[
  #pad(left: 18mm, right: 18mm, top: 12mm, bottom: 12mm)[
    #grid(
      columns: (1fr,),
      rows: (48mm, 8mm, 197mm, 20mm),
      row-gutter: 0pt,

      // Identidad institucional.
      align(center + horizon)[
        #image(
          "assets/logos.png",
          width: 174mm,
          height: 44.2mm,
          fit: "contain",
        )
      ],

      // Separador geométrico que retoma el motivo tecnológico de la referencia.
      align(center + horizon)[
        #grid(
          columns: (1fr, 8mm, 1fr),
          column-gutter: 2mm,
          line(length: 100%, stroke: 0.7pt + gold),
          block(
            width: 8mm,
            height: 6mm,
            fill: navy,
          )[
            #align(center + horizon)[
              #text(size: 7pt, weight: "bold", fill: white)[IA]
            ]
          ],
          line(length: 100%, stroke: 0.7pt + gold),
        )
      ],

      // Bloques informativos con una separación vertical común.
      align(center + horizon)[
        #grid(
          columns: (1fr,),
          row-gutter: cover-block-gap,
          align(center + horizon)[
            #pad(left: 12mm, right: 12mm)[
              #text(
                size: 15pt,
                weight: "bold",
                tracking: 1.2pt,
                fill: burgundy,
              )[#upper(data.document-type)]

              #v(2mm)

              #text(
                size: 8.5pt,
                weight: "medium",
                fill: muted,
              )[#data.course · #data.course-code]
            ]
          ],

          align(center + horizon)[
            #pad(left: 12mm, right: 12mm)[
              #par(leading: 0.98em, justify: false)[
                #text(
                  size: 23pt,
                  weight: "bold",
                  fill: navy,
                  hyphenate: false,
                )[#data.title]
              ]

              #v(4mm)

              #par(leading: 1.15em, justify: false)[
                #text(
                  size: 10.5pt,
                  fill: muted,
                )[#data.subtitle]
              ]
            ]
          ],

          align(center + horizon)[
            #cover-entry(
              "PRESENTA",
              data.student,
              secondary: [Matrícula: #data.student-id · #data.email],
            )
          ],
          align(center + horizon)[
            #cover-entry("DOCENTE TITULAR", data.professor)
          ],
          align(center + horizon)[
            #cover-entry(
              "PROGRAMA",
              data.program,
              secondary: [#data.unit · #data.institution],
            )
          ],
          align(center + horizon)[
            #cover-entry(
              "FECHA DE ENTREGA",
              data.date,
              secondary: [#data.city · #data.period],
            )
          ],
        )
      ],

      // Remate inferior sobrio.
      align(center + horizon)[
        #line(length: 34mm, stroke: 1pt + gold)
      ],
    )
  ]
]
