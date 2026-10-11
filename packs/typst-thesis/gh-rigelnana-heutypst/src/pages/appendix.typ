#import "../utils.typ": font-size, font-family

// 附录页
#let appendix-page(
  label: "A",
  title: "",
  standard: none,  // 如 "GB××××××"
  body,
) = {
  // 附录标题：小2号黑体，居中，段前1行，行距22磅
  pagebreak()
  v(22pt)  // 段前1行
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    附录#label
  ])

  // 标准号（如有）：小4号Times New Roman，居中，段后1行
  if standard != none {
    align(center, text(font: "Times New Roman", size: font-size.xiaosihao)[
      #standard
    ])
    v(22pt)  // 段后1行
  }

  // 附录内容：小4号宋体，行距22磅
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(first-line-indent: 2em, leading: 22pt - 1em, justify: true)

  // 附录子标题：小4号黑体，顶格，行距22磅
  show heading.where(level: 2): it => {
    set text(font: font-family.heiti, size: font-size.xiaosihao)
    set par(leading: 22pt - 1em, justify: false)
    it
  }

  body
}
