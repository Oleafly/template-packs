#let template(
  title: "",
  subtitle: "",
  front_page_image: none,
  author: "",
  date: datetime.today(),
  keywords: (),
  //
  code_theme: "assets/halcyon.tmTheme",
  code_font: "Ubuntu Mono",
  code_font_size: 12pt,
  doc_font: "Montserrat",
  doc_font_size: 12pt,
  header_font: "Montserrat",
  header_font_size: 10pt,
  // The content
  body
) = {
set page(
    paper: "a4",
    margin: (
        top:3cm,
        bottom: 3cm,
        left:6cm,
        right: 2cm,
    )
)
line(
    length: 200%,
    stroke: (
        paint: rgb("#39cccc"),
        thickness: 6pt,
        cap: "round")
)
block(
    above: 200pt,
    below: 20pt,
    text(
        size: 40pt,
        fill: rgb("#3e474a"),
    )[
        #title
    ]
)
block(text(size: 20pt,fill: rgb("#3e474a"),)[
    #subtitle
])
block(text(size: 20pt,fill: rgb("#3e474a"),)[
    #author
])
if front_page_image != none [
    #image(front_page_image)
]
set page(
    paper: "a4",
    numbering: "1/1",
    margin: (
        top:3cm,
        bottom: 3cm,
        left:3cm,
        right: 2cm,
    ),
    header: [
        #grid(
            columns: (1fr, 1fr),
            [
                #set text(size: header_font_size)
                #title
            ],
            [
                #set align(right)
                #set text(size: header_font_size)
                #date.display("[day]-[month]-[year]")
            ]
        )
        #line(length: 100%)
    ],
    footer: [
        #line(length: 100%)
        #grid(
            columns: (1fr, 1fr),
            [
                #set text(size: header_font_size)
                #author
            ],
            [
                #set align(right)
                #set text(size: header_font_size)
                #counter(page).display("1")
            ]
        )
    ]
)
set text(
    font: doc_font,
    size: 12pt
)
set raw(
    theme: code_theme,
    tab-size: 4,
    )
show raw.where(block: true): (item) => box(
    width: 100%,
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 8pt,
    text(fill: rgb("#a2aabc"), font: code_font, size: 12pt, item)
)
show raw.where(block: false): (item) => box(
  fill: rgb("#1d2433"),
  inset: 2pt,
  radius: 2pt,
  text(fill: rgb("#a2aabc"), font: code_font, size: 12pt, item)
)
set heading(
    numbering: "1.",
)
show heading: set block(below: 20pt)
show heading.where(level: 1): (item) => [
    #pagebreak()
    #text(item)
]
show par: set block(below: 20pt) 
set par(justify: true)
show outline.entry.where(
  level: 1
): it => {
  v(doc_font_size, weak: true)
  strong(it)
}
outline(
    indent: auto
)
body
}
