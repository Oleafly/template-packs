#import "@preview/abbr:0.3.0"
#import "@preview/linguify:0.5.0": *

#let lang-data = toml("../lang.toml")

#let l(key) = linguify(key, from: lang-data)

#let styling-headers(it) = {
  import "@preview/abbr:0.1.1"

  set text(font: "DejaVu Serif", 11pt)

  set par(leading: 0.8em, justify: true)

  show heading: set block(below: 1.5em, above: 2em)

  set page(
    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 3cm,
    ),
  )

  set page(
    numbering: (..numbers) => {
      if numbers.pos().at(0) != 1 {
        align(right)[#numbering("i", numbers.pos().at(0))]
      }
    },
  )

  show outline: it => {
    set page(
      margin: (
        top: 3cm,
        bottom: 2.5cm,
        left: 5cm,
      ),
    )
    show heading: set block(below: 10em)
    it
  }

  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )


  show outline.entry.where(level: 1): it => {
    v(12pt)
    text(weight: "bold")[#it]
  }

  show outline.entry.where(level: 2): it => {
    v(12pt, weak: true)
    text(weight: "medium")[#it]
  }


  it
}

#let styling-main(it) = {
  set text(font: "DejaVu Serif", 12pt)

  set page(
    number-align: right,
    numbering: "1",
  )

  set heading(numbering: "1.1")
  show heading: it => [
    #if it.level == 1 [
      #pagebreak()
      #set block(below: 10em)
      #it
    ] else [
      #it
    ]

  ]

  set page(
    margin: (
      top: 3cm,
      bottom: 2.5cm,
      left: 5cm,
    ),
  )
  set text(size: 12pt, spacing: 150%)

  let current-chapter-title() = context {
    let headings = query(heading.where(level: 1).after(here()))
    if headings == () { panic("At least one heading must be defined.") }
    if headings.first().location().page() == here().page() {
      return headings.first().body
    } else {
      let before = query(heading.where(level: 1).before(here()))
      if before == () { return headings.first().body }
      return before.last().body
    }
  }

  set page(
    header: [
      #align(right)[
        #text(size: 9pt)[
          #current-chapter-title()
        ]
      ]
    ],
  )
  counter(page).update(1)
  it

  show figure: it => {
    set block(below: 2em)
    set text(size: 10pt, spacing: 150%)
    it
  }

}

#let colors = (
  red: rgb("#FD6360"),
  yellow: rgb("#F7E159"),
  blue: rgb("#46A5FF"),
)

#let color-header(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  language: "English",
  color: colors.red,
  dark: false,
) = {

  let fontcolor = if dark { black } else { white }
  let logo = if dark { "logo-black.png" } else { "logo-white.png" }

  set page(fill: color)
  set text(weight: 1000, size: 10pt, font: "DejaVu Serif", fill: fontcolor)

  let a = lower(language.slice(0, 2))
  set text(lang: a)

  [
    #l("program")
  ]
  text()[
    \ \ \
  ]
  align()[
    #text(size: 35pt, fill: fontcolor)[
      #title
      \ \
    ]
    #text(size: 12pt, fill: fontcolor)[
      #subtitle\
      \
      \
      #line(length: 100%, stroke: fontcolor)
      \
      #author\
    ]]

  align(bottom)[
    #grid(
      columns: (1fr, 1fr),
      rows: 100pt,
      rect(stroke: none)[
        #image(logo, width: 100pt)
      ],
      align(right)[
        #rect(stroke: none, width: 100pt, height: 100pt)[
          #align(horizon + left)[
            #grid(
              columns: (10pt, 1fr),
              rows: 35pt,
              line(end: (0%, 90%), stroke: fontcolor),
              align(horizon)[
                #text(size: 10pt, hyphenate: false)[
                  #l("type")
                ]
              ],
            )
          ]
        ]
      ],
    )
  ]
  pagebreak()

  counter(page).update(1)
}

#let header(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  language: "English",
) = {
  let a = lower(language.slice(0, 2))
  set text(lang: a)

  [
    #l("aalto")\
    #l("sci")\
    #l("program")
  ]

  text()[
    \ \ \ \ \ \ \
  ]
  align(right)[
    #grid(
      columns: 70%,
      rows: 100pt,
      align(left)[
        #text(size: 22pt)[
          *#title*
        ]
        \ \ \ \
        #text(size: 13pt)[
          #subtitle\
        ]
        \ \ \ \
        #text(size: 13pt)[
          *#author*
        ]
      ]
    )
  ]
  pagebreak()
  //heading.where(level: 1).after(here())
  let check-if-contents-exists() = context {
    let headings = query(numbering.after(here())).first()
    if headings == () { panic("At least one heading must be defined.") }
    headings.first().body
  }
}

#let intro(
  title: "Title",
  author: "Jaakko Turpela",
  teacher: "Teacher",
  supervisor: "Supervisor",
  keywords: (),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
  subtitle: "SubTitle",
) = {
  let date = (
    date.display("[day padding:none]. ") + l(lower(date.display("[month repr:long]"))) + date.display(" [year]")
  )

  let a = lower(language.slice(0, 2))
  set text(lang: a)
  let logo = "logo-black.png"

  grid(
    columns: (50%, 50%),
    align: (left, right),
    image(logo, width: 70pt),
    align(horizon)[
      #text(size: 12pt)[
        *#l("summary")*
      ]
    ],
  )
  text()[
    \ \ \
  ]

  block(spacing: 0.5em)[
    #strong(l("author"))
  ]
  block(spacing: 0.5em)[
    #author
  ]
  block(spacing: 0.5em)[
    #line(length: 100%, stroke: black)
  ]

  block(spacing: 0.5em)[
    #strong(l("title"))
  ]
  block(spacing: 0.5em)[
    #title
  ]
  block(spacing: 0.5em)[
    #line(length: 100%, stroke: black)
  ]

  block(spacing: 0.5em)[
    #strong(l("subtitle"))
  ]
  block(spacing: 0.5em)[
    #subtitle
  ]
  block(spacing: 0.5em)[
    #line(length: 100%, stroke: black)
  ]

  block(spacing: 0.5em)[
    #strong(l("main_teacher")) #h(1em) #teacher
  ]

  block(spacing: 0.5em)[
    #line(length: 100%, stroke: black)
  ]

  block(spacing: 0.5em)[
    #strong(l("supervisor")) #h(1em) #supervisor
  ]

  block(spacing: 0.5em)[
    #line(length: 100%, stroke: black)
  ]

  block(spacing: 0.5em)[
    #box(width: 100%)[
      #set par(justify: false)
      #text()[
        #strong(l("level")) #l("type")
      ] #h(2fr)
      #text()[
        #strong(l("date")) #date
      ] #h(2fr)
      #text()[
        #strong(l("nof_pages")) #context [ #counter(page).final().at(0) ]
      ] #h(2fr)
      #text()[
        #strong(l("language")) #l("languagename")
      ]
    ]
  ]


  line(length: 100%, stroke: black)

  text(size: 13pt)[
    \ \ \ *#l("summary")* \
  ]

  l("abstract")

  align(bottom)[
    #text(size: 13pt)[
      \ *#l("keywords"):*
    ]
    #keywords.join(", ")
    #line(length: 100%, stroke: black)
  ]

  pagebreak()
}

#let end(bibfile, appendix) = {
  pagebreak(weak: true)

  show bibliography: bib => {
    show "vsk.": "vol."
    bib
  }
  let dd = "../"
  let ddbib = dd + bibfile
  bibliography(ddbib, style: "ieee-aalto.csl", full: true)

  pagebreak(weak: true)

  counter(heading).update(0)
  set heading(numbering: "A.1")

  appendix
}
