// ============================================================
// 复旦大学学位论文 Typst 模板 - 主要符号对照表
// ============================================================

#import "../config.typ": *

#let notation-page(body) = {
  set text(font: font-family.宋体, size: font-size.小四)
  set par(first-line-indent: 0em, leading: body-leading, justify: true)
  body
}
