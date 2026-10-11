#let scene-break = {
  v(1em)
  align(center)[◆]
  v(1em)
}

// Drop cap for chapter openings (optional)
#let drop-cap(letter) = {
  box(
    height: 3em,
    width: 2.5em,
    float: left,
    align(bottom)[
      #text(size: 3.5em, font: "Garamond")[#letter]
    ]
  )
}