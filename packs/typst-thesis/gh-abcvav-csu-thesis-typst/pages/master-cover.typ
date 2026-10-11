#import "../styles/font-settings.typ": *

#let _bold-title(body, font_: font.黑体, size: font-size.小二, weight: "regular") = {
  return align(center)[
    #text(
      font: font_,
      size: size,
      weight: weight,
      body
    )
  ]
}

#let _paper-info(key, val, key-align: left, val-align: center, key-width: auto, val-width: 1fr) = [
  #set text(
        font: global-font,
        size: font-size.四号,
        weight: "thin",
        stroke: 0.2pt,
        bottom-edge: "descender",
      )
  #box(
    width: key-width,
    inset: 1pt,
    align(key-align)[#key]
  )
  #box(
    width: val-width,
    stroke: (bottom: black),
    inset: 1pt,
    align(val-align)[#val]
  )
]

#let cover-info-table(
  一级学科,
  二级学科,
  作者姓名,
  指导教师,
) = [
  #set text(
    font: global-font,
    size: font-size.三号,
    weight: "thin"
  )

  #align(center)[
    #let info-table = table.with(
      columns: (1.5fr, 2.5fr),
      inset: 0.725em,
      stroke: none,
      [一 级 学 科], [#一级学科],
      [二 级 学 科], [#二级学科],
      [作 者 姓 名], [#作者姓名],
      [指 导 教 师], [#指导教师],
    )
    #show text: strong.with(delta: 600)
    #info-table()
  ]
]

#let _student-info-table(
  作者姓名,
  一级学科,
  二级学科,
  研究方向,
  二级培养单位,
  指导教师,
  副指导教师
) = [
  #set text(
    font: global-font,
    size: font-size.三号,
    weight: "thin"
  )

  #align(center)[
    #let info-table = table.with(
      columns: (1.5fr, 2.5fr),
      rows: (35pt,) * 7,
      inset: 0.725em,
      stroke: none,
      [作 者 姓 名], [#作者姓名],
      [一 级 学 科], [#一级学科],
      [二 级 学 科], [#二级学科],
      [研 究 方 向], [#研究方向],
      [二级培养单位], [#二级培养单位],
      [指 导 教 师], [#指导教师],
    )
    #{
      if 副指导教师 == "" [#info-table()]
      else [
        #info-table(
          [副指导教师], [#副指导教师])
      ]
    }
  ]
]

#let _date-info(year, month) = [
  #align(center)[
    #text(spacing: 200%)[#year 年 #month 月]
  ]
]

#let master-cover(
  中图分类号: "",
  学校代码: "10533",
  UDC: "",
  学位: "硕士",
  学位类别: "专业学位",
  论文名称: "学位论文中文题名",
  论文英文名称: "学位论文英文题名",
  作者姓名: "XXX",
  一级学科: "一级学科名称",
  二级学科: "二级学科名称",
  研究方向: "关键词组",
  二级培养单位: "XXX",
  指导教师: "导师姓名",
  副指导教师: "",
  答辩日期: "",
  答辩委员会主席: "",
  年: "XXXX",
  月: "XX"
) = [
  #set page(
    margin: (
      top: 75pt,
      bottom: 40pt,
    )
  )
  #_bold-title(weight: "bold")[#(学位)学位论文]
  #v(3em)
  #_bold-title(font_: font.Times + font.黑体, size: font-size.二号, weight: "bold")[#论文名称]
  #_bold-title(font_: font.Times, weight: "bold")[#论文英文名称]
  #v(10em)
  #cover-info-table(
    一级学科,
    二级学科,
    作者姓名,
    指导教师,
  )
  #place(
    bottom + center,
    dy: -3.5em,
    [
      #set text(font: global-font, size: font-size.小三, weight: "thin")
      #_date-info(年, 月)
    ]
  )

  #pagebreak()
  #pagebreak()

  #_paper-info("中图分类号", 中图分类号, key-width: 18%)
  #h(2.5fr)
  #_paper-info("学校代码", 学校代码, key-align: right) \
  #v(3.9pt, weak: true)
  #_paper-info("UDC", UDC, key-width: 18%)
  #h(2.5fr)
  #_paper-info("学位类别", 学位类别, key-align: right)

  #v(font-size.二号, weak: true)
  #_bold-title(weight: "bold")[#(学位)学位论文]
  #v(2em)
  #_bold-title(font_: font.Times + font.黑体, size: font-size.二号, weight: "bold")[#论文名称]
  #v(1em, weak: true)
  #_bold-title(font_: font.Times, weight: "bold")[#论文英文名称]
  #v(38pt, weak: true)

  #_student-info-table(
    作者姓名,
    一级学科,
    二级学科,
    研究方向,
    二级培养单位,
    指导教师,
    副指导教师,
  )
  #v(38pt, weak: true)

  #_paper-info("论文答辩日期", 答辩日期, key-align: right, val-width: 3.5fr)
  #h(1fr)
  #_paper-info("答辩委员会主席", 答辩委员会主席, key-align: right, val-width: 2fr)

  #v(89pt, weak: true)

  #place(
    bottom + center,
    dy: -4em,
    [
      #set text(font: global-font, size: font-size.小三, weight: "thin")
      #align(center)[#text(spacing: 450%, "中 南 大 学")]
      #v(-8pt)
      #_date-info(年, 月)
    ]
  )

  #pagebreak()
  #pagebreak()
]
