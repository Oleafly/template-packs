#let block(width, height, dx: 0pt, dy: 0pt, color: rgb(255, 255, 255, 50%), position: top + right) = {
  place(
    position,
    dx: dx,
    dy: dy,
    rect(width: width, height: height, fill: color),
  )
}
