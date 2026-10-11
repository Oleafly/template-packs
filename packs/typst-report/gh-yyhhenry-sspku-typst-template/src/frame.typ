#import "@preview/cuti:0.2.1": show-cn-fakebold

#import "fonts.typ": cn-font-size, font-color, font-family

/// 重置图、表、代码块、算法与公式的编号计数器，用于实现按章编号。
#let re-index = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
  counter(figure.where(kind: "algorithm")).update(0)
  counter(math.equation).update(0)
}

/// 引用与编号规则：链接着色、图表公式按「章-序号」编号（每遇一级标题重置）、
/// 题注加粗、脚注按数字编号。
#let ref-rules(body) = {
  show link: it => text(fill: font-color.link-blue)[#underline[#it]]

  set math.equation(numbering: (..nums) => [(#counter(heading).get().at(0)-#nums.at(0))])
  set figure(numbering: (..nums) => [#counter(heading).get().at(0)-#nums.at(0)])
  set figure.caption(separator: [ ])
  show figure.caption: set text(size: cn-font-size.五号, weight: "bold")
  set footnote(numbering: (..nums) => [#nums.at(0)])
  show heading.where(level: 1): it => {
    it
    re-index
  }

  body
}

/// 通用文档骨架：应用排版规则、绘制页眉页脚、重置页码与脚注计数、
/// 输出居中的标题块。
///
/// - 页眉：页眉文字，居中显示于横线上方。
/// - 标题：二号字标题。
/// - 署名：标题下方的署名区，自由内容，由调用方组织。
#let document-frame(
  页眉: [],
  标题: [],
  署名: none,
  body,
) = [
  #show: show-cn-fakebold
  #show: ref-rules

  // Official paragraph indentation, including paragraphs after any block.
  // https://typst.app/docs/reference/model/par/#parameters-first-line-indent
  #set par(first-line-indent: (amount: 2em, all: true))
  #set list(indent: 2em)
  #set enum(indent: 2em)
  #show raw: set text(font: font-family.等宽)
  // A caption-placement convention, independent of paragraph indentation.
  #show figure.where(kind: table): set figure.caption(position: top)

  #set page(
    footer: context {
      set text(fill: gray, font: font-family.宋体, size: cn-font-size.小五)
      align(center)[#counter(page).display("1")]
    },
    header: {
      align(center)[
        #text(fill: gray, font: font-family.宋体, size: cn-font-size.小五)[
          #页眉
        ]
        #v(-0.5em)
        #line(length: 100%, stroke: (paint: gray, thickness: 0.5pt))
      ]
    },
  )
  #set heading(numbering: "1.1 ", outlined: true)
  #show heading: it => {
    v(0.5em)
    it
    v(0.5em)
  }
  #counter(page).update(1)
  #counter(footnote).update(0)

  #align(center)[
    #text(size: cn-font-size.二号)[
      #标题
    ]

    #署名
  ]

  #body
]
