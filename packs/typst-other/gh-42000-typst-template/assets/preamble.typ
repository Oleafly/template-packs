#import "@preview/shadowed:0.3.0": *

#let color_table_header = rgb("#ACE1FF") // <-- KUL cool blue
// #let color_table_header = rgb("#FFFF99") // <-- CEA/CESI hot yellow
#let cea-theme(
  title: [],
  author: (),
  subtitle: none,
  date: datetime.today(),
  footer: [],
  institute: [CEA/DRF/Irfu/DIS/LEI],
  cea-list-style: true,
  lang: "fr",

  footer_txt: "Auteur du document : ",

  color_main: rgb("#ace1ff"), // does nothing, couldnt figure out how to add it to tables
  color_secondary: gray.lighten(65%),
  color_rule: rgb("#00a0ff"),

  show_outline: true,
  outline_title: "Sommaire",
  list_tables: true,
  list_figs: true,
  list_code: false,
  list_tables_name: "Liste des tableaux",
  list_figs_name: "Table des figures",
  list_code_name: "Table des listing",

  logo_l: none,
  logo_r: none,
 body,
) = {
    set page(
    paper: "a4",
    numbering: "1",
    header: context [
        #table(
          columns: (1fr, auto, 1fr),
          align: (left + bottom, center + bottom, right + bottom),
          // fill: red,
          stroke: (x, y) => (
            bottom: if y == 0 { (1.5pt + color_rule ) } else { none },
          ),
          logo_l,
          title,
          logo_r
        )
    ],
    footer: context [
        #table(
          columns: (1fr, auto, 1fr),
          align: (left + horizon, center + horizon, right + horizon),
          stroke: (x, y) => (
            top: if y == 0 { (1.5pt + color_secondary) } else { none },
          ),
          text(fill: color_secondary.darken(20%))[#footer_txt#author],
          context here().page(),
          text(fill: color_secondary.darken(20%))[#date.display()],
        )
    ]
    )
    set heading(numbering: "1.")
    show link: set text(fill: blue, weight: 100)
    show link: underline
    // show heading: highlight.with(fill: gray.lighten(65%));
    // show heading: underline
    show heading: it => {
      set text(size: 14pt, tracking: -0.9pt)
      stack(
        dir: ltr,
        spacing: 0.25em,
        // square(fill: black, size: 19pt),
        box(
          stroke: (top: 1pt+gray, bottom: 1pt+gray),
          inset: 4pt,
          width: 100%,
          fill: gray.lighten(75%),
          )[
            #if it.numbering != none {counter(heading).display()+h(0.5em)}
            #it.body ],
      )
    }
    show figure: set block(breakable: true)
    show heading.where(level: 1): it => {
      set text(size: 14pt, tracking: -0.9pt)
      stack(
        dir: ltr,
        spacing: 0.25em,
        // square(fill: black, size: 19pt),
        shadow(fill: black, spread: 1pt, dx: 1.5pt, dy: 2pt)[
        #box(
          stroke: 1.5pt+gray,
          inset: 6pt,
          width: 100%,
          fill: gray.lighten(75%),
          )[
            #if it.numbering != none {counter(heading).display()+h(0.5em)}
            #it.body ]],
      )
    }
    // show outline.entry: set outline.entry(fill: line(length: 100%, stroke: (thickness: 0.3pt, dash: "loosely-dashed")))
    show outline.entry.where(level: 1): set outline.entry(fill: line(length: 100%, stroke: 0.3pt))
    show outline.entry.where(level: 1): set text(weight: "bold")

    if show_outline { page[ #outline(title: outline_title) ] }
    show figure: it => {
      show figure.caption: set text(0.8em)
      it
    }
    body
    if list_figs or list_tables {
      page[
        #show outline.entry.where(level: 1): set text(weight: "regular")
        #if list_figs {
          heading(numbering: none)[#list_figs_name]
          outline(
            title: none,
            target: figure.where(kind: image),
          )}
          #if list_tables {
            heading(numbering: none)[#list_tables_name]
            outline(
              title: none,
              target: figure.where(kind: table),
            )}
          #if list_code {
            heading(numbering: none)[#list_code_name]
            outline(
              title: none,
              target: figure.where(kind: raw),
            )}
          ]
        }
      }

//======== TABLEAU PAREIL QUE PHILIPPE
#let cea_table(
  ..it,
  gray: 0, // the x maximum for gray columns, put negative for no gray columns
  caption: none,
  // color_main: color_table_header,
  color_main: color_table_header,
  color_secondary: gray.lighten(65%),
  label: none,
  ) = {
  show table.cell.where(y: 0): strong
  [
    #figure(
    table(
      align: left,
      stroke: 0.5pt,
      fill: (x, y) => if y == 0 { color_main } else if x <= gray { color_secondary },
      ..it
    ),
    caption: figure.caption(
      position: top,
      caption,
    ),
  )#label]
}
#let note(..it, body, title: [Note], width: 99%) = {
  align(center)[
    #box(width: width, stroke: 0.5pt, inset: 6pt)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.5em,
        align: (right, left),
        [#underline()[*#title*] *:*], body,
      )
    ]]
}
#let tbd(content) = {
  highlight(fill: rgb(255, 255, 0))[#text(weight: "bold")[#content]]
}
#let listing(
  ..it,
  caption: [],
) = {
  figure(
    block(
      breakable: true,
      fill:gray.lighten(85%),
      inset:1.5em,
      width:99%,
      align(left)[#text(0.95em,
        ..it
      )]
    ),
    caption: figure.caption(
      position: top,
      caption
    ),
  )}

//======== PAGE DE GARDE
#let page_garde(
  _title : none,
  _subtitle : none,
  author : none,

  logo_l : none,
  logo_r : none,
  text_l : [
    Auteur\
    CEA/DRF/Irfu/DIS/LEI
  ],
  text_r : [
    JELASSI Sana\
    CESI/FISA S3E\
  ],
  distribution_header : true,
  distribution_limited : false,
  distribution_txt_limited : [Limitée],
  distribution_txt_open : [Libre],
) = {
  page[
    #grid(
      columns: (auto, 1fr, auto),
      logo_l,
      none,
      logo_r
    )
    #show title: set text(size: 1.8em, weight: "bold")
    #show title: set align(center)
    #show title: smallcaps
    #align(horizon)[
      #title[#_title]#v(-0.25em)
      #align(center)[
        #text(size: 1.75em)[#_subtitle]\
        #v(0.8em)#datetime.today().display()
      ]
    ]
    #align(bottom)[
      #grid(
        columns: (1fr, 1fr),
        align: (left+top, right+top),
        rows: (auto, 40pt),
        text_l,
        text_r,
      )
      #if distribution_header {
        [
          #[ Diffusion : #v(-0.75em) #line(length: 100%) ]
          #grid(
            columns: (2fr, 1fr),
            align: (left, left),
            rows: (auto, 60pt),
            [
              #distribution_txt_limited
              #if distribution_limited {sym.ballot.cross} else {sym.ballot}
            ],
            [
              #distribution_txt_open
              #if not distribution_limited {sym.ballot.cross} else {sym.ballot}
            ]
          )
        ]}
    ]
  ]
}
#let warning(content) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 1.5em,
    text(size: 2em, [#emoji.warning]),
    [#content])
}
