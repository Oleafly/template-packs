#import "../fonts.typ": fonts, sizes

#let authorization-confidential = state("authorization-confidential", false)

#let authorization-student-signature = state("authorization-student-signature", none)

#let authorization-advisor-signature = state("authorization-advisor-signature", none)

#let authorization(
  confidential: false,
  student-signature: none,
  advisor-signature: none,
) = {
  context authorization-confidential.update(confidential)
  context authorization-student-signature.update(student-signature)
  context authorization-advisor-signature.update(advisor-signature)
}

#let authorization-page(
  date,
) = {
  set page(numbering: "I")

  counter(page).update(1)

  v(13pt)

  align(center)[
    #text(font: fonts.黑体, size: sizes.小二, weight: "bold")[学位论文版权使用授权书]
  ]

  v(18pt)

  set par(first-line-indent: (amount: 2em, all: true), leading: 12pt)

  set text(font: (fonts.main, fonts.宋体), size: 13pt, lang: "zh")

  [本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权台州学院可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

    本学位论文属于]

  let checkmark(
    checked: false,
  ) = {
    if checked {
      text(font: "Wingdings 2")[\u{0052}]
    } else {
      text(font: "Wingdings 2")[\u{00A3}]
    }
  }

  context pad(left: 7em)[
    #checkmark(checked: authorization-confidential.final()) 保#h(1em)密，在一年后，解密适用本授权书。

    #checkmark(checked: not authorization-confidential.final()) 无密级。

    （请在以上相应方框内打“√”）
  ]

  v(1em)

  context pad(left: 2em)[
    #grid(
      columns: (5em, 9.5em, 1fr),
      gutter: 5pt,
      [作者签名：],
      [#if authorization-student-signature.final() != none { authorization-student-signature.final() } else {
        h(9.5em)
      }],
      [日期：#h(0.5em)#date.year()#h(0.5em)年#h(0.5em)#date.month()#h(0.5em)月#h(0.5em)#date.day()#h(0.5em)日],
    )

    #grid(
      columns: (5em, 9.5em, 1fr),
      gutter: 5pt,
      [导师签名：],
      [#if authorization-advisor-signature.final() != none { authorization-advisor-signature.final() } else {
        h(9.5em)
      }],
      [日期：#h(0.5em)#date.year()#h(0.5em)年#h(0.5em)#date.month()#h(0.5em)月#h(0.5em)#date.day()#h(0.5em)日],
    )
  ]
}
