#import "../layouts/page-layout.typ": page-header, page-footer
#import "../layouts/basic-layout.typ": basic-layout
#import "../utils/font.typ": 字号

#let abstract-page-cn(keywords: array, body) = {
  show: page-header.with()
  show: basic-layout.with()

  set heading(outlined: false, numbering: none)
  show heading.where(level: 1): it => [
    #set text(bottom-edge: "bounds")
    #pagebreak(weak: true)

    #v(2em)
    #it.body
    #v(1em)
  ]
  show <keyword>: set text(font: ("Times New Roman", "SimHei"), size: 字号.小四, weight: "bold")

  [= 摘#h(2em)要]

  body

  v(1.5em)

  par(first-line-indent: 0em)[
    关键词：<keyword>
    #(("",) + keywords.intersperse("；")).sum()
  ]

  pagebreak()
}

#let abstract-page-en(keywords: (), body) = {
  show: page-header.with()
  show: basic-layout.with()

  set heading(outlined: false, numbering: none)
  show heading.where(level: 1): it => [
    #set text(bottom-edge: "bounds")
    #set text(font: "Times New Roman", weight: "bold")
    #pagebreak(weak: true)

    #v(2em)
    #it.body
    #v(1em)
  ]
  show <keyword>: set text(font: ("Times New Roman", "SimHei"), size: 字号.小四, weight: "bold")

  [= ABSTRACT]

  body

  v(1.5em)

  par(first-line-indent: 0em)[
    Keywords：<keyword>
    #(("",) + keywords.intersperse("；")).sum()
  ]

  pagebreak()
}
