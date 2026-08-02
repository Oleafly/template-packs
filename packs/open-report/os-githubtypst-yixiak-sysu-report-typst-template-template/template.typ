

#let report(
  title: "实验报告",
  subtitle: "Lab 0: 环境准备",
  name: "张三",
  stdid: "11223344",
  classid: "计科一班",
  subject:"实验课程",
  time: "2022~2023 学年第二学期",
  banner: none + "",
  body,
) = {
  set document(title: title)
  set page(paper: "a4", numbering: "1", number-align: center)
  set text( lang: "zh", size: 11pt)
  set heading(numbering: "1.1.")

    let fieldname(name) = [
    #set align(right + horizon)
    //#set text(font: fonts.text)
    #name
  ]

  let fieldvalue(value) = [
    #set align(left + horizon)
    //#set text(font: fonts.text)
    #value
  ]

  align(center)[
    #grid(
      columns: (200pt, 240pt),
      row-gutter: 1em,
      fieldname(text("姓") + h(2em) + text("名：") + h(1em)),
      fieldvalue(name),
      fieldname(text("学") + h(2em) + text("号：") + h(1em)),
      fieldvalue(stdid),
      fieldname(text("教学班号：") + h(1em)),
      fieldvalue(classid),
      fieldname(text("课") + h(2em) + text("程：") + h(1em)),
      fieldvalue(subject),

    )
  ]
}