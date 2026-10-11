#import "@preview/cuti:0.2.1": *

#import "../utils/font.typ": 字号

#let cover-page(
  icon: "../assets/hdu.png",
  graduate-year: int,
  topic: str,
  institute: str,
  major: str,
  class: int,
  student-id: int,
  name: str,
  supervisor: str,
  complete-time: datetime,
) = {
  set page(paper: "a4", margin: (top: 3cm, bottom: 2cm, left: 4cm, right: 2cm))
  show: set align(center)

  v(1.75cm)

  image(icon, width: 9.83cm, height: 1.39cm)

  [
    #text(font: "SimSun", size: 40pt, tracking: 0.6em)[
      #fakebold[本科毕业设计]
    ]

    #text(font: "SimSun", size: 字号.二号, top-edge: "baseline")[
      #fakebold[（#(graduate-year)届）]
    ]
  ]

  let thesis_info(content) = {
    align(center, text(font: ("Times New Roman", "KaiTi"), size: 字号.小三)[#content])
  }

  v(1cm)

  set text(font: "SimSun", size: 字号.小三)
  grid(
    columns: (auto, 9.26cm),
    rows: 1.8cm,
    align: bottom,
    inset: 6pt,
    stroke: (x, _) => if x == 1 {
      (bottom: (thickness: 0.5pt))
    },
    fakebold[题#h(2em)目], thesis_info[#topic],
    fakebold[学#h(2em)院], thesis_info[#institute],
    fakebold[专#h(2em)业], thesis_info[#major],
    fakebold[班#h(2em)级], thesis_info[#class],
    fakebold[学#h(2em)号], thesis_info[#student-id],
    fakebold[学生姓名], thesis_info[#name],
    fakebold[指导老师], thesis_info[#supervisor],
    fakebold[完成日期], thesis_info[#complete-time.display("[year]年[month]月")],
  )

  pagebreak()
}
