#import "@preview/cuti:0.4.0": show-cn-fakebold

#import "../fonts.typ": fonts, sizes

#let toc = {
  show: show-cn-fakebold

  set page(numbering: "I")

  show outline: it => {
    set par(
      leading: 1.5em,
      spacing: 0.5em,
    )

    align(center)[
      #block(above: 1.5 * 1.5em, below: 1.5 * 1.5em)[
        #set text(
          font: fonts.黑体,
          size: sizes.小二,
        )
        #text(size: 16pt, weight: "bold")[目#h(1em)录]

      ]
    ]

    it
  }

  show outline.entry: it => {
    it
  }

  // 这里更改 top-edge 和 bottom-edge 会影响目录中的 ...
  set text(font: (fonts.main, fonts.宋体), size: sizes.小四, top-edge: 1em, bottom-edge: 0em)

  set par(leading: 1em)

  outline(depth: 3, title: none)
}
