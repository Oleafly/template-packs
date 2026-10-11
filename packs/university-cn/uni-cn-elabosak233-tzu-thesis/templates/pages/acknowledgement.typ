#import "../fonts.typ": fonts, sizes

#let acknowledgement-content = state("acknowledgement", "")

#let acknowledgement(
  body,
) = {
  context acknowledgement-content.update(body)
}

#let acknowledgement-page() = {
  set text(font: fonts.宋体, size: sizes.小四)

  show heading.where(level: 1): set text(font: fonts.黑体, size: sizes.小三)

  show heading.where(level: 1): set heading(numbering: none)

  [
    #align(center)[
      #v(1.5em)
      #heading(numbering: none)[谢#h(1em)辞]
      #v(1.5em)
    ]

    #set par(first-line-indent: (amount: 2em, all: true))
    #context acknowledgement-content.final()
  ]
}
