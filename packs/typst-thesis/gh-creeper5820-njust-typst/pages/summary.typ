// 附件2.5：中文摘要
// 附件2.6：英文摘要
// 调用时通过 lang 切换语言

#import "../common.typ": fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold, fakebold

#let summary(
  title: none,
  body,
  keywords: (),
  lang: "zh",
) = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "I",
    header: context {
      thesis-header(
        odd-left: "毕业设计（论文）报告",
        odd-right: thesis-title-state.get(),
        even-left: if lang == "zh" { "摘    要" } else { "Abstract" },
        even-right: "毕业设计（论文）报告",
      )
    },
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  // 目录条目
  let toc-title = if lang == "zh" { "摘    要" } else { "Abstract" }
  // 目录条目（隐藏渲染，保留 outline 条目）
  show heading.where(level: 1, numbering: none): none

  let toc-heading = if lang == "zh" { "摘\u{3000}\u{3000}要" } else { "Abstract" }
  heading(level: 1, numbering: none, outlined: true)[#toc-heading]

  // 标题
  v(10mm)
  if title == none {
    title = toc-title
  }

  set par(first-line-indent: (amount: 2em, all: true), leading: 12pt, justify: true)
  set text(font: (fonts.times, fonts.song), size: size.小四)

  align(center)[
    #set text(font: (fonts.times, fonts.song), size: size.三号)
    #fakebold(text(title))
  ]

  text(font: (fonts.times, fonts.song))[#body]

  v(13mm)

  set text(font: (fonts.times, fonts.song), size: size.四号)

  if lang == "zh" {
    par(first-line-indent: (amount: 0em, all: false), leading: 12pt)[
      #cn-fakebold(text("关键词："))
      #set text(font: fonts.song, size: size.小四)
      #(keywords.join("，"))
    ]
  } else {
    par(first-line-indent: (amount: 0em, all: false), leading: 12pt)[
      #fakebold(text("Keywords: "))
      #set text(font: fonts.times, size: size.小四)
      #(sym.space.thin + keywords.join(", "))
    ]
  }
}
