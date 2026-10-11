#import "../utils/style.typ": 字体, 字号

#let header-render(content, fonts: (:)) = {
  fonts = 字体 + fonts
  [
    #set par(leading: 0em, spacing: 0em)
    #set text(font: fonts.宋体, size: 字号.小五)
    #align(center)[#content]
    #v(0.5em)
    #line(length: 100%, stroke: 3pt + black)
    #v(0.4em)
    #line(length: 100%, stroke: 0.5pt + black)
  ]
}

#let graduate-header-config = (
  header-ascent: 1.5cm - 1.5em,
)

#let graduate-header-title(doctype) = {
  if doctype == "doctor" {
    "西北工业大学博士学位论文"
  } else {
    "西北工业大学硕士学位论文"
  }
}

#let add-blank-even-page(doctype: "master", fonts: (:), terminal: false) = {
  fonts = 字体 + fonts
  context {
    let current-page = counter(page).get().first()
    if calc.rem(current-page, 2) == 1 {
      pagebreak(weak: not terminal)
      set page(header: header-render([#graduate-header-title(doctype)], fonts: fonts))
      v(1fr)
    }
  }
}

#let break-to-odd-page(doctype: "master", fonts: (:)) = {
  fonts = 字体 + fonts
  context {
    let current-page = counter(page).get().first()
    if calc.rem(current-page, 2) == 1 {
      pagebreak()
      set page(header: header-render([#graduate-header-title(doctype)], fonts: fonts))
      v(1fr)
    }
    pagebreak()
  }
}
