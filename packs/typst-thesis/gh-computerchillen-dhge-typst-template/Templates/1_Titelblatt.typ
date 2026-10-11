#import "/Daten.typ": *

#let titelblatt() = {
  set page(
    background: 
      rotate(60deg, text(59pt, fill: luma(85%), [ *SPERRVERMERK* ])
    )
  )
  set par(leading: 10pt, justify: true, spacing: 20pt)
  v(50pt)
  align(text("BACHELORARBEIT", size: 40pt),center)
  v(15pt)
  align(text("zum Thema", size: 12pt),center)
  v(10pt)
  align(text("„"+Titel+"“", size: 12pt, weight: "bold", hyphenate: false),center)
  v(15pt)
  align(text("vorgelegt an der", size: 12pt),center)
  v(-10pt)
  align(text("Dualen Hochschule Gera-Eisenach", size: 12pt),center)
  v(20pt)
  

    table(
      columns: (1fr, 1.5fr),
      stroke: none,
      align: left,
      row-gutter: 15pt,
      column-gutter: 70pt,
      

      text("von:", weight: "bold"), [
        #Author \
        #StraßeHausnr \
        #PLZOrt
      ],

      text("Matrikelnummer:", weight: "bold"), [
        #Matrikelnummer
      ],

      text("Studiengang", weight: "bold"), [
        #Studiengang
      ],

      text("Studienrichtung:", weight: "bold"), [
        #Studienbereich
      ],

      text("Praxispartner:", weight: "bold"), [
        #Ausbildungsstätte \
        #StraßeHausnrAusbilder \
        #PLZOrtAusbilder
      ],

      text("Gutachterin/Gutachter der Dualen Hochschule Gera-Eisenach:", weight: "bold"), [
        #Gutachter
      ],

      text("Gutachterin/Gutachter des Praxispartners (Betreuer i.S.v. § 20 (1) DHGEPrüfO):", weight: "bold"), [
        #Betreuer
      ],
      
    )
}

#titelblatt()