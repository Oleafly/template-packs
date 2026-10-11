#import "../utils.typ": font-size, font-family

// 英文摘要页
#let abstract-en(
  keywords: (),
  body,
) = {
  // 标题：小2号Times New Roman加粗，居中，段前后各1行，行距22磅，段前分页
  pagebreak()
  v(22pt)
  align(center, text(font: "Times New Roman", size: font-size.xiaoerhao, weight: "bold")[
    Abstract
  ])
  v(22pt)

  // 内容：小4号Times New Roman，首行缩进2字符，固定行距22磅
  set text(font: "Times New Roman", size: font-size.xiaosihao)
  set par(first-line-indent: 2em, leading: 22pt - 1em, justify: true)
  body

  // 关键词：小4号Times New Roman加粗，顶格，离摘要内容一行距离
  v(22pt)
  par(first-line-indent: 0pt)[
    #text(font: "Times New Roman", size: font-size.xiaosihao, weight: "bold")[Key words: ]#text(font: "Times New Roman", size: font-size.xiaosihao)[#keywords.join(", ")]
  ]
}
