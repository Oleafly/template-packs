// chapters/00-endpage.typ

// --- PAGE DE FIN (Quatrième de couverture) ---
#pagebreak(weak: true)

#page(
  background: image("../assets/global/bg_um.jpg", width: 100%, height: 100%),
  header: none,
  footer: none,
  margin: (x: 2cm, y: 2cm),
)[
  // Bloc des résumés
  #rect(
    width: 100%,
    fill: rgb(255, 255, 255, 0%),
    inset: 0pt,
    radius: 4pt,
    stroke: 0pt
  )[
    #grid(
      columns: (1fr, 1fr), // Deux colonnes : FR à gauche, EN à droite
      gutter: 1cm,
      
      // Colonne Gauche : Français
      [
        #text(weight: "bold", size: 1.2em)[Résumé] \
        #v(0.5em)
        #text(size: 10pt, style: "italic")[
          #lorem(200) 
        ]
        #v(1em)
        #text(weight: "bold", size: 10pt)[Mots-clés :] mot1, mot2, mot3
      ],

      // Colonne Droite : Anglais
      [
        #text(weight: "bold", size: 1.2em)[Abstract] \
        #v(0.5em)
        #text(size: 10pt, style: "italic")[
          #lorem(180)
        ]
        #v(1em)
        #text(weight: "bold", size: 10pt)[Keywords:] word1, word2, word3
      ]
    )
  ]

  // Logos
  #place(bottom + right)[
    #set image(width: 2.5cm) // Taille par défaut des logos
    #grid(
      columns: 3, // Nombre de logos à aligner
      gutter: 1cm, // Espace entre les logos
      align: horizon, // Alignement vertical au centre pour des logos de formes différentes
      
      // Logos Partenaires (à remplacer)
      image("../assets/global/logo_cnrs_bleu.png"),
      rect(width: 2.5cm, height: 1cm, fill: gray.lighten(50%))[Logo Labo], // placeholder
      image("../assets/global/logo_um_short.jpg"),

    )
  ]
]