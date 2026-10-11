#import "../common.typ": content-width, fonts, page-margin, size
#import "@preview/cuti:0.4.0": cn-fakebold

#let signature-date-dx = 91.5mm

#let signature-row() = box(width: content-width, height: 1em)[
  #place(top + left, dx: 0mm, dy: 0mm)[
    学生签名：#box(width: 6em, line(length: 7em))
  ]

  #place(top + left, dx: signature-date-dx, dy: 0mm)[
    年　月　日
  ]
]

#let declare() = {
  set page(
    paper: "a4",
    margin: page-margin,
    header: none,
    footer: none,
  )

  set text(font: fonts.song, size: size.四号)
  set par(justify: true, leading: 20pt, first-line-indent: 2em)

  v(2em)

  // ── 声明 ──
  align(center)[
    #cn-fakebold(text(size: size.三号)[声　　明])
  ]

  v(1em)

  [本毕业设计（论文）是我在导师的指导下取得的研究成果，尽我所知，除了加以标注和致谢的部分外，不包含其他人已经发表或公布过的研究成果，也不包含我为获得任何教育机构的学位或学历而使用过的材料。]

  [与我一同工作的同事对本毕业设计（论文）做出的贡献均已在文中作了明确的说明。]

  v(2em)

  [#set par(first-line-indent: 0em)
    #signature-row()]

  v(4cm)

  // ── 使用授权声明 ──
  align(center)[
    #cn-fakebold(text(size: size.三号)[使用授权声明])
  ]

  v(1em)

  [南京理工大学有权保存本文的电子和纸质文档，可以借阅或上网公布本文的部分或全部内容，可以向有关部门或机构送交并授权其保存、借阅或上网公布本文的部分或全部内容。对于保密论文，按保密的有关规定和程序处理。]

  v(2em)

  [#set par(first-line-indent: 0em)
    #signature-row()]
}
