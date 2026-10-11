#import "common.typ": *

#let special-chapter(
  title,
  body,
  outlined: true,
  print_mode: false,
  size: 12pt,
  line_spacing: 20pt,
  fonts: default-fonts,
) = {
  let leading = fixed-leading(size, line_spacing)
  major-break(print-mode: print_mode, weak: true)
  heading(level: 1, numbering: none, outlined: outlined)[#title]
  set text(font: fonts.body, size: size)
  set par(
    justify: true,
    first-line-indent: paragraph-indent,
    leading: leading,
    spacing: leading,
  )
  body
}

#let experience-page(rows, print_mode: false, fonts: default-fonts) = {
  major-break(print-mode: print_mode, weak: true)
  heading(level: 1, numbering: none, outlined: true)[作者学习经历]
  v(-6pt)
  set text(font: fonts.body, size: 12pt)
  set par(first-line-indent: 0pt)
  align(center)[
    #move(dx: -6.2mm)[
      #table(
      columns: (30.5mm, 18.3mm, 60.8mm, 49.1mm),
      align: center + horizon,
      inset: (x: 4pt, y: 8.2pt),
      stroke: 0.5pt,
      [起止年月], [类别], [学习单位名称], [学科/专业名称],
        ..rows.map(row => (
          row.period,
          row.category,
          row.institution,
          row.major,
        ).map(value => box(height: 12pt)[#value])).flatten(),
      )
    ]
  ]
}
