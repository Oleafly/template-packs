#import "@preview/pointless-size:0.1.2": zh
#import "header.typ": header_colorful

#let page-setup(body) = {
  set page(
    paper: "a4",
    numbering: "1",
    header: context {
      let page-num = counter(page).get().first()
      if page-num >= 2 {
        header_colorful
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num >= 2 {
        grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          line(length: 95%, stroke: gray),
          text(size: zh(4), baseline: -0.3em)[#(page-num - 1)],
          line(length: 95%, stroke: gray),
        )
      }
    },
    margin: (
      top: 9.5em,
    ),
  )
  body
}
