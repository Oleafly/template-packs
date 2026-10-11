#let style_options = (
  font_normal: "EB Garamond",
  font_heading: "Avara",
  font_handwriting: "Crafty Girls",
  heading2: (size: 9pt, weight: "semibold")
)

#let stonetop_style(body) = {
  set text(
    font: style_options.font_normal,
    size: 8.3pt,
  )

  set list(
    marker: box(height: 0.7em)[#align(horizon)[#image("img/swirl.svg")]]
  )

  set par(leading: 0.55em, spacing: 0.95em, justify: false)
  set block(spacing: 0.6em)

  show title: set text(font: style_options.font_heading, size: 22pt, weight: "bold")
  show heading.where(level: 1): set text(font: style_options.font_heading, size: 10pt, weight: "bold")
  show heading.where(level: 2): it => {
    set text(..style_options.heading2)
    upper[#it.body]
  }

  body
}
