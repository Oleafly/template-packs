#import "@preview/touying:0.8.0": *

// 目录页
#let outline-slide(
  config: (:),
  title: [目录],
  depth: 2,
  indent: 1.2em,
  columns: auto,
  gutter: 6%,
  ..args,
) = touying-slide-wrapper(self => {
  let header-content = {
    place(hide(heading(
      level: self.slide-level,
      title,
      bookmarked: false,
      outlined: false,
      numbering: none,
    )))

    v(0.1em)
    text(
      size: 1.4em,
      weight: "bold",
      fill: self.colors.primary,
      title,
    )
    v(0.4em)
    line(length: 20%, stroke: 1.5pt + self.colors.primary)
    v(0.8em)
  }

  let outline-content = outline(
    title: none,
    indent: indent,
    depth: depth,
  )

  let body = if columns != auto {
    header-content
    if columns == 1 {
      outline-content
    } else {
      std.columns(columns, gutter: gutter, outline-content)
    }
  } else {
    layout(size => context {
      let start-h = std.measure(header-content).height
      let body-h = std.measure(outline-content).height
      let avail-h = calc.max(size.height - start-h - 40pt, 50pt)
      let n = calc.min(calc.max(calc.ceil(body-h / avail-h), 1), 3)
      header-content
      if n == 1 {
        outline-content
      } else {
        std.columns(n, gutter: gutter, outline-content)
      }
    })
  }

  touying-slide(self: self, config: config, body)
})
