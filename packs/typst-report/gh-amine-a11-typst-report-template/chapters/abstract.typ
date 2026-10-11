#import "../config.typ": *

#set page(
  margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
  footer: none,
)

// Arabic Abstract
#block(
  width: 100%,
  stroke: 1pt + black,
  inset: 12pt,
  radius: 5pt,
)[
  #align(right)[
    #text(size: 13pt, weight: "bold")[ملخص]
  ]
  
  #v(0.3em)
  
  #align(right)[
    #text(size: 10pt, lang: "ar")[
السلام عليكم
    ]
  ]
  
  #v(0.3em)
  
  #align(right)[
    #text(size: 9pt, weight: "bold", lang: "ar")[
      الكلمات المفتاحية: Location Intelligence، المركبات الكهربائية، Vector Tiles، تحسين الأداء
    ]
  ]
]

#v(0.6em)

// French Abstract
#block(
  width: 100%,
  stroke: 1pt + black,
  inset: 12pt,
  radius: 5pt,
)[
  #text(size: 13pt, weight: "bold")[Résumé]
  
  #v(0.3em)
  
  #text(size: 10pt)[
    lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
  ]
  
  #v(0.3em)
  
  #text(size: 9pt, weight: "bold")[
    Mots-clés : Intelligence géospatiale, Véhicules électriques, Tuiles vectorielles, Optimisation des performances
  ]
]

#v(0.6em)

// English Abstract
#block(
  width: 100%,
  stroke: 1pt + black,
  inset: 12pt,
  radius: 5pt,
)[
  #text(size: 13pt, weight: "bold")[Abstract]
  
  #v(0.3em)
  
  #text(size: 10pt)[
    lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
  ]
  
  #v(0.3em)
  
  #text(size: 9pt, weight: "bold")[
    Keywords: Location Intelligence, Electric Vehicles, Vector Tiles, Performance Optimization
  ]
]

#v(1.2em)

// Contact Information Section
#block(
  width: 100%,
  stroke: 1pt + black,
  inset: 15pt,
  radius: 5pt,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 40pt,
    column-gutter: 40pt,
    [
      #text(size: 11pt, weight: "bold", fill: isi_blue)[Institut Supérieur d'Informatique (ISI)]\
      #text(size: 9pt)[2 Rue Abou Raihane Bayrouni]\
      #text(size: 9pt)[Ariana 2080]\
      #text(size: 9pt)[Tél : (+216) 71 706 164]\
      #text(size: 9pt)[Fax : (+216) 71 706 698]\
      #text(size: 9pt)[Email : isi\@isi.utm.tn]
    ],
    [
      #text(size: 11pt, weight: "bold", fill: isi_blue)[company]\
      #text(size: 9pt)[company address]\
      #text(size: 9pt)[Ariana 2080]\
      #text(size: 9pt)[Tél : (+216) 00 000 000]\
      #text(size: 9pt)[Email : contact\@something.io]\
    ]
  )
]
