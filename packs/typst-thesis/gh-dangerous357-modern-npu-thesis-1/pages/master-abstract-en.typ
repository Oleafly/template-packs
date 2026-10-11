#import "../utils/style.typ": 字体, 字号
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/header.typ": header-render

#let master-abstract-en(
  doctype: "master",
  degree: "academic",
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  keywords: (),
  outline-title: "Abstract",
  outlined: true,
  anonymous-info-keys: ("author-en", "supervisor-en", "supervisor-ii-en"),
  leading: 1.5em,
  spacing: 1.5em,
  body,
) = {
  fonts = 字体 + fonts
  info = (
    (
      title-en: "NPU Thesis Template for Typst",
      author-en: "Zhang San",
      department-en: "XX School",
      major-en: "XX",
      supervisor-en: "Li Si",
    ) + info
  )

  if type(info.title-en) == str {
    info.title-en = info.title-en.split("\n")
  }

  pagebreak(weak: true, to: if twoside { "odd" })
  set page(header: header-render([Abstract], fonts: fonts))

  [
    #set par(leading: leading, spacing: spacing, justify: true)
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    #align(center)[
      #set text(font: fonts.黑体, size: 字号.三号, weight: "bold")
      #v(2em)
      Abstract
    ]

    #v(1em)

    #[
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(first-line-indent: (amount: 2em, all: true))
      #body
    ]

    #v(1em)
    #text(size: 字号.小四)[
      #strong[Key words:] #(("",) + keywords.intersperse("; ")).sum()
    ]
  ]
}
