#import "common.typ": default-fonts, scoped-numbering, fixed-leading

// 手动分页。to 可设为 "odd" 或 "even"，用于双面打印时控制起始页。
#let thesis-pagebreak(to: none, weak: false) = {
  if to == none {
    pagebreak(weak: weak)
  } else {
    pagebreak(to: to, weak: weak)
  }
}

#let thesis-figure(body, caption_zh, caption_en: none, label: none) = {
  set figure.caption(position: bottom)
  let result = figure(
    {
      set par(first-line-indent: 0pt)
      body
    },
    kind: image,
    supplement: [图],
    numbering: scoped-numbering,
    caption: [
      #caption_zh
      #if caption_en != none {
        linebreak()
        [Figure #context counter(figure.where(kind: image)).display(scoped-numbering) #caption_en]
      }
    ],
  )
  if label == none { result } else { [#result #label] }
}

#let thesis-table(body, caption_zh, caption_en: none, label: none) = {
  set figure.caption(position: top)
  let result = figure(
    {
      set par(first-line-indent: 0pt)
      body
    },
    kind: table,
    supplement: [表],
    numbering: scoped-numbering,
    caption: [
      #caption_zh
      #if caption_en != none {
        linebreak()
        [Table #context counter(figure.where(kind: table)).display(scoped-numbering) #caption_en]
      }
    ],
  )
  if label == none { result } else { [#result #label] }
}

#let academic-table(columns, header, rows) = {
  set par(first-line-indent: 0pt, justify: false)
  table(
    columns: columns,
    align: center + horizon,
    inset: (x: 6pt, y: 4pt),
    stroke: (x, y) => if y == 0 {
      (top: 1pt, bottom: 0.6pt)
    } else if y == rows.len() {
      (bottom: 1pt)
    } else {
      none
    },
    table.header(..header),
    ..rows.flatten(),
  )
}

#let caption-note(body, fonts: default-fonts) = {
  let leading = fixed-leading(10.5pt, 15.5pt)
  block(width: 100%, above: 3pt, below: 3pt)[
    #set text(font: fonts.body, size: 10.5pt)
    #set par(first-line-indent: 0pt, leading: leading, spacing: leading)
    #body
  ]
}
