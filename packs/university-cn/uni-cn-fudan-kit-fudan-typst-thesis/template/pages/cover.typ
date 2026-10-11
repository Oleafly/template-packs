// ============================================================
// 复旦大学学位论文 Typst 模板 - 封面
// 按《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》
// 附件一标准样本制作
// 参考 MobtgZhang/fudan-typst-thesis 封面布局
// ============================================================

#import "../config.typ": *
#import "../utils.typ": *

// ============================================================
// 研究生封面（硕士/博士，学术/专业学位）
// ============================================================
#let graduate-cover(info) = {
  set page(margin: page-margin, header: none, footer: none)
  set text(font: font-family.宋体)
  set par(first-line-indent: 0em)

  // ===== 顶部：中图分类号 / 密级 / 学校代码 =====
  grid(
    columns: (1fr, 1fr),
    align: (left + top, right + top),
    text(size: font-size.小四)[中图分类号：#info.at("clc", default: "")],
    stack(
      dir: ttb,
      spacing: 4pt,
      if info.at("secret-level", default: none) != none {
        text(size: font-size.小四)[密级：#info.secret-level]
      },
      text(size: font-size.小四)[学校代码：#school-code],
    ),
  )

  v(18pt)

  // 非同等学力、非英文项目时不显示该行。
  if info.at("equivalent-education", default: false) or info.at("english-program", default: false) {
    align(center, text(size: font-size.小四)[
      #if info.at("equivalent-education", default: false) [同等学力人员]
      #if info.at("equivalent-education", default: false) {
        if info.at("english-program", default: false) { " / " }
      }
      #if info.at("english-program", default: false) [英文项目]
    ])
  } else {
    v(font-size.小四)
  }

  v(10pt)

  // ===== 校名图片（毛泽东题写） =====
  align(center)[
    #figure(
      image("../../images/fudan-name.png", width: 2.65in),
      outlined: false,
    )
  ]

  v(8pt)

  // ===== 学位论文类别 =====
  align(center + top)[
    #(if info.degree == "博士" or info.degree == "doctor" {
      text(
        tracking: 0.45em,
        "博士学位论文",
        font: font-family.宋体,
        size: font-size.二号,
      )
    } else {
      text(
        tracking: 0.45em,
        "硕士学位论文",
        font: font-family.宋体,
        size: font-size.二号,
      )
    })

    // 学位类别
    #if info.at("degree-category", default: none) != none {
      text(
        "（" + info.degree-category + "）",
        font: font-family.宋体,
        size: font-size.小三,
      )
    }

    #v(28pt)

    // ===== 论文中文标题（加粗） =====
    #text(
      info.title,
      font: font-family.宋体,
      size: font-size.小二,
      weight: "bold",
    )

    // ===== 论文英文标题 =====
    #if info.at("title-en", default: none) != none {
      text(
        info.title-en,
        font: font-family.宋体,
        size: font-size.小三,
      )
    }
  ]

  v(48pt)

  // ===== 论文信息字段（带下划线） =====
  {
    set text(font: font-family.宋体, size: font-size.四号)
    let label-width = 9em
    let value-width = 205pt

    let field-row(label-content, value) = {
      set align(center)
      grid(
        columns: (label-width, value-width),
        column-gutter: 0pt,
        row-gutter: 0pt,
        align(right + horizon, label-content),
        box(
          width: value-width,
          inset: (left: 12pt, bottom: 4pt, top: 4pt),
        )[
          #align(left, value)
        ],
      )
    }

    align(center)[
      #field-row([学 #h(0.8em) 生 #h(0.8em) 姓 #h(0.8em) 名：], info.author)
      #v(7pt)
      #field-row([学 #h(2.6em) 号：], info.student-id)
      #v(7pt)
      #field-row([导师姓名、职称：], info.supervisor)
      #v(7pt)
      #field-row([学 #h(0.8em) 科 #h(0.8em) 专 #h(0.8em) 业：], info.major)
      #v(7pt)
      #field-row([培 #h(0.8em) 养 #h(0.8em) 单 #h(0.8em) 位：], info.school)
      #v(7pt)
      #field-row([论 文 提 交 日 期：], format-date-cover(info.date))
    ]
  }
}

// ============================================================
// 本科生封面
// ============================================================
#let bachelor-cover(info) = {
  set page(margin: page-margin, header: none, footer: none)
  set text(font: font-family.宋体, size: font-size.小四)

  // 学校代码 + 学号
  align(right + top)[
    #set text(font: font-family.宋体, weight: "semibold", size: font-size.五号)
    #table(
      stroke: none,
      align: (right, left),
      columns: (auto, 100pt),
      [#strong("学校代码：")], [#school-code],
      [#strong("学" + h(2em) + "号：")], [#info.student-id],
    )
  ]

  v(40pt)

  // 校名图片
  align(center)[
    #figure(
      image("../../images/fudan-name.png", width: 3.02in, height: 1.13in),
      outlined: false,
    )
  ]

  v(16pt)

  align(center, text(
    font: font-family.宋体,
    size: font-size.小一,
    weight: "bold",
  )[本 科 毕 业 论 文（设 计）])

  v(80pt)

  // 论文信息字段
  {
    set text(font: font-family.宋体, size: font-size.四号)
    let label-width = 6em
    let value-width = 200pt

    let field-row(label-content, value) = {
      set align(center)
      grid(
        columns: (label-width, value-width),
        column-gutter: 0pt,
        row-gutter: 0pt,
        align(right + horizon, label-content),
        box(
          width: value-width,
          stroke: (bottom: 0.5pt + black),
          inset: (bottom: 5pt, top: 5pt),
        )[
          #align(center, value)
        ],
      )
    }

    align(center)[
      #field-row([#spread-chars("题目", width: 4em, count: 4)：], info.title)
      #v(0.8em)
      #field-row([#spread-chars("院系", width: 4em, count: 4)：], info.school)
      #v(0.8em)
      #field-row([#spread-chars("专业", width: 4em, count: 4)：], info.major)
      #v(0.8em)
      #field-row([#spread-chars("姓名", width: 4em, count: 4)：], info.author)
      #v(0.8em)
      #field-row([#spread-chars("学号", width: 4em, count: 4)：], info.student-id)
      #v(0.8em)
      #field-row([#spread-chars("指导教师", width: 4em)：], info.supervisor)
    ]
  }

  v(1fr)

  align(center, text(
    font: font-family.宋体,
    size: font-size.四号,
  )[#format-date-cover(info.date)])

  v(30pt)
}

// ============================================================
// 盲审封面（隐藏个人信息）
// ============================================================
#let blind-cover(info) = {
  set page(margin: page-margin, header: none, footer: none)

  v(80pt)

  // 校名图片
  align(center)[
    #figure(
      image("../../images/fudan-name.png", width: 3.02in, height: 1.13in),
      outlined: false,
    )
  ]

  v(16pt)

  align(center)[
    #(if info.degree == "博士" or info.degree == "doctor" {
      text(
        "博" + h(1em) + "士" + h(1em) + "学" + h(1em) + "位" + h(1em) + "论" + h(1em) + "文",
        font: font-family.宋体,
        size: font-size.二号,
      )
    } else {
      text(
        "硕" + h(1em) + "士" + h(1em) + "学" + h(1em) + "位" + h(1em) + "论" + h(1em) + "文",
        font: font-family.宋体,
        size: font-size.二号,
      )
    })
  ]

  if info.at("degree-category", default: none) != none {
    v(6pt)
    align(center, text(
      font: font-family.楷体,
      size: font-size.四号,
    )[（#info.degree-category）])
  }

  v(50pt)

  // 盲审仅显示标题和专业
  {
    set text(font: font-family.宋体, size: font-size.四号)
    let label-width = 6em
    let value-width = 200pt

    let field-row(label-content, value) = {
      set align(center)
      grid(
        columns: (label-width, value-width),
        column-gutter: 0pt,
        row-gutter: 0pt,
        align(right + horizon, label-content),
        box(
          width: value-width,
          stroke: (bottom: 0.5pt + black),
          inset: (bottom: 5pt, top: 5pt),
        )[
          #align(center, value)
        ],
      )
    }

    align(center)[
      #field-row([论文题目：], info.title)
      #v(0.8em)
      #if info.at("title-en", default: none) != none {
        field-row([英文题目：], info.title-en)
        v(0.8em)
      }
      #field-row([#spread-chars("学科专业", width: 4em)：], info.major)
    ]
  }

  v(1fr)

  {
    set text(font: font-family.宋体, size: font-size.四号)
    let label-width = 7em
    let value-width = 200pt

    let field-row(label-content, value) = {
      set align(center)
      grid(
        columns: (label-width, value-width),
        column-gutter: 0pt,
        row-gutter: 0pt,
        align(right + horizon, label-content),
        box(
          width: value-width,
          stroke: (bottom: 0.5pt + black),
          inset: (bottom: 5pt, top: 5pt),
        )[
          #align(center, value)
        ],
      )
    }

    align(center)[
      #field-row([论文提交日期：], format-date-cover(info.date))
    ]
  }

  v(30pt)
}

// ============================================================
// 封面总入口
// ============================================================
#let cover-page(info, blind: false) = {
  if blind {
    blind-cover(info)
  } else if info.degree == "bachelor" {
    bachelor-cover(info)
  } else {
    graduate-cover(info)
  }
}
