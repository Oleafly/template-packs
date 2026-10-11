#import "shared.typ": *
#import "@preview/numbly:0.1.0": numbly
#let report(
  title: "实验报告",
  lab_number: "实验一",
  lab_name: "Lab 0: 环境准备",
  create_time: "2025年9月9日",
  name: "张三",
  stdid: "11223344",
  banner: none + "",
  body,
) = {
  set document(title: title)
  show: shared
  set page(numbering: none)
  let fieldname(name) = [
    #set align(right + horizon)
    #set text(font: fonts.serif)
    #name
  ]

  let fieldvalue(value) = [
    #set align(left + horizon)
    #set text(font: fonts.serif)
    #value
  ]

  align(center)[
    #if (banner == none) {
      v(200pt)
    } else {
      image(banner, height: 200pt, width: 95%, fit: "contain")
    }
    #linebreak()
    #v(50pt, weak: true)
    #block(text(weight: "semibold", 30pt, title))
    // #v(50pt, weak: true)
    // #block(text(weight: "medium", 24pt, subtitle))

    #v(250pt, weak: true)
    #set text(14.5pt)

    #grid(
      columns: (200pt, 240pt),
      row-gutter: 1em,
      fieldname(text("实") + h(0.5em) + text("验") + h(0.5em) + text("一")+ text("：")+ h(1em)), fieldvalue(lab_name),
      fieldname(text("实验时间：") + h(1em)), fieldvalue(create_time),
      fieldname(text("姓") + h(2em) + text("名：") + h(1em)), fieldvalue(name),
      fieldname(text("学") + h(2em) + text("号：") + h(1em)), fieldvalue(stdid),
    )
    #pagebreak()
]

  set align(left + top)
  set par(justify: true, first-line-indent: 2em, leading: line_height)
  body
}

#let title(content: "") = align(center)[
  #set text(26pt, weight: "bold")
  #v(2em)
  #content
  #v(1.625em)
]
