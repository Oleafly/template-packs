// ============================================================
// 复旦大学学位论文 Typst 模板 - 中文摘要页
// 包含：摘要正文、关键词、中图分类号
// ============================================================

#import "../config.typ": *

#let abstract-zh-page(
  title: "论文题目",
  abstract-body: [],
  keywords: (),
) = {
  set text(font: font-family.宋体, size: font-size.小四)
  set par(first-line-indent: 2em, leading: body-leading, justify: true)

  align(center, text(font: font-family.黑体, size: font-size.三号, weight: "bold", title))
  v(20pt)

  par(first-line-indent: 0em)[#text(font: font-family.黑体, weight: "bold")[摘要：]]
  abstract-body

  v(20pt)

  // 关键词
  par(first-line-indent: 0em)[
    #text(font: font-family.黑体, weight: "bold")[关键词：]
    #text(font: font-family.宋体)[#keywords.join("；")]
  ]

}
