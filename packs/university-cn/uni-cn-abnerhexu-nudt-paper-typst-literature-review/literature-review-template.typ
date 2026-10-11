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
    #block(text(size: 30pt)[*本科毕业设计英文文献综述*])
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
    rows: (14pt, 16pt, 2pt, 14pt, 16pt, 2pt, 14pt, 16pt, 2pt, 14pt, 16pt, 2pt, 14pt, 16pt, 2pt, ),
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
    [#text(size: 14pt, font: song, tracking: 9pt, "培养类型")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, major2)),
    [#text(size: 14pt, font: song, tracking: 56pt, "专业")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, major1)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    [#text(size: 14pt, font: song, tracking: 9pt, "所属学院")#text(size: 14pt, font: song)[：]],
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
    [#text(size: 14pt, font: song, tracking: 9pt, "校内导师")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, advisor)),
    [#text(size: 14pt, font: song, tracking: 56pt, "职称")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, jobtitle)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    text(""),
    line(length: 100%, stroke: (thickness: 0.5pt)),
    v(14pt),
    v(14pt),
    v(14pt),
    v(14pt),
    [#text(size: 14pt, font: song, tracking: 9pt, "校外导师")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, "")),
    [#text(size: 14pt, font: song, tracking: 56pt, "职称")#text(size: 14pt, font: song)[：]],
    align(center, text(size: 14pt, font: fsong, "")),
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
  align(center)[#text(font: hei, size: 16pt)[国防科技大学计算机学院制]]
  pagebreak()
  // Main body.
  // show par: set block(spacing: 6pt) // for older typst version
  set par(spacing: 6pt)
  set par(justify: true, leading: 6pt, first-line-indent: 2em)
  set page(footer: context [
    #let (cur,) = counter(page).get()
    #align(center)[#text(font: tnr, size: 9pt)[#cur]]
  ])

  set heading(numbering: (..args) => {
  let nums = args.pos()
  let level = nums.len() - 1
  let label = ("1.", "(1)", "a.", "I.").at(level)
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
  
  // pagebreak()
  set text(size: 12pt)
  // show par: set block(spacing: 12pt) // for older typst version
  set par(spacing: 12pt) // for newer typst version
  set par(justify: true, leading: 12pt, first-line-indent: 2em)
  body
  // pagebreak()
  // show par: set block(spacing: 6pt) // for older typst version
  // set par(spacing: 6pt) // for newer typst version
  // set par(justify: true, leading: 6pt, first-line-indent: 0em)
  // grid(block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
  //   #text(font: hei, size: 12pt)[指导教员审核意见：]
  //   #v(1em)
  //   #text(font: song, size: 12pt)[#h(2em)#comments]
  //   #v(63pt) // change here for suitable spacing
  //   #text(font: song, size: 12pt)[#h(4em)签名：#h(20em)年#h(2em)月#h(2em)日]
  // ], block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
  //   #text(font: hei, size: 12pt)[教研室（研究室、实验室）意见：]
  //   #v(117pt)
  //   #text(font: song, size: 12pt)[#h(2em)领导签名：#h(20em)年#h(2em)月#h(2em)日]
  // ], block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
  //   #text(font: hei, size: 12pt)[系（研究所、重点实验室）意见：]
  //   #v(117pt)
  //   #text(font: song, size: 12pt)[#h(2em)领导签名：#h(20em)年#h(2em)月#h(2em)日]
  // ], block(stroke: (thickness:0.5pt), width: 100%, height: 156pt, inset: 6pt)[
  //   #text(font: hei, size: 12pt)[学院教学科研处（教务处）意见：]
  //   #v(93pt)
  //   #text(font: song, size: 12pt)[#h(27em)（公章）]
  //   #v(12pt)
  //   #text(font: song, size: 12pt)[#h(27em)年#h(2em)月#h(2em)日]
  // ])
  // [#text(font: song, size: 10.5pt)[注：开题报告由学员撰写，答辩结束交指导教员。]]

}