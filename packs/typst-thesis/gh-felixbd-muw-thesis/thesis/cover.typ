#import "@preview/grape-suite:3.1.0": german-dates 

#import "@preview/nth:1.0.1": nth, nths 


#import "preamble.typ": *
// #show: document => my-config(document)
#show: doc => my-config(
  is-draft: false,
  doc
)


#page(
  // margin: (left: 3cm),
  background: [
    #place(dx: 1cm, dy: 6cm,
      image("./images/logo/MedUni-Wien.svg", width: 600%)
    )

    #box(width: 100%, height: 100%, fill: white.transparentize(5%))
  ]
)[

#show link: set text(fill: blue)
#show link: underline

#set text(lang: "en", region: "gb")

#show figure.caption: set text(
  fill: gray.darken(20%),
  size: 7pt,
)

#show figure.caption: set align(right)

#set align(center)  // + horizon

#v(-10mm)
#box(
  image("./images/logo/muw-loco-center.svg", width: 50%)
)

~

#line(length: 110%, stroke: .8mm + dunkelblau.lighten(20%))

#set text(
    fill: dunkelblau.lighten(10%),
    font: (
      "Libre Baskerville",
      "Libertinus Serif"
    ),
  )

#text(weight: "bold", size: 34pt)[
  From Goldfish to Trapezfisch
]

#text(weight: "semibold", size: 20pt)[
  Evolutionary Perspectives on Medical Data Pipelines
]

#v(3mm)

#line(length: 105%, stroke: .8mm + dunkelblau.lighten(20%))

#v(2cm)

#set text(size: 13pt)

by #[
  #set text(size: 15pt, weight: "semibold")
  Alice Bob Charlie #smallcaps[David-Eve]
] \
#text(size: 9pt)[12345678]

#v(1fr)

submitted in partial fulfilment \ of the requirements for the degree of

#text(lang: "de", region: "at")[
  *Diplom-Ingenieur (Dipl.-Ing.)*
]

in Medical Informatics

~

Meducal University of Vienna

// Universitätsklinik für Innere Medizin III
University Hospital for Internal Medicine #numbering("I", 3)

// Klinische Abteilung für Gastroenterologie und Hepatologie
Division of Endocrinology and Metabolism


/*
  Primary Secondary
  First auditor
  Second auditor
*/

#v(1fr)
#set text(size: 12pt)
#table(
  stroke: none, align: left,
  columns: (auto, auto, auto),
  [*#nths(1) Supervisor:*], [Prof. Dr. rer. nat. Name], [(MedUni Vienna)],
  [*#nths(2) Supervisor:*], [Prof. Dr. med. Name], [(MedUni Vienna)],
  [*#nths(3) Supervisor:*], [O.Univ.Prof. Dipl.-Ing. Dr.techn. Name], [(TU Wien)],
  // [*#nth(4) Supervisor*], [Univ.Prof. Dipl.-Ing. Dr.techn. Name], [(TU Wien)],
  [*Place, Date:*], [
    Vienna,
    #sys.inputs.at(
      "date",
      default: datetime.today().display(
        "[day]. [month repr:short] [year]"  // repr:last_two
      )
    )
  ], [],
  [*Semester:*], [
    #german-dates.semester(
      datetime.today(),
      short: true
    )
  ], []
)



#place(bottom + center, dy: 2.3cm)[
  #box(inset: 1.5mm, radius: .4em, fill: gray.lighten(70%).transparentize(25%))[
    #set text(fill: black.transparentize(70%))
    #show link: set text(fill: gray)
    #link("https://meduniwien.ac.at/")[
      // #emoji.chain
      *Git Version:* #sys.inputs.at("git-version", default: "v0.0.0")
    ]
  ]
]

]
