#import "../utils/style.typ": 字号, 字体
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/header.typ": header-render

#let master-abstract(
  doctype: "master",
  degree: "academic",
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  keywords: (),
  outline-title: "摘 要",
  outlined: true,
  anonymous-info-keys: ("author", "grade", "supervisor", "supervisor-ii"),
  leading: 1.0em,
  spacing: 1.0em,
  body,
) = {
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "西北工业大学学位论文"),
    author: "张三",
    grade: "20XX",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
  ) + info

  if type(info.title) == str {
    info.title = info.title.split("\n")
  }

  set page(header: header-render([摘　要], fonts: fonts))

  [
    #set par(leading: leading, spacing: spacing, justify: true)
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    #block[
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(leading: 3.6pt)
      #v(15.6pt, weak: false)
    ]

    #block(width: 100%, above: 8pt, below: 0pt)[
      #align(center)[
        #set text(font: fonts.黑体, size: 字号.三号)
        #set par(leading: 4pt)
        摘　要
      ]
    ]

    #block[
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(leading: 3.6pt)
      #v(15.6pt, weak: false)
    ]

    #[
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(first-line-indent: (amount: 2em, all: true))
      #body
    ]

    #v(1em)
    #h(2em)#text(font: fonts.黑体, size: 字号.小四)[关键词：]#text(font: fonts.宋体, size: 字号.小四)[#(("",) + keywords.intersperse("；")).sum()]
  ]
}
