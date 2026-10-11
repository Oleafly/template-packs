#import "@preview/touying:0.8.0": *
#import "./cards.typ": render-card

// 定理环境
#let _theorem(self: none, title: none, it) = {
  let primary = if (
    self != none and "colors" in self and "primary" in self.colors
  ) {
    self.colors.primary
  } else {
    rgb("#003a8c")
  }
  let header-title = if title != none [定理 (#title)] else [定理]
  render-card(
    self: self,
    title: header-title,
    accent-color: primary,
    bg-color: rgb("#f0f4fa"),
    stroke-color: rgb("#cbdff5"),
    it,
  )
}

#let theorem(title: none, it) = touying-fn-wrapper-raw(
  _theorem.with(title: title),
  it,
)

// 证明环境
#let _proof(self: none, title: [证明], it) = {
  let crimson = if (
    self != none and "colors" in self and "crimson" in self.colors
  ) {
    self.colors.crimson
  } else {
    rgb("#e11d48")
  }

  block(
    width: 100%,
    breakable: false,
    radius: 4pt,
    fill: rgb("#fdf8f9"),
    stroke: (
      left: 3pt + crimson,
      top: 0.5pt + rgb("#fce7eb"),
      right: 0.5pt + rgb("#fce7eb"),
      bottom: 0.5pt + rgb("#fce7eb"),
    ),
    inset: (x: 1.15em, y: 0.65em),
    spacing: 0.8em,
    [
      #text(fill: crimson, weight: "bold", size: 0.95em, title)
      #v(0.2em)
      #it
      #align(right, text(fill: crimson, sym.square.filled))
    ],
  )
}

#let proof(title: [证明], it) = touying-fn-wrapper-raw(
  _proof.with(title: title),
  it,
)
