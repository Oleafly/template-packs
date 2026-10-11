// #import "@preview/numbly:0.1.0": numbly
#let numbly(..arr, default: "1.") = (..nums) => {
  let arr = arr.pos()
  nums = nums.pos()
  if nums.len() > arr.len() {
    if default == none {
      return none
    }
    if type(default) == function {
      return default(..nums)
    }
    return numbering(default, ..nums)
  }
  let format = arr.at(nums.len() - 1)
  if format == none {
    return none
  }
  if type(format) == function {
    return format(..nums)
  }
  format.replace(
    regex("\{(\d)(:(.+?))?\}"),
    m => {
      let (a, b, c) = m.captures
      if b != none {
        numbering(c, nums.at(int(a) - 1))
      } else {
        str(nums.at(int(a) - 1))
      }
    },
  )
}

#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#let tnr = "Times New Roman"
#let fsong = (tnr, "FangSong")
#let song = (tnr, "SimSun")
#let hei = (tnr, "SimHei")
#let project(title: "", name: "", idnum: "", major1: "", major2: "", college: "", grade: "", advisor: "", jobtitle: "", unit:"", comments: "", body) = {
  // Set the document's basic properties.
  // set document(title: title)
  counter(page).update(0)
  set page(
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
  )
  set text(font: ("Times New Roman", "SimSun"), lang: "zh")
  // Flag (can be commented)
  // text(font: "SimHei", size: 16pt)[附件3]
  // Or 
  v(16pt)
  // Space
  v(63pt)
  // Title row.
  align(center)[
    #block(text(size: 30pt)[*本科毕业设计（论文）开题报告*])
  ]
  // Space
  v(105pt)
  align(center)[
    #grid(columns: (3.53fr, 10.82fr), row-gutter: 5pt, 
    [#text(weight: "bold", size: 16pt)[课题名称：]], [#text(weight: "bold", font: fsong, size: 16pt)[#title]], [], [#line(length: 100%, stroke: (thickness: 0.5pt))])
  ]
  v(73.5pt)
  // Author information.
  grid(
    columns: (0.22fr, 0.29fr, 0.22fr, 0.29fr),
    rows: (14pt, 16pt, 2pt, 14pt, 16pt, 2pt, 14pt, 16pt, 2pt, 14pt, 16pt, 2pt),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    [#text(size: 14pt, font: song, tracking: 9pt, "学员姓名")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, name)),
    [#text(size: 14pt, font: song, tracking: 56pt, "学号")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: tnr, idnum)),
    v(14pt),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    // align(center, text(size: 14pt, font: fsong, major1)),
    [#text(size: 14pt, font: song, "首次任职专业")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, major2)),
    text(size: 14pt, font: song, "学历教育专业："),
    align(center, text(size: 14pt, font: fsong, major1)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    [#text(size: 14pt, font: song, tracking: 9pt, "命题学院")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, college)),
    [#text(size: 14pt, font: song, tracking: 56pt, "年级")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, grade)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    [#text(size: 14pt, font: song, tracking: 9pt, "指导教员")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, advisor)),
    [#text(size: 14pt, font: song, tracking: 56pt, "职称")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, jobtitle)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
  )
  v(-12pt)
  grid(
    columns: (0.22fr, 0.80fr),
    rows: (14pt, 15pt, 8pt),
    text(size: 14pt, ""),
    text(size: 14pt, ""),
    [#text(size: 14pt, font: song, tracking: 9pt, "所属单位")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, unit)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
  )
  v(58pt)
  align(center)[#text(font: hei, size: 16pt)[国防科技大学教育训练部制]]
  pagebreak()
  // Main body.
  // show par: set block(spacing: 6pt) // for older typst version
  set par(spacing: 6pt)
  set par(justify: true, leading: 6pt, first-line-indent: 2em)
  set page(footer: context [
    #let (cur,) = counter(page).get()
    #align(center)[#text(font: tnr, size: 9pt)[#cur]]
  ])

  [
    #text(font: hei, size: 14pt)[#h(2em)主要内容：]
    #set text(size: 12pt)

一、课题名称、来源、选题依据；

二、本课题国内外研究现状及发展趋势；

三、课题在理论与实践上的意义；

四、课题需要解决的关键理论问题和实际问题；

五、课题研究的基本方法、实验方案及技术路线的可行性论证；

六、开展研究应具备的条件及已具备的条件，并估计在进行论文工作中可能遇到的困难与问题和解决措施；

七、论文研究的进展计划；

八、课题所需器材、设备清单。
#v(60pt)
#text(font: hei, size: 14pt)[编排打印要求：]

#text(font: fsong)[
  （1）采用A4（21cm×29.7cm）白色复印纸，单面黑字打印。上下左右各侧的页边距均为3cm；缺省文档网格：字号为小4号，中文为宋体，英文和阿拉伯数字为Times New Roman，每页30行，每行36字；页脚距边界为2.5cm，页码置于页脚、居中，采用小5号阿拉伯数字从1开始连续编排，封面不编页码。

（2）报告正文最多可设四级标题，字体均为黑体，第一级标题字号为4号，其余各级标题为小4号；标题序号第一级用“一、”、“二、”……，第二级用“（一）”、“（二）” ……，第三级用“1.”、“2.” ……，第四级用“（1）”、“（2）” ……，分别按序连续编排。

（3）正文插图、表格中的文字字号均为5号。
]

  ]

  set heading(numbering: (..args) => {
  let nums = args.pos()
  let level = nums.len() - 1
  let label = ("一、", "（一）", "1.", "（1）").at(level)
  let indents = (0em, 2em, 2em, 2em).at(level)
  let fsize = (14pt, 12pt, 12pt, 12pt).at(level)
  [#h(indents)#numbering(label, nums.at(level))]
})
  
  show heading: it => box(width: 100%)[
    #set text(weight: "regular")
    #counter(heading).display()
    // #h(0.5em)
    #it.body
  ]
  
  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #v(-24pt)
    // #set align(center)
    // #set heading(numbering: "一、")
    #set text(font: hei, size: 14pt, weight: "regular")
    #it
  ]

  show heading.where(
    level: 2
  ): it => box(width: 100%)[
    #v(-24pt)
    #h(2em)
    #set text(font: hei, size: 12pt, weight: "regular")
    #it
  ]

  show heading.where(
    level: 3
  ): it => box(width: 100%)[
    #v(-24pt)
    #h(2em)
    #set text(font: hei, size: 12pt, weight: "regular")
    #it
  ]
  show heading.where(
    level: 4
  ): it => box(width: 100%)[
    #v(-24pt)
    #h(2em)
    #set text(font: song, size: 12pt, weight: "regular")
    #it
  ]
  
  pagebreak()
  set text(size: 12pt)
  // show par: set block(spacing: 12pt) // for older typst version
  set par(spacing: 12pt) // for newer typst version
  set par(justify: true, leading: 12pt, first-line-indent: 2em)
  body
  pagebreak()
  // show par: set block(spacing: 6pt) // for older typst version
  set par(spacing: 6pt) // for newer typst version
  set par(justify: true, leading: 6pt, first-line-indent: 0em)
  grid(
    block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
      #text(font: hei, size: 12pt)[指导教员审核意见：]
      #v(1em)
      #text(font: song, size: 12pt)[#h(2em)#comments]
      #v(63pt) // change here for suitable spacing
      #text(font: song, size: 12pt)[#h(4em)签名：#h(20em)年#h(2em)月#h(2em)日]
    ], 
    block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
      #text(font: hei, size: 12pt)[教研室（研究室、实验室）意见：]
      #v(117pt)
      #text(font: song, size: 12pt)[#h(2em)领导签名：#h(20em)年#h(2em)月#h(2em)日]
    ], 
    block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
      #text(font: hei, size: 12pt)[系（研究所、重点实验室）意见：]
      #v(117pt)
      #text(font: song, size: 12pt)[#h(2em)领导签名：#h(20em)年#h(2em)月#h(2em)日]
    ], 
    block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
      #text(font: hei, size: 12pt)[学院教学科研处（教务处）意见：]
      #v(93pt)
      #text(font: song, size: 12pt)[#h(27em)（公章）]
      #v(12pt)
      #text(font: song, size: 12pt)[#h(27em)年#h(2em)月#h(2em)日]
    ]
  )
  [#text(font: song, size: 10.5pt)[注：开题报告由学员撰写，答辩结束交指导教员。]]

}