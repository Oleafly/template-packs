#let title-content = [苏州大学实验报告]
// 由于 Typst 的限制，为了实现内容框，目前页数必须手动指定。
#let num-pages = 3

// 编辑以下基本信息 - Edit the following basic information
//
// 这些信息会出现在实验报告开头的表格中。
// This information appears in the table at the beginning of the report.

// 实验名称 - Name of the assignment
#let assignment = [实验 X、实验名称]
// 姓名 - Your name
#let author = [你的姓名]
// 班级（通常为年级 专业的形式） - Your class (typically "grade major")
#let class = [年级 专业]
// 实验日期 - When you do the assignment
#let date = [2025-12-1]
// 同组实验者，若没有则填「无」
// Other group memebers, "无" if there is none
#let friends = [无]
// 课程名称 - Name of the course
#let lesson = [XXX 课程实践]
// 学院 - Name of your school
#let school = [学院]
// 学号 - Student ID
#let student-id = "XXX"
// 教师 - Name of your teacher
#let teacher = "XXX"

#set text(lang: "zh", region: "cn")

// 改成你想要的字体 - Change it to whatever font you like
// 如果需要用 Windows 自带的字体 - If you need Windows fonts
//
// #let kaiti = "KaiTi"
// #let main-font = ("Times New Roman", "SimSun")
#let kaiti = "AR PL KaitiM GB"
#let main-font = ("Noto Serif", "Noto Serif CJK SC")

#set page(
  paper: "a4",
  footer: context [
    #table(
      columns: (20%, 60%, 20%),
      inset: 0pt,
      stroke: none,
      [],
      align(center, counter(page).display("第 1 页，共 1 页", both: true)),
      align(right, text(font: kaiti)[教务处制]),
    )
  ],
)

// 10.5pt 是五号字
#set text(font: main-font, size: 10.5pt)
// 首行缩进两个汉字宽度
#set par(first-line-indent: (amount: 2em, all: true))
#set enum(indent: 2em)
#set list(indent: 2em)

#set heading(numbering: (..nums) => {
  nums = nums.pos()
  if (nums.len() == 1) {
    return numbering("一、", ..nums)
  } else {
    return numbering("1.", ..nums).slice(0, -1)
  }
})

#show title: set align(center)
#show title: set text(font: kaiti, size: 24pt)
#show heading: set text(size: 10.5pt)
#show raw: set text(size: 10.5pt)
#title[#underline(title-content)]

// 实验信息表 - Information table
#block[
  #set text(
    font: kaiti,
    size: 12pt,
  )
  #table(
    columns: (auto, auto, auto, 1fr, auto, auto, auto, auto),
    align: center,
    inset: 2pt,
    [院、系], school, [年级专业], class, [姓名], author, [学号], student-id,
    [课程名称], table.cell(colspan: 5)[#lesson], [成绩], [],
    [指导教师], teacher, [同组实验者], table.cell(colspan: 2)[#friends], [实验日期], table.cell(colspan: 2)[#date],
  )
]

#block(
  clip: true,
  stroke: 1pt + black,
  inset: 6pt,
  width: 100%,
  // 如果改了字体，微调这个 86%
  // If you've changed the fonts, adjust the 86% below
  height: 86% + (num-pages - 1) * 100%,
)[
  #align(center)[
    #block(width: 90%, inset: 6pt)[
      #set text(font: kaiti, size: 12pt)
      #table(
        columns: (18%, 1fr),
        align: center,
        stroke: none,
        [实验名称], underline(assignment, offset: 4pt, extent: 10pt),
      )
    ]
  ]

  = 实验目的

  = 实验内容

  = 实验步骤和结果

  = 实验总结
]
