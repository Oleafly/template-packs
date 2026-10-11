#import "common.typ": *

#let abstract-page(
  title,
  body,
  keywords,
  english: false,
  size: 14pt,
  line_spacing: 20pt,
  fonts: default-fonts,
) = {
  let leading = fixed-leading(size, line_spacing)
  heading(level: 1, numbering: none, outlined: true)[#title]
  v(if english { -1.9pt } else { -17.5pt })
  set text(font: if english { fonts.latin } else { fonts.body }, size: size)
  set par(
    justify: true,
    first-line-indent: paragraph-indent,
    leading: leading,
    spacing: leading,
  )
  body
  v(if english { 16pt } else { 8pt })
  par(first-line-indent: 0pt)[
    #text(
      font: if english { fonts.latin } else { fonts.heading },
      weight: "bold",
    )[#if english { [KEY WORDS:] } else { [关键词：] }]
    #h(0.5em)
    #keywords.join(if english { "; " } else { "；" })
  ]
}

#let contents-page(depth: 3, fonts: default-fonts) = {
  heading(level: 1, numbering: none, outlined: false)[目　录]
  v(6.7pt)
  set text(font: fonts.body, size: 12pt)
  set par(first-line-indent: 0pt, leading: 8pt)
  outline(title: none, depth: depth, indent: 21pt)
}

#let nomenclature-page(entries, fonts: default-fonts) = {
  heading(level: 1, numbering: none, outlined: false)[符号说明]
  v(-3pt)
  set text(font: fonts.body, size: 12pt)
  set par(first-line-indent: 0pt)
  align(center)[
    #table(
      columns: (41mm, 41mm, 41mm),
      align: center + horizon,
      inset: (x: 6pt, y: 4pt),
      stroke: (x, y) => if y == 0 {
        (top: 1pt, bottom: 0.6pt)
      } else if y == entries.len() {
        (bottom: 1pt)
      } else {
        none
      },
      [符　号], [代表意义], [单　位],
      ..entries.map(row => (row.symbol, row.description, row.unit)).flatten(),
    )
  ]
}
