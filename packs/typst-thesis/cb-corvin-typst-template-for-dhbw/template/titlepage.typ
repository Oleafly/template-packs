#let titlepage(meta) = {
  align(center)[
    #text(size: 14pt, font: "Arial")[
      #v(1cm)

      #text(size: 20pt, weight: "bold")[
        #meta.title
      ]

      #v(2em)
      #if meta.secret == true {
        align(left)[
          #rotate(-20deg)[
            #text(size: 22pt, weight: "bold", fill: rgb("#ff4136"))[
              #pad(left: 2.5cm)[
                Sperrvermerk
              ]
            ]
          ]
        ]
      } else{
        v(2em)
      }

      #v(0.7cm)

      #meta.type \
      Studienjahrgang: #meta.academic-year \
      Kurs: #meta.course

      #v(1.2cm)

      Fakultät: #meta.faculty \
      Studiengang: #meta.degree-program

      #v(1cm)

      #meta.university \
      #meta.campus
    ]
  ]
  v(2.5cm)

  let optional-row(label, value) = {
    if value == none {
      ()
    } else {
      (label, [#value])
    }
  }

  let matriculation-number =  meta.at("matriculation-number", default: none)

  let company =  meta.at("company", default: none)

  let delivery-date =  meta.at("delivery-date", default: none)

  align(left)[
    #pad(left: 4cm)[
      #text(size: 14pt, font: "Arial")[
        #table(
          columns: (6cm, 6cm),
          stroke: none,
          [*Bearbeiter:*], [#meta.author],
          ..optional-row(
            [*Matrikelnummer:*], matriculation-number,
          ),
          ..optional-row(
            [*Ausbildungsbetrieb:*], company,
          ),
          [*Betreuer:*], [#meta.supervisor],
          ..optional-row(
            [*Abgabedatum:*], delivery-date,
          )
        ) 
      ]
    ]
  ]

  place(
    bottom + center,
    grid(
      columns: (1.2fr, 1fr),

      [
        #if meta.left-logo != none {
          image(meta.left-logo, height: 3.5cm, width: 3.3cm)
        }
      ],

      [
        #align(right)[
          #if meta.right-logo != none {
            image(meta.right-logo, height: 3cm, width: 80%)
          }
        ]
      ],
    ),
  )
  if meta.secret == true {
    
    pagebreak()

    set page(
      numbering: "I",
      footer: none,
    )

    set heading(
      outlined: false,
      numbering: none,
    )

    set text(
      size: 12pt,
      font: "Arial",
    )

    set par(
      justify: true,
      spacing: 1em,
      leading: 1em
    )

    [= Sperrvermerk]

    v(3em)
    par[Nach § 20 Abs. 4 der Studien- und Prüfungsordnung für die Bachelorstudiengänge im Studienbereich Wirtschaft der Dualen Hochschule Baden-Württemberg (DHBW) (Studien- und Prüfungsordnung DHBW Wirtschaft) vom 18. Juli 2024:]

    v(1em)
    par[ #text(weight: "bold", size: 13pt)[„Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungs- und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine anderslautende Genehmigung des Dualen Partners vorliegt.“]
    ]
  }
}