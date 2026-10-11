#import "../config.typ": thesis
#import "../style/font.typ": *
#import "../utils.typ": *

#set align(center)
#set text(font: font.中黑英宋)

#empty_line(3, size: font_size.四号)
// 官方学校标识 https://www.scut.edu.cn/new/9017/list.htm
#image("logo.jpg", width: 12cm)

#text(font_size.小初)[#thesis.degree-label]

#empty_line(4, size: font_size.四号)

#let show_title() = context {
  let title = if thesis.title == none {
    "论文题目"
  } else {
    thesis.title
  }.split("\n")

  // // 确保标题有两行
  title.push("")

  set text(font_size.二号)

  grid(
    rows: 1.2cm,
    columns: 15.38cm,
    align: bottom,
    inset: 5pt,
    stroke: (bottom: black + 0.5pt),
    title.at(0),
    title.at(1),
  )
}

#show_title()

#set text(font_size.三号)

#empty_line(5, size: font_size.四号)
#empty_line(1)

#let info = (
  author: thesis.author,
  degree: thesis.degree,
  supervisor: if thesis.supervisor-title == "" {
    thesis.supervisor
  } else {
    thesis.supervisor + " " + thesis.supervisor-title
  },
  external_supervisor: thesis.external-supervisor,
  college: thesis.college,
  date: thesis.submit-date,
)

#grid(
  columns: (4.57cm, 6.85cm),
  rows: 0.95cm,
  align: bottom,
  stroke: (x, y) => if x > 0 {
    (bottom: black + 0.5pt)
  },
  inset: 5pt,
  justify_str("作者姓名"), info.author,
  justify_str("学位类别"), info.degree,
  justify_str("指导教师"), info.supervisor,
  if info.external_supervisor == "" { [] } else { "" }, info.external_supervisor,
  justify_str("所在学院"), info.college,
  justify_str("论文提交日期"), info.date,
)
