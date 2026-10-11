// 附件2.11：参考文献

#import "../common.typ": content-width, fonts, page-margin, size, thesis-footer, thesis-header, thesis-title-state
#import "@preview/cuti:0.4.0": cn-fakebold
#import "@preview/modern-nju-thesis:0.4.1": bilingual-bibliography

#let reference-bibliography(source, style: "gb-7714-2015-numeric", title: none, full: false) = {
  bilingual-bibliography(
    bibliography: (title: none, full: false, style: "gb-7714-2015-numeric") => bibliography(
      source,
      title: title,
      full: full,
      style: style,
    ),
    style: style,
    title: title,
    full: full,
  )
}

#let reference(source, style: "gb-7714-2015-numeric", title: none, full: false) = {
  let heading-title = if title == none { [参考文献] } else { title }

  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "1",
    header: context {
      thesis-header(
        odd-left: "毕业设计（论文）报告",
        odd-right: thesis-title-state.get(),
        even-left: "参考文献",
        even-right: "毕业设计（论文）报告",
      )
    },
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  block(inset: (top: 2mm, bottom: 5mm))[
    #show heading.where(level: 1, numbering: none): none
    #heading(level: 1, numbering: none, outlined: true)[#heading-title]

    #v(10mm)
    #align(center)[
      #set text(font: fonts.song, size: size.三号)
      #cn-fakebold(heading-title)
    ]

    #v(8pt)

    #set text(font: (fonts.times, fonts.song), size: size.小四)
    #set par(justify: true, leading: 12pt, spacing: 12pt)

    #reference-bibliography(source, style: style, title: none, full: full)
  ]
}
