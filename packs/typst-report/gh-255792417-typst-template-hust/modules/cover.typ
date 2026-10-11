#import "@preview/zh-format:0.1.0": *
#import "@preview/pointless-size:0.1.2": zh

#let cover-page(
  title: "课程实验报告",
  course: "数据结构实验",
  class: "计卓 2401",
  student-id: "U2024xxxxx",
  name: "张三",
  teacher: "李四",
  report-date: "2024年1月1日",
  college: "计算机科学与技术学院",
) = {
  v(1em)

  align(center, image("../images/HUSTGreen.svg", width: 20em))

  v(-1em)

  align(center, text(font: "HYFangSongJ", size: zh(0.5), weight: "bold", tracking: 0.5em, stroke: 0.03em)[#title])

  v(3em)

  set text(size: zh(3))

  let format-key(width, s) = box(width: width, {
    set text(font: "SimHei", weight: "bold", stroke: 0.03em)
    let chars = s.clusters()
    stack(dir: ltr, spacing: 1fr, ..chars)
  })
  let format-value(width, s) = text(font: "SimHei", weight: "bold", stroke: 0.01em)[#u(width: width)[#s]]

  let key = format-key.with(5em)
  let value = format-value.with(10em)

  align(center, text(size: zh(2))[#key("课程名称： ")#value(course)])

  v(8em)

  let key-width = 4em
  let key = format-key.with(key-width)
  let value = format-value.with(12em)

  align(center, grid(
    columns: (key-width, auto),
    column-gutter: 0.5em,
    row-gutter: 2em,
    key("专业班级"), value(class),
    key("学号"), value(student-id),
    key("姓名"), value(name),
    key("指导教师"), value(teacher),
    key("报告日期"), value(report-date),
  ))

  v(3em)

  align(center, text(college, font: "SimHei", size: zh(3), weight: "bold", stroke: 0.03em))

  pagebreak()
}
