
#import "lib.typ": cn-font-size, document-frame, font-color, font-family, references

#set page(margin: (x: 3cm, y: 2.5cm))
#set text(
  font: font-family.serif,
  size: cn-font-size.小四,
  lang: "zh",
  region: "cn",
)
#set par(spacing: 1em, leading: 1em, justify: true)

// 署名区按需增删，此处为课程报告排法：姓名学号一行、日期一行。
#show: body => document-frame(
  页眉: [北京大学软件与微电子学院],
  标题: [通用课程报告模板],
  署名: text(size: cn-font-size.小四)[
    姓名：姓名
    #h(2em)
    学号：250xxx0xxx

    2025年x月x日
  ],
  body,
)

= 内容1

内容1描述 @Attention_Is_All_You_Need


= 内容2

内容2描述 #footnote()[Download at https://github.com/yyhhenry/typst-common-fonts]

#pagebreak(weak: true)

#set heading(numbering: none, outlined: false)

= 参考文献

#let std_bib = bibliography("ref.bib", title: none, style: "gb-7714-2015-numeric")
#references(bibliography: std_bib)
