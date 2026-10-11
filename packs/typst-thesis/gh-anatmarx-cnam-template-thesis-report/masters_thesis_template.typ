#import "@preview/subpar:0.2.2"
#import "@preview/hydra:0.6.3": hydra

// Global settings
#let param = (
  paper: "a4",
  text-size: 11pt,
  text-font: ("Times New Roman","Arial"),
  line-spacing:1.06em,//équivalent à 1.5 sur Microsoft Word dans ce cas là (j'ai mesuré)
  // math-font: ("Libertinus Math", "New Computer Modern Math"),
  math-font: ("New Computer Modern Math",),
  fig-supplement: [Figure],
)

#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#405A68")
)

#let states = (
  isapp: state("isapp", false)
)


//Environnements
//Appendix
#let appendix(body) = {
  // Reset equation counter
  counter(math.equation).update(0)
  set heading(numbering: "A.",supplement: [Annexe])

  // Reset heading counter
  counter(heading).update(0)


  // set math.equation(numbering: n => numbering("(A.1)", counter(heading).get().first(), n))

  // show figure.where(kind: image): set figure(
  //   numbering: n => numbering("A.1", counter(heading).get().first(), n)
  // )

  states.isapp.update(true)
  [#metadata(none)<appendix-exists>]
  body
}

// Boxed equation
// #let boxeq(body) = {
//   set align(center)
//   box(
//     stroke: 1pt + colors.gray,
//     radius: 5pt,
//     inset: 0.5em,
//     fill: colors.gray.lighten(60%),
//   )[#body]
// }

// Unnumbered equation
// #let nonumeq(x) = {
//    set math.equation(numbering: none)
//    x
// }

// Template
#let masters-thesis-template(
  title: [Titre du rapport],
  defended-on: [Date de la soutenance],
  author: "Nom de l'auteur",
  jury-director:"",
  maitre-app:"",
  tuteur:"",
  rapporteur:"",
  jury: ("Membre A", "Membre B"),
  lang: "fr",
  body
) = {
  // localization
  let localization = json("resources/i18n/fr.json")
  if lang == "en" {
    localization = json("resources/i18n/en.json")
  }

  // Document metadata
  set document(author: author.first(), title: title)

  // Text settings
  set text(font: param.text-font, size: param.text-size, lang: lang)
  show math.equation: set text(font: param.math-font)


  


  // Page settings
  let header = {
    set text(fill: colors.gray)
    context{
      let page-number = counter(page).at(here()).first()
      if page-number > 0 {
        grid(
          columns: (1fr, 1fr),
          [#set align(left)
           #emph(author.first()+ [ -- ] + "Mémoire d'ingénieur")],
          [#set align(right)
           #context strong(hydra(1))]
        )
        v(-1.6em)
        line(length: 100%, stroke: 1pt + colors.red)
      }
    }
  }

  let footer = {
    context{
      let page-number = counter(page).at(here()).first()
      let page-final = counter(page).final().first() - 1 // -1 pour ne pas compter la page de résumé
      if page-number > 0 {
       set align(right)
       set text(fill: colors.gray)
       [Page #page-number #localization.of #page-final]
      }
    }
  }

  set page(
    paper: param.paper,
    header: none,
    footer: none
  )

  // Headings
  set heading(numbering: "I.1.1")
  show heading: it => {
    // set text(font:"Arial")
    block(v(0.5em,weak:true)+
    it+
    v(0em,weak:false))

    // context{
    //   if it.level == 1 and states.isapp.get() {
    //     counter(math.equation).update(0)
    //     counter(figure.where(kind: image)).update(0)
    //     counter(figure.where(kind: table)).update(0)
    //   }
    // }
  }

  // Equations
  set math.equation(numbering: "(1)", 
  supplement: localization.equation
  )

  // Tables
  show figure.where(kind: table): it => {
    set figure.caption(position: top,)
    it
  }
  show figure.where(kind: table): set figure(numbering:"I")

  // Figures
  show figure: set figure.caption(separator: [ -- ])
  show figure.where(kind: image): set figure(
    supplement: param.fig-supplement,
    numbering: "1"
  )
  
  show figure.caption: set text(style: "italic")

  // Cover Page

  // School title
  align(center)[#text(size:11pt,weight:"bold",upper("Conservatoire National des Arts et Métiers"))]

  v(0em)

  align(center)[#upper("Centre régional associé de Bourgogne-Franche-Comté")]

  v(1em)

  align(center)[#line(length: 15%, stroke: 1pt)]

 
  v(0.5cm)

  align(center)[#text(size:11pt,weight:"bold",upper("Mémoire")
  +linebreak()+
  "présenté en vue d'obtenir"
  +linebreak()+
  "le "+ upper("diplôme")+" d'"+ upper("ingénieur·e CNAM"))]

  v(0.5cm)

  align(center)[#text(size:11pt,weight:"bold",upper("Spécialité : ")+"Science de la donnée et Intelligence Artificielle"
  +v(0.5cm)+
  upper("En partenariat avec") + "
L’École Nationale Supérieure d’Arts et Métiers
ET
L’Union des Industries et Métiers de la Métallurgie 71" 
  +
  v(2em)+
  "par"
  +v(2em)+
  author.first()
  +
  v(2em)+

  align(center)[#line(length: 15%, stroke: 1pt)]
  +
  v(1.5cm)+
  grid(columns:27em, // limite la taille horizontale du titre, ajuster au besoin
  title)
  +
  v(0.75em)+
  "Soutenu le " + defended-on
  +
  v(1.5cm)+
  align(center)[#line(length: 15%, stroke: 1pt)]
  +
  v(0.75em)+
  [*JURY*]
  )
  ]
 v(1em)
  // Jury

    let jury-colsize = 35%
    align(center)[#grid(align:(left),
      columns:(jury-colsize,jury-colsize),gutter:10pt,
      upper(strong("Président")) , jury-director,
      upper(strong("Maître d'apprentissage")), maitre-app,
      upper(strong("Tuteur académique")), tuteur,
      upper(strong("Rapporteur")), rapporteur,

      grid.cell(colspan: 2)[],

      upper(text(weight:"bold","Autres examinateurs"),
      ))]


  align(left)[
    #align(center)[#grid(align:(left),
      columns:(jury-colsize,jury-colsize),
      gutter:10pt,
      ..jury
    )]]

  
  pagebreak()
  // Paragraph settings
  set par(justify: true, leading: param.line-spacing, spacing:2*param.line-spacing)
  set page(
    paper: param.paper,
    header: header,
    footer: footer
  )
  set enum(indent:2em)
  set list(indent: 2em)

  counter(page).update(1)
  
  body
}