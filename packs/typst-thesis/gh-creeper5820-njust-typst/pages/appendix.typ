#import "../common.typ": content-width, fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold

#let appendix(body) = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "1",
    header: context {
      thesis-header(
        odd-left: "毕业设计（论文）报告",
        odd-right: thesis-title-state.get(),
        even-left: "附    录",
        even-right: "毕业设计（论文）报告",
      )
    },
    footer: thesis-footer(),
    footer-descent: -3mm,
    header-ascent: 14pt,
  )

  // 目录条目
  // 目录条目
  show heading.where(level: 1, numbering: none): none
  heading(level: 1, numbering: none, outlined: true)[附\u{3000}\u{3000}录]

  // 标题 "附    录"：三号宋体加粗，段前段后各 18 磅，居中
  v(10mm)
  align(center)[
    #set text(font: (fonts.times, fonts.song), size: size.三号)
    #cn-fakebold[附　　录]
  ]
  v(18pt)

  // 子标题：与正文二级标题保持一致（不出现在目录中）
  set heading(outlined: false)
  show heading.where(level: 2): it => {
    set text(font: (fonts.times, fonts.song), size: size.四号)
    set par(first-line-indent: 0em)
    set block(above: 20pt, below: 24pt)
    cn-fakebold(it.body)
  }

  // 正文：小四号宋体，行距与正文保持一致，两端对齐
  set text(font: (fonts.times, fonts.song), size: size.小四)
  set par(
    leading: 12pt,
    spacing: 12pt,
    justify: true,
    first-line-indent: (amount: 2em, all: true),
  )

  body
}
