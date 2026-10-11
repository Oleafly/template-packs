// fonctions
#let dark_gray = rgb("#676967")
#let white = rgb("#ffffff")
#let lining(it) = text(number-type: "lining", it)
#let arcosh = math.op(limits: false, "arcosh")

#let conf-data = yaml("./conf.yaml")

#let body-font = conf-data.fonts.body-font
#let code-font = conf-data.fonts.code-font
#let math-font = conf-data.fonts.math-font
#let mono-font = conf-data.fonts.mono-font
#let sans-font = conf-data.fonts.sans-font

#let mono(it) = text(font: mono-font, number-type: "lining", it)
#let sans(it) = text(font: sans-font, it)

#let main-color = conf-data.main-color

#let primary-color = rgb(main-color)
#let block-color = dark_gray.lighten(90%) //Section block de code ects
#let body-color = primary-color.lighten(80%) //
#let header-color = primary-color.lighten(65%)
#let fill-color = dark_gray.lighten(50%) // Remplissage des tableaux ects

// template
#let front_header(
  uptitle: "", // surtitre
  title: "", // titre
  subtitle: "", // sous-titre
  authors: (), // liste d'auteurs (name, affiliation, year, class, email), toutes ces catégories sont optionnelles
  date: "", // date
  //
  little_logo:  "", // Si little_logo alors ne pas mettre big_logo (et inversement)
  // little_logo apparaitra en haut à droite de la page de garde
  //
  size_little: 10%, // taille du little logo, valeur de base 10%
  //
  dx_little: -20pt, // décalage horizontal du little logo, valeur de base -20pt
  //
  dy_little: 0pt, // décalage vertical du little logo, valeur de base 0pt
  // 
  big_logo: "",  // Si big_logo alors little_logo et front_image ne seront pas affichés
  // big_logo apparaitra au milieu de l entete de la page de garde 
  // 
  front-image: "", //Si big_logo alors ne pas mettre front-images et little_logo (et inversement)
  // front-image apparaitra au milieu de la page de garde
  // 
  size_front: 80%, // taille de l'image de la page de garde (big_logo ou front-image), valeur de base 80%
  //
  header-title: "", // texte en haut à gauche de la page (dans le header)
  header-middle: "", // texte au milieu du header
  header-subtitle: "", // texte en haut à droite de la page (dans le header)
  number-style: "lining", // style de numérotation (lining, old-style, etc.)
  body // le contenu du document
) = {

  let count = authors.len()
  if count > 3{ //Verifie si il y a plus de 3 auteurs pour éviter que ça déborde sur la page de garde
    rect[Can't Fit More Than *3* Authors On 1st Page: *#count Found*, comment *ligne 52* of `template.typ` to delete this message] //Debordement
  }
  let ncols = calc.min(count, 3)
  set document(title: title)

  set text(lang: "fr")

  set page(margin: 1.75in)

  // police de texte
  set text(font: body-font, number-type: number-style)

  // titres
  show heading: set text(fill: primary-color)
  show heading: set block(above: 1.4em, below: 1em)

  // page de garde
  set page(margin: 0%)

if big_logo != "" {
    place(top + center,
    rect(width: 100%, fill: primary-color, v(2%) + align(center, std.image(big_logo, width: size_front)) + v(2%))
  )
} else {
    
    if little_logo != ""{
       place(top + center,
        rect(width: 100%, height: 10%,  fill: primary-color, v(2%) + place(right, dx: dx_little, dy: dy_little, std.image(little_logo, width: size_little)) + v(2%)))
    } else {
      place(top + center,
        rect(width: 100%, height: 10%,  fill: primary-color))
    }
}

  place(bottom + center, rect(width: 200%,height: 5%, fill: primary-color, [#v(3%)]))

  if date != "" {
    place(bottom + right, dy: -17pt, dx: -40pt, text(size: 18pt, fill: white)[#date])
  }

  if subtitle != ""{
    place(bottom + left, dy: -17pt, dx: 40pt, text(size: 18pt, fill: white)[ #title, #subtitle])
  } else {
    place(bottom + left, dy: -17pt, dx: 40pt, text(size: 18pt, fill: white)[#title])
  }

  

  if big_logo !=""{
    align(center + horizon)[
      #box(width: 70%)[
        #if uptitle != "" {
          set text(tracking: 2pt, number-type: "old-style")
          smallcaps(lower(uptitle))
        }
        #line(length: 100%)
        #v(15pt)
        #text(size: 25pt)[*#title*]
        #if subtitle != "" {
          linebreak()
          linebreak()
          text(size: 25pt)[#subtitle]
        }
        #v(15pt)
        #line(length: 100%)
        #v(20pt)
        #text(size: 17pt)[
          #table(
            align: center,
            stroke: none,
            column-gutter: 15pt,
            columns: (1fr,) * ncols,
            ..authors.map(author => [//Pour mettrez 1 seul auteur mettre autors: ((auteur1... ,),)
              #if author.name != "" {
                strong(author.name); linebreak()
              }
              #if author.affiliation != "" and author.year != "" {
                author.affiliation; " "; author.year; linebreak()
              } else if author.affiliation != "" and author.year == "" {
                author.affiliation; linebreak()
              } else if author.affiliation == "" and author.year != "" {
                author.year; linebreak()
              }
              #if author.class != "" {
                emph(author.class); linebreak()
              }
              #if author.email != "" {
                set text(size: 12pt)
                link("mailto:" + author.email, mono(author.email))
              }
            ])
          )
        ]
      ]
    ]
    } else {
      if uptitle != "" {
          place( top + right, dy: 30pt, dx: -470pt ,text(tracking: 2pt, number-type: "old-style", size: 2em, fill: white)[
          #uptitle])
        }
      place(top+center, dy: 150pt, [
      #box(width: 70%)[
        #line(length: 100%)
        #v(15pt)
        #text(size: 25pt)[*#title*]
        #if subtitle != "" {
          linebreak()
          linebreak()
          text(size: 25pt)[#subtitle]
        }
        #v(15pt)
        #line(length: 100%)
        #v(20pt)
        #rect(align(center,std.image(front-image, width: size_front)), stroke: none)
        #text(size: 17pt)[
          #table(
            align: center,
            stroke: none,
            column-gutter: 15pt,
            columns: (1fr,) * ncols,
            ..authors.map(author => [//Pour mettrez 1 seul auteur mettre autors: ((auteur1... ,),)
              #if author.name != "" {
                strong(author.name); linebreak()
              }
              #if author.affiliation != "" and author.year != "" {
                author.affiliation; " "; author.year; linebreak()
              } else if author.affiliation != "" and author.year == "" {
                author.affiliation; linebreak()
              } else if author.affiliation == "" and author.year != "" {
                author.year; linebreak()
              }
              #if author.class != "" {
                emph(author.class); linebreak()
              }
              #if author.email != "" {
                set text(size: 12pt)
                link("mailto:" + author.email, mono(author.email))
              }
            ])
          )
        ]
      ]
    ])
  }

  pagebreak()

  // table des matières
  set page(
    margin: auto,
    numbering: (n, ..) => [#n],
    number-align: center
  )

  // Footer
  set page(footer: context {
    let i = counter(page).at(here()).first()

    let is-odd = calc.odd(i)
    let aln = if is-odd {
      right
    } else {
      left
    }

    let target = heading.where(level: 1)
    if query(target).any(it => it.location().page() == i) {
      return align(aln)[#i]
    }

    let before = query(target.before(here()))
    if before.len() > 0 {
      let current = before.last()
      let gap = 1.75em
      let chapter = smallcaps(lower(text(
        size: 0.68em,
        tracking: 0.5pt,
        fill: primary-color,
        current.body
      )))
      if is-odd {
        align(aln)[#chapter #h(gap) #text(number-type: "lining")[#i]]
      } else {
        align(aln)[#text(number-type: "lining")[#i] #h(gap) #chapter]
      }
    }
  })

  // contenu
  set page(header: [
    #text(size: 9pt)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        rows: 1,
        header-title,
        [#text(weight: "bold", header-middle)],
        [#text(style: "italic", header-subtitle)]
      )
      #line(length: 100%, stroke: 0.4pt + black)
    ]
  ])

  // réglage des titres
  set heading(numbering: (..n) =>
    text(number-type: "lining", numbering("I.1.A.a.i. ", ..n))
  )
  
  show heading: set text(fill: primary-color)
  show heading: set block(above: 1.4em, below: 1em)

  // l'affichage des listes
  set enum(
    indent: 1em,
    numbering: n => [#text(fill: rgb(main-color), numbering("1.", n))]
  )

  set list(
    indent: 1em,
    marker: ([#text(fill: primary-color)[--]], [#text(fill: primary-color)[•]], [#text(fill: primary-color)[‣]])
  )

  // réglages paragraphes
  set par(
    leading: 0.55em,
    spacing: 1em,
    first-line-indent: (all: true, amount: 1.8em),
    justify: true
  )

  // le séparateur dans la légende des figures
  set figure.caption(separator: [ : ])

  show figure.caption: it => [
    #smallcaps[
      #it.supplement #context it.counter.display(it.numbering)
    ]
    #it.separator
    #it.body
  ]

  // permet de casser l'affichage des figures
  show figure: set block(breakable: false)

    // on règle l'affichage du code
  show raw: it => {
    text(
      font: code-font,
      number-type: "lining",
      it
    ) // police pour les blocs de texte brut
  }

  // on règle l'affichage des blocs de code
  show raw.where(block: true): block.with(
    fill: block-color,
    radius: 0.5em,
    inset: 1em,
    stroke: 0.1pt,
    width: 100%
  )

  // on règle l'affichage du code en ligne
  show raw.where(block: false): box.with(
    fill: block-color,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 3pt,
  )

  // on règle l'affichage des équations en ligne
  show math.equation: set text(font: math-font)

  // on règle l'affichage des blocs d'équation
  show math.equation: it => {
    show regex("\d+\.\d+"): it => {
      show ".": {"," + h(0pt)}
      it
    }
    it
  } // permet d'utiliser les virgules comme séparateur décimal

  // on règle l'affichage des liens
  show link: it => {
    if type(it.dest) == str {
      text[
        #it#super(
          typographic: false,
          size: 0.75em,
          text(fill: blue, sym.circle.small)
        )
      ]
    } else {
      text[
        #it#super(
          typographic: false,
          size: 0.75em,
          text(fill: fill-color, sym.square)
        )
      ]
    }
  }

  // bloc de citation
  show quote.where(block: true): it => {
    v(-5pt)
    block(
      fill: block-color, inset: 5pt, radius: 1pt,
      stroke: (left: 3pt+fill-color), width: 100%,
      outset: (left:-5pt, right:-5pt, top: 5pt, bottom: 5pt)
      )[#it]
    v(-5pt)
  }

  // tableaux
  show table: set table(
    stroke: 0.6pt + primary-color,
    fill: (x, y) =>
      if y == 0 {
        body-color
      } else if calc.even(y) {
        block-color
      } else {
        none
      }
    ,
    inset: (x: 0.4em, y: 0.4em)
  )
  show table.cell.where(y: 0): set text(
    style: "normal", weight: "bold"
  )
  show table: set text(number-type: "lining")

  // on règle l'affichage des équations en ligne
  show math.equation: set text(font: math-font)

  // réglages figures
  show figure: set block(breakable: true)
  show figure.where(kind: table): set figure(supplement: [Tabl.])
  show figure.where(kind: table): set figure.caption(position: top)

  show figure.where(kind: raw): set figure(supplement: [List.])
  show figure.where(kind: raw): set align(left)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.caption.where(kind: raw): set align(center)

  show figure.where(kind: "equation"): set figure(supplement: [Équ.])

  body
}
