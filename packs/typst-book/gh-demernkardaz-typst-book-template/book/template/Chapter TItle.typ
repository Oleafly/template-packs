#let template(number, title, subtitle: none) = {
	pagebreak()

  v(4cm)

  text(size: 4em, weight: "black", fill: gray.lighten(50%))[#number]

  v(-1em)
  text(size: 2.5em, weight: "bold")[#title]

  if subtitle != none {
    v(0.5em)
    text(size: 1.2em, style: "italic", fill: gray)[#subtitle]
  }

  v(2cm)

	pagebreak()
}
