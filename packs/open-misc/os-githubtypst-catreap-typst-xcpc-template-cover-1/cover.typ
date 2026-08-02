#let title = "XCPC Algorithm"
#let author = "Catreap"

#let serif-font = (
  "Noto Serif",
  "Noto Serif CJK SC",
)

#let raw-font = (
  "Fira Code",
  "Noto Sans CJK SC",
)

#set page(paper: "a4")

#align(horizon + center)[
  #text(
    25pt,
    font: serif-font,
    weight: 700,
  )[#title]

  #v(4cm)
  #text(
    18pt,
    font: serif-font,
  )[
    #author

    #(
      datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日")
    )
  ]
]

#pagebreak()

#set heading(numbering: "1.")
#set text(font: serif-font)
#show raw: set text(
  font: raw-font,
  ligatures: false,
  features: (calt: 0),
)

#show outline.entry.where(level: 1): it => {
  v(2em, weak: true)
  text(12pt, it)
}

#outline(indent: 2em)

#pagebreak()

#let code(file) = raw(
  read(file),
  block: true,
  lang: "cpp",
)

#set page(numbering: "1")
#counter(page).update(1)
