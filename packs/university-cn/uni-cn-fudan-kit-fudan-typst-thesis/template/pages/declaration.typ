// ============================================================
// 复旦大学学位论文 Typst 模板 - 独创性声明与授权声明
// 文本按照《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》
// 附件二原文
// ============================================================

#import "../config.typ": *

#let declaration-page(twoside: false) = {
  set page(margin: page-margin, header: none, footer: none)

  v(30pt)

  align(center, text(
    font: font-family.黑体,
    size: font-size.小二,
    weight: "bold",
  )[复旦大学])

  v(10pt)

  align(center, text(
    font: font-family.黑体,
    size: font-size.小二,
    weight: "bold",
  )[学位论文独创性声明])

  v(30pt)

  set text(font: font-family.宋体, size: font-size.小四)
  set par(first-line-indent: 2em, leading: body-leading, justify: true)

  [本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。论文中除特别标注的内容外，不包含任何其他个人或机构已经发表或撰写过的研究成果。对本研究做出重要贡献的个人和集体，均已在论文中作了明确的声明并表示了谢意。本声明的法律结果由本人承担。]

  v(50pt)

  set par(first-line-indent: 0em)

  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    [作者签名：#h(5em)],
    [日期：#h(3em)年#h(2em)月#h(2em)日],
  )

  v(80pt)

  align(center, text(
    font: font-family.黑体,
    size: font-size.小二,
    weight: "bold",
  )[复旦大学])

  v(10pt)

  align(center, text(
    font: font-family.黑体,
    size: font-size.小二,
    weight: "bold",
  )[学位论文使用授权声明])

  v(30pt)

  set par(first-line-indent: 2em)

  [本人完全了解复旦大学有关收藏和利用博士、硕士学位论文的规定，即：学校有权收藏、使用并向国家有关部门或机构送交论文的印刷本和电子版本；允许论文被查阅和借阅；学校可以公布论文的全部或部分内容，可以采用影印、缩印或其它复制手段保存论文。涉密学位论文在解密后遵守此规定。]

  v(50pt)

  set par(first-line-indent: 0em)

  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    [作者签名：#h(5em)],
    [导师签名：#h(5em)],
  )

  v(16pt)

  align(right)[日期：#h(3em)年#h(2em)月#h(2em)日]
}
