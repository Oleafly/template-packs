#let line_height = 1em

#let fonts = (
  serif: "SimSun",
  sans: "SimHei",
  monospace: ("Consolas", "SimSun"),
  math: ("Libertinus Math")
)

#let textbf(it) = block(text(font: fonts.sans, weight: "semibold", it))

#let textit(it) = block(text(style: "italic", it))
