#let ada-blue = rgb("#1e81b1")
#let dark-text = rgb("#2b2b2b")
#let gray-text = rgb("#666666")

#let universities_path = (
  "Universidad de Sevilla": "../assets/logo_US.png",
  "Universidad Pablo de Olavide": "../assets/logo_UPO.png",
  "Universidad de Cádiz": "../assets/logo_UCA.jpg",
  "Universidad de Huelva": "../assets/logo_UHU.png",
)

#let get-university_path(universidad) = {
  universities_path.at(universidad, default: "../assets/logo_US.png")
}

#let card(nombre-equipo, universidad) = {
  block(width: 100%, height: 100%, stroke: none, inset: 0cm)[

    // franjas de color
    #place(top, rect(width: 100%, height: 1.3cm, fill: ada-blue))
    #place(bottom, rect(width: 100%, height: 1.3cm, fill: ada-blue))

    #place(top, dy: 1.6cm)[
      #block(width: 100%, inset: (x: 1cm))[
        #grid(
          columns: (1fr, 2fr, 1fr),
          align: (left + horizon, center + horizon, right + horizon),

          stack(
            dir: ttb,
            spacing: 0.4em,
            text(size: 10pt, fill: gray-text, weight: "bold", tracking: 0.5pt)[Patrocinado por:],
            image("../assets/Logo_ND.png", width: 4cm),
            v(0.35cm),
            image("../assets/logo-ETSII-Color.png", width: 4cm),
          ),

          // Centro: Título
          stack(
            dir: ttb,
            spacing: 0.3em,
            text(size: 18pt, weight: "regular", fill: dark-text, tracking: 1pt)[Concurso de programación],
            v(0.4cm),
            text(size: 32pt, weight: "black", fill: ada-blue)[CompliCAUS V],
          ),

          // Derecha: Logo del evento
          image("../assets/logo-CAUS.png", width: 3.2cm),
        )
      ]
    ]
    #v(2cm)
    // logo us + nombres
    #align(horizon)[
      #block(width: 100%, inset: (x: 1.5cm))[
        #grid(
          columns: (30%, 70%),
          gutter: 0.5cm,
          align: horizon,

          align(center)[
            #image(get-university_path(universidad), width: 5.5cm)
          ],

          align(center)[
            #text(
              size: 45pt,
              weight: "black",
              fill: dark-text,
            )[#nombre-equipo]
          ],
        )
      ]
    ]
  ]
}

#let generate-page(nombre, universidad) = {
  grid(
    columns: 100%,
    rows: (1fr, 1fr),
    gutter: 0pt,

    block(width: 100%, height: 100%, stroke: none)[
      #rotate(180deg, origin: center)[
        #card(nombre, universidad)
      ]
    ],

    block(width: 100%, height: 100%, stroke: none)[
      #card(nombre, universidad)
    ]
  )
}
