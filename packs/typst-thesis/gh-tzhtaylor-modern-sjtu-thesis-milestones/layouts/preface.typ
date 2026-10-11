#import "../style.typ": zihao

#let preface(
  doctype: "midterm",
  ziti: (:),
  it,
) = {
  set page(
    header: if doctype == "proposal" { none } else [
      #align(center, text(
        if doctype == "midterm" {
          "上海交通大学硕士论文中期检查报告  Mid-term Examination for SJTU Master Student"
        } else if doctype == "annual-progress" {
          "上海交通大学博士生年度进展报告  Annual Progress Review for SJTU Doctoral Student"
        },
        font: ziti.songti,
        size: zihao.xiaowu,
      ))
      #v(-0.8em)
      #line(length: 100%, stroke: 0.5pt)
      #v(0.5em)
    ],
    footer: if doctype == "midterm" {
      context [
        #set align(center)
        #set text(zihao.xiaowu, weight: "bold")
        1 / 1
      ]
    } else { none },
  )
  counter(page).update(1)

  set text(font: ziti.fangsong, size: zihao.xiaosi)
  set par(justify: true)

  it
}
