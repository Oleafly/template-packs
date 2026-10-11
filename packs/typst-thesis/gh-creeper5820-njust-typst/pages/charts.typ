// 附件2.8：图表目录

#import "../common.typ": content-width, fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold

#let charts() = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "I",
    header: context thesis-header(
      odd-left: "毕业设计（论文）报告",
      odd-right: thesis-title-state.get(),
      even-left: "图表目录",
      even-right: "毕业设计（论文）报告",
    ),
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  show heading.where(level: 1, numbering: none): none
  heading(level: 1, numbering: none, outlined: true)[图表目录]

  set text(font: fonts.song, size: size.小四, lang: "zh")
  set par(leading: 20pt)
  set outline.entry(fill: repeat([.], gap: 0.15em))

  show outline.entry: it => {
    set block(above: 3mm, below: 0pt)
    set text(font: (fonts.times, fonts.song), size: size.小四)
    it
  }

  v(10mm)

  // 标题：3号宋体加粗，居中
  align(center)[
    #set text(font: fonts.song, size: size.三号)
    #cn-fakebold[图表目录]
  ]

  v(6mm)

  outline(title: none, target: figure, indent: 0mm)
}
