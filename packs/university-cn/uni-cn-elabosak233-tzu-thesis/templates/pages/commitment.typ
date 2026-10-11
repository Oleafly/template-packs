#import "../fonts.typ": fonts, sizes

#let commitment-signature = state("commitment-signature", none)

#let commitment(
  signature: none,
) = {
  context commitment-signature.update(signature)
}

#let commitment-page(
  date,
) = {
  v(12pt)

  align(center)[
    #set par(leading: 1.5em)
    #heading(numbering: none)[诚信承诺书]
  ]

  v(18pt)

  set text(font: fonts.仿宋, size: sizes.三号, lang: "zh", top-edge: "ascender", bottom-edge: "descender")

  [本人郑重承诺：]

  set par(first-line-indent: (amount: 2em, all: true), leading: 1em)

  [
    现提交的毕业设计（论文）系本人独立完成。毕业设计（论文）所使用的相关资料、数据、观点等均真实可靠，文中所有引用的他人观点、材料、数据、图表均已注释说明来源，无抄袭、剽窃或不正当引用他人学术观点、思想、学术成果和伪造、篡改数据的情况。

    本人已被告知并清楚：学校对毕业设计（论文）中的抄袭、剽窃、弄虚作假等违反学术规范的行为将严肃处理，并可能导致毕业设计（论文）成绩不合格，无法正常毕业、取消学士学位资格或注销并追回已发放的毕业证书、学士学位证书等严重后果。

    若在教育部、省教育厅、学院组织的毕业论文（设计）检查、评比中，被发现有抄袭、剽窃、弄虚作假等违反学术规范的行为，本人愿意接受学校按有关规定给予的处理，并承担相应责任。
  ]

  align(right)[
    #context grid(
      columns: (9.5em, 7.5em),
      gutter: 5pt,
      [承诺人（签名）：], [#if commitment-signature.final() != none { commitment-signature.final() } else { h(7.5em) }],
    )

    #h(0.5em)#date.year()#h(0.5em)年#h(0.5em)#date.month()#h(0.5em)月#h(0.5em)#date.day()#h(0.5em)日
  ]
}
