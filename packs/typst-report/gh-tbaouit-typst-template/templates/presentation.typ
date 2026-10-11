#import "../core/theme.typ": make-theme

#let slide-content(title, body) = {
  let footer = context {
    let cover = state("slide-cover-info", (:)).get()
    let course = if "course-name" in cover { cover.course-name } else { "" }
    let term = if "term" in cover { cover.term } else { "" }
    let total = if "total-page" in cover {
      cover.total-page
    } else {
      counter(page).final().first()
    }
    let current = counter(page).at(here()).first()

    grid(
      columns: (1fr, 1fr, 1fr),
      inset: 0pt,
      align: (left, center, right),
      block(width: 100%, fill: rgb("#a00000"), inset: (x: 12pt, y: 8pt))[
        #text(fill: white, size: 13pt)[University of Information Technology (UIT)]
      ],
      block(width: 100%, fill: rgb("#f1f3f5"), inset: (x: 12pt, y: 8pt))[
        #text(fill: rgb("#a00000"), size: 13pt)[#course]
      ],
      block(width: 100%, fill: rgb("#e1e1e1"), inset: (x: 12pt, y: 8pt))[
        #text(fill: rgb("#a00000"), size: 13pt)[#term #h(6em) #current / #total]
      ],
    )
  }

  set page(
    paper: "presentation-16-9",
    margin: 0pt,
    header: none,
    footer: none,
  )
  pagebreak()

  grid(
    rows: (auto, 1fr, auto),
    columns: 1fr,
    [
      #rect(
        width: 100%,
        fill: rgb("#f5f5f5"),
        inset: (x: 24pt, y: 12pt),
      )[
        #text(size: 24pt, weight: "bold", fill: rgb("#a00000"))[#title]
      ]
    ],
    [
      #pad(left: 2cm)[
        #align(horizon)[
        #block(width: 88%)[#body]
      ]
      ]
      
    ],
    [#footer],
  )
}

#let presentation(title: "", author: "", body) = {
  let t = make-theme(preset: "presentation")

  let footer = context {
    let cover = state("slide-cover-info", (:)).get()
    let footer-author = if "author" in cover { cover.author } else { author }
    let footer-course = if "course-name" in cover { cover.course-name } else { title }
    let footer-term = if "term" in cover { cover.term } else { "" }
    let total = if "total-page" in cover { cover.total-page } else { counter(page).final().first() }
    let current = counter(page).at(here()).first()

    grid(
      columns: (1fr, 1fr, 1fr),
      inset: 0pt,
      align: (left, center, right),
      block(width: 100%, fill: rgb("#a00000"), inset: (x: 12pt, y: 8pt))[
        #text(fill: white, size: 13pt)[University of Information Technology (UIT)]
      ],
      block(width: 100%, fill: rgb("#f1f3f5"), inset: (x: 12pt, y: 8pt))[
        #text(fill: rgb("#a00000"), size: 13pt)[#footer-course]
      ],
      block(width: 100%, fill: rgb("#e1e1e1"), inset: (x: 12pt, y: 8pt))[
        #text(fill: rgb("#a00000"), size: 13pt)[#footer-term #h(6em) #current / #total]
      ],
    )
  }

  set page(
    paper: "presentation-16-9",
    margin: 0pt,
    header: none,
    footer: footer,
  )

  set text(font: t.font-body, size: t.size-body, fill: t.text, lang: "vi")
  set par(leading: t.line-height, first-line-indent: 0pt, justify: false)

  show heading.where(level: 1): it => {
    rect(
      width: 100%,
      fill: rgb("#f5f5f5"),
      inset: (x: 24pt, y: 12pt),
      stroke: (bottom: 2pt + rgb("#a00000")),
    )[
      #text(size: 26pt, weight: "bold", fill: rgb("#a00000"))[#it.body]
    ]
  }

  show heading.where(level: 2): it => {
    block(width: 100%, inset: (top: 12pt, bottom: 8pt))[
      #text(size: 22pt, weight: "bold", fill: rgb("#a00000"))[#it.body]
    ]
  }

  show heading.where(level: 3): it => {
    text(size: 18pt, weight: "bold", fill: rgb("#a00000"))[it.body]
  }
  set par(justify: true)
  body
}