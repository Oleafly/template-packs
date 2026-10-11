#import "utils/utils.typ": *

= Position du problème <partie1>

== Énoncé <partie1a>

Paragraphes avec des références : Article @memoireM1, Web @awaf, Chapter @refRAD, Publisher @refCigref ; et des footnotes #footnote[Coucou !].

On peut faire une référence à :
- Une illustration, Comme montré dans la @FigureEFREIParis.
- Un chapitre, comme @partie1 et @partie1a

#figure(caption: "Figure classique", image("assets/efrei_paris.png", width: 30%)) <FigureEFREIParis>
#align(center, box(inset: (top: -1em))[Source de l'illustration : @memoireM1])


#figure(caption: [Table créée avec du markdown])[
  #tablem(align: left)[
    | *Critère*  | *Description*  |
    | ----------- | --------------- |
    | A | B  |
    | A | C
    
    C
    
    C |
  ]
]

#figure(caption: [Table avec cellules colorées])[
  #let P1 = table.cell(fill: green.lighten(60%))[P1 - Haute]
  #let P2 = table.cell(fill: yellow.lighten(60%))[P2 - Moyenne]
  #let P3 = table.cell(fill: red.lighten(60%))[P3 - Faible]
  #table(
    columns: 4,
    [VM \\ C], [Complexité faible], [Complexité moyenne], [Complexité forte],
    [Valeur métier forte   ], P1, P1, P2,
    [Valeur métier moyenne ], P1, P2, P3,
    [Valeur métier faible  ], P2, P3, P3,
  )
]


#figure(caption: [Infobox])[
  #abstract(title: "document (archive censurée)")[
    #set text(size: 9pt)
    Bonjour [A],

    BLABLABLA

  ]
]
#pagebreak()
