#import "template.typ" : *

#show: body => presentation(
  title: "Modèle de présentation",
  subtitle: "Un modèle de présentation avec macros de layout et composants réutilisables",
  author: "Thual Labart-Barnagaud",
  date: "14 juin 2026",
  cover: "resources/mountain.webp",
  body
)

#section("Introduction")

#index()

#single(title: "Introduction")[
  #columns(2)[
    Ce document est à la fois un exemple, une démonstration et une explication sur ce qu'est ce modèle.

    J'ai construit ce modèle afin de pouvoir construire rapidement une présentation de qualité avec *Typst*. Il suffit d'importer le *fichier unique* `template.typ` dans le dossier de votre projet et d'importer les fonctions dont vous avez besoin. 
    
    Je pense qu'il est utile d'importer toutes les fonctions, puisque l'accès aux macros internes vous permet de créer vous-même des layouts plus complexes que ce que je propose.

    ```typ
    #import "template.typ" : *
    ```

    Ce modèle apporte principalement trois choses :
    
    - Un *thème de couleurs*, que vous retrouverez en tête du fichier
    - Un ensemble de *macros* qui permettent de définir des *layouts* spécifiques
    - Un ensemble de *composants réutilisables*, principalement des composants typst légèrement modifiés pour correspondre au thème, et quelques composants uniques (notamment `focus` et `index`)
  ]
]

#split-2(title: "Initialiser la présentation")[
  Pour initialiser la présentation, écrivez :

  ```typ
  #show: body => presentation(
    title: "Comment j'ai survécu à 42 réunions qui auraient pu être un e-mail",
    subtile: "Guide pratique pour feindre une attention totale en visio",
    author: "Moi",
    date: "14 juin 2026",
    cover: "caffertier_en_surchauffe.jpg",
    cover-filter-transparency: 20%
  )
  ```
][
  La seule variable obligatoire est le titre. La variable `cover` vous permet de placer une image en fond de présentation (le format est 16:9). Afin de garantir la lisibilité, cette image sera recouverte par un filtre de la couleur d'accent, avec une transparence par défaut de 20%. Le paramètre `cover-filter-transparency` vous permet de modifier le taux de transparence.
]

#section(
  "Les différents layout",
  subtitle: "Représentation visuelle de tous les layouts disponibles"
)

#split-2(title: "Liste des layouts disponibles")[
  Un layout est une grille dont les cellules contiennent des blocs de contenu.

  `single` désigne le layout le plus simple. Il contient un bloc de contenu et un titre facultatif.

  `split-2` et `split-3` sont les layouts en colonnes. De même, ils peuvent contenir un titre, ou non. Le contenu est aligné en haut à gauche de chaque bloc. Le titre est facultatif.
][
  `focus-slide` permet de mettre en avant un contenu spécifique. Le contenu est centré au milieu de la slide. On peut ajouter un titre, facultatif.

  `cover` vous donne globalement une page vide. Cover est pensé à l'origine pour mettre une image, mais il est parfaitement possible de l'utiliser pour d'autres choses, par exemple pour définir un layout spécifique sur toute la page.
]

#cover()[#image("resources/mountain.webp", fit: "cover", width: 100%)]

#single(title: "Une slide avec titre, un bloc de contenu")[
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
]

#single()[
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
]

#split-2(title: "Une slide avec titre, deux colonnes")[
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
][
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
]

#split-2()[
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
][
  #rect(
    width: 100%, 
    height: 1fr, 
    
    fill: _ACCENT-SOFT
  )
]

#split-3(title: "Une slide avec titre, trois colonnes")[
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )
][
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )
][
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )
]

#split-3()[
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )[
    Dans ce layout, le ration est fixé à `(1fr, 1fr, 1fr)`.
  ]
][
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )
][
  #rect(
    width: 100%, 
    height: 100%, 
    
    fill: _ACCENT-SOFT
  )
]

#focus-slide(title: "Une slide qui met en valeur un contenu, avec titre")[
  #rect(
    width: 50%, 
    height: 50%, 
    
    fill: _ACCENT-SOFT
  )
]

#focus-slide()[
  #rect(
    width: 50%, 
    height: 50%, 
    
    fill: _ACCENT-SOFT
  )
]

#cover()[
  #rect(
    width: 100%,
    height: 100%,
    
    fill: _ACCENT-SOFT
  )[
    #align(center + horizon)[
      #text(
        size: 3em,
      )[
        MON CONTENU
      ]
    ]
  ]
]

#focus-slide()[
  #figure(image("resources/annoying-meeting.png"))
]

#cover()[
  #rect(
    width: 50%,
    height: 50%,
    
    fill: _ACCENT-SOFT
  )[
    #align(center + horizon)[
      #text(
        size: 3em,
      )[
        Un contenu plus petit
      ]
    ]
  ]
]

#section("Les composants réutilisables")

#split-3(
  title: "Les composants principaux"
)[
  Typst nous permet d'écrire en *gras*, _italique_, d'écrire du code directement dans le texte : `helloworld()`...

  On peut écrire des listes :

  - Pomme
  - Poire

  Et des listes ordonnées :

  + Mirabelle
  + Cassis
][
  Le bloc de code permet d'écrire du code avec coloration syntaxique.

  ```rust
  fn main() {
    println!("Hello World!");
  }
  ```

  On peut écrire des math en ligne : $a x^2 + b x + c$ est un polynôme du second degré. On peut aussi écrire des blocs de math :

  $ integral u'(x) dot e^(u(x)) = e^(u(x)) $

  
][
  Le composant `focus` permet de mettre en avant une idée ou une information. Il existe en trois déclinaisons.

  #focus(level: _level.focus)[
    Une note mise en lumière.
  ]
  #focus(level: _level.important)[
    Une information importante.
  ]
  #focus(level: _level.alert)[
    Une information qui ne doit pas être ratée.
  ]
]

#single(title: "Le contenu textuel")[
  Typst permet aussi d'organiser le contenu selon différents niveaux de titres. Dans une présentation, nous ne vous conseillons pas d'utiliser plus de 1 niveau de titre dans le contenu. Les titres de section et de slide sont déjà remappés sur les titres de niveau 1 et 2 visibles dans la slide d'index.

  = #lorem(10)

  #lorem(40)
]

#single(title: "Les layouts avancés")[
  Si vous avez besoin d'un layout plus complexe, n'hésitez surtout pas à créer la slide vous-même. Vous avez plusieurs options :

  #grid(columns: 3)[
    - Introduire une nouvelle grille dans le contenu d'une slide. Vous devez savoir utiliser `grid()` (#link("https://typst.app/docs/reference/layout/grid/")).

    ```typst
    #grid(
      columns: (1fr, 2fr),
      [Contenu de la colonne C1L1],
      [Contenu de la cellule C2L1],
      grid.cell(
        colspan: 2,
        [Cellule s'étendant sur toute la deuxième ligne de la grille]
      )
    )
    ```
  ][
    - Créer une nouvelle page (en dehors de la définition d'une slide !), et utiliser les commandes macros du fichier `template.typ`.

    ```typst
    #pagebreak(weak: true)
    #_layout-grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, 1fr, 1fr),
      stroke: 1pt + _IMPORTANT,
      grid.cell(colspan: 2, _title("Mon titre")),
      grid.cell(rowspan: 2)[], [], [],
      [], grid.cell(colspan: 2)[]
    )
    ```

    Ce code donne le résultat suivant :
  ]
]

#pagebreak(weak: true)
#_layout-grid(
  columns: (1fr, 1fr, 1fr),
  rows: (auto, 1fr, 1fr),
  stroke: 1pt + _IMPORTANT,
  grid.cell(colspan: 2, _title("Mon titre")),
  grid.cell(rowspan: 2)[], [], [],
  [], grid.cell(colspan: 2)[]
)

#section(
  "J'espère que ce modèle vous sera utile !",
  subtitle: "Thual"
)