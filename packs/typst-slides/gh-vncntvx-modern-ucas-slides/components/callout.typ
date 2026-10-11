#import "@preview/touying:0.8.0": *

// 提示注记条
#let _callout(self: none, title: none, it) = {
  let primary = if (
    self != none and "colors" in self and "primary" in self.colors
  ) {
    self.colors.primary
  } else {
    rgb("#003a8c")
  }
  block(
    width: 100%,
    breakable: false,
    radius: 4pt,
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 1.1em, y: 0.6em),
    spacing: 0.75em,
    {
      if title != none {
        text(fill: primary, weight: "bold", size: 0.85em, [💡 #title])
        v(0.15em)
      }
      text(size: 0.85em, it)
    },
  )
}

#let callout(title: none, it) = touying-fn-wrapper-raw(
  _callout.with(title: title),
  it,
)
