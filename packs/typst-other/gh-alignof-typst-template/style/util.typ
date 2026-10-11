#let quote_block(body) = {
  block(
    width: 100%,
    fill: silver,
    inset: 8pt,
    body
  )
}

#let terminal(body) = {
  block(
    width: 100%,
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#c2cacc"), body)
  )
}
