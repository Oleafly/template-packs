#import "../utils/custom-cuti.typ": fakebold
#import "../utils/style.typ": 字号, 字体
#import "../utils/invisible-heading.typ": invisible-heading

// 西北工业大学本科生英文摘要页
#let bachelor-abstract-en(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  keywords: (),
  outline-title: "ABSTRACT",
  outlined: false,
  anonymous-info-keys: ("author-en", "supervisor-en", "supervisor-ii-en"),
  leading: 1.28em,
  spacing: 1.38em,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title-en: "NPU Thesis Template for Typst",
    author-en: "Zhang San",
    department-en: "XX School",
    major-en: "XX",
    supervisor-en: "Li Si",
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title-en) == str {
    info.title-en = info.title-en.split("\n")
  }

  // 3.  正式渲染
  [
    #pagebreak(weak: true, to: if twoside { "odd" })

    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(leading: leading, justify: true, spacing: spacing)

    // 标记一个不可见的标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    #align(center)[
      #set text(size: 字号.三号, font: fonts.黑体, weight: "bold")

      #v(2em)

      ABSTRACT
    ]

    #v(1em)

    #[
      #set par(first-line-indent: (amount: 2em, all: true))

      #body
    ]

    #v(1em)

    #text(font: fonts.宋体, size: 字号.小四)[
      KEY WORDS: #(("",)+ keywords.intersperse(", ")).sum()
    ]
  ]
}