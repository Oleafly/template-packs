#let titlepage(meta) = [
  #align(center)[

    #set page(footer: none)
    
    #image(meta.logo, height: 2cm)

    #block(height: .5cm)

    #set par(leading: 0.5em)
    
    #text(size: 22pt, weight: "bold")[#meta.title]
    
    #set par(leading: 1.2em)
    #block(height: 0cm)

    #text(size: 14pt)[#meta.type]

    #block(height: 2cm)

    #text(size: 13pt)[des Studiengangs #meta.studyprogram]\
    #text(size: 13pt)[an der #meta.university]

    #block(height: .5cm)

    #text(size: 13pt)[von] \
    #text(size: 13pt)[#meta.author]

    #block(height: 4.5cm)

    #align(center)[
      #block(width: 80%)[
        #grid(
          columns: (1fr, 0.7fr),
          align: left,
          row-gutter: 1.2em,
    
          grid.cell(align: left)[*Abgabedatum:*], [#meta.submission],
          [*Bearbeitungszeitraum:*], [#meta.duration],
          [*Matrikelnummer, Kurs:*], [#meta.mnr, #meta.course],
          [*Dualer Partner:*], [
            #meta.company  \
            #meta.company_address
          ],
          //[*Betreuer der Dualen Hochschule:*], [#meta.supervisor],
          [*Betreuer des Dualen Partners:*], [#meta.supervisor]
        )
      ]
    ]
  ]
]
#pagebreak()