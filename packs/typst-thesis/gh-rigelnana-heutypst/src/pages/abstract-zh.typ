#import "../utils.typ": font-size, font-family

// 中文摘要页
#let abstract-zh(
  keywords: (),
  body,
) = {
  // 标题：小2号黑体，居中，"摘要"间空两字符，段前后各0.5行，单倍行距，段前分页
  // 单倍行距：leading = 1.0em - 0.75em = 0.25em
  // 段前后0.5行：基于正文固定行距22磅，0.5行 = 11pt
  pagebreak()
  v(11pt)
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    摘#h(2em)要
  ])
  v(11pt)

  // 内容：小4号宋体，首行缩进2字符，固定行距22磅
  // leading = 22pt - font-size = 22pt - 12pt = 10pt
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(first-line-indent: 2em, leading: 22pt - 1em, justify: true)
  body

  // 关键词：小4号黑体，顶格，离摘要内容一行距离，行距22磅
  v(22pt)
  par(first-line-indent: 0pt)[
    #text(font: font-family.heiti, size: font-size.xiaosihao)[关键词：]#text(font: font-family.songti, size: font-size.xiaosihao)[#keywords.join("；")]
  ]
}
