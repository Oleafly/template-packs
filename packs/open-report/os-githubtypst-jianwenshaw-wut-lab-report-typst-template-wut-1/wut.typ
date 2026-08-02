#let conf(
  title: none,
  number: none,
  course: none,
  college: none,
  teacher: none,
  author: none,
  class: none,
  from: none,
  to: none,
  which: none,
  doc,
) = {
  set page(paper: "a4", margin: (bottom: 2.54cm, top: 2.54cm, left: 3.18cm, right: 3.18cm), numbering: "1")
  // TODO: This maybe a bug
  set text(font: ("Times New Roman", "SimSun"), lang: "zh", region: "cn")
  // 设置首段缩进 
  set par(first-line-indent: 2em)
  grid(columns: (70%, auto), rows: (30pt), [
    #table(
      columns: (23.54%, 25.49%, 25.49%, 25.49%),
      align: (center, center, center, auto,),
      stroke: (.6pt),
      [学生学号],
      [#number],
      [实验课成绩],
      [],
    )
  ])
  box(height: 20pt)
  [
    #set block(spacing: 10pt)
    #align(center, image("assets/logo.jpg"))
    #align(center)[
      #set text(size: 40pt)
      学 生 实 验 报 告 书
    ]
  ]
   
  // text的tracking参数用来设置字间距
  box(height: 140pt) 
  [
    #set text(18pt)
    #set table.hline(stroke: .6pt)
    #align(center)[
      #set text(font: "FangSong_GB2312")
      #table(
        stroke: none,
        columns: (120pt, 190pt),
        align: (left, center),
        row-gutter: (4pt),
        [实验课程名称],
        [#course],
        table.hline(start: 1),
        [#text(tracking: 0.7em)[开课学院]],
        [#college],
        table.hline(start: 1),
        [#text(tracking: 0.02em)[指导老师姓名]],
        [#teacher],
        table.hline(start: 1),
        [#text(tracking: 0.7em)[学生姓名]],
        [#author],
        table.hline(start: 1),
        [学生专业班级],
        [#class],
        table.hline(start: 1),
      )
    ]
  ]
   
  box(height: 30pt)
  align(center)[
    #set text(size: 16pt)
    // #h 用来插入水平距离
    #from #h(0.5cm) -- #h(0.5cm) #to#h(0.3cm)学年#h(0.8cm) 第#h(0.3cm)#text(size: 18pt)[#which]#h(0.3cm)学期
  ]
   
   
  pagebreak()
  doc
}

#let indent = h(2em)
#let experiment_table(course_name: none, project_name: none, student: none, class: none, year: none, month: none, day: none, content) = {
  box(width: 100%, height: 100%)[
    #set block(spacing: 6pt) 
    #text(size: 16pt)[实验课程名称 #underline(course_name) ]
    #figure(align(center)[#table(
        columns: (19.72%, 13.6%, 16.66%, 16.66%, 14.7%, 18.65%),
        align: (auto, auto, auto, auto, auto, auto,),
        [实验项目名称],
        table.cell(colspan: 3)[#project_name],
        [实验成绩],
        [],
        [实验者],
        [#student],
        [专业班级],
        [#class],
        [组别],
        [/],
        [同组者],
        table.cell(colspan: 3)[/],
        [实验日期],
        [#year 年#month 月#day 日],
        table.cell(colspan: 6, align: left)[#content],
      )], kind: table)
  ]
  pagebreak()
} 
#let blank_table(content) = {
  box(width: 100%, height: 100%)[
    #figure(align(center)[#table(columns: (100%), align: left, content)], kind: table)
  ]
  pagebreak()
}
#let enf(content) = {
  set text(lang: "en", font: "Times New Roman")
  set text(size: 11pt)
  content
}
#let section_1() = [
  #set text(font: "SimHei")
  #heading()[第一部分：实验分析与设计]
]

#let section_1_1() = [
  #heading(level: 2)[一、实验内容描述（问题域描述）]
]

#let section_1_2() = [
  #heading(level: 2)[二、实验基本原理与设计（包括实验方案设计，实验手段的确定，试验步骤等，用硬件逻辑或者算法描述）]
]
#let section_1_3() = [
  #heading(level: 2)[三、主要仪器设备及耗材]
  PC机
]

#let section_2() = [
  #set text(font: "SimHei")
  #heading()[第二部分：实验调试与结果分析]
]

#let section_2_1() = [
  #heading(level: 2)[一、调试过程（包括调试方法描述、实验数据记录，实验现象记录，实验过程发现的问题等）]
]

#let section_2_2() = [
  #heading(level: 2)[二、实验结果及分析（包括结果描述、实验现象分析、影响因素讨论、综合分析和结论等）]
]

#let section_2_3() = [
  #heading(level: 2)[三、实验小结、建议及体会]
]