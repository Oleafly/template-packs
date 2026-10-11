#import "fonts.typ": *

// 基础摘要模板
#let base-abstract(title, content, keywords-label, keywords, is-chinese: true, page-number: 1) = {
  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
    header: none,
    footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("I")]]],
  )

  counter(page).update(page-number)

  [
    // 1.5倍行距
    #set par(leading: 1.5em)

    // 标题（三号，居中）
    #align(center)[
      #if is-chinese [
        #text(size: 16pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[#title]
      ] else [
        #text(size: 16pt, weight: "bold")[#title]
      ]
    ]

    #v(1em)

    // 正文（小四号，1.5倍行距，首行缩进）
    #set par(first-line-indent: 2em)
    #if is-chinese [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#content]
    ] else [
      #text(size: 12pt)[#content]
    ]

    #v(2em)

    // 关键词
    #set par(first-line-indent: 0em)
    #if is-chinese [
      #text(size: 12pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[#keywords-label：]
    ] else [
      #text(size: 12pt, weight: "bold")[#keywords-label: ]
    ]
    #if is-chinese [
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#keywords.join("；")]
    ] else [
      #text(size: 12pt)[#keywords.join(";")]
    ]

  ]
}

// 中文摘要 — 小四号仿宋，1.5倍行距
#let chinese-abstract(content, keywords) = {
  base-abstract(
    "摘要",
    content,
    "关键词",
    keywords,
    is-chinese: true,
    page-number: 1
  )
}

// 英文摘要 — 小四号 Times New Roman，1.5倍行距
#let english-abstract(content, keywords) = {
  base-abstract(
    "Abstract",
    content,
    "Keywords",
    keywords,
    is-chinese: false,
    page-number: 2
  )
}
