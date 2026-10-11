#import "../utils/style.typ": 字号, 字体

// 西北工业大学研究生声明页
#let master-decl-page(
  anonymous: false,
  twoside: false,
  fonts: (:),
) = {
  // 0. 如果需要匿名则短路返回
  if anonymous {
    return
  }

  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染 - 原创性声明
  pagebreak(weak: true, to: if twoside { "odd" })

  v(25pt)

  align(
    center,
    text(
      font: fonts.黑体,
      size: 字号.四号,
      weight: "bold",
      "西北工业大学学位论文原创性声明",
    ),
  )

  v(46pt)

  block[
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.5em)

    秉承学校严谨的学风和优良的科学道德，本人郑重声明：所呈交的学位论文，是本人在导师的指导下进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容和致谢的地方外，本论文不包含任何其他个人或集体已经公开发表或撰写过的研究成果，不包含本人或他人已申请学位或其他用途使用过的成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。

    本人学位论文与资料若有不实，愿意承担一切相关的法律责任。
  ]

  v(80pt)

  align(right)[
    #set text(font: fonts.宋体, size: 字号.小四)

    学位论文作者签名：#h(5.8em)

    年    月    日
  ]


  // 第二个声明 - 使用授权声明
  pagebreak(weak: true, to: if twoside { "odd" })

  v(25pt)

  align(
    center,
    text(
      font: fonts.黑体,
      size: 字号.四号,
      weight: "bold",
      "西北工业大学学位论文使用授权声明",
    ),
  )

  v(46pt)

  block[
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.5em)

    本人完全了解学校有关保护知识产权的规定，即：研究生在校攻读学位期间论文工作的知识产权单位属于西北工业大学。学校有权保留并向国家有关部门或机构送交论文的复印件和电子版。本人允许论文被查阅和借阅。学校可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。同时本人保证，毕业后结合学位论文研究课题再撰写的文章一律注明作者单位为西北工业大学。

    本学位论文属于（在以下方框内打"√"）：

    #h(2em)□ 保密论文，保密期（ #h(4em) 年 #h(2em) 月 #h(2em) 日至 #h(4em) 年 #h(2em) 月 #h(2em) 日）。

    #h(2em)□ 公开论文。
  ]

  v(60pt)

  grid(
    columns: (1fr, 1fr),
    align(right)[
      #set text(font: fonts.宋体, size: 字号.小四)

      学位论文作者签名：#h(3em)

      年    月    日
    ],
    align(right)[
      #set text(font: fonts.宋体, size: 字号.小四)

      指导教师签名：#h(3em)

      年    月    日
    ]
  )
}