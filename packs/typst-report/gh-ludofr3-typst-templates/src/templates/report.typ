// Generates a dedicated Glossary page with automatic formatting
#let glossary_page(theme, terms: ()) = [
  #set page(background: if "toc-bg" in theme.graphics {
    (theme.graphics.toc-bg)()
  })

  #heading(numbering: none)[Glossary]
  #v(1cm)

  #for item in terms [
    #let term = item.at(0)
    #let definition = item.at(1)

    #let ref-key = if item.len() > 2 { item.at(2) } else { none }

    / #term #if ref-key != none {
        context {
          let bib-exists = query(bibliography).len() > 0

          if bib-exists {
            cite(label(ref-key))
          }
        }
      }: #definition
  ]
]

#let part_cover(title: "", target: "", preamble: "", theme) = [
  #pagebreak()
  #set page(background: if "cover-bg" in theme.graphics {
    (theme.graphics.cover-bg)()
  })
  #place(top, hide(heading(level: 1, outlined: true, bookmarked: true)[#title]))

  #align(horizon + center)[
    #text(
      size: 22pt,
      weight: "bold",
      fill: theme.colors.primary,
    )[#title]
    #v(1cm)
    #rect(
      inset: 16pt,
      radius: 6pt,
      stroke: 2pt + theme.colors.primary,
      fill: theme.colors.white,
      width: 85%,
      align(left)[
        #text(weight: "bold", fill: theme.colors.dblue)[Target Audience:] #target \
        #v(0.5cm)
        #text(weight: "bold", fill: theme.colors.dblue)[Preamble:] #preamble
      ],
    )
  ]
]


#let report(
  theme: none,
  title: "",
  author: "",
  email: "",
  company: "",
  dates: "",
  logo-path: none,
  glossary: none,
  acknowledgments: none,
  body,
) = {
  let c-primary = theme.colors.at("primary", default: rgb("#000000"))
  let c-text = theme.colors.at("text", default: rgb("#333333"))
  let c-dblue = theme.colors.at("dblue", default: rgb("#0000FF"))

  let font-main = theme.fonts.at("main", default: "Arial")

  set document(author: author, title: title)
  set text(font: font-main, size: 11pt, fill: c-text)

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    numbering: "1",
    number-align: center,
  )

  set heading(numbering: "1.1.")
  show heading: set text(fill: c-dblue)

  set page(background: if "cover-bg" in theme.graphics {
    (theme.graphics.cover-bg)()
  })

  align(left)[
    #if logo-path != "" {
      image(logo-path, width: 3cm)
    }
  ]

  align(center)[
    #v(4cm)
    #text(size: 26pt, weight: "bold", fill: c-primary)[#title]
    #v(4cm)

    #block(
      fill: c-primary.lighten(95%),
      stroke: 1pt + c-primary,
      inset: 20pt,
      radius: 8pt,
      width: 80%,
      align(left)[
        #text(size: 14pt)[*Author :* #author] \
        #link("mailto:" + email)[#text(fill: c-dblue)[#email]] \
        #v(0.5cm)
        #text(size: 14pt)[*Company :* #company] \
        #text(size: 14pt)[*Date :* #dates] \
      ],
    )
  ]
  pagebreak()

  [
    #set page(background: if "cover-bg" in theme.graphics {
      (theme.graphics.cover-bg)()
    })

    #align(horizon + center)[
      #text(size: 22pt, weight: "bold", fill: c-primary)[Acknowledgments]
      #v(1.5cm)

      #block(
        width: 85%,
        align(left)[
          #if acknowledgments != none [
            #acknowledgments
          ] else [
            #text(
              style: "italic",
            )[_No acknowledgments provided. Please add them via the `acknowledgments` parameter in the project configuration._]
          ]
        ],
      )

      #v(4cm)

      #let styled-link(url, body) = {
        link(url)[
          #underline(stroke: 1.5pt + c-dblue)[
            #text(fill: c-dblue, weight: "bold")[#body]
          ]
        ]
      }

      #text(size: 8pt, fill: c-text)[
        *Technical Note:* The visual identity and geometric components of this document utilize elements from the open-source project #styled-link("https://github.com/Keluaa/cea-slides/tree/main", "cea-slides"), distributed under the CeCILL-C license.
      ]

    ]
  ]

  [
    #set page(background: if "toc-bg" in theme.graphics {
      (theme.graphics.toc-bg)()
    })
    #outline(title: "Table of Contents", indent: auto)
  ]

  set page(background: if "page-bg" in theme.graphics {
    (theme.graphics.page-bg)()
  })

  body
}
