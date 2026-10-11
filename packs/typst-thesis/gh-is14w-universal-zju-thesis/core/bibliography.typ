#import "fonts.typ": *

#let bibliography-page(bib) = {
  pagebreak()

  // 参考文献另起新页
  set page(
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
    header: none,
    footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("1")]]],
  )

  v(2em)

  // 参考文献标题 — 小三号黑体 (15pt), 居中
  align(center)[
    #text(size: 15pt, weight: "bold", font: fonts.hei)[
      参考文献
    ]
  ]

  v(1em)

  // 参考文献内容 — 5号宋体 (10.5pt), 单倍行距, 顶格
  set text(size: 10.5pt, font: ("Times New Roman",) + fonts.song)
  set par(leading: 1em, first-line-indent: 0em)

  show cite: it => { it }

  // et al. 后处理
  show regex("[A-Za-z],\s*等"): it => {
    it.text.first() + ", et al"
  }

  bib
}
