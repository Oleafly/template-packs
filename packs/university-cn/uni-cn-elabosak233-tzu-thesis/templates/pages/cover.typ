#import "@preview/cuti:0.4.0": show-fakebold

#import "../fonts.typ": fonts, sizes

#let cover(
  title,
  school,
  major,
  class,
  uid,
  student,
  advisor,
  second-advisor,
  date,
) = {
  show: show-fakebold

  set page(numbering: none)

  image("/assets/vi/tzu-logo.png", width: 2.85cm)

  v(0.4cm)

  align(center)[
    #image("/assets/vi/tzu-text.svg", width: 9.5cm)

    #scale(x: 200%, y: 200%, reflow: true)[
      #scale(y: 50%, reflow: true)[
        #text(font: fonts.华文新魏, size: sizes.一号, weight: "bold", tracking: 1.5pt)[本科毕业设计]
      ]
    ]

    #text(font: fonts.黑体, size: sizes.二号, weight: "bold")[（#date.year()届）]
  ]

  v(2.5cm)

  let info-key(
    font: fonts.宋体,
    size: sizes.小三,
    body,
  ) = {
    rect(
      inset: (x: 0pt, bottom: 1pt),
      stroke: none,
      text(
        font: font,
        size: size,
        body,
      ),
    )
  }

  let info-value(
    font: (fonts.main, fonts.楷体),
    size: sizes.小三,
    body,
  ) = {
    set align(center)
    set par(leading: 0.5em)
    rect(
      width: 100%,
      inset: (x: 0pt, bottom: 1pt),
      stroke: (bottom: 0.5pt + black),
      text(
        font: font,
        size: size,
        top-edge: "ascender",
        bottom-edge: "descender",
        body,
      ),
    )
  }

  pad(left: 4em, right: 1em)[
    #set par(leading: 1em, spacing: 1em)

    #grid(
      columns: (auto, 1fr),
      align: bottom,
      gutter: 5pt,
      info-key[题#h(2em)目], info-value[#title],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[学#h(2em)院], info-value[#school],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[专#h(2em)业], info-value[#major],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[班#h(2em)级], info-value[#class],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[学#h(2em)号], info-value[#uid],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[学生姓名], info-value[#student],
    )

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[指导教师], info-value[#advisor],
    )

    #if second-advisor != none {
      grid(
        columns: (auto, 1fr),
        gutter: 5pt,
        align: bottom,
        info-key[第二指导教师], info-value[#h(-2em)#second-advisor],
      )
    }

    #grid(
      columns: (auto, 1fr),
      gutter: 5pt,
      align: bottom,
      info-key[完成日期], info-value[#date.display("[year]年[month]月")],
    )
  ]
}
