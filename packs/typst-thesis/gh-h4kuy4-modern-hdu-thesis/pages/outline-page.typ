#import "../layouts/basic-layout.typ": basic-layout
#import "../layouts/page-layout.typ": page-header, page-footer
#import "../utils/font.typ": 字号, 字体

#let outline-page(pager-state: state) = context {
  show: page-header.with()
  show: basic-layout.with()

  set heading(outlined: false, numbering: none)

  let indent-width = (0em, 1.6em, 4em)

  set outline.entry(fill: repeat([.], gap: 0.01em))
  set outline(depth: 3, indent: n => indent-width.at(n))

  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner(), gap: 1em),
  )

  show outline: it => {
    pager-state.update(true)
    it
    pager-state.update(false)
  }

  [
    = 目#h(2em)录
    #v(0.25em)
    #outline(title: none)
  ]
}
