#import "fonts.typ": *

// 公式：右对齐编号，格式 (章节-序号)
#let formula(body, number) = {
  block(above: 1.5em, below: 0.2em, {
    show math.equation: set text(font: "Times New Roman")
    grid(
      columns: (1fr, auto), gutter: 0pt,
      align(center, body),
      align(bottom, number),
    )
  })
  par[#box()]
}

// 作者简历页
#let author-bio(
  name: "",
  gender: "",
  ethnicity: "",
  birth: "",
  hometown: "",
  education: [],
  awards: [],
  projects: [],
  publications: [],
) = {
  pagebreak()
  set page(
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
    header: none,
    footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("1")]]],
  )

  [
    #set par(leading: 1.5em)

    #align(center)[
      #text(size: 16pt, weight: "bold", font: fonts.hei)[作者简历]
    ]

    #v(1em)

    #set par(first-line-indent: 2em)
    #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[
      姓名：#name，性别：#gender，民族：#ethnicity，\
      出生年月：#birth，籍贯：#hometown。
    ]

    #v(0.5em)

    #text(size: 12pt, font: ("Times New Roman",) + fonts.fang, weight: "bold")[教育经历]
    #set par(first-line-indent: 2em)
    #for item in education [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#item]
      #parbreak()
    ]

    #v(0.5em)

    #if awards.len() > 0 [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang, weight: "bold")[获奖情况]
      #for item in awards [
        #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#item]
        #parbreak()
      ]
      #v(0.5em)
    ]

    #if projects.len() > 0 [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang, weight: "bold")[参加项目]
      #for item in projects [
        #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#item]
        #parbreak()
      ]
      #v(0.5em)
    ]

    #if publications.len() > 0 [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang, weight: "bold")[发表论文]
      #for item in publications [
        #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#item]
        #parbreak()
      ]
    ]
  ]
}
