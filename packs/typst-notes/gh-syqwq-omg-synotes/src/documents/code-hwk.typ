#import "../utils/mod.typ": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/theorion:0.4.0": remark

#let link-color = rgb("#227591")

#let doc(author: "author", id: 123456789, hw-id: 1,course:"course", body) = {
  show: show-utils
  set text(font: (en-font-serif, cn-font-serif), weight: 100)


  set outline.entry(fill: repeat(math.dot, gap: 0.1em))
  show outline.entry: it => text(fill: link-color, it)
  show link: it => text(fill: link-color, it)

  set heading(numbering: "I.1")
  set page(numbering: "1", header: context {
    if here().page() == 1 { return none }
    align(center, box(image("../pic/ecnu-logo.svg"), height: 45%))
  })

  show heading.where(level: 1): it => text(size: 16pt, it)
  show heading.where(level: 2): it => text(size: 14pt, it)

  align(center, underline(stroke: red + 0.7pt, offset: 5pt, (
    underline(stroke: red + 0.7pt, offset: 3pt, text(size: 20pt, weight: 500, [
      #course -HW #hw-id 报告
    ]))
  )))

  align(center, text(size: 13pt)[
    #author #id \
    #datetime.today().display("[year].[month].[day]")
  ])

  outline(title: " 总览", depth: 2)

  body
}

#let remark = remark.with(fill: rgb("#5b67d8"))
