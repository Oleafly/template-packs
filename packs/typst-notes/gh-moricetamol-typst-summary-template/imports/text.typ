#import "template.typ": main-color, math-color, code-color

#let dt(body) = (
  text(
    fill: main-color.darken(10%),
    weight: 700,
    body,
  )
)
#let mt(body) = (
  text(
    fill: math-color.darken(10%),
    weight: 700,
    body,
  )
)
#let ct(body) = (
  text(
    fill: code-color.darken(10%),
    weight: 700,
    body,
  )
)

#let small-text(body) = (
  text(
    fill: black.lighten(10%),
    size: 0.8em,
    body,
  )
)
