// cover.typ — 封面页
// 对应 LaTeX 版 cover.tex

#import "config.typ": *
#import "template.typ": font-size, font-family, heiti, fangsong, underline-field

/// 生成封面页（无页码）
#let cover-page() = {
  // 封面不显示页码
  set page(numbering: none)
  set par(first-line-indent: 0pt)

  align(center)[
    // ---- 校徽 Logo ----
    #v(1cm)
    #image("whut-logo.png", width: 8cm)

    #v(1.5cm)

    // ---- 主标题：小二号仿宋加粗 ----
    #text(
      font: font-family.fangsong,
      size: font-size.xiao-er,
      weight: "bold",
    )[本科生毕业设计（论文）开题报告]

    #v(3cm)

    // ---- 个人信息表格 ----
    #set text(font: font-family.heiti, size: font-size.si)
    #set par(leading: 1.5em) // 2.2 倍行距

    // box 限制表格宽度，使整个表格块在页面中居中
    #box(
      grid(
        columns: (auto, 230pt),
        row-gutter: 1.2em,
        column-gutter: 0.8em,
        align: (right + horizon, center + horizon),
        text(weight: "bold")[学生姓名：],
        underline-field(width: 230pt)[#student-name],

        text(weight: "bold")[导师姓名、职称：],
        underline-field(width: 230pt)[#advisor #advisor-title],

        text(weight: "bold")[所属学院：],
        underline-field(width: 230pt)[#school],

        text(weight: "bold")[专业班级：],
        underline-field(width: 230pt)[#major #class-name],

        text(weight: "bold")[设计（论文）题目：],
        underline-field(width: 230pt)[
          #set text(size: font-size.si)
          #set par(leading: 0.65em)
          #thesis-title
        ],
      )
    )

    #v(1fr) // 弹性空间，将日期推至页面底部

    // ---- 底部日期：三号仿宋 ----
    #text(
      font: font-family.fangsong,
      size: font-size.san,
    )[#submit-date]

    #v(2cm)
  ]
}
