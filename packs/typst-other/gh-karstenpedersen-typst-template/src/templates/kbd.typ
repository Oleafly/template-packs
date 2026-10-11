#let kbd(it) = context {
  // if target() == "html" {
    // html.elem("kbd", it)
  // } else {
    set text(fill: rgb("#1f2328"))
    let r = 3pt
    box(
      fill: rgb("#f6f8fa"),
      stroke: rgb("#d1d9e0b3"),
      outset: (y: r),
      inset: (x: r),
      radius: r,
      raw(it)
    )
  // }
}
