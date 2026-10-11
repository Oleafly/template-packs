// conf.typ

#let language = (
  "en": (
    email: "E-mail",
    references: "References",
    section: "Section",
    figure: "Figure",
    table: "Table",
    version: "Version",
  ),
  "sv": (
    email: "E-post",
    references: "Referenser",
    section: "Avsnitt",
    figure: "Figur",
    table: "Tabell",
    version: "Version",
  ),
)

#let conf(
  title: [Report Title],
  author: (
    name: "Adil Shamji",
    email: "adil02.shamji@gmail.com",
    affiliation: "Linköping University",
  ),
  date: datetime.today(),
  version: "0.1",
  lang: "en",
  rectangle_color: black,
  doc,
) = {
  let t = language.at(lang, default: language.at("en"))
  let affiliation = author.at("affiliation", default: "")
  let email = author.at("email", default: none)
  

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    numbering: "1",
    header-ascent: 25%,
    header: context if here().page() > 1 [
      #set text(size: 9pt)
      #grid(
        columns: (1fr, auto),
        column-gutter: 1em,
        [
          #author.name
          #linebreak()
          #affiliation
        ],
        [
          #align(right, block[
            #set align(left)
            #title
            #linebreak()
            #version
          ])
        ],
  )
  #v(-0.5em)
  #line(length: 100%, stroke: 0.4pt)
]
  )

  set text(
    font: "New Computer Modern",
    lang: lang,
    size: 11pt,
  )

  set par(
    first-line-indent: 0em,
    spacing: 1.4em,
    justify: true,
    leading: 0.7em,
  )

  if title != none {
    text(size: 20pt, weight: "regular", title)
    v(0.45em)

    grid(
      columns: (1fr, auto),
      column-gutter: 1.5em,
      row-gutter: 0.3em,

      text(weight: "bold", author.name),
      date.display("[day] [month repr:long] [year]"),

      if affiliation != "" { affiliation } else { [] },
      if version != none { [#t.version #version] } else { [] },

      if email != none { [#t.email: #email] } else { [] },
      [],
    )

    v(0.3em)
  }
 // I have taken the rectangle implementation from https://github.com/coli-saar/bananote/blob/main/main.typ
  set heading(numbering: "1.1")
  let heading_size = 12pt

show heading.where(level: 1): it => {
  v(2em, weak: true)

  block(below: 1em)[
    #place(dx: -3mm - 2em, dy: -3.5pt)[
      #box(width: 2em)[
        #context {
          align(right)[
            #box(fill: rectangle_color, width: 1em, height: 1em)[
              #if it.numbering != none [
                #align(center + horizon)[
                  #set text(
                    font: "New Computer Modern",
                    weight: "bold",
                    size: heading_size,
                    fill: white,
                  )
                  #counter(heading).get().first()
                ]
              ]
            ]
          ]
        }
      ]
    ]

    #it.body
  ]
}  
  show heading.where(level: 2): set text(weight: "bold", size: 12pt)
  show heading.where(level: 2): set block(above: 1.4em, below: 0.8em)

  doc
}
