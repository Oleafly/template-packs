#let cv(
  lang: "",
  paper-size: "",
  font-size: 12pt,
  font-family: "",
  bg: "",
  doc
) = {
  set text(lang: lang)
  set page(paper-size)
  set text(font: (font-family))
  set text(font-size)
  set page(background: image(bg, width: 100%, height: 100%)) if bg != ""
  show heading: it => it.body
  doc
}

#let cover(
  university: "",
  program: "",
  name: "",
  school: "",
  font-family: "",
  logo: "",
  bg: ""
) = {
  set text(font: (font-family)) if font-family != ""
  if bg != "" {
    place(horizon+center, image(bg, width: 130%, height: 120%))
  }
  align(center)[
    #set text(60pt)
    \
    \
    #strong[#university] \
    #set text(38pt)
    #strong[#program]
    \
    \
    #set text(36pt)
    #school \
    #name

    #if logo != "" {
      image(logo, width: 30%)
    }
  ]

  pagebreak()
}

#let toc() = {
  text(22pt)[*目录*]

  set text(14pt)

  show outline.entry.where(level: 1): set block(above: 2.4em)
  // #show outline.entry.where(level: 2): set block(above: 1.6em)

  outline(
    title: [],
    depth: 1
  )

  pagebreak()
}

#let page-numbering(doc) = {
  set page(numbering: "P1")
  set page(footer: context align(center, numbering("1", ..counter(page).get())))
  counter(page).update(1)
  doc
}