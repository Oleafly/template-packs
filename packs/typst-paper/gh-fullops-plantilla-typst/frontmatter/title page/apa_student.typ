#import "../../config/variables.typ": *

#page(
  numbering: "1",
  header: none,
  footer: none,
)[
  #align(center)[

    // ==================================================
    // BLOQUE SUPERIOR
    // TÍTULO
    // ==================================================
    #block(width: 15cm)[
      #text(weight: "bold")[
        #titulo
      ]
    ]

    #v(1fr)

    // ==================================================
    // BLOQUE CENTRAL
    // AUTORES + PROFESOR
    // ==================================================
    #block(width: 15cm)[

      // ----------------------------------------------
      // AUTORES
      // ----------------------------------------------
      #text(weight: "bold")[Autor(es)]

      #v(0.4em)

      #for autor in autores [
        #autor
        #v(0.3em)
      ]


      // ----------------------------------------------
      // PROFESOR
      // ----------------------------------------------
      #v(1.2em)

      #text(weight: "bold")[Profesor]

      #v(0.4em)

      #nombre_instructor
    ]

    #v(1fr)

    // ==================================================
    // BLOQUE INFERIOR
    // INFORMACIÓN INSTITUCIONAL
    // ==================================================
    #block(width: 15cm)[

      #institucion

      #v(0.5em)

      #facultad

      #v(0.5em)

      #carrera

      #v(0.5em)

      #ubicacion

      #v(0.5em)

      #fecha_entrega
    ]
  ]
]
