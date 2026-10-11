#import "../utils/font.typ": 字号, 字体

#let page-header(doc) = {
  set page(
    header-ascent: 1cm - 字号.五号,
    header: {
      set align(center)
      set text(font: 字体.宋体, size: 字号.五号)
      box(width: 100%, outset: (bottom: 5pt), stroke: (bottom: black))[
        杭州电子科技大学本科毕业设计（论文）
      ]
    },
  )

  doc
}

#let page-footer(pager-state: state("pager-state", bool), doc) = {
  set page(
    footer-descent: 1cm,
    numbering: (..n) => context {
      if pager-state.get() {
        numbering("1", ..n)
      } else {
        text(size: 字号.小五)[\- #n.at(0) \-]
      }
    },
  )

  doc
}
