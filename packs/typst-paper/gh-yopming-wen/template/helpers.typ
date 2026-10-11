#let color_notes_back = rgb(248, 250, 255)
#let color_notes_border = rgb(166, 203, 254)

/**** custom functions ****/
#let notes(term) = {
  v(0.5em)
  rect(
    fill: color_notes_back,
    stroke: 1pt + color_notes_border,
    inset: 1em,
    radius: 2pt,
    width: 100%,
    term
  )
  v(0.5em)
}

