#import "@preview/subpar:0.2.2"
#import "@preview/hydra:0.6.3": hydra

// Global settings
#let param = (
  paper: "a4",
  text-size: 12pt,
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
#let masters-report-template(
  title: [Titre du rapport],
  defended-on: [Date de la soutenance],
  author: "Nom de l'auteur",
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
  // Header du document entier sauf page de couverture et 4ème de couverture
  let header = {
    set text(fill: colors.gray)
    context{
      let page-number = counter(page).at(here()).first()
      if page-number > 0 {
        grid(
          columns: (1fr, 1fr),
          [#set align(left)
           #emph(author.first()+ [ -- ] + "Dossier d'alternance")],
          [#set align(right)
           #context strong(hydra(1))]
        )
        v(-1.6em)
        line(length: 100%, stroke: 1pt + colors.red)
      }
    }
  }

// Footer du document entier sauf page de couverture et 4ème de couverture
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

  // Cover Page - Page de couverture

  // Top side logos

grid(
          columns: (1fr, 1fr),
          [#set align(left + top)
           #box(
     stroke: 1pt + colors.gray,
     radius: 5pt,
     height: 2cm,
     width: 3cm,
    inset: 0.5em,

    fill: colors.gray.lighten(60%),
  )[#{align(center + horizon)[logo de l'entreprise]}]],

          [#set align(right + top)
           #image("resources/assets/EICnam.jpg",height: 2cm)]
        )


  [
    #set align(center)
    #set text(weight:"bold")
    
    #v(0.5cm)

    Dossier d'alternance présenté par
    #v(0.5cm)
    #author.first()
    #v(0.5cm)
    Spécialité :

    Génie Nucléaire 1#super[ère] année

    Année universitaire : 2026-2027
    #v(0.5cm)
    Antenne Alternance EI Cnam
    #line(length: 15%, stroke: 1pt)
    
    #v(2cm)
    #grid(columns:27em, // limite la taille horizontale du titre, ajuster au besoin
    title)

    Réalisé dans l'entreprise ...
    #v(0.75em)
    
    Soutenu le #defended-on
    
    #v(2cm)

    #line(length: 15%, stroke: 1pt)
    
    #v(0.75em)

    #upper()[Jury]
    
  ]
 v(1em)
  // Jury
    let jury-colsize = 35%

  align(left)[
    #align(center)[#grid(align:(left),
      columns:(jury-colsize,jury-colsize),
      gutter:10pt,
      ..jury
    )]]
// Bottom side logos
align(bottom)[#grid(
          columns: (1fr,1fr),
          [#set align(left + bottom)
           #image("resources/assets/logo-cnam-bfc.pdf",height:1.5cm)],

          [#set align(right + top)
           #box(
     stroke: 1pt + colors.gray,
     radius: 5pt,
     height: 2cm,
     width: 3cm,
    inset: 0.5em,

    fill: colors.gray.lighten(60%),
  )[#{align(center + horizon)[logos des partenaires]}]],
        )]
  // End of the cover page


  pagebreak()
  // Paragraph settings
  set par(justify: true, leading: param.line-spacing, spacing:2*param.line-spacing)
  set page(
    paper: param.paper,
    header: header,
    footer: footer
  )
  set enum(indent: 2em)
  set list(indent: 2em)

  counter(page).update(1)
  
  body
}