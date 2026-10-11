#import "../utils/mod.typ": *
#import "cover.typ": *
#import "@preview/catppuccin:1.0.1": catppuccin, flavors, get-flavor

#let palette = get-flavor("latte").colors
#let note(author: "author", body) = {
  show: show-utils
  show: catppuccin.with(flavors.latte)

  set page(numbering: "1",background: image("../pic/bg-ecnu-logo.svg"))

  set heading(numbering: "1.1.1")
  show heading.where(level: 1): text.with(size: 24pt, font: (en-font-sans, cn-font-sans))
  show heading.where(level: 2): text.with(size: 17pt, font: (en-font-sans, cn-font-sans))
  show heading.where(level: 3): text.with(size: 14pt, font: (en-font-sans, cn-font-sans))

  elegant-cover(
    author: author,
    mail: "3422403944@qq.com",
    course: [ACM 代码模板],
    course-alt: [ACM Code Template],
    cover-pic: "../pic/dragonfly.png",
    cover-rec-color: palette.teal.rgb,
  )

  outline()

  pagebreak()

  body
}
