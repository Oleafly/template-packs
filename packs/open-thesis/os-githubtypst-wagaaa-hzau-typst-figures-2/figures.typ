#import "@preview/tablem:0.1.0": tablem
#import "@preview/tablex:0.0.6": tablex, hlinex

//设定编号为章节-序号
#let equation_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("equation-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    "(" + str(chapt) + "-" + str(n + 1) + ")"
  })
}

#let table_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}

#let image_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}

#set figure.caption(separator: [ ])

#set text(
  font: ( "Times New Roman","Songti SC"),
  size: 16pt)

#let tables=tablem.with(
  render: (columns: auto, ..args) => {
    tablex(
      columns: columns,
      auto-lines: false,
      align: center + horizon,
      hlinex(y: 0,stroke:2pt),
      hlinex(y: 1),
      ..args,
      hlinex(stroke:2pt),
    )
  }
)

#let 简单表格(表格, caption: "", cap_en: "")={
  figure(
      figure(
        tables(表格),
        caption: figure.caption(position: top)[#cap_en],
        gap: 1em,
        numbering: table_num,
        supplement: [表],
        kind: "table",
      ),
    caption: figure.caption(position: top)[#caption],
    supplement: [Table ],
    numbering: table_num,
  )
  v(1em)
}

#let 图片(图片, caption: "", cap_en: "")={
  figure(
    figure(
      图片,
      caption: caption,
      gap: 1em,
      numbering: image_num,
      supplement: [图],
      kind: "image",
    ),
  caption: cap_en,
  supplement: [Fig. ],
  numbering: table_num,
  )
  v(1em)
}
