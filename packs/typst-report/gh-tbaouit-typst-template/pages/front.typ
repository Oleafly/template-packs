#import "../templates/presentation.typ": slide-content
#import "cover.typ": *
#let list-of-tables() = {
  pagebreak()
  v(1.5cm)
  heading(level: 1, numbering: none,)[Danh mục bảng]
  v(1.5cm)
  outline(
    target: figure.where(kind: table),
    title: none,
  )
}

#let list-of-figures() = {
  pagebreak()
  v(1.5cm)
  heading(level: 1, numbering: none)[Danh mục hình ảnh]
  v(1.5cm)
  outline(
    target: figure.where(kind: image),
    title: none,
  )
}

#let list-of-abbreviations(entries) = {
  pagebreak()
  v(1.5cm)
  heading(level: 1, numbering: none)[Danh mục từ viết tắt]
  v(1.5cm)
  let rows = entries
    .pairs()
    .enumerate()
    .map(((index, pair)) => {
      let abbreviation = pair.at(0)
      let translations = pair.at(1)
      (
        str(index + 1),
        abbreviation,
        translations.at(0),
        translations.at(1),
      )
    })
    .flatten()

  table(
    columns: (auto, auto, 1fr, 1fr),
    align: (center, center, left, left),
    stroke: 0.5pt + gray,
    table.header(
      [STT],
      [Từ viết tắt],
      [Đầy đủ],
      [Tiếng Việt],
    ),
    ..rows,
  )
}

#let bib(path, style: "ieee", full: true) = {
  let dark-red = rgb("#a00000")
  let light-gray = rgb("#f5f5f5")

  let footer = context {
    let cover = slide-cover-info.get()
    let current = counter(page).at(here()).first()
    grid(
      columns: (1fr, 1fr, 1fr),
      inset: 0pt,
      align: (left, center, right),
      block(width: 100%, fill: dark-red, inset: (x: 12pt, y: 8pt))[
        #text(fill: white, size: 13pt)[University of Information Technology (UIT)]
      ],
      block(width: 100%, fill: light-gray, inset: (x: 12pt, y: 8pt))[
        #text(fill: dark-red, size: 13pt)[#cover.course-name]
      ],
      block(width: 100%, fill: rgb("#E1E1E1"), inset: (x: 12pt, y: 8pt))[
        #text(fill: dark-red, size: 13pt)[#cover.term #h(6em) #current / #cover.total-page]
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
        fill: light-gray,
        inset: (x: 24pt, y: 12pt),
      )[
        #text(size: 24pt, weight: "bold", fill: dark-red)[References]
      ]
    ],
    [
      #pad(left: 1.5cm)[
        #align(horizon)[
          #block(width: 88%)[
            #text(size: 18pt)[
              #bibliography(
                path,
                title: none,
                style: style,
                full: full,
              )
            ]
          ]
        ]
      ]
    ],
    [#footer],
  )
}