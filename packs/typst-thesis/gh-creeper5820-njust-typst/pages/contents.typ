#import "../common.typ": content-width, fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold, fakebold

#let contents(body) = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "I",
    header: context thesis-header(
      odd-left: "毕业设计（论文）报告",
      odd-right: thesis-title-state.get(),
      even-left: "目    录",
      even-right: "毕业设计（论文）报告",
    ),
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  block(inset: (top: 2mm, bottom: 8mm))[
    #show heading.where(level: 1, numbering: none): none
    #heading(level: 1, numbering: none, outlined: true)[目　　录]

    #set text(font: fonts.song, size: size.小四, lang: "zh")
    #set par(leading: 20pt)
    #set outline.entry(fill: repeat([.], gap: 0.15em))

    #show outline.entry: it => {
      set block(above: 3mm, below: 0pt)
      if it.level == 1 {
        set text(font: (fonts.times, fonts.song), size: size.四号, weight: "bold")
        cn-fakebold(it)
      } else if it.level == 2 {
        set text(font: (fonts.times, fonts.song), size: size.小四)
        pad(left: 8mm, it)
      } else {
        set text(font: (fonts.times, fonts.song), size: size.小四)
        pad(left: 14mm, it)
      }
    }

    #v(10mm)

    #align(center)[
      #set text(size: size.三号)
      #cn-fakebold(text[目　　录])
    ]

    #v(6mm)

    #body
  ]
}
