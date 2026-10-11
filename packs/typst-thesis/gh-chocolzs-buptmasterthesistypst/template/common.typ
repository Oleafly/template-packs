// Shared constants and helpers for the BUPT thesis template.

#let default-fonts = (
  body: (
    "Times New Roman",
    "SimSun",
    "Noto Serif SC",
    "Source Han Serif SC",
    "STSong",
  ),
  heading: (
    "Arial",
    "SimHei",
    "Noto Sans SC",
    "Source Han Sans SC",
    "Microsoft YaHei",
  ),
  kai: (
    "Times New Roman",
    "KaiTi_GB2312",
    "KaiTi",
    "STKaiti",
    "FangSong",
  ),
  latin: (
    "Times New Roman",
    "Libertinus Serif",
  ),
)

// Word 的“固定值行距”对应基线间距。将文本行盒固定为 1em 后，
// leading = 目标行距 - 字号，可得到稳定的基线间距。
#let fixed-leading(font-size, line-spacing) = line-spacing - font-size

// all: true 确保标题、公式、图表等块级元素后的第一段也缩进。
#let paragraph-indent = (amount: 2em, all: true)

#let degree-name-zh(info) = if info.degree == "doctor" { "博士" } else { "硕士" }
#let degree-name-en(info) = if info.degree == "doctor" { "Doctoral" } else { "Master" }
#let thesis-name-en(info) = if info.degree == "doctor" { "Dissertation" } else { "Thesis" }

#let degree-type-zh(info) = if info.degree_type == "professional" {
  "专业学位"
} else {
  "学术学位"
}

#let study-mode-zh(info) = if info.study_mode == "part-time" {
  "非全日制"
} else {
  "全日制"
}

#let study-mode-en(info) = if info.study_mode == "part-time" {
  "Part-time"
} else {
  "Full-time"
}

#let date-zh(date) = [#date.year 年 #date.month 月 #date.day 日]
#let date-en(date) = [Date #date.day　Month #date.month　Year #date.year]

#let major-break(print-mode: false, weak: false) = {
  if print-mode {
    pagebreak(to: "odd", weak: weak)
  } else {
    pagebreak(weak: weak)
  }
}

#let chapter-numbering(..numbers) = {
  let values = numbers.pos()
  if values.len() == 1 {
    [第#numbering("一", values.first())章]
  } else {
    numbering("1.1", ..values)
  }
}

#let scoped-numbering(..numbers) = context {
  let own = numbers.pos().last()
  let chapter = counter(heading).get().first()
  numbering("1-1", chapter, own)
}

#let equation-numbering(..numbers) = context {
  let own = numbers.pos().last()
  let chapter = counter(heading).get().first()
  [(#numbering("1-1", chapter, own))]
}

#let fill-line(value, width: 78mm, font: default-fonts.body, size: 14pt, weight: "bold") = {
  block(width: width)[
    #align(center)[#text(font: font, size: size, weight: weight)[#value]]
    #v(-1pt)
    #line(length: 100%, stroke: 0.8pt)
  ]
}

// 封面信息栏使用固定高度的字段盒。标签和值共享相同的底部留白，
// 从而让文字基线彼此对齐，并与下划线保持恒定距离。
#let form-field(
  value,
  width: 78mm,
  height: 7mm,
  line-gap: 0pt,
  font: default-fonts.body,
  size: 14pt,
  weight: "bold",
  alignment: center,
) = {
  block(width: width, height: height)[
    #place(bottom)[#line(length: 100%, stroke: 0.8pt)]
    #align(alignment + bottom)[
      #pad(bottom: line-gap)[#text(font: font, size: size, weight: weight)[#value]]
    ]
  ]
}

#let form-label(
  value,
  height: 7mm,
  line-gap: 0pt,
  font: default-fonts.body,
  size: 14pt,
  weight: "bold",
  alignment: right,
) = {
  block(width: 100%, height: height)[
    #align(alignment + bottom)[
      #pad(bottom: line-gap)[#text(font: font, size: size, weight: weight)[#value]]
    ]
  ]
}

// 官方封面固定预留两行题目横线；标题文字从每条横线左端开始。
// 单行标题自动补出第二条空白横线，多行标题应显式写成数组。
#let multi-line-form-field(
  value,
  width: 104mm,
  line-count: 2,
  height: 10mm,
  row-gap: 3pt,
  line-gap: 1.5pt,
  font: default-fonts.body,
  size: 18pt,
  weight: "bold",
  alignment: left,
) = {
  let lines = if type(value) == array { value } else { (value,) }
  assert(
    lines.len() <= line-count,
    message: "封面题目最多支持两行，请缩短题目或重新分行。",
  )
  while lines.len() < line-count {
    lines.push([])
  }

  stack(
    dir: ttb,
    spacing: row-gap,
    ..lines.map(line => form-field(
      line,
      width: width,
      height: height,
      line-gap: line-gap,
      font: font,
      size: size,
      weight: weight,
      alignment: alignment,
    )),
  )
}

// 根据标题级别统一计算样式。一级到三级使用官方模板参数；四级及更深层级
// 自动使用同一套正文型标题样式，因此新增五级、六级标题无需再编写 show 规则。
#let heading-style(level, fonts: default-fonts) = if level == 1 {
  (
    font: fonts.heading,
    size: 16pt,
    alignment: center,
    above: 0pt,
    below: 40pt,
    weight: "regular",
  )
} else if level == 2 {
  (
    font: fonts.heading,
    size: 14pt,
    alignment: left,
    above: 8pt,
    below: 16pt,
    weight: "regular",
  )
} else if level == 3 {
  (
    font: fonts.heading,
    size: 12pt,
    alignment: left,
    above: 8pt,
    below: 5pt,
    weight: "regular",
  )
} else {
  (
    font: fonts.body,
    size: 12pt,
    alignment: left,
    above: 5pt,
    below: 5pt,
    weight: "regular",
  )
}

#let display-heading(it, font, size, alignment: left, above: 0pt, below: 0pt, weight: "regular") = {
  block(width: 100%, above: above, below: below)[
    #set par(first-line-indent: 0pt)
    #align(alignment)[
      #text(font: font, size: size, weight: weight)[
        #context {
          if it.numbering != none {
            counter(heading).display(it.numbering)
            h(1em)
          }
          it.body
        }
      ]
    ]
  ]
}
