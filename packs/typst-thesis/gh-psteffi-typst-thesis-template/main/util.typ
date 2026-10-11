#let pageref(label) = context {
  let loc = locate(label)
  let nums = counter(page).at(loc)
  link(loc, numbering(loc.page-numbering(), ..nums))
}

#let todo(body) = box(
  fill: red.lighten(80%),
  inset: 6pt,
  radius: 4pt,
  text(red.darken(20%))[TODO: #body],
)

#let corr = "≙"
#let dnd = "Drag-and-Drop"

#let img(path, cap, lab, wid: auto) = box(width: 100%)[
  #align(center)[
    #figure(image(path, width: wid), caption: cap) #lab]]

#let bsp(body) = box(width: 100%)[
  #line(length: 35%, stroke: 0.6pt)
  *Beispiel*

  #body
  #line(length: 35%, stroke: 0.6pt)
  #v(0.5cm)
]

#let code-line-numbering = it => [
  #box(width: 2.5em)[
    #align(left)[
      #text(size: 0.85em, fill: luma(100))[#it.number]
    ]
  ]
  #h(0.8em)
  #it.body
]

#let code(body, cap, lab) = box(width: 100%)[
  #show raw.line: code-line-numbering
  #figure(
    raw(body, block: true, lang: "java"),
    caption: cap,
  ) #lab
]

