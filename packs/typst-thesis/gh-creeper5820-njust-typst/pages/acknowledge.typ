// 附件2.10：致谢

#import "../common.typ": content-width, fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold

#let acknowledge(body) = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "1",
    header: context {
      thesis-header(
        odd-left: "毕业设计（论文）报告",
        odd-right: thesis-title-state.get(),
        even-left: "致    谢",
        even-right: "毕业设计（论文）报告",
      )
    },
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  // 目录条目
  show heading.where(level: 1, numbering: none): none
  heading(level: 1, numbering: none, outlined: true)[致\u{3000}\u{3000}谢]

  // 标题：3号宋体加粗，居中
  v(10mm)
  align(center)[
    #set text(font: (fonts.times, fonts.song), size: size.三号)
    #cn-fakebold[致　　谢]
  ]

  v(8pt)

  // 正文：小4号宋体，行距20磅，两端对齐
  set text(font: (fonts.times, fonts.song), size: size.小四)
  set par(leading: 12pt, justify: true, first-line-indent: 2em)

  body
}
