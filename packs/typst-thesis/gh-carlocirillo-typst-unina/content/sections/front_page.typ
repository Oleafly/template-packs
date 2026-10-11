#import "../config.typ": *

#set page(
  paper: "a4",
  margin: (x: 3cm, y: 3cm),
  header: none,
  numbering: none,
)

#align(center)[
  #smallcaps[
    #set text(size: 21pt)
    Università degli Studi di Napoli Federico II\

    #set text(size: 18pt)
    #image("../images/logo_unina.png", width: 40%)\
    Scuola Politecnica e delle Scienze di Base\
    Dipartimento di Ingegneria Elettrica e Tecnologie dell'Informazione\
    Corso di Laurea Triennale in Ingegneria Informatica\

    #text(size: 30pt, weight: "bold")[
        #context document.title
      ]
  ]

  #set text(size: 15pt)
  #columns(2)[
    *Relatore*\
    Prof. Relatore

    #colbreak()

    *Candidato*\
    #nome #smallcaps(cognome)\
    #matricola
  ]

  #align(bottom)[
    Anno Accademico 2025-2026
  ]
]
